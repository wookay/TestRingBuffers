using BinaryProvider
using Compat

const verbose = true #"--verbose" in ARGS
const prefix = Prefix(joinpath(@__DIR__, "usr"))
println("prefix ", prefix)

product = LibraryProduct(prefix, "pa_ringbuffer", :libpa_ringbuffer)
println("product ", product)
println("satisfied1 ", satisfied(product; verbose=verbose))
println("satisfied2 ", satisfied(product; verbose=verbose, platform=Windows(Sys.ARCH)))
@static if Compat.Sys.iswindows()
    l_path = joinpath(libdir(prefix), "pa_ringbuffer.dll")
    println("l_path ", l_path)
    println("s ", satisfied(l, verbose=true, platform=Windows(Sys.ARCH)))
    satisfied(l; verbose=verbose, platform=Windows(Sys.ARCH)) && write_deps_file(joinpath(@__DIR__, "deps.jl"), [product])
else
    satisfied(product; verbose=verbose) && write_deps_file(joinpath(@__DIR__, "deps.jl"), [product])
end
println(read(joinpath(@__DIR__, "deps.jl"), String))
