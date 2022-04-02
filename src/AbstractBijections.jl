module AbstractBijections
  using Dictionaries

  import Base: insert!, getindex, inv, length, show, copy

  export Bijection, AbstractBijection, bijection, domain, image, domain_eltype, image_eltype

  abstract type AbstractBijection{D,I} end

  _not_implemented() = error("Not implemented")

  # Apply the Bijective function to an element
  # `x ∈ domain(f)`, resulting in an element `y ∈ image(f)`.
  apply(f::AbstractBijection, x) = _not_implemented()
  inv(f::AbstractBijection) = _not_implemented()
  domain(f::AbstractBijection) = _not_implemented()
  image(f::AbstractBijection) = _not_implemented()
  insert!(f::AbstractBijection, x, y) = _not_implemented()

  apply_inv(f::AbstractBijection, y) = apply(inv(f), y)

  getindex(f::AbstractBijection, x) = apply(f, x)
  length(f::AbstractBijection) = length(domain(f))
  domain_eltype(f::AbstractBijection) = eltype(domain(f))

  function show(io::IO, mime::MIME"text/plain", f::AbstractBijection)
    println(io, typeof(f))
    for (x, y) in zip(domain(f), image(f))
      show(io, x)
      print(io, " ↔ ")
      show(io, y)
      println(io)
    end
    return nothing
  end

  show(io::IO, f::AbstractBijection) = show(io, MIME"text/plain"(), f)

  struct Bijection{D,I,F,FINV} <: AbstractBijection{D,I}
    f::F # D -> I
    finv::FINV # I -> D
    function Bijection(f::F, finv::FINV) where {F,FINV}
      D = keytype(f)
      I = eltype(f)
      @assert keytype(finv) == I
      @assert eltype(finv) == D
      return new{D,I,F,FINV}(f, finv)
    end
  end

  copy(f::Bijection) = Bijection(copy(f.f), copy(f.finv))

  function bijection(F::Type, FINV::Type, domain, image)
    f = F(domain, image)
    finv = FINV(copy(image), copy(domain))
    return Bijection(f, finv)
  end

  function bijection(F_FINV::Type, domain, image)
    return bijection(F_FINV, F_FINV, domain, image)
  end

  bijection(domain, image) = bijection(Dictionary, domain, image)

  ## bijection(image) = Bijection(eachindex(image), image)

  ## function bijection(domain_image)
  ##   f = dictionary(domain_image)
  ##   finv = Dictionary(f.values, f.indices)
  ##   return Bijection(f, finv)
  ## end

  apply(f::Bijection, x) = f.f[x]
  inv(f::Bijection) = Bijection(f.finv, f.f)

  (f::Bijection)(x) = apply(f, x)

  ## domain(f::Bijection) = f.finv.values
  ## image(f::Bijection) = f.f.values

  domain(f::Bijection) = keys(f.f)
  image(f::Bijection) = keys(f.finv)

  function insert!(f::Bijection, x, y)
    insert!(f.f, x, y)
    insert!(f.finv, y, x)
    return f
  end
end # module AbstractBijections
