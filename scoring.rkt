#lang racket/base
(require racket/match)

(provide exercise-score
         grade-for-total-score)

(define point-worth
  (match-lambda
    [1 1]
    [2 5]
    [3 15]
    [4 60]
    [5 240]
    [else (point-worth 2)]))

(define (exercise-score difficulty lateness)
  (* (point-worth difficulty) (expt 0.9 lateness)))
  
(define (grade-for-total-score p)
  (cond
    [(< p 1500) (exact->inexact (/ p 2000))]
    [(< p 2000) (exact->inexact (+ (/ p 5000) 9/20))]
    [else (let ([a (* 3/20 (exp 8/3))]
                [b -1/750])
            (- 1 (* a (exp (* b p)))))]))
