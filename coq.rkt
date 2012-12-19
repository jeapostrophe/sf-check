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

(define (print/w w left right)
  (let ([left (format "~a" left)]
        [right (format "~a" right)])
  (printf "~a~a~a~n"
          left
          (make-string (max 0 (- w (string-length left) (string-length right))) #\space)
          right)))

(define (display-exercises exercises fuel)
  (for ([(exercise score) (in-hash exercises)])
    (print/w 80 (format "      ~a" exercise) (or score "-"))))

(define (display-manual/chapter manual/chapter)
  (map
   (λ (exercise)
     (printf "    ~a~n" exercise))
   manual/chapter))

(define (display-chapters chapters fuel)
  (for ([(chapter exercises) (in-hash chapters)])
    (let-values ([(total-score manual/chapter) (chapter-total-score exercises)])
      (print/w 80 (format"    ~a" chapter) total-score)
      (if (zero? fuel)
          (display-manual/chapter manual/chapter)
          (display-exercises exercises (sub1 fuel))))))

(define (display-manual/turnin manual/turnin)
  (map
   (λ (chapter)
     (printf "  ~a~n" (first chapter))
     (display-manual/chapter (rest chapter)))
   manual/turnin))

(define (display-turnins turnins fuel)
  (for ([(turnin chapters) (in-hash turnins)])
    (let-values ([(total-score manual/turnin) (turnin-total-score chapters)])
      (print/w 80 (format "  ~a" turnin) total-score)
      (if (zero? fuel)
          (display-manual/turnin manual/turnin)
          (display-chapters chapters (sub1 fuel))))))

(define (display-manual/total manual/total)
  (map
   (λ (turnin)
     (printf "~a~n" (first turnin))
     (display-manual/turnin (rest turnin)))
   manual/total))

(define (display-all fuel)
  (for ([student (directory-list students-dir)])
    (let* ([turnins
            (sort (map
                   path->string
                   (directory-list (build-path students-dir student)))
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
        (print/w 80 student 
                 (format "~a (~a)" 
                         (~a (real->decimal-string grade 2) 
                             #:min-width 5 #:left-pad-string "0" #:align 'right)
                         (convert-to-letter grade)))
        (print/w 80 "total" total-score)
        (if (zero? fuel)
            (display-manual/total manual/total)
            (display-turnins deltas (sub1 fuel)))))))

(match (current-command-line-arguments)
  [(vector (regexp #px"\\d+" (list x))) (display-all (string->number x))]
  [(vector (or "-h" "--help") _ ...) (printf "usage: racket coq.rkt [0|1|2|3]
The single numeric argument specifies the \"depth\" to print detail:
  0  semester
  1  turnin
  2  chapter
  3  exercise~n")]
  [_ (display-all 0)])
