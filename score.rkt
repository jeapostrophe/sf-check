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
         convert-to-letter)

(define-runtime-path curriculum-file "curriculum.sexp")

(define curriculum (file->value curriculum-file))

(define weeks-due (hasheq 'Basics       0.5
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

(define chapter-exercises (make-hasheq (map
                                        (λ (chapter)
                                          (cons (first chapter)
                                                (make-hasheq (first (rest chapter)))))
                                        curriculum)))



(define point-worth
  (match-lambda
    [1 1]
    [2 5]
    [3 15]
    [4 60]
    [5 240]
    [else (point-worth 2)]))

(define (score/lateness score lateness)
  (* score (expt 0.9 lateness)))

(define (exercise-score difficulty lateness)
  (score/lateness (point-worth difficulty) lateness))

(define (chapter-score path chapter lateness)
  (let ([sentences (apply seteq (filter-map
                                 (match-lambda
                                   [(list _ name 'completed) name]
                                   [_ #f])
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
                              [(manual-grade-path) (build-path base (symbol->string exercise))])
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
    (filter-map
     (λ (entry)
       (let ([match (regexp-match #px"^(\\w+)\\.v$" (path->string entry))])
         (and match
              (let ([chapter (string->symbol (second match))])
                (and (hash-has-key? weeks-due chapter) chapter)))))
     (directory-list path)))))



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

(define (total-score->grade p)
  (cond
    [(< p 1500) (exact->inexact (/ p 2000))]
    [(< p 2000) (exact->inexact (+ (/ p 5000) 9/20))]
    [else (let ([a (* 3/20 (exp 8/3))]
                [b -1/750])
            (- 1 (* a (exp (* b p)))))]))

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
