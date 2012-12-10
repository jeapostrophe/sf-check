#lang racket/base
(require racket/match)

(provide points)

(define worth
  (match-lambda
    [1 1]
    [2 5]
    [3 15]
    [4 60]
    [5 120]
    [else (worth 2)]))

(define (points week-received week-due stars)
  (* (worth stars) (/ (- 14 (max (- week-received week-due) 0)) 14)))
