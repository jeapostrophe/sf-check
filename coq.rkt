#lang racket/base
(require racket/list
         racket/match
         racket/port
         racket/set
         racket/system
         "extract.rkt"
         "scoring.rkt")

(define curriculum (call-with-input-file "curriculum.sexp" read #:mode 'text))

(define weeks-due (make-hasheq (for/list ([chapter (map first curriculum)]
                                          [week (in-naturals)])
                                 (cons chapter (add1 week)))))

;; chapter exercise -> difficulty (in stars)
(define (chapter-exercise-difficulty chapter exercise)
  (match-let ([(list (list _ difficulty _) _) (findf (match-lambda
                                                       [(list (list exercise _ _) _) #t]
                                                       [else #f])
                                                     (assq chapter curriculum))])
    difficulty))
  

;; student turnin chapter -> (hash exercise score)
(define (grade-student-turnin-chapter student turnin chapter)
  (displayln (format "grade-student-turnin-chapter ~a ~a ~a" student turnin chapter))
  (let ([chapter-detail (assq chapter curriculum)])
    (if chapter-detail
        (match-let ([(list stdout stdin pid stderr control)
                     (process (format "coqc -verbose ~a"
                                      (build-path "students"
                                                  student
                                                  turnin
                                                  (format "~a.v" chapter))))])
          (begin0
            (let ([proven-set (with-handlers ([(λ (x) #t) (λ (e) (seteq))])
                                (extract-proven (port->lines stdout)))])
              (hasheq
               (map
                (λ (exercise)
                  (cons exercise (points turnin
                                         (hash-ref weeks-due chapter)
                                         (chapter-exercise-difficulty chapter exercise))))
                (let ([x (filter
                 (λ (x) x)
                 (map
                  (λ (exercise)
                    (match-let ([(list (list name _ _) (list parts ...)) exercise])
                      (and (andmap
                            (λ (part)
                              (set-member? proven-set part))
                            parts)
                           name)))
                  (second chapter-detail)))]) (displayln x) x))))
            (close-input-port stdout)
            (close-output-port stdin)
            (close-input-port stderr)))
        (hasheq))))

;; student turnin -> (hash chapter (hash exercise score)))
(define (grade-student-turnin student turnin)
  (displayln (format "grade-student-turnin ~a ~a" student turnin))
  (foldr
   (λ (chapter scores)
     (hash-set scores chapter (grade-student-turnin-chapter student turnin chapter)))
   (hasheq)
   (filter
    (λ (x) x)
    (map
     (λ (filename)
       (cond
         [(regexp-match "^(.+)\\.v$" filename)
          => (λ (m) (string->symbol (second m)))]
         [else #f]))
     (directory-list (build-path "students" student turnin))))))

;; student -> score
(define (grade-student student)
  (define (scores-combine-chapters c1 c2)
    (define (scores-combine-exercises e1 e2)
      (for/fold ([exercises e1])
        ([(exercise score) e2])
        (hash-set exercises exercise (max (hash-ref exercises exercise 0)
                                          score))))
    (for/fold ([chapters c1])
      ([(chapter exercises) c2])
      (hash-set chapters chapter (scores-combine-exercises (hash-ref chapters chapter (hasheq))
                                                           exercises))))
  
  (for/fold ([scores (hasheq)])
    ([turnin (directory-list (build-path "students" student))])
    (scores-combine-chapters scores (grade-student-turnin student turnin))))

(for ([student (directory-list "students")])
  (printf "~a\t~a~n" student (grade-student student)))



