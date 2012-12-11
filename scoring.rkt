#lang racket/base
(require racket/match)

(provide points)

(define worth
  (match-lambda
    [1 1]
    [2 5]
    [3 15]
    [4 60]
    [5 240]
    [else (worth 2)]))

(define (points week-received week-due stars)
  (* (worth stars) (/ (- 14 (max (- week-received week-due) 0)) 14)))

(define (grade-for-total-points p)
  (cond
    [(< p 1500) (exact->inexact (/ p 2000))]
    [(< p 2000) (exact->inexact (+ (/ p 5000) 9/20))]
    [else (let ([a (* 3/20 (exp 8/3))]
                [b -1/750])
            (- 1 (* a (exp (* b p)))))]))
