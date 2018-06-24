using BinaryProvider
using Compat

const verbose = true #"--verbose" in ARGS
const prefix = Prefix(joinpath(@__DIR__, "usr"))
println("prefix ", prefix)

product = LibraryProduct(prefix, "pa_ringbuffer", :libpa_ringbuffer)
println("product ", product)
println("satisfied ", satisfied(product; verbose=verbose))
@static if Compat.Sys.iswindows()
    l_path = joinpath(libdir(prefix), "libfoo.dll")
    println("l_path ", l_path)
    println(satisfied(l, verbose=true, platform=Windows(Sys.ARCH)))
    satisfied(l; verbose=verbose, platform=Windows(Sys.ARCH)) && write_deps_file(joinpath(@__DIR__, "deps.jl"), [product])
else
    satisfied(product; verbose=verbose) && write_deps_file(joinpath(@__DIR__, "deps.jl"), [product])
end
println(read(joinpath(@__DIR__, "deps.jl"), String))
