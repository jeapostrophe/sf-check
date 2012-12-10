#lang racket/base
(require racket/list
         racket/set)

;(parameterize ([current-input-port (open-input-string "test 1\ntesty 2\n")])
(let loop ([sum 0]
           [exercises (set)])
  (let ([line (read-line)])
    (if (eof-object? line)
        sum
        (cond
          [(regexp-match #px"^(\\S+)\\s+(\\d*\\.?\\d*)$" line)
           => (λ (match)
                (if (set-member? exercises (second match))
                    (loop sum exercises)
                    (loop (+ sum (string->number (third match)))
                          (set-add exercises (second match)))))]
          [else (error 'sum "unexpected line format \"~a\"" line)]))))
;)

  