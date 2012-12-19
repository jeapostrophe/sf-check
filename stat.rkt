#lang racket/base
(require racket/contract
         racket/file
         racket/list
         racket/match
         racket/runtime-path
         "score.rkt")

(define-runtime-path curriculum-file "curriculum.sexp")

(define stars
  (map
   (λ (chapter-exercises)
     (map
      (match-lambda
        [(list _ star _ _ _) star])
      (second chapter-exercises)))
   (file->value curriculum-file)))


(map
 (λ (n)
   (* (point-worth n)
      (apply +
             (map
              (λ (exs)
                (count (=/c n) exs))
              stars))))
 (list 1 2 3 4 5))