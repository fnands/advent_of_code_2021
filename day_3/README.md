## Things I learned:


* `...` can be used to split single func argument into many. Read the [docs](https://docs.julialang.org/en/v1/manual/faq/#What-does-the-...-operator-do?)

* ` is transpose in Julia

* Can set the rounding mode as 0.5 rounds down by default (ties round to nearest even number by default..)

* broadcasting in Julia is done with `.` (as in `abs.(x)` will find the absolute value of each element of `x` and it's my favourite thing about Julia so far. Why doesn't Python have this? Reminds me of `vmap` in JAX.  
