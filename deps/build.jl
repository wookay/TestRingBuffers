using BinaryProvider
using Compat

@static if Compat.Sys.iswindows()
    BinaryProvider.libdir(prefix::Prefix) = joinpath(prefix, "lib")
end

const verbose = true #"--verbose" in ARGS
const prefix = Prefix(joinpath(@__DIR__, "usr"))

#println("product ", product)
#println("satisfied1 ", satisfied(product; verbose=verbose))
#println("satisfied2 ", satisfied(product; verbose=verbose, platform=Windows(Sys.ARCH)))
#@static if Compat.Sys.iswindows()
#product = FileProduct(joinpath(prefix, "lib"))
#else
#product = LibraryProduct(libdir(prefix), "pa_ringbuffer", :libpa_ringbuffer)
#end
#    l_path = joinpath(libdir(prefix), "pa_ringbuffer.dll")
#    println("l_path ", l_path)
#    println("s ", satisfied(product, verbose=true, platform=Windows(Sys.ARCH)))
#    satisfied(l; verbose=verbose, platform=Windows(Sys.ARCH)) && write_deps_file(joinpath(@__DIR__, "deps.jl"), [product])
#else
#    satisfied(product; verbose=verbose) && write_deps_file(joinpath(@__DIR__, "deps.jl"), [product])
#end
#println(read(joinpath(@__DIR__, "deps.jl"), String))

product = LibraryProduct(prefix, "pa_ringbuffer", :libpa_ringbuffer)
satisfied(product; verbose=verbose) && write_deps_file(joinpath(@__DIR__, "deps.jl"), [product])
