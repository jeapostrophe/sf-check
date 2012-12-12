#lang racket/base
(require racket/list
         racket/match
         racket/set)

(provide scrape)

(define (snoc xs x)
  (append xs (list x)))

(define (designates-exercise? line)
  (cond
    [(regexp-match #px"Exercise:\\s(\\d)\\sstars?\\s+\\(([\\w\\s']+)\\)" line) => (λ (match) (list 'exercise (string->symbol (third match)) (string->number (second match)) #f))]
    [(regexp-match #px"Exercise:\\s(\\d)\\sstars?\\,\\s(\\w+)\\s\\(([\\w\\s']+)\\)" line) => (λ (match) (list 'exercise (string->symbol (fourth match)) (string->number (second match)) (string->symbol (third match))))]
    [(regexp-match #px"Exercise:\\s(\\d)\\sstars?\\,\\s(\\w+)" line) => (λ (match) (list 'exercise #f (string->number (second match)) (string->symbol (third match))))]
    [(regexp-match #px"\\s(\\w+)\\sExercise:\\s([\\w\\s]+)\\s\\*" line) => (λ (match) (list 'exercise (string->symbol (third match)) #f (string->symbol (string-downcase (second match)))))] 
    [(regexp-match #px"Exercise:\\s([\\w\\s\\[\\]\\-]+)\\s\\*" line) => (λ (match) (list 'exercise (string->symbol (second match))))] 
    [else #f]))

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
  (or (regexp-match #px"Admitted\\." line)
      (regexp-match #px"admit\\." line)))

(define (qed? line)
  (regexp-match #px"Qed\\." line))

(define (in-provable lines spec)
  (if (empty? lines)
      (cons (snoc spec 'unspecified) (scrape lines))
      (let ([line (first lines)])
        (cond
          [(admit? line) (cons (snoc spec 'admitted) (scrape (rest lines)))]
          [(qed? line) (cons (snoc spec 'completed) (scrape (rest lines)))]
          [(designates-error? line) => (λ (message) (error 'scrape message))]
          [else (in-provable (rest lines) spec)]))))

;; coq file or coqc verbose output as lines -> list of exercises and definitions
(define (scrape lines)
  (if (empty? lines)
      empty
      (let ([line (first lines)])
        (cond
          [(designates-exercise? line)
           => (λ (exercise) (cons exercise (scrape (rest lines))))]
          [(start-inductive? line)
           => (λ (name) (in-inductive (rest lines) name))]
          [(start-def/fix? line)
           => (λ (name) (in-def/fix (rest lines) name))]
          [(start-provable? line)
           => (λ (name) (in-provable (rest lines) name))]
          [(designates-error? line) => (λ (message) (error 'scrape message))]
          [else (scrape (rest lines))]))))