#lang racket/base
(require racket/list)
(provide scrape)

(define (snoc xs x)
  (append xs (list x)))

(define (designates-error? line)
  (let ([match (regexp-match #px"^Error:\\s+(.+)$" line)])
    (and match (second match))))

(define (start-inductive? line)
  (let ([match (regexp-match #px"^(Inductive)\\s+([\\w']+)[^\\w']" line)])
    (and match (list (string->symbol (string-downcase (second match)))
                     (string->symbol (third match))))))

(define (end-inductive? line)
  (regexp-match #px"\\.$" line))

(define (in-inductive lines spec)
  (if (empty? lines)
      (cons (snoc spec 'unspecified) (scrape lines))
      (let ([line (first lines)])
        (cond
          [(end-inductive? line) (cons (snoc spec 'defined) (scrape (rest lines)))]
          [(designates-error? line) => (λ (message) (error 'scrape message))]
          [else (in-inductive (rest lines) spec)]))))

(define (start-def/fix? line)
  (let ([match (or (regexp-match #px"^(Definition)\\s+([\\w']+)[^\\w']" line)
                   (regexp-match #px"^(Fixpoint)\\s+([\\w']+)[^\\w']" line))])
    (and match (list (string->symbol (string-downcase (second match)))
                     (string->symbol (third match))))))

(define (end-def/fix? line)
  (regexp-match #px"^  end\\.$" line))

(define (in-def/fix lines spec)
  (if (empty? lines)
      (cons (snoc spec 'unspecified) (scrape lines))
      (let ([line (first lines)])
        (cond
          [(admit? line) (cons (snoc spec 'admitted) (scrape (rest lines)))]
          [(end-def/fix? line) (cons (snoc spec 'completed) (scrape (rest lines)))]
          [(designates-error? line) => (λ (message) (error 'scrape message))]
          [else (in-def/fix (rest lines) spec)]))))

(define (start-provable? line)
  (let ([match (or (regexp-match #px"^(Example)\\s+([\\w']+)[^\\w']" line)
                   (regexp-match #px"^(Fact)\\s+([\\w']+)[^\\w']" line)
                   (regexp-match #px"^(Lemma)\\s+([\\w']+)[^\\w']" line)
                   (regexp-match #px"^(Theorem)\\s+([\\w']+)[^\\w']" line))])
    (and match (list (string->symbol (string-downcase (second match)))
                     (string->symbol (third match))))))

(define (admit? line)
  (or (regexp-match #px"^Admitted\\.$" line)
      (regexp-match #px"admit\\." line)))

(define (qed? line)
  (regexp-match #px"^Qed\\.$" line))

(define (in-provable lines spec)
  (if (empty? lines)
      (cons (snoc spec 'unspecified) (scrape lines))
      (let ([line (first lines)])
        (cond
          [(admit? line) (cons (snoc spec 'admitted) (scrape (rest lines)))]
          [(qed? line) (cons (snoc spec 'completed) (scrape (rest lines)))]
          [(designates-error? line) => (λ (message) (error 'scrape message))]
          [else (in-provable (rest lines) spec)]))))

;; coqc verbose output as lines -> list of coq sentences
(define (scrape lines)
  (if (empty? lines)
      empty
      (let ([line (first lines)])
        (cond
          [(designates-error? line)
           => (λ (message) (error 'scrape message))]
          [(start-inductive? line)
           => (λ (name) (in-inductive (rest lines) name))]
          [(start-def/fix? line)
           => (λ (name) (in-def/fix (rest lines) name))]
          [(start-provable? line)
           => (λ (name) (in-provable (rest lines) name))]
          [else (scrape (rest lines))]))))