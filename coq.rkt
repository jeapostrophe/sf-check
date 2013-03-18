#lang racket/base
(require racket/list
         racket/match
         racket/runtime-path
         racket/set
         racket/system
         racket/format
         "delta.rkt"
         "score.rkt")

(define-runtime-path students-dir "students")

(define WIDTH 77)

(define (print/w w left right)
  (let ([left (format "~a" left)]
        [right (format "~a" right)])
    (printf "~a~a~a~n"
            left
            (make-string (max 0 (- w (string-length left) (string-length right))) #\space)
            right)))

(define (display-exercises ordered-exercises exercise->score fuel)
  (for ([exercise (in-list ordered-exercises)])
    (let/ec esc
      (define score (hash-ref exercise->score exercise esc))
      (print/w WIDTH (format "      ~a" exercise) (or (and score (format-score score)) "-")))))

(define (display-manual/chapter manual/chapter)
  (map
   (λ (exercise)
     (printf "    ~a~n" exercise))
   manual/chapter))

(define (display-chapters chapter->exercises fuel)
  (for ([chapter (in-list ordered-chapters)])
    (define exercises (hash-ref chapter->exercises chapter hasheq))
    (when (not (zero? (hash-count exercises)))
      (let-values ([(total-score manual/chapter) (chapter-total-score exercises)])
        (print/w WIDTH (format"    ~a" chapter) (format-score total-score))
        (if (zero? fuel)
          (display-manual/chapter manual/chapter)
          (display-exercises (hash-ref chapter->ordered-exercises chapter)
                             exercises (sub1 fuel)))))))

(define (display-manual/turnin manual/turnin)
  (map
   (λ (chapter)
     (printf "  ~a~n" (first chapter))
     (display-manual/chapter (rest chapter)))
   manual/turnin))

(define (display-turnins turnins turnin->chapters fuel)
  (for ([turnin (in-list turnins)])
    (define chapters (hash-ref turnin->chapters turnin))
    (let-values ([(total-score manual/turnin) (turnin-total-score chapters)])
      (print/w WIDTH (format "  ~a" turnin) (format-score total-score))
      (if (zero? fuel)
        (display-manual/turnin manual/turnin)
        (display-chapters chapters (sub1 fuel))))))

(define (display-manual/total manual/total)
  (map
   (λ (turnin)
     (printf "~a~n" (first turnin))
     (display-manual/turnin (rest turnin)))
   manual/total))

(define (format-score grade)
  (~a (real->decimal-string grade 2)
      #:min-width 7 #:left-pad-string " " #:align 'right))
(define (format-grade grade)
  (~a (real->decimal-string (* 100 grade) 2)
      #:min-width 5 #:left-pad-string "0" #:align 'right))

(define (display-all fuel)
  (for ([student (filter ; only get directories that don't start with '.'
                   (lambda (path)
                     (and (not (eq? (string-ref (path->string path) 0) #\. ))
                          (directory-exists? (build-path students-dir path))))
                   (directory-list students-dir))])
    (display-student fuel student)))

(define (display-student fuel student)
  (let* ([turnins
          (sort (filter string->number
                        (map
                         path->string
                         (directory-list (build-path students-dir student))))
                <
                #:key string->number)]
         [turnin-scores
          (for/fold ([turnin-scores (hash)])
              ([turnin turnins])
            (hash-set turnin-scores
                      turnin
                      (turnin-score (build-path students-dir student turnin)
                                    (string->number turnin))))]
         [deltas (turnin-scores->deltas turnin-scores)])
    (let-values ([(total-score manual/total) (total-score deltas)])
      (define grade (total-score->grade total-score))
      (print/w WIDTH student
               (format "~a (~a)"
                       (format-grade grade)
                       (convert-to-letter grade)))
      (print/w WIDTH "total" (format-score total-score))
      (if (zero? fuel)
        (display-manual/total manual/total)
        (display-turnins turnins deltas (sub1 fuel))))))

(module+ main
  (define depth 0)
  (define user #f)
  (for ([a (in-vector (current-command-line-arguments))])
    (match a
      [(? string? (app string->number (and (not #f) n)))
       (set! depth n)]
      [(? string? u)
       (set! user u)]
      [_
       (eprintf "got: ~v\n" a)
       (eprintf "usage: [0|1|2|3]
The single numeric argument specifies the \"depth\" to print detail:
  0  semester
  1  turnin
  2  chapter
  3  exercise~n")
       (exit 1)]))
  (cond
    [user
     (display-student depth user)]
    [else
     (display-all depth)]))
