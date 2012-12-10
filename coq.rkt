#lang racket/base
(require racket/match)
;(require "scoring.rkt")

(match-let ([(vector turnin filenames ...)
             (current-command-line-arguments)])
  filenames)

#|
(define cirriculum (call-with-input-file "cirriculum.rkt" read #:mode 'text))

(define chapters
  (for/list ([chapter (map first cirriculum)]
             [i (in-naturals)])
    (list chapter (add1 i))))

;(define (hash-merge h1 h2 

;; score-chapter : path? (listof exercise-spec) -> (hashof symbol? real?)
(define (score-chapter path specs)
  2)

(define (grade student)
  #;(for* ([week (directory-list (build-path "students" student))]
         [submission (directory-list (build-path "students" student week))])
    (let ([match (regexp-match #rx"^(.+)\\.v$" submission)])
      (if match
          (let* ([name (second match)]
                 [chapter (assq (string->symbol name) cirriculum)])
            (if chapter
          ; process according to (second chapter)
          (printf "unknown assignment: ~a~n" (make-path student week submission)))))))
    ; run coqc on the submission
    ; extract the completed exercises
    ; generate a score based on the difficulty and week
    ;(let ([match (regexp-match #rx"^(.+)\\.v$" submission)])
     ; (if match
  1.0)

(define (grade-student-turnin-chapter student turnin chapter)
  (match-let ([(list stdout stdin pid stderr control)
               (process (format "/usr/local/bin/coqc -verbose ~a"
                                (build-path "students"
                                            student
                                            turnin
                                            (format "~a.v" chapter))))])
    

(define (grade-student-turnin student turnin)
  (filter (λ (filename)
            (cond
              [(regexp-match "^(.+)\\.v$" filename) => (λ (m) (string->symbol (second m)))]
              [else #f]))
          (directory-list (build-path "students" student turnin)))

(for ([student (directory-list "students")])
  (printf "~a\t~a~n" student (grade-student student)))

#;(match-let ([(list stdout stdin pid stderr control) (process "/usr/local/bin/coqc -verbose ")])
  
  (close-input-port stdout)
  (close-output-port stdin)
  (close-input-port stderr))

|#
