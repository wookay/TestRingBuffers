using BinaryProvider

const verbose = "--verbose" in ARGS
const prefix = Prefix(joinpath(@__DIR__, "usr"))

product = LibraryProduct(prefix, "pa_ringbuffer", :libpa_ringbuffer)
satisfied(product; verbose=verbose) && write_deps_file(joinpath(@__DIR__, "deps.jl"), [product])
