#lang racket/base
(require racket/list
         racket/match
         racket/port
         "scrape.rkt")
(provide lines->curriculum)

(define (accumulate-parts scrape)
  (if (empty? scrape)
      (values empty scrape)
      (match (first scrape)
        [(list 'exercise _ _ _)
         (values empty scrape)]
        [(list _ part 'admitted)
         (let-values ([(parts scrape) (accumulate-parts (rest scrape))])
           (values (cons part parts) scrape))]
        [_ (accumulate-parts (rest scrape))])))

(define (scrape->curriculum scrape)
  (if (empty? scrape)
      empty
      (match (first scrape)
        [(list 'exercise name difficulty designation)
         (let-values ([(parts scrape) (accumulate-parts (rest scrape))])
           (cons (list name difficulty designation (empty? parts) parts)
                 (scrape->curriculum scrape)))]
        [_ (scrape->curriculum (rest scrape))])))

; lines -> list of exercises
(define (lines->curriculum lines)
  (scrape->curriculum (scrape lines)))

(define chapters '(Basics
                   Lists
                   Poly
                   Gen
                   Prop
                   Logic
                   Imp
                   ImpCEvalFun
                   Equiv
                   Hoare
                   Rel
                   Smallstep
                   Types
                   Stlc
                   MoreStlc))

; use define-runtime-path
(define sf-path (build-path "/home/kimballg/Documents/sf"))

(define (chapter-curriculum chapter)
  (let ([lines (with-input-from-file (build-path sf-path (format "~a.v" chapter)) port->lines #:mode 'text)])
    (lines->curriculum lines)))

(map list chapters
     (map chapter-curriculum chapters))
