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
! date: 2 March 2021
! summary: This submodule contains method for [[ReferenceQuadrangle_]]

SUBMODULE( ReferenceQuadrangle_Method ) Methods
USE BaseMethod
IMPLICIT NONE
CONTAINS

!----------------------------------------------------------------------------
!                                                                  Initiate
!----------------------------------------------------------------------------

MODULE PROCEDURE Initiate_ref_Quadrangle
  IF( PRESENT( XiJ ) ) THEN
    Obj % XiJ = XiJ
  ELSE
    Obj % XiJ =  RESHAPE( [-1, -1, 0, 1, -1, 0, 1, 1, 0, -1, 1, 0], [3, 4] )
  END IF
  Obj % EntityCounts = [4, 4, 1, 0]
  Obj % XiDimension = 2
  Obj % Name = Quadrangle4
  Obj % Order = 1
  Obj % NSD = NSD
  ALLOCATE( Obj % Topology( 9 ) )
  Obj % Topology( 1 ) = ReferenceTopology( [1], Point )
  Obj % Topology( 2 ) = ReferenceTopology( [2], Point )
  Obj % Topology( 3 ) = ReferenceTopology( [3], Point )
  Obj % Topology( 4 ) = ReferenceTopology( [4], Point )
  Obj % Topology( 5 ) = ReferenceTopology( [1, 2], Line2 )
  Obj % Topology( 6 ) = ReferenceTopology( [2, 3], Line2 )
  Obj % Topology( 7 ) = ReferenceTopology( [3, 4], Line2 )
  Obj % Topology( 8 ) = ReferenceTopology( [4, 1], Line2 )
  Obj % Topology( 9 ) = ReferenceTopology( [1, 2, 3, 4], Quadrangle4 )
  Obj % LagrangeElement => LagrangeElement_Quadrangle
END PROCEDURE Initiate_ref_Quadrangle

!----------------------------------------------------------------------------
!                                                       ReferenceQuadrangle
!----------------------------------------------------------------------------

MODULE PROCEDURE reference_Quadrangle
  IF( PRESENT( XiJ ) ) THEN
    CALL Initiate( Obj, NSD, XiJ )
  ELSE
    CALL Initiate( Obj, NSD )
  END IF
END PROCEDURE reference_Quadrangle

!----------------------------------------------------------------------------
!                                               ReferenceQuadrangle_Pointer
!----------------------------------------------------------------------------

MODULE PROCEDURE reference_Quadrangle_Pointer
  ALLOCATE( Obj )
  IF( PRESENT( XiJ ) ) THEN
    CALL Initiate( Obj, NSD, XiJ )
  ELSE
    CALL Initiate( Obj, NSD )
  END IF
END PROCEDURE reference_Quadrangle_Pointer


!----------------------------------------------------------------------------
!                                                            LagrangePoints
!----------------------------------------------------------------------------

!----------------------------------------------------------------------------
!                                                  LagrangePoints@Quadrangle
!----------------------------------------------------------------------------

!> authors: Vikas Sharma, Ph. D.
! date: 3 March 2021
! summary: This function returns coordinates of higher order Lagrange [[ReferenceQuadrangle_]] element.
!
!### Introduction
! * Returns equidistant points on [-1,1] for lagrange interpolation
!	* Nodecoord is a 2D array with 3 rows
!	* first row is xi, second row is eta, third row is zeta

PURE FUNCTION EquidistanceLIP_Quadrangle( XiJ, Order ) RESULT( NodeCoord )
  REAL( DFP ), INTENT( IN ) :: XiJ( 3, 4 )
  INTEGER( I4B ), INTENT( IN ) :: Order
  REAL( DFP ) :: NodeCoord( 3, ( Order + 1 ) ** 2 )

  NodeCoord( 1:3, 1:4 ) = XiJ( 1:3, 1:4 )

  SELECT CASE( Order )
  CASE( 2 )
    NodeCoord( 1:3, 5 ) = 0.5_DFP * (XiJ( 1:3, 1 ) + XiJ( 1:3, 2 ))
    NodeCoord( 1:3, 6 ) = 0.5_DFP * (XiJ( 1:3, 2 ) + XiJ( 1:3, 3 ))
    NodeCoord( 1:3, 7 ) = 0.5_DFP * (XiJ( 1:3, 3 ) + XiJ( 1:3, 4 ))
    NodeCoord( 1:3, 8 ) = 0.5_DFP * (XiJ( 1:3, 4 ) + XiJ( 1:3, 1 ))
    NodeCoord( 1:3, 9 ) = 0.5_DFP * (NodeCoord(1:3, 6) + NodeCoord( 1:3, 8 ))
  CASE( 3 )
    NodeCoord( 1:3, 5 ) = N1(-0.5_DFP) * XiJ( 1:3, 1 ) + N2(-0.5_DFP) * XiJ( 1:3, 2 )
    NodeCoord( 1:3, 6 ) = N1(0.5_DFP) * XiJ( 1:3, 1 ) + N2(0.5_DFP) * XiJ( 1:3, 2 )

    NodeCoord( 1:3, 7 ) = N1(-0.5_DFP) * XiJ( 1:3, 2 ) + N2(-0.5_DFP) * XiJ( 1:3, 3 )
    NodeCoord( 1:3, 8 ) = N1(0.5_DFP) * XiJ( 1:3, 2 ) + N2(0.5_DFP) * XiJ( 1:3, 3 )

    NodeCoord( 1:3, 10 ) = N1(-0.5_DFP) * XiJ( 1:3, 4 ) + N2(-0.5_DFP) * XiJ( 1:3, 4 )
    NodeCoord( 1:3, 9 ) = N1(0.5_DFP) * XiJ( 1:3, 4 ) + N2(0.5_DFP) * XiJ( 1:3, 4 )

    NodeCoord( 1:3, 12 ) = N1(-0.5_DFP) * XiJ( 1:3, 1 ) + N2(-0.5_DFP) * XiJ( 1:3, 4 )
    NodeCoord( 1:3, 11 ) = N1(0.5_DFP) * XiJ( 1:3, 1 ) + N2(0.5_DFP) * XiJ( 1:3, 4 )
  END SELECT

  CONTAINS
  PURE REAL( DFP ) FUNCTION N1( x )
    REAL( DFP ), INTENT( IN ) ::  x
    N1 = 0.5_DFP * ( 1.0_DFP - x )
  END FUNCTION

  PURE REAL( DFP ) FUNCTION N2( x )
    REAL( DFP ), INTENT( IN ) ::  x
    N2 = 0.5_DFP * ( 1.0_DFP + x )
  END FUNCTION

END FUNCTION EquidistanceLIP_Quadrangle

!----------------------------------------------------------------------------
!                                                            LagrangeElement
!----------------------------------------------------------------------------

MODULE PROCEDURE LagrangeElement_Quadrangle
  INTEGER( I4B ) :: NNS, I

  CALL DeallocateData( Obj )
  SELECT CASE( Order )
  CASE( 1 )
    CALL Initiate( Obj=Obj, AnotherObj=RefElem )
  CASE( 2 )
    Obj % XiJ = EquidistanceLIP_Quadrangle( RefElem%XiJ(1:3, 1:4), Order )
    NNS = 9
    Obj % EntityCounts = [NNS, 4, 1, 0]
    Obj % XiDimension = 2
    Obj % Name = Quadrangle9
    Obj % Order = Order
    Obj % NSD = RefElem % NSD
    ALLOCATE( Obj % Topology( SUM( Obj % EntityCounts) ) )
    DO I = 1, NNS
      Obj % Topology( I ) = ReferenceTopology( [I], Point )
    END DO
    Obj % Topology( NNS + 1 ) = ReferenceTopology( [1, 2, 5], Line3 )
    Obj % Topology( NNS + 2 ) = ReferenceTopology( [2, 3, 6], Line3 )
    Obj % Topology( NNS + 3 ) = ReferenceTopology( [3, 4, 7], Line3 )
    Obj % Topology( NNS + 4 ) = ReferenceTopology( [4, 1, 8], Line3 )

    Obj % Topology( NNS + 5 ) = ReferenceTopology( [1,2,3,4,5,6,7,8,9], Obj%Name )
    Obj % LagrangeElement => RefElem % LagrangeElement
  CASE( 3 )
    Obj % XiJ = EquidistanceLIP_Quadrangle( RefElem%XiJ(1:3, 1:4), Order )
    NNS = 16
    Obj % EntityCounts = [NNS, 4, 1, 0]
    Obj % XiDimension = 2
    Obj % Name = Quadrangle16
    Obj % Order = Order
    Obj % NSD = RefElem % NSD
    ALLOCATE( Obj % Topology( SUM( Obj % EntityCounts) ) )
    DO I = 1, NNS
      Obj % Topology( I ) = ReferenceTopology( [I], Point )
    END DO
    Obj % Topology( NNS + 1 ) = ReferenceTopology( [1, 2, 5, 6], Line4 )
    Obj % Topology( NNS + 2 ) = ReferenceTopology( [2, 3, 7, 8], Line4 )
    Obj % Topology( NNS + 3 ) = ReferenceTopology( [3, 4, 9, 10], Line4 )
    Obj % Topology( NNS + 4 ) = ReferenceTopology( [4, 1, 11, 12], Line4 )
    Obj % Topology( NNS + 5 ) = ReferenceTopology( arange(1,NNS,1), Obj%Name)
    Obj % LagrangeElement => RefElem % LagrangeElement
  END SELECT
END PROCEDURE LagrangeElement_Quadrangle

!----------------------------------------------------------------------------
!                                                              MeasureSimplex
!----------------------------------------------------------------------------

MODULE PROCEDURE Measure_Simplex_Quadrangle
  IF( refelem%nsd .EQ. 2 ) THEN
    CALL QUADAREA2D( XiJ( 1:2, 1:4 ), Ans )
  ELSE
    CALL QUADAREA3D( XiJ( 1:3, 1:4 ), Ans )
  END IF
END PROCEDURE Measure_Simplex_Quadrangle

!----------------------------------------------------------------------------
!
!----------------------------------------------------------------------------

MODULE PROCEDURE Quadrangle_quality
END PROCEDURE Quadrangle_quality

!----------------------------------------------------------------------------
!
!----------------------------------------------------------------------------

#include "./modified_burkardt.inc"

END SUBMODULE Methods