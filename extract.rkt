#lang racket/base
(require racket/list
         racket/match
         racket/set)

(provide extract-proven)

(define (line-signals-definition/fixpoint? line)
  (or (regexp-match #px"^Definition\\s+(\\S+)\\s" line)
      (regexp-match #px"^Fixpoint\\s+(\\S+)\\s" line)))

(define (line-signals-example/theorem? line)
  (or (regexp-match #px"^Example\\s+(\\S+)\\s" line)
      (regexp-match #px"^Theorem\\s+(\\S+)\\s" line)))

(define (line-admits? line)
  (or (regexp-match #px"^Admitted.$" line)
      (regexp-match #px"^admit.$" line)))
  
(define (line-qed? line)
  (regexp-match #px"^Qed.$" line))

(define (line-signals-error? line)
  (regexp-match #px"^Error:\\s+(.+)$" line))

(define (in-definition/fixpoint lines proven-set proposition)
  (if (empty? lines)
      (extract-proven lines proven-set)
      (let ([line (first lines)])
        (cond
          [(line-signals-definition/fixpoint? line) (extract-proven lines proven-set)]
          [(line-signals-example/theorem? line) (extract-proven lines proven-set)]
          [(line-admits? line) (extract-proven (rest lines) proven-set)]
          [(line-qed? line) (extract-proven lines proven-set)]
          [(line-signals-error? line) (extract-proven lines proven-set)]
          [else (in-definition/fixpoint (rest lines) proven-set proposition)]))))

(define (in-example/theorem lines proven-set proposition)
  (if (empty? lines)
      (extract-proven lines proven-set)
      (let ([line (first lines)])
        (cond
          [(line-signals-definition/fixpoint? line) (extract-proven lines proven-set)]
          [(line-signals-example/theorem? line) (extract-proven lines proven-set)]
          [(line-admits? line) (extract-proven (rest lines) proven-set)]
          [(line-qed? line) (extract-proven (rest lines) (set-add proven-set proposition))]
          [(line-signals-error? line) (extract-proven lines proven-set)]
          [else (in-example/theorem (rest lines) proven-set proposition)]))))


;; coqc verbose output as lines -> set of names of proven propositions
(define (extract-proven lines [proven-set (seteq)])
  (displayln proven-set)
  (if (empty? lines)
      proven-set
      (let ([line (first lines)])
        (displayln line)
        (cond
          [(line-signals-definition/fixpoint? line)
           => (λ (m) (in-definition/fixpoint (rest lines) proven-set (string->symbol (second m))))]
          [(line-signals-example/theorem? line)
           => (λ (m) (in-example/theorem (rest lines) proven-set (string->symbol (second m))))]
          [(or (line-admits? line)
               (line-qed? line))
           (error 'extract "stray admit or qed; rest of file: ~a" lines)]
          [(line-signals-error? line) => (λ (m) (error 'extract "~a" (second m)))]
          [else (extract-proven (rest lines) proven-set)]))))