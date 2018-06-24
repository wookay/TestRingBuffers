using BinaryProvider

const verbose = true #"--verbose" in ARGS
const prefix = Prefix(get([a for a in ARGS if a != "--verbose"], 1, joinpath(@__DIR__, "usr")))

product = LibraryProduct(prefix, "pa_ringbuffer", :libpa_ringbuffer)
satisfied(product; verbose=verbose) && write_deps_file(joinpath(@__DIR__, "deps.jl"), [product])
