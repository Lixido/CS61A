(define (cddr s)
    (cdr (cdr s)))

(define (cadr s)
    (car (cdr s)))

(define (caddr s)
    (car (cdr (cdr s))))

(define (sign x)
    (cond
        ((> x 0) 1)
        ((< x 0) -1)
        ((= x 0) 0)))

(define (square x) (* x x))

(define (pow b n)
    (cond
        ((even? n) (square (pow b (/ n 2))))
        ((odd? n) (* (square (pow b (/ (- n 1) 2))) b))))

(define (ordered? s)
    (cond 
        ((null? s) #t)
        ((null? (cdr s)) #t)
        (else (and (<= (car s) (cadr s)) (ordered? (cdr s))))))

(define (nodots s)
    (define (dotted? s)
        (and (pair? s)
             (not (or (null? (cdr s))
                          (pair? (cdr s))))))
    (cond ((dotted? s) (list (nodots (car s)) (cdr s)))
          ((pair? s) (cons (nodots (car s)) (nodots (cdr s))))
          (else s)))
; I'm dead with the parenthesis

; Sets as sorted lists

(define (empty? s) (null? s))

(define (contains? s v)
    (cond ((empty? s) #f)
          ((> (car s) v) #f)
          ((= (car s) v) #t)
          (else (contains? (cdr s) v))))

; Equivalent Python code, for your reference:
;
; def empty(s):
;     return s is Link.empty
;
; def contains(s, v):
;     if empty(s):
;         return False
;     elif s.first > v:
;         return False
;     elif s.first == v:
;         return True
;     else:
;         return contains(s.rest, v)

(define (add s v)
    (cond ((empty? s) (list v))
          ((= v (car s)) s)
          ((< v (car s)) (cons v s))
          (else (cons (car s) (add (cdr s) v)))))

(define (intersect s t)
    (cond ((or (empty? s) (empty? t)) nil)
          (else (define e1 (car s)) (define e2 (car t)) 
                (define r1 (cdr s)) (define r2 (cdr t))
                (cond ((= e1 e2) (cons e1 (intersect r1 r2)))
                      ((< e1 e2) (intersect r1 t))
                      ((> e1 e2) (intersect s r2))))))


; Equivalent Python code, for your reference:
;
; def intersect(set1, set2):
;     if empty(set1) or empty(set2):
;         return Link.empty
;     else:
;         e1, e2 = set1.first, set2.first
;         if e1 == e2:
;             return Link(e1, intersect(set1.rest, set2.rest))
;         elif e1 < e2:
;             return intersect(set1.rest, set2)
;         elif e2 < e1:
;             return intersect(set1, set2.rest)

(define (union s t)
    (define e1 (car s)) (define e2 (car t)) 
    (define r1 (cdr s)) (define r2 (cdr t))
    (cond ((empty? s) t)
          ((empty? t) s)
          ((= e1 e2) (cons e1 (union r1 r2)))
          ((< e1 e2) (cons e1 (union r1 t)))
          ((> e1 e2) (cons e2 (union s r2)))))