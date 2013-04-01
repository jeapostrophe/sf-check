#lang racket/base
(require racket/contract
         racket/file
         racket/list
         racket/format
         racket/match
         racket/runtime-path
         racket/function
         "score.rkt")

(define-runtime-path curriculum-file "curriculum.sexp")

(define stars
  (map
   (λ (chapter-exercises)
     (cons (first chapter-exercises)
           (map
            (match-lambda
             [(list _ star _ _ _) star])
            (second chapter-exercises))))
   (file->value curriculum-file)))

(module+ main
  (for/fold ([total 0])
      ([e (in-list stars)])
    (match-define (cons ch exs) e)
    (printf "~a: " (~a #:align 'right #:min-width 12 ch))
    (define ch-total
      (for/sum ([n (in-list '(1 2 3 4 5))])
        (define n-exs
          (count (curry = n) exs))
        (printf "~a (~a) "
                n (~a #:align 'right #:min-width 2 n-exs))
        (* (point-worth n) n-exs)))
    (define next-total
      (+ total ch-total))
    (printf "\t~a\t~a" 
            (~a #:align 'right #:min-width 3 ch-total)
            (~a #:align 'right #:min-width 4 next-total))
    (newline)
    next-total))
