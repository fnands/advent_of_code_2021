## Things I learned:


* `readdlm` will autimatically read your file values into a multidimentional array, 1000x2 in this case

* `readdlm` will automatically infer the type of the values if you don't specify them, useful if you are reding a mix of Strings and integers

* Unpacking is similar to python, but needs brackets `(x, y) = structure_to_unpack`

* Julia is column major, so if performance is of any concern avoid iterating over rows
