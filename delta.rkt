#lang racket/base
(require racket/list)

(provide turnin-scores->deltas)

(define (chapter-delta base-chapter marginal-chapter)
  (for/fold ([delta (hasheq)])
    ([(exercise score) (in-hash marginal-chapter)])
    (if (hash-has-key? base-chapter exercise)
        delta
        (hash-set delta exercise score))))

(define (turnin-delta base-turnin marginal-turnin)
  (for/fold ([delta (hasheq)])
    ([(chapter exercises) (in-hash marginal-turnin)])
    (if (hash-has-key? base-turnin chapter)
        (hash-set delta chapter (chapter-delta (hash-ref base-turnin chapter) exercises))
        (hash-set delta chapter exercises))))

;; (hash turnin (hash chapter (hash exercise score)))
;; ->
;; (hash turnin (hash chapter (hash exercise score)))
(define (turnin-scores->deltas turnin-scores)
  (let* ([turnins (sort (hash-keys turnin-scores) < #:key string->number)]
         [scores (map (λ (turnin) (hash-ref turnin-scores turnin)) turnins)])
    (make-hasheq (map cons
                      turnins
                      (reverse
                       (for/fold ([deltas empty])
                         ([score scores])
                         (cons (foldr
                                turnin-delta
                                score
                                deltas)
                               deltas)))))))
  