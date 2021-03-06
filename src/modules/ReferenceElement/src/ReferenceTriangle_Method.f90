! This program is a part of EASIFEM library
! Copyright (C) 2020-2021  Vikas Sharma, Ph.D
!
! This program is free software: you can redistribute it and/or modify
! it under the terms of the GNU General Public License as published by
! the Free Software Foundation, either version 3 of the License, or
! (at your option) any later version.
!
! This program is distributed in the hope that it will be useful,
! but WITHOUT ANY WARRANTY; without even the implied warranty of
! MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
! GNU General Public License for more details.
!
! You should have received a copy of the GNU General Public License
! along with this program.  If not, see <https: //www.gnu.org/licenses/>
!

!> authors: Vikas Sharma, Ph. D.
! date: 5 March 2021
! summary: 	This module contains method for [[ReferenceTriangle_]] data type.

MODULE ReferenceTriangle_Method
USE GlobalData
USE BaseType
IMPLICIT NONE
PRIVATE

!----------------------------------------------------------------------------
!                                                         Initiate@Triangle
!----------------------------------------------------------------------------

!> authors: Vikas Sharma, Ph. D.
! date: 	3 March 2021
! summary: This routine constructs an instance of [[ReferenceTriangle_]]
!
!### Introduction
! * This routine contructs an instance of [[ReferenceTriangle_]]
! * User can specify the coordinates of the trinagle
!@note
! 	This routine will contruct a three node triangle. Also, SHAPE(XiJ) = [3,3]
!@endnote
!
!### Usage
!
!```fortran
! subroutine test1
!   type( ReferenceTriangle_ ) :: obj
!   real( dfp ) :: xij( 3, 3 )
!   xij( 1, 1:3 ) = [1.0, 2.0, 1.0]
!   xij( 2, 1:3 ) = [0.0, 0.0, 1.0]
!   xij( 3, : ) = 0.0
!   call initiate( obj, nsd = 2, xij = xij )
!   call display( obj, "obj : " )
! end
!```

INTERFACE
MODULE PURE SUBROUTINE initiate_ref_Triangle( Obj, NSD, XiJ )
  CLASS( ReferenceTriangle_ ), INTENT( INOUT ) :: Obj
  INTEGER( I4B ), INTENT( IN ) :: NSD
  REAL( DFP ), INTENT( IN ), OPTIONAL :: XiJ( :, : )
END SUBROUTINE initiate_ref_Triangle
END INTERFACE

INTERFACE Initiate
  MODULE PROCEDURE initiate_ref_Triangle
END INTERFACE Initiate

PUBLIC :: Initiate

!----------------------------------------------------------------------------
!                                                 ReferenceTriangle@Triangle
!----------------------------------------------------------------------------

!> authors: Vikas Sharma, Ph. D.
! date: 	3 March 2021
! summary: This function returns an instance of [[ReferenceTriangle_]]
!
!### Introduction
! * This routine contructs an instance of [[ReferenceTriangle_]]
! * User can specify the coordinates of the trinagle
!@note
! 	This routine will contruct a three node triangle. Also, SHAPE(XiJ) = [3,3]
!@endnote
!
!### Usage
!
!```fortran
! subroutine test2
!   type( ReferenceTriangle_ ) :: obj
!   obj = referenceTriangle( nsd = 2 )
!   call display( obj, "obj : " )
! end
!```

INTERFACE
MODULE PURE FUNCTION reference_Triangle(NSD, XiJ) RESULT( Obj )
  INTEGER( I4B ), INTENT( IN ) :: NSD
  REAL( DFP ), INTENT( IN ), OPTIONAL :: XiJ(:,:)
  TYPE( ReferenceTriangle_ ) :: Obj
END FUNCTION reference_Triangle
END INTERFACE

INTERFACE ReferenceTriangle
  MODULE PROCEDURE reference_Triangle
END INTERFACE ReferenceTriangle

PUBLIC :: ReferenceTriangle

!----------------------------------------------------------------------------
!                                         ReferenceTriangle_Pointer@Triangle
!----------------------------------------------------------------------------

!> authors: Vikas Sharma, Ph. D.
! date: 	3 March 2021
! summary: This function returns an instance of [[ReferenceTriangle_]]
!
!### Introduction
! * This routine contructs an instance of [[ReferenceTriangle_]]
! * User can specify the coordinates of the trinagle
!@note
! 	This routine will contruct a three node triangle. Also, SHAPE(XiJ) = [3,3]
!@endnote
!
!### Usage
!
!```fortran
! subroutine test3
!   class( ReferenceElement_ ), pointer :: obj => null()
!   obj => referenceTriangle_pointer( nsd = 2 )
!   call display( obj, "obj : " )
! end
!```

INTERFACE
MODULE PURE FUNCTION reference_Triangle_pointer(NSD, XiJ) RESULT( Obj )
  INTEGER( I4B ), INTENT( IN ) :: NSD
  REAL( DFP ), INTENT( IN ), OPTIONAL :: XiJ(:,:)
  CLASS( ReferenceTriangle_ ), POINTER :: Obj
END FUNCTION reference_Triangle_pointer
END INTERFACE

INTERFACE ReferenceTriangle_Pointer
  MODULE PROCEDURE reference_Triangle_Pointer
END INTERFACE ReferenceTriangle_Pointer

PUBLIC :: ReferenceTriangle_Pointer

!----------------------------------------------------------------------------
!                                                   LagrangeElement@Triangle
!----------------------------------------------------------------------------

!> authors: Vikas Sharma, Ph. D.
! date: 1 March 2021
! summary: Returns lagrange Triangle element of higher order
!
!### Introduction
! 	This routine retuns the lagrance element of higher order
! This routine will be called by [[ReferenceTriangle_:LagrangeElement]]
! Currently upto 3rd order triangle elements are supported.
!
!
!### Usage
!
!```fortran
! subroutine test4
!   class( ReferenceElement_ ), pointer :: obj_ptr => null()
!   type( ReferenceTriangle_ ) :: obj
!   obj_ptr => referenceTriangle_pointer( nsd = 2 )
!   call obj_ptr%LagrangeElement( order = 2, HighOrderObj = obj )
!   call display( obj, "higher order obj : ")
!   call obj_ptr%LagrangeElement( order = 3, HighOrderObj = obj )
!   call display( obj, "3rd order obj : ")
! end
!```

INTERFACE
MODULE PURE SUBROUTINE LagrangeElement_Triangle( RefElem, Order, Obj )
  CLASS( ReferenceElement_ ), INTENT( IN ) :: RefElem
  INTEGER( I4B ), INTENT( IN ) :: Order
  CLASS( ReferenceElement_ ), INTENT( INOUT) ::  Obj
END SUBROUTINE LagrangeElement_Triangle
END INTERFACE

!----------------------------------------------------------------------------
!                                                 MeasureSimplex@Triangle
!----------------------------------------------------------------------------

!> authors: Vikas Sharma, Ph. D.
! date: 5 March 2021
! summary: Returns the measure of linear triangle
!
!### Introduction
!
! This function returns the measure of linear triangle. This function belongs to the generic function [[ReferenceElement_Method:MeasureSimplex]].
!
!@note
! 	This function is private
!@endnote
!
!### Usage
!
!```fortran
!
!```

INTERFACE
MODULE PURE FUNCTION Measure_Simplex_Triangle( RefElem, XiJ ) RESULT( Ans )
  CLASS( ReferenceTriangle_ ), INTENT( IN ) :: RefElem
  REAL( DFP ), INTENT( IN ) :: XiJ( :, : )
  REAL( DFP ) :: Ans
END FUNCTION Measure_Simplex_Triangle
END INTERFACE

PUBLIC :: Measure_Simplex_Triangle

!----------------------------------------------------------------------------
!                                                            Angles@Triangle
!----------------------------------------------------------------------------

!> authors: Vikas Sharma, Ph. D.
! date: 	5 March 2021
! summary: Returns three angles of a triangle

INTERFACE
MODULE FUNCTION triangle_angles( refelem, xij ) RESULT( Ans )
  CLASS(ReferenceTriangle_), INTENT( IN ) :: refelem
  REAL( DFP ), INTENT( IN ) :: xij(:,:)
  REAL( DFP ) :: Ans(3)
END FUNCTION triangle_angles
END INTERFACE

INTERFACE Angles
  MODULE PROCEDURE triangle_angles
END INTERFACE Angles

PUBLIC :: Angles

!----------------------------------------------------------------------------
!                                                             Area@Triangle
!----------------------------------------------------------------------------

!> authors: Vikas Sharma, Ph. D.
! date: 	5 March 2021
! summary: 	Returns the area of triangle

INTERFACE
MODULE FUNCTION triangle_area( refelem, xij ) RESULT( Ans )
  CLASS(ReferenceTriangle_), INTENT( IN ) :: refelem
  REAL( DFP ), INTENT( IN ) :: xij(:,:)
  REAL( DFP ) :: Ans
END FUNCTION triangle_area
END INTERFACE

INTERFACE Area
  MODULE PROCEDURE triangle_area
END INTERFACE Area

PUBLIC :: Area

!----------------------------------------------------------------------------
!                                                        AreaVector@Triangle
!----------------------------------------------------------------------------

!> authors: Vikas Sharma, Ph. D.
! date: 5 March 2021
! summary: Returns the area vector

INTERFACE
MODULE FUNCTION triangle_areaVector( refelem, xij ) RESULT( Ans )
  CLASS(ReferenceTriangle_), INTENT( IN ) :: refelem
  REAL( DFP ), INTENT( IN ) :: xij(:,:)
  REAL( DFP ) :: Ans( 3 )
END FUNCTION triangle_areaVector
END INTERFACE

INTERFACE AreaVector
  MODULE PROCEDURE triangle_areaVector
END INTERFACE AreaVector

PUBLIC :: AreaVector

!----------------------------------------------------------------------------
!                                                      Barycentric@Triangle
!----------------------------------------------------------------------------

!> authors: Vikas Sharma, Ph. D.
! date: 	5 March 2021
! summary: Returns the barycentric coordinates of triangle

INTERFACE
MODULE FUNCTION triangle_barycentric( refelem, xij, x ) RESULT( Ans )
  CLASS(ReferenceTriangle_), INTENT( IN ) :: refelem
  REAL( DFP ), INTENT( IN ) :: xij(:,:)
  REAL( DFP ), INTENT( IN ) :: x( : )
  REAL( DFP ) :: Ans( 3 )
END FUNCTION triangle_barycentric
END INTERFACE

INTERFACE Barycentric
  MODULE PROCEDURE triangle_barycentric
END INTERFACE Barycentric

PUBLIC :: Barycentric

!----------------------------------------------------------------------------
!                                                          Centroid@Triangle
!----------------------------------------------------------------------------

!> authors: Vikas Sharma, Ph. D.
! date: 	5 March 2021
! summary: Returns the centroid of a triangle

INTERFACE
MODULE FUNCTION triangle_centroid( refelem, xij ) RESULT( Ans )
  CLASS(ReferenceTriangle_), INTENT( IN ) :: refelem
  REAL( DFP ), INTENT( IN ) :: xij(:,:)
  REAL( DFP ) :: Ans(3)
END FUNCTION triangle_centroid
END INTERFACE

INTERFACE Centroid
  MODULE PROCEDURE triangle_centroid
END INTERFACE Centroid

PUBLIC :: Centroid

!----------------------------------------------------------------------------
!                                                      CircumCenter@Triangle
!----------------------------------------------------------------------------

!> authors: Vikas Sharma, Ph. D.
! date: 	5 March 2021
! summary: 	Returns the circum center of the triangle

INTERFACE
MODULE FUNCTION triangle_circumcentre(  refelem, xij ) RESULT( Ans )
  CLASS( ReferenceTriangle_ ), INTENT( IN ) :: refelem
  REAL( DFP ), INTENT( IN ) :: xij(:,:)
  REAL( DFP ) :: Ans(3)
END FUNCTION triangle_circumcentre
END INTERFACE

INTERFACE CircumCenter
  MODULE PROCEDURE triangle_circumcentre
END INTERFACE CircumCenter

PUBLIC :: CircumCenter

!----------------------------------------------------------------------------
!                                                      CircumCircle@Triangle
!----------------------------------------------------------------------------

!> authors: Vikas Sharma, Ph. D.
! date: 	5 March 2021
! summary: Returns circum circle of triangle

INTERFACE
MODULE FUNCTION triangle_circumcircle( refelem, xij ) RESULT( Ans )
  CLASS( ReferenceTriangle_ ), INTENT( IN ) :: refelem
  REAL( DFP ), INTENT( IN ) :: xij(:,:)
  REAL( DFP ) :: Ans(4)
    !! Ans(1) = radius and Ans(2:4) center
END FUNCTION triangle_circumcircle
END INTERFACE

INTERFACE CircumCircle
  MODULE PROCEDURE triangle_circumcircle
END INTERFACE CircumCircle

PUBLIC :: CircumCircle

!----------------------------------------------------------------------------
!                                                      CircumRadius@Triangle
!----------------------------------------------------------------------------

INTERFACE
MODULE FUNCTION triangle_circumradius( refelem, xij ) RESULT( Ans )
  CLASS( ReferenceTriangle_ ), INTENT( IN ) :: refelem
  REAL( DFP ), INTENT( IN ) :: xij(:,:)
  REAL( DFP ) :: Ans
END FUNCTION triangle_circumradius
END INTERFACE

INTERFACE CircumRadius
  MODULE PROCEDURE triangle_circumradius
END INTERFACE CircumRadius

PUBLIC :: CircumRadius

!----------------------------------------------------------------------------
!                                                     ContainsLine@Triangle
!----------------------------------------------------------------------------

INTERFACE
MODULE SUBROUTINE triangle_contains_line( refelem, xij, x1, x2, &
  & parametricLine, inside, xint )
  CLASS( ReferenceTriangle_ ), INTENT( IN ) :: refelem
  REAL( DFP ), INTENT( IN ) :: xij(:,:), x1(3), x2(3)
  LOGICAL(LGT), INTENT( IN ) :: parametricLine
  LOGICAL(LGT), INTENT (OUT) :: inside
  REAL( DFP ), INTENT( OUT ) :: xint(3)
END SUBROUTINE triangle_contains_line
END INTERFACE

INTERFACE ContainsLine
  MODULE PROCEDURE triangle_contains_line
END INTERFACE ContainsLine

PUBLIC :: ContainsLine

!----------------------------------------------------------------------------
!                                                    ContainsPoint@Triangle
!----------------------------------------------------------------------------

INTERFACE
MODULE FUNCTION triangle_contains_point( refelem, xij, x ) RESULT( Ans )
  CLASS( ReferenceTriangle_ ), INTENT( IN ) :: refelem
  REAL( DFP ), INTENT( IN ) :: xij(:,:), x(:)
  LOGICAL(LGT) :: Ans
END FUNCTION triangle_contains_point
END INTERFACE

PUBLIC :: triangle_contains_point

!----------------------------------------------------------------------------
!                                                         Diameter@Triangle
!----------------------------------------------------------------------------

INTERFACE
MODULE FUNCTION triangle_diameter( refelem, xij ) RESULT( Ans )
  CLASS( ReferenceTriangle_ ), INTENT( IN ) :: refelem
  REAL( DFP ), INTENT( IN ) :: xij(:,:)
  REAL( DFP ) :: Ans
END FUNCTION triangle_diameter
END INTERFACE

INTERFACE diameter
  MODULE PROCEDURE triangle_diameter
END INTERFACE diameter

PUBLIC :: diameter

!----------------------------------------------------------------------------
!                                                       EdgeLength@Triangle
!----------------------------------------------------------------------------

INTERFACE
MODULE FUNCTION triangle_edge_length( refelem, xij ) RESULT( Ans )
  CLASS( ReferenceTriangle_ ), INTENT( IN ) :: refelem
  REAL( DFP ) , INTENT( IN ) :: xij(:,:)
  REAL( DFP ) :: Ans(3)
END FUNCTION triangle_edge_length
END INTERFACE

INTERFACE EdgeLength
  MODULE PROCEDURE triangle_edge_length
END INTERFACE EdgeLength

PUBLIC :: EdgeLength

!----------------------------------------------------------------------------
!                                                         Incenter@Triangle
!----------------------------------------------------------------------------

INTERFACE
MODULE FUNCTION triangle_incenter( refelem, xij ) RESULT( Ans )
  CLASS( ReferenceTriangle_ ), INTENT( IN ) :: refelem
  REAL( DFP ) , INTENT( IN ) :: xij(:,:)
  REAL( DFP ) :: Ans(3)
END FUNCTION triangle_incenter
END INTERFACE

INTERFACE Incenter
  MODULE PROCEDURE triangle_incenter
END INTERFACE Incenter

PUBLIC :: Incenter

!----------------------------------------------------------------------------
!                                                         Incircle@Triangle
!----------------------------------------------------------------------------

INTERFACE
MODULE FUNCTION triangle_incircle( refelem, xij ) RESULT( Ans )
  CLASS( ReferenceTriangle_ ), INTENT( IN ) :: refelem
  REAL( DFP ) , INTENT( IN ) :: xij(:,:)
  REAL( DFP ) :: Ans(4)
END FUNCTION triangle_incircle
END INTERFACE

INTERFACE Incircle
  MODULE PROCEDURE triangle_incircle
END INTERFACE Incircle

PUBLIC :: Incircle

!----------------------------------------------------------------------------
!                                                         Inradius@Triangle
!----------------------------------------------------------------------------

INTERFACE
MODULE FUNCTION triangle_inradius( refelem, xij ) RESULT( Ans )
  CLASS( ReferenceTriangle_ ), INTENT( IN ) :: refelem
  REAL( DFP ) , INTENT( IN ) :: xij(:,:)
  REAL( DFP ) :: Ans
END FUNCTION triangle_inradius
END INTERFACE

INTERFACE Inradius
  MODULE PROCEDURE triangle_inradius
END INTERFACE Inradius

PUBLIC :: Inradius

!----------------------------------------------------------------------------
!                                                      Orthocenter@Triangle
!----------------------------------------------------------------------------

INTERFACE
MODULE FUNCTION triangle_orthocenter( refelem, xij ) RESULT( Ans )
  CLASS( ReferenceTriangle_ ), INTENT( IN ) :: refelem
  REAL( DFP ) , INTENT( IN ) :: xij(:,:)
  REAL( DFP ) :: Ans( 3 )
END FUNCTION triangle_orthocenter
END INTERFACE

INTERFACE Orthocenter
  MODULE PROCEDURE triangle_orthocenter
END INTERFACE Orthocenter

PUBLIC :: Orthocenter

!----------------------------------------------------------------------------
!                                                DistanceFromPoint@Triangle
!----------------------------------------------------------------------------

INTERFACE
MODULE FUNCTION triangle_point_dist( refelem, xij, x ) &
  & RESULT( Ans )
  CLASS( ReferenceTriangle_ ), INTENT( IN ) :: refelem
  REAL( DFP ) , INTENT( IN ) :: xij(:,:), x(:)
  REAL( DFP ) :: Ans
END FUNCTION triangle_point_dist
END INTERFACE

INTERFACE DistanceFromPoint
  MODULE PROCEDURE triangle_point_dist
END INTERFACE DistanceFromPoint

PUBLIC :: DistanceFromPoint

!----------------------------------------------------------------------------
!                                                      NearestPoint@Triangle
!----------------------------------------------------------------------------

INTERFACE
MODULE SUBROUTINE triangle_get_nearest_point( refelem, xij, x, xn, dist )
  CLASS( ReferenceTriangle_ ), INTENT( IN ) :: refelem
  REAL( DFP ) , INTENT( IN ) :: xij(:,:), x(:)
  REAL( DFP ) , INTENT (INOUT) :: xn(:)
  REAL( DFP ), INTENT (OUT) :: dist
END SUBROUTINE triangle_get_nearest_point
END INTERFACE

INTERFACE NearestPoint
  MODULE PROCEDURE triangle_get_nearest_point
END INTERFACE NearestPoint

PUBLIC :: NearestPoint

!----------------------------------------------------------------------------
!                                                       RandomPoint@Triangle
!----------------------------------------------------------------------------

INTERFACE
MODULE FUNCTION triangle_random_point( refelem, xij, n, seed ) RESULT( Ans )
  CLASS( ReferenceTriangle_ ), INTENT( IN ) :: refelem
  REAL( DFP ), INTENT( IN ) :: xij(:,:)
  INTEGER( I4B ) :: n, seed
  REAL( DFP ) :: Ans(3, n)
END FUNCTION triangle_random_point
END INTERFACE

INTERFACE RandomPoint
  MODULE PROCEDURE triangle_random_point
END INTERFACE RandomPoint

PUBLIC :: RandomPoint

!----------------------------------------------------------------------------
!                                                          Quality@Triangle
!----------------------------------------------------------------------------

INTERFACE
MODULE FUNCTION triangle_quality( refelem, xij, measure ) RESULT( Ans )
  CLASS( ReferenceTriangle_ ), INTENT( IN ) :: refelem
  REAL( DFP ) , INTENT( IN ) :: xij(:,:)
  INTEGER( I4B ), INTENT( IN ) :: measure
  REAL( DFP ) :: Ans
END FUNCTION triangle_quality
END INTERFACE

PUBLIC :: triangle_quality

END MODULE ReferenceTriangle_Method