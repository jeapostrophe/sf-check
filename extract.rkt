#lang racket/base
(require racket/list
         racket/match
         racket/set)

(provide extract-completed)

(define (start-inductive? line)
  (regexp-match #px"^Inductive\\s+([\\w']+)[^\\w']" line))

(define (end-inductive? line)
  (regexp-match #px"\\.$" line))

(define (start-definition/fixpoint? line)
  (or (regexp-match #px"^Definition\\s+([\\w']+)[^\\w']" line)
      (regexp-match #px"^Fixpoint\\s+([\\w']+)[^\\w']" line)))

(define (end-definition/fixpoint? line)
  (regexp-match #px"^  end\\.$" line))

(define (start-example/theorem? line)
  (or (regexp-match #px"^Example\\s+([\\w']+)[^\\w']" line)
      (regexp-match #px"^Theorem\\s+([\\w']+)[^\\w']" line)))

(define (admit? line)
  (or (regexp-match #px"^Admitted\\.$" line)
      (regexp-match #px"admit\\." line)))
  
(define (qed? line)
  (regexp-match #px"^Qed.$" line))

(define (error? line)
  (regexp-match #px"^Error:\\s+(.+)$" line))

; inductive  . at end of line
; definition/fixpoint "  end."
; example - Admitted. or Qed.
; 

(define (in-inductive lines completed-set name)
  ;(printf "inductive ~a~n" name)
  (if (empty? lines)
      (extract-completed lines completed-set)
      (let ([line (first lines)])
        (cond
          [(end-inductive? line) (extract-completed (rest lines) completed-set)]
          [else (in-inductive (rest lines) completed-set name)]))))

(define (in-definition/fixpoint lines completed-set name)
  ;(printf "definition/fixpoint ~a~n" name)
  (if (empty? lines)
      (extract-completed lines completed-set)
      (let ([line (first lines)])
        (cond
          [(admit? line) (extract-completed (rest lines) completed-set)]
          [(end-definition/fixpoint? line) (extract-completed (rest lines) (set-add completed-set name))]
          [else (in-definition/fixpoint (rest lines) completed-set name)]))))

(define (in-example/theorem lines completed-set name)
  ;(printf "example/theorem ~a~n" name)
  (if (empty? lines)
      (extract-completed lines completed-set)
      (let ([line (first lines)])
        (cond
          [(admit? line) (extract-completed (rest lines) completed-set)]
          [(qed? line) (extract-completed (rest lines) (set-add completed-set name))]
          ;[(error? line) (extract-completed lines completed-set)]
          [else (in-example/theorem (rest lines) completed-set name)]))))

;; coqc verbose output as lines -> set of names of completed things
(define (extract-completed lines [completed-set (seteq)])
  (if (empty? lines)
      completed-set
      (let ([line (first lines)])
        ;(displayln line)
        (cond
          [(start-inductive? line)
           => (λ (m) (in-inductive (rest lines) completed-set (string->symbol (second m))))]
          [(start-definition/fixpoint? line)
           => (λ (m) (in-definition/fixpoint (rest lines) completed-set (string->symbol (second m))))]
          [(start-example/theorem? line)
           => (λ (m) (in-example/theorem (rest lines) completed-set (string->symbol (second m))))]
          #;[(or (line-admits? line)
               (line-qed? line))
           (error 'extract-completed "stray admit or qed; rest of file: ~a" lines)]
          [(error? line) => (λ (m) (error 'extract-completed "~a" (second m)))]
          [else (extract-completed (rest lines) completed-set)]))))