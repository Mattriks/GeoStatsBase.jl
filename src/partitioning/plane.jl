# ------------------------------------------------------------------
# Licensed under the MIT License. See LICENSE in the project root.
# ------------------------------------------------------------------

"""
    PlanePartition(normal; tol=1e-6)

A method for partitioning spatial data into a family of hyperplanes defined
by a `normal` direction. Two points `x` and `y` belong to the same
hyperplane when `(x - y) ⋅ normal < tol`.
"""
struct PlanePartition{T,N} <: SPredicatePartitionMethod
  normal::SVector{N,T}
  tol::Float64

  function PlanePartition{T,N}(normal, tol) where {N,T}
    new(normalize(normal), tol)
  end
end

PlanePartition(normal::SVector{N,T}; tol=1e-6) where {T,N} =
  PlanePartition{T,N}(normal, tol)

PlanePartition(normal::NTuple{N,T},; tol=1e-6) where {T,N} =
  PlanePartition(SVector(normal), tol=tol)

(p::PlanePartition)(x, y) = abs((x - y) ⋅ p.normal) < p.tol
