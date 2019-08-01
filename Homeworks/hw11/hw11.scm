(define (find s predicate)
    (if (nil? s)
        #f
        (if (predicate (car s))
            (car s)
            (find (cdr-stream s) predicate))))
; Note: #f can only be returned if the input stream is of finite length.
; It will simply run forever on infinite streams which lack a suitable element.

;or use cond
(define (find s predicate)
    (cond ((null? s) #f)
          ((predicate (car s)) (car s))
          (else (find (cdr-stream s) predicate))))


(define (scale-stream s k)
    (if (null? s) 
        nil
        (cons-stream (* (car s) k) (scale-stream (cdr-stream s) k))))


(define (has-cycle s)
    (define (track cache current)
        (cond ((null? current) #f)
              ((contain? cache current) #t)
              (else (track (cons current cache) (cdr-stream current)))))
    (track nil s))
(define (contain? cache s)
    (cond ((null? cache) #f)
          ((eq? cache s) #t)
          (else (contain? (cdr cache) s)))
; a bit difficult


; has-cycle taking up constant space
(define (has-cycle-const s)
    (define compare-helper hare tortoise) ; 
        (cond ((or (null? hare) (null? cdr-stream hare)) #f)  ; finite -> no cycle
              ((eq? hare tortoise) #t)
              (else (compare-helper (cdr-stream (cdr-stream hare)) (cdr-stream tortoise))))
    (compare-helper (cdr-stream s) s))
; "Floyd cycle detection algorithm": 
; Every round, hare is advanced by 2 while tortoise advanced by 1.
; The distance between the hare and the tortoise in the cycle will decrease by 1.
; Eventually, they're guaranteed to meet up if there is cycle.