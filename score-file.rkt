#lang racket/base
(require racket/list
         racket/match
         racket/port
         racket/set
         racket/system
         "scoring.rkt"
         (prefix-in coqc: "coqc-scrape.rkt"))

(define chapter-exercises (make-hasheq (map
                                        (λ (chapter)
                                          (cons (first chapter)
                                                (make-hasheq (first (rest chapter)))))
                                        (call-with-input-file "curriculum.sexp" read #:mode 'text))))

(define (coqc-scrape filepath)
  (with-handlers ([exn:fail? (λ (e)
                               (printf "error in ~a; ignoring~n" filepath)
                               (error 'not-grabbing filepath))])
    (match-let ([(list stdout stdin pid stderr control)
                 (process (format "/usr/local/bin/coqc -verbose ~a" filepath))])
      (begin0
        (coqc:scrape (port->lines stdout))
        (close-input-port stdout)
        (close-output-port stdin)
        (close-input-port stderr)))))

(define (completed-sentences filepath)
  (apply seteq (filter-map
                (match-lambda
                  [(list _ name 'completed) name]
                  [_ #f])
                (coqc-scrape filepath))))

(define (score-file filepath chapter lateness)
  (let ([sentences (completed-sentences filepath)])
    (for/fold ([completed-exercises (hasheq)])
      ([(exercise info) (hash-ref chapter-exercises chapter)])
      (match-let ([(list difficulty _ manual? parts) info])
        (if (andmap
             (λ (part)
               (set-member? sentences part))
             parts)
            (hash-set completed-exercises exercise (if manual?
                                                       'flag
                                                       (exercise-score difficulty lateness)))
            completed-exercises)))))

(score-file "/Users/kimballg/Development/sf-check/students/bob/1.5/Basics.v" 'Basics 0.5)
