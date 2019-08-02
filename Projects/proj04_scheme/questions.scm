(define (caar x) (car (car x)))
(define (cadr x) (car (cdr x)))
(define (cdar x) (cdr (car x)))
(define (cddr x) (cdr (cdr x)))

; Some utility functions that you may find useful to implement.

(define (cons-all first rests)
  (map (lambda (x) (cons first x)) rests))

(define (zip pairs)
  'replace-this-line)

;; Problem 17
;; Returns a list of two-element lists
; BEGIN PROBLEM 17
(define (enumerate s)
    (define (enumerate-iter s n)
        (if (null? s)
            nil
            (cons (cons n (cons (car s) nil)) (enumerate-iter (cdr s) (+ n 1))))  )
    (enumerate-iter s 0))
; END PROBLEM 17

;; Problem 18
;; List all ways to make change for TOTAL with DENOMS
; BEGIN PROBLEM 18
(define (list-change total denoms)
    (cond ((null? denom) nil)
          ((= total 0) '(()) )
          ((< total (car denoms)) (list-change total (cdr denoms)))
          (else (define with_max (list-change (- total (car denoms)) denoms))
                (define without_max (list-change total (cdr denoms)))
                (append (cons-all (car denoms) with_max) without_max))))
; END PROBLEM 18

;; Problem 19
;; Returns a function that checks if an expression is the special form FORM
(define (check-special form)
    (lambda (expr) (equal? form (car expr))))

(define lambda? (check-special 'lambda))
(define define? (check-special 'define))
(define quoted? (check-special 'quote))
(define let?    (check-special 'let))

;; Converts all let special forms in EXPR into equivalent forms using lambda
; BEGIN PROBLEM 19
(define (let-to-lambda expr)
    (cond ((atom? expr) (expr))
          ((quoted? expr) (expr))
          ((or (lambda? expr) (define? expr))
              (let ((form   (car expr))
                    (params (cadr expr))
                    (body   (cddr expr)))
                (cons form (cons params (let-to-lambda body)))))
              ((let? expr)
                  (let ((values (cadr expr))
                        (body   (cddr expr)))
                  (cons (cons 'lambda (cons (car (zip values)) (let-to-lambda body)))
                        (map let-to-lambda (cadr (zip values))))))
          (else (map let-to-lambda expr))))
; END PROBLEM 19
