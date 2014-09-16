; How to use Scheme:
; command line : scheme48
; to call a script, enter Scheme48 and (load "filename.scm")
; make sure, if in gedit, to use highlight matching bracket



; finonacci numbers
(define fib1
    (lambda (n)
        (cond
            ((< n 2) 1)
            (else (+ (fib1 (- n 1)) (fib1 (- n 2)))))))
;(display "\n\nsample output for fib1\n")
;(display (fib1 10))

; factorials
(define fact1
    (lambda (n)
        (cond
            ((< n 2) 1)
            (else (* n (fact1 (- n 1)))))))
;(display "\n\nsample output for fact1\n")
;(display (fact1 10))

; integrals
(define integrate1
    (lambda (f a b)
        (let
            ((dx (/ (- b a) 3)))
            (* (/ 1.0 3) (+ (f a) (f (+ a dx)) (f (+ a dx dx)))))))
;(display "\n\nsample output for integrate1\n")
;(display (integrate1 (lambda (x) (* x x)) 0.0 1.0))
            

(define range
    (letrec (
        (revrange
            (lambda (n)
                (if (= n 1)
                        '(1)
                        (cons n (revrange (- n 1)))))))
        (lambda (N) (reverse (revrange N)))))
;(display "\n\nsample output of range\n")
;(display (range 5))

(define intervals1
    (lambda  (a b N)
        (let* (
            (dx (/ (- b a) N))
            (x (lambda (k) (+ a (* k dx))))
            )
            (map x (range N)))))
;(display "\n\nsample output of intervals1\n")
;(display (intervals1 0.0 1.0 5))

(define sum
    (lambda (ls)
        (if (= 0 (length ls))
            0.0
            (+ (car ls) (sum (cdr ls))))))
(define integrate
    (lambda (f a b)
        (let* (
            (N 20)
            (xs (intervals1 a b N))
            (s (sum (map f xs)))
            )
            (* s (/ (- b a) (+ N 1)) ))))
(display "\n\nsample output of integrate\n")
(display (integrate (lambda (x) (+ (* x x) x )) 0.0 1.0))


(define mesh
    (lambda (l1 l2)
        (let (
            (x2pairs
                (lambda (x)
                    (map (lambda (y) (cons x y)) l2)))
            )
            (map x2pairs l1))))
(define integrateGrid
    (lambda (f a b A B)
        (let* (
            (N 20)
            (xs (intervals1 a b N))
            (ys (intervals1 A B N))
            (grid (mesh xs ys))
            (f-of-pair (lambda (p) (f (car p) (cdr p))))
            (fs (map (lambda (col) (map f-of-pair col)) grid))
            (sum-of-sums (lambda (gr) (sum (map sum gr))))
            (coeff (/ (* (- b a) (- B A)) (* (+ N 1) (+ N 1)) ))
            )
            (* coeff (sum-of-sums fs)))))
(display "\n\nsample output of integrateGrid\n")
(display (integrateGrid (lambda (x y) (* x y)) 0.0 1.0 0.0 1.0))

            

(define integrate2d
    (lambda (f a b g1 g2)
        (let* (
            (f-curry
                (lambda (x)
                (lambda (y) (f x y))))
            (integral-over-y 
                (lambda (x) 
                (integrate (f-curry x) (g1 x) (g2 x)) ))
            )
            (integrate integral-over-y a b))))
(display "\n\nsample output of integrate2d\n")
(display (integrate2d (lambda (x y) (* x y))
            0.0 1.0 (lambda (x) 0.0) (lambda (x) (+ x 3.0)) ))




