using BinaryProvider
using Compat

const verbose = true #"--verbose" in ARGS
# libraryProduct(dir_path::String, libnames::Vector{String}, variable_name::Symbol, prefix::Prefix) = LibraryProduct(dir_path, libnames, variable_name, prefix)

#function g(dir_path, libnames; platform::Platform = platform_key())
#for f in readdir(dir_path)
#    # Skip any names that aren't a valid dynamic library for the given
#    # platform (note this will cause problems if something compiles a `.so`
#    # on OSX, for instance)
#    if !valid_dl_path(f, platform)
#        continue
#    end
#
#    if verbose
#        Compat.@info("Found a valid dl path $(f) while looking for $(join(libnames, ", "))")
#    end
#
#    # If we found something that is a dynamic library, let's check to see
#    # if it matches our libname:
#    for libname in libnames
#        if startswith(basename(f), libname)
#            dl_path = abspath(joinpath(dir_path), f)
#            if verbose
#                Compat.@info("$(dl_path) matches our search criteria of $(libname)")
#            end
#
#            # If it does, try to `dlopen()` it if the current platform is good
#            if platform == platform_key()
#                hdl = Libdl.dlopen_e(dl_path)
#                if hdl == C_NULL
#                    if verbose
#                        Compat.@info("$(dl_path) cannot be dlopen'ed")
#                    end
#                else
#                    # Hey!  It worked!  Yay!
#                    Libdl.dlclose(hdl)
#                    return dl_path
#                end
#            else
#                # If the current platform doesn't match, then just trust in our
#                # cross-compilers and go with the flow
#                return dl_path
#            end
#        end
#    end
#end
#end
#
#dir_path = joinpath(prefix, "lib")
#dl_path = g(dir_path, ["pa_ringbuffer"])
#Compat.@info :dl_path dl_path

const prefix = Prefix(joinpath(@__DIR__, "usr"))

@static if Compat.Sys.iswindows()
    BinaryProvider.libdir(::Nothing, ::Platform) = joinpath(prefix.path, "lib")
end

product = LibraryProduct(prefix, "pa_ringbuffer", :libpa_ringbuffer)

#`@static if Compat.Sys.iswindows()
#`    product = FileProduct(joinpath(prefix, "lib"), :libpa_ringbuffer)
#`else
#`    product = LibraryProduct(prefix, "pa_ringbuffer", :libpa_ringbuffer)
#`    product = FileProduct(prefix, joinpath("lib", "pa_ringbuffer"), :libpa_ringbuffer)
#`end

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

#println(:libnames, ' ', product.libnames, ' ', product.dir_path)
println(:sat, ' ', satisfied(product; verbose=true))
println(:locate, ' ', locate(product; verbose=true))

satisfied(product; verbose=verbose) && write_deps_file(joinpath(@__DIR__, "deps.jl"), [product])

println(read(joinpath(@__DIR__, "deps.jl"), String))
