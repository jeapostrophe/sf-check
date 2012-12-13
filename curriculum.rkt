#lang racket/base
(require racket/list
         racket/match
         racket/port
         racket/pretty
         racket/runtime-path
         "file-scrape.rkt")

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
  (scrape->curriculum (file-scrape lines)))

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

(match (current-command-line-arguments)
  [(vector base-path) (pretty-write (map
                                     list
                                     chapters
                                     (map
                                      (λ (chapter)
                                        (lines->curriculum
                                         (file->lines
                                          (build-path base-path
                                                      (format "~a.v" chapter))
                                          #:mode 'text)))
                                      chapters)))]
  [(vector) (printf "usage: racket curriculum.rkt [sf-coq-files-base-path]~n")])
