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

(define ->path
  (case-lambda
    [(student) (build-path "students" student)]
    [(student turnin) (build-path "students" student turnin)]
    [(student turnin chapter) (build-path "students" student turnin (format "~a.v" chapter))]))

(define (partition/automation exercises)
  (partition
   (λ (exercise)
     (match-let ([(list (list name _ _) parts) exercise])
       (not (zero? (length parts)))))
   exercises))

;; student turnin chapter -> (setof exercise-names)
(define (extract student turnin chapter)
  (with-handlers ([exn:fail? (λ (e)
                               (printf "error in ~a; ignoring~n" (->path student turnin chapter))
                               (seteq))])
    (match-let ([(list stdout stdin pid stderr control)
                 (process (format "/usr/local/bin/coqc -verbose ~a"
                                  (->path student turnin chapter)))])
      (begin0
        (extract-completed (port->lines stdout))
        (close-input-port stdout)
        (close-output-port stdin)
        (close-input-port stderr)))))

;; chapter exercise -> difficulty (in stars)
(define (chapter-exercise-difficulty chapter exercise)
  (let ([exercise (findf (match-lambda
                           [(list (list exercise _ _) _) #t]
                           [else #f])
                         (second (assq chapter curriculum)))])
    (if exercise
        (match-let ([(list (list _ difficulty _) _) exercise])
          difficulty)
        (error 'chapter-exercise-difficulty "exercise ~a not found in chapter ~a" exercise chapter))))


;; student turnin chapter -> (hash exercise score)
(define (grade-student-turnin-chapter student turnin chapter)
  (let ([chapter-detail (assq chapter curriculum)])
    (if chapter-detail
        (let-values ([(automated not-automated) (partition/automation (second chapter-detail))])
          (let ([proven-set (extract student turnin chapter)])
            (let ([automated-completed (filter-map
                                        (λ (exercise)
                                          (match-let ([(list (list name _ _) parts) exercise])
                                            (and (andmap
                                                  (λ (part)
                                                    (set-member? proven-set part))
                                                  parts)
                                                 name)))
                                        automated)]
                  [not-automated-completed (filter-map
                                            (λ (exercise)
                                              (match-let ([(list (list name _ _) _) exercise])
                                                (and (set-member? proven-set name)
                                                     name)))
                                            not-automated)])
              (map
               (λ (exercise-name)
                 (printf "look at ~a in ~a~n"
                         exercise-name
                         (->path student turnin chapter)))
               not-automated-completed)
              (make-hasheq
               (map
                (λ (exercise)
                  (cons exercise
                        (points (string->number (path->string turnin))
                                (hash-ref weeks-due chapter)
                                (chapter-exercise-difficulty chapter exercise))))
                automated-completed)))))
        (hasheq))))

;; student turnin -> (hash chapter (hash exercise score)))
(define (grade-student-turnin student turnin)
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
     (directory-list (->path student turnin))))))

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
  
  (let ([scores (for/fold ([scores (hasheq)])
                  ([turnin (directory-list (build-path "students" student))])
                  (scores-combine-chapters scores (grade-student-turnin student turnin)))])
    (for/fold ([total-sum 0])
      ([chapter (in-hash-values scores)])
      (+ total-sum
         (for/fold ([chapter-sum 0])
           ([score (in-hash-values chapter)])
           (+ chapter-sum score))))))

(for ([student (directory-list "students")])
  (printf "~a\t~a~n" student (grade-student student)))



