(define square (lambda (x) (* x x)))
(define average (lambda (x y) (/ (+ x y) 2)))
(define average-damp (lambda (f)
  (lambda (x) (average x (f x)))))
((average-damp square) 10)
; 期待値は55
(define sqrt (lambda (x)
  (fixed-point (average-damp (lambda (y) (/ x y))) 1.0)))
(define fixed-point (lambda (f first-guess)
  (let ((try (lambda (guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))))
  (try first-guess))))
(define close-enough? (lambda (v1 v2)
    (< (abs (- v1 v2)) tolerance)))
(define tolerance 0.00001)
(sqrt 81.0)
; 9