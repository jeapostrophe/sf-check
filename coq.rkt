#lang racket/base
(require racket/list
         racket/match
         racket/runtime-path
         racket/set
         racket/system
         "delta.rkt"
         "score.rkt")


(define-runtime-path students-dir "students")

(define (display-exercises exercises fuel)
  (for ([(exercise score) (in-hash exercises)])
    (printf "      ~a\t~a~n" (or score "TBD") exercise)))

(define (display-manual/chapter manual/chapter)
  (map
   (λ (exercise)
     (printf "    ~a~n" exercise))
   manual/chapter))

(define (display-chapters chapters fuel)
  (for ([(chapter exercises) (in-hash chapters)])
    (let-values ([(total-score manual/chapter) (chapter-total-score exercises)])
      (printf "    ~a\t~a~n" chapter total-score)
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
      (printf "  ~a\t~a~n" turnin total-score)
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
        (printf "~a\t~a\t~a~n" student total-score (total-score->grade total-score))
        (if (zero? fuel)
            (display-manual/total manual/total)
            (display-turnins deltas (sub1 fuel)))))))

(display-all 3)

#;(match (current-command-line-arguments)
  [(vector (regexp #px"\\d+" (list x))) (display-all (string->number x))]
  [_ (display-all 0)])