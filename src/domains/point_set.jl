# ------------------------------------------------------------------
# Licensed under the MIT License. See LICENSE in the project root.
# ------------------------------------------------------------------

"""
    PointSet(coords)

A set of points with coordinates `coords`. Each point is represented by
a static vector or tuple. Alternatively, `coords` can be a matrix where
the number of rows equals the number of dimensions.

## Examples

Create a 2D point set with 100 points:

```julia
julia> PointSet(rand(2,100))
```

Or equivalently, using a vector of tuples:

```julia
julia> PointSet([(rand(),rand()) for i in 1:100])
```
"""
struct PointSet{T,N} <: SpatialDomain{T,N}
  coords::Vector{SVector{N,T}} 
end

PointSet(coords::AbstractVector{<:NTuple}) =
  PointSet(SVector.(coords))

PointSet(coords::AbstractMatrix) =
  PointSet(SVector{size(coords,1)}.(eachcol(coords)))

nelms(ps::PointSet) = length(ps.coords)

coordinates!(buff, ps::PointSet, ind::Int) =
  @inbounds buff .= ps.coords[ind]

# ------------
# IO methods
# ------------
function Base.show(io::IO, ps::PointSet{T,N}) where {N,T}
  npts = length(ps.coords)
  print(io, "$npts PointSet{$T,$N}")
end

function Base.show(io::IO, ::MIME"text/plain", ps::PointSet{T,N}) where {N,T}
  println(io, ps)
  Base.print_array(io, reduce(hcat, ps.coords))
end
