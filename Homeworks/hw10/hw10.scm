(define (accumulate combiner start n term)
    (if (= n 0)
        start
        (combiner (term n) (accumulate combiner start (- n 1) term))))

;a tail recursive version of accumulate above
(define (accumulate-tail combiner start n term)
    (define (accumulate-iter combiner start n term s)
        (if (= n 0)
            s
            (accumulate-iter combiner start (- n 1) term (combiner s (term n)))))
    (accumulate-iter combiner start n term start))

(define-macro (list-of expr for var in seq if filter-fn)
    `(map (lambda (,var) ,expr) (filter (lambda (,var) ,filter-fn) ,seq)))

;extra: let if filter-in be optional
(define-macro (list-of expr for var in seq . args)
    (if (= (length args) 0)
        `(map (lambda (,var) ,expr) ,seq)
        `(map (lambda (,var) ,expr) (filter (lambda (,var) ,filter-fn) ,seq))))