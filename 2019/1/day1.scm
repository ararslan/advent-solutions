(define (parse-file file)
  (let ([p (open-input-file file)])
    (let loop ([line (get-line p)]
               [results '()])
      (if (eof-object? line)
          (begin
            (close-port p)
            (reverse results))
          (loop (get-line p) (cons (string->number line) results))))))

(define input (parse-file "input"))

(define (fuel mass)
  (max 0 (- (exact (floor (/ mass 3))) 2)))

(printf "Part 1 answer: ~a\n" (apply + (map fuel input)))

(define (total-fuel mass)
  (letrec ([f (lambda (total mass)
                (if (positive? mass)
                    (f (+ total (fuel mass)) (fuel mass))
                    total))])
    (f 0 mass)))

(printf "Part 2 answer: ~a\n" (apply + (map total-fuel input)))
