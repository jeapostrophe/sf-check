#lang racket/base
(require racket/file
         racket/list
         racket/match
         racket/runtime-path
         racket/set
         "coqc-scrape.rkt"
         "delta.rkt")


(provide point-worth
         chapter-score
         turnin-score
         chapter-total-score
         turnin-total-score
         total-score
         total-score->grade
         convert-to-letter
         ordered-chapters
         chapter->ordered-exercises)

(define-runtime-path curriculum-file "curriculum.sexp")

(define curriculum (file->value curriculum-file))

(define weeks-due
  (hasheq 'Basics       0.5
          'Lists        1.5
          'Poly         2.5
          'Gen          3.5
          'Prop         4.5
          'Logic        5.5
          'Imp          6.5
          'ImpCEvalFun  7.5
          'Extraction   7.5
          'Equiv        8.5
          'Hoare        9.5
          'Rel          10.5
          'HoareAsLogic 10.5
          'Smallstep    11.5
          'Types        12.5
          'Stlc         13.5
          'MoreStlc     14.5))
(define ordered-chapters
  (sort (hash-keys weeks-due)
        <
        #:key (λ (c) (hash-ref weeks-due c))))

(define chapter-exercises
  (make-hasheq (map
                (λ (chapter)
                  (cons (first chapter)
                        (make-hasheq (first (rest chapter)))))
                curriculum)))
(define chapter->ordered-exercises
  (make-hasheq (map
                (λ (chapter)
                  (cons (first chapter)
                        (map first (first (rest chapter)))))
                curriculum)))

(define point-worth
  (match-lambda
   [1   1   2]
   [2   5  10]
   [3  15  30]
   [4  60 120]
   [5 240 480]
   [else (point-worth 2)]))

(define (score/lateness score lateness)
  ;; XXX Don't penalize lateness... theorems never get easier
  (* score (expt 0.95 (* lateness 2)))
  score)

(define (exercise-score difficulty lateness)
  (score/lateness (point-worth difficulty) lateness))

(define (chapter-score path chapter lateness)
  (let ([sentences (apply seteq (filter-map
                                 (match-lambda
                                  [(and x (list _ name 'completed))
                                   (deprintf "~a > found: ~a\n" path x)
                                   name]
                                  [x
                                   (deprintf "~a > dropped: ~a\n" path x)
                                   #f])
                                 (coqc-scrape path)))])
    (for/fold ([completed-exercises (hasheq)])
        ([(exercise info) (in-hash (hash-ref chapter-exercises chapter))])
      (match-let ([(list difficulty _ manual? parts) info])
                 (if (andmap
                      (λ (part)
                        (set-member? sentences part))
                      parts)
                   (if manual?
                     (let*-values ([(base x y) (split-path path)]
                                   [(manual-grade-path)
                                    (build-path base
                                                (format ".~a.~a"
                                                        chapter
                                                        exercise))])
                       (hash-set completed-exercises exercise (and (file-exists? manual-grade-path)
                                                                   (* (file->value manual-grade-path)
                                                                      (exercise-score difficulty lateness)))))
                     (hash-set completed-exercises exercise (exercise-score difficulty lateness)))
                   completed-exercises)))))


                                        ; (hash exercise (or score #f)) -> score (listof exercise)
                                        ; exercise : symbol?
                                        ; score : number?
(define (chapter-total-score exercise-scores)
  (let-values ([(total manual/chapter)
                (for/fold ([total-score 0]
                           [manual/chapter empty])
                    ([(exercise score) (in-hash exercise-scores)])
                  (if score
                    (values (+ total-score score) manual/chapter)
                    (values total-score (cons exercise manual/chapter))))])
    (values total (reverse manual/chapter))))

(define (turnin-score path turnin)
  (make-hasheq
   (map
    (λ (chapter)
      (cons chapter
            (chapter-score (build-path path (format "~a.v" chapter))
                           chapter
                           (- turnin (hash-ref weeks-due chapter)))))
    (filter
     (λ (c) (file-exists? (build-path path (format "~a.v" c))))
     (sort (hash-keys weeks-due) < #:key (λ (c) (hash-ref weeks-due c)))))))



                                        ; (hash chapter (hash exercise (or score #f)))
                                        ; ->
                                        ; score (listof (pair chapter (listof exercise))
(define (turnin-total-score chapter-scores)
  (let-values ([(total-score manual/turnin)
                (for/fold ([total-score 0]
                           [manual/turnin empty])
                    ([(chapter exercise-scores) (in-hash chapter-scores)])
                  (let-values ([(score manual/chapter) (chapter-total-score exercise-scores)])
                    (if (empty? manual/chapter)
                      (values (+ total-score score) manual/turnin)
                      (values (+ total-score score) (cons (cons chapter manual/chapter) manual/turnin)))))])
    (values total-score (reverse manual/turnin))))

(define (total-score turnin-scores)
  (let-values ([(total-score manual/total)
                (for/fold ([total-score 0]
                           [manual/total empty])
                    ([(turnin delta) (in-hash (turnin-scores->deltas turnin-scores))])
                  (let-values ([(score manual/turnin) (turnin-total-score delta)])
                    (values (+ total-score score) (if (empty? manual/turnin)
                                                    manual/total
                                                    (cons (cons turnin manual/turnin) manual/total)))))])
    (values total-score (reverse manual/total))))

(define (first-score-part p)
  (* (/ first-score first-break) p))
(define (second-score-part p)
  (+ (* (/ (- second-score (first-score-part first-break)) (- second-break first-break)) (- p first-break))
     (first-score-part first-break)))
(define (third-score-part p)
  (+ (* (/ (- 1 (second-score-part second-break)) (- 5000 second-break)) (- p second-break))
     (second-score-part second-break)))

;; New
#;#;#;#;
(define first-break 1400)
(define first-score .9)
(define second-score .93)
(define second-break 1800)

;; Old
(define first-break 1300)
(define first-score .7)
(define second-score .9)
(define second-break 2000)

(define (total-score->grade p)
  (cond
    [(< p first-break)
     (exact->inexact (first-score-part p))]
    [(< p second-break)
     (exact->inexact
      (second-score-part p))]
    [else
     (exact->inexact
      (third-score-part p))]))
#;
(module+ main
  (require plot)
  (plot-file
   #:x-label "total points"
   #:y-label "numeric grade"
   #:legend-anchor 'bottom-right
   #:y-min 0
   #:y-max 1
   (list (points (list (list first-break (total-score->grade first-break))
                       (list second-break (total-score->grade second-break))))
         (function total-score->grade 0 5000
                   #:label "numeric grade for total points"
                   #:color "green")
         (function first-score-part 0 first-break
                   #:color "blue")
         (function second-score-part first-break second-break
                   #:color "red")
         (function third-score-part second-break 5000
                   #:color "black"))
   "grade-for-points.png"))

(define (convert-to-letter ng)
  (cond
    [(> ng 0.93) "A"]
    [(> ng 0.9) "A-"]
    [(> ng 0.86) "B+"]
    [(> ng 0.83) "B"]
    [(> ng 0.8) "B-"]
    [(> ng 0.76) "C+"]
    [(> ng 0.73) "C"]
    [(> ng 0.7) "C-"]
    [(> ng 0.66) "D+"]
    [(> ng 0.63) "D"]
    [(> ng 0.6) "D-"]
    [else "F"]))
