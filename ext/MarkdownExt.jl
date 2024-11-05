module MarkdownExt

using Markdown: Markdown, @md_str, term
using DontMaterialize: dont_materialize

@static if isdefined(Base.Experimental, :register_error_hint)
    function __init__()
        Base.Experimental.register_error_hint(MethodError) do io, exc, argtypes, kwargs
            if exc.f === dont_materialize
                println(io, "\n")
                term(io, md"""
                `dont_materialize` (also known as `lazy`) is not meant to be called directly on arguments like a regular function, it only works in broadcast expressions. For example, `lazy(x .+ x)` should be replaced with `lazy.(x .+ x)`
                """)
                print(io, "\n\n")
            end
        end
    end
end

end
