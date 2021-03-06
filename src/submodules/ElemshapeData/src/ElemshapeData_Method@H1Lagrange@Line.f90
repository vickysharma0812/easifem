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

SUBMODULE( ElemshapeData_Method : H1Lagrange ) Line
USE BaseMethod
IMPLICIT NONE

CONTAINS

MODULE PROCEDURE Line_H1_Lagrange
  INTEGER( I4B ) :: nips
  REAL( DFP ), ALLOCATABLE :: Xi( :, : )

  CALL Initiate( Obj % RefElem, RefElem )
  CALL getQuadraturePoints( Obj = Quad, Point = Xi,  Weight = Obj % Ws )
  Obj % Quad = Quad
  nips = SIZE( Obj % Ws )

  SELECT CASE( refelem%order )
  CASE( 1 )
  BLOCK
    !                 define internal variables
    REAL( DFP ) :: x( 2 )
    !         ....................................         !

    call AllocateData( obj = obj, nsd = refelem % nsd, &
      & xidim = refelem % xidimension, nns = 2, nips = nips )
    x = RefElem % XiJ( 1, 1:2 )
    Obj % N( 1, : ) = ( Xi( 1, : ) - x( 2 ) ) / ( x( 1 ) - x( 2 ) )
    Obj % N( 2, : ) = 1.0_DFP - Obj % N( 1, : )
    Obj % dNdXi( 1, 1, : ) = 1.0_DFP / ( x( 1 ) - x( 2 ) )
    Obj % dNdXi( 2, 1, : ) = 1.0_DFP / ( x( 2 ) - x( 1 ) )
  END BLOCK
  !---------------------------------------------------------------!
  !---------------------------------------------------------------!
  CASE( 2 )
  BLOCK
    !                 define internal variables
    REAL( DFP ) :: X( 3 )
    !         ....................................         !

    call AllocateData( obj = obj, nsd = refelem % nsd, &
    & xidim = refelem % xidimension, nns = 3, nips = nips )

    X = RefElem % XiJ( 1, 1:3 )

    Obj % N( 1, : ) = &
      &   ( Xi( 1, : ) - X( 2 ) ) &
      & * ( Xi( 1, : ) - X( 3 ) ) &
      & / (     X( 1 ) - X( 2 ) ) &
      & / (     X( 1 ) - X( 3 ) )

    Obj % N( 2, : ) = &
      &   ( Xi( 1, : ) - X( 1 ) ) &
      & * ( Xi( 1, : ) - X( 3 ) ) &
      & / (     X( 2 ) - X( 1 ) ) &
      & / (     X( 2 ) - X( 3 ) )

    Obj % N( 3, : ) = &
      &   ( Xi( 1, : ) - X( 1 ) ) &
      & * ( Xi( 1, : ) - X( 2 ) ) &
      & / (     X( 3 ) - X( 1 ) ) &
      & / (     X( 3 ) - X( 2 ) )

    Obj % dNdXi( 1, 1, : ) = &
      & ( 2.0_DFP * Xi( 1, : ) - X( 2 ) - X( 3 ) ) &
      & / ( X( 1 ) - X( 2 ) ) &
      & / ( X( 1 ) - X( 3 ) )

    Obj % dNdXi( 2, 1, : ) = &
      & ( 2.0_DFP * Xi( 1, : ) - X( 1 ) - X( 3 ) ) &
      & / ( X( 2 ) - X( 1 ) ) &
      & / ( X( 2 ) - X( 3 ) )

    Obj % dNdXi( 3, 1, : ) = &
      & ( 2.0_DFP * Xi( 1, : ) - X( 1 ) - X( 2 ) ) &
      & / ( X( 3 ) - X( 1 ) ) &
      & / ( X( 3 ) - X( 2 ) )
  END BLOCK
  !---------------------------------------------------------------!
  !---------------------------------------------------------------!
  CASE( 3 )
    BLOCK
      !                 define internal variables
      REAL( DFP ) :: X( 4 ), DummyReal
      !         ....................................         !

      call AllocateData( obj = obj, nsd = refelem % nsd, &
        & xidim = refelem % xidimension, nns = 4, nips = nips )

      X = RefElem % XiJ( 1, 1:4 )

      Obj % N( 1, : ) = &
        &   ( Xi( 1, : ) - X( 2 ) ) &
        & * ( Xi( 1, : ) - X( 3 ) ) &
        & * ( Xi( 1, : ) - X( 4 ) ) &
        & / (     X( 1 ) - X( 2 ) ) &
        & / (     X( 1 ) - X( 3 ) ) &
        & / (     X( 1 ) - X( 4 ) )

      Obj % N( 2, : ) = &
        &   ( Xi( 1, : ) - X( 1 ) ) &
        & * ( Xi( 1, : ) - X( 3 ) ) &
        & * ( Xi( 1, : ) - X( 4 ) ) &
        & / (     X( 2 ) - X( 1 ) ) &
        & / (     X( 2 ) - X( 3 ) ) &
        & / (     X( 2 ) - X( 4 ) )

      Obj % N( 3, : ) = &
        &   ( Xi( 1, : ) - X( 1 ) ) &
        & * ( Xi( 1, : ) - X( 2 ) ) &
        & * ( Xi( 1, : ) - X( 4 ) ) &
        & / (     X( 3 ) - X( 1 ) ) &
        & / (     X( 3 ) - X( 2 ) ) &
        & / (     X( 3 ) - X( 4 ) )

      Obj % N( 4, : ) = &
        &   ( Xi( 1, : ) - X( 1 ) ) &
        & * ( Xi( 1, : ) - X( 2 ) ) &
        & * ( Xi( 1, : ) - X( 3 ) ) &
        & / (     X( 4 ) - X( 1 ) ) &
        & / (     X( 4 ) - X( 2 ) ) &
        & / (     X( 4 ) - X( 3 ) )

      ! 1
      Obj % dNdXi( 1, 1, : ) = &
        &   ( Xi( 1, : ) - X( 3 ) ) &
        & * ( Xi( 1, : ) - X( 4 ) ) &
        & + ( Xi( 1, : ) - X( 2 ) ) &
        & * ( Xi( 1, : ) - X( 4 ) ) &
        & + ( Xi( 1, : ) - X( 2 ) ) &
        & * ( Xi( 1, : ) - X( 3 ) )

      DummyReal = &
        &   ( X( 1 ) - X( 2 ) ) &
        & * ( X( 1 ) - X( 3 ) ) &
        & * ( X( 1 ) - X( 4 ) )

      Obj % dNdXi( 1, 1, : ) = Obj % dNdXi( 1, 1, : ) / DummyReal

      ! 2
      Obj % dNdXi( 2, 1, : ) = &
        &   ( Xi( 1, : ) - X( 3 ) ) &
        & * ( Xi( 1, : ) - X( 4 ) ) &
        & + ( Xi( 1, : ) - X( 1 ) ) &
        & * ( Xi( 1, : ) - X( 4 ) ) &
        & + ( Xi( 1, : ) - X( 1 ) ) &
        & * ( Xi( 1, : ) - X( 3 ) )

      DummyReal = &
        &   ( X( 2 ) - X( 1 ) ) &
        & * ( X( 2 ) - X( 3 ) ) &
        & * ( X( 2 ) - X( 4 ) )

      Obj % dNdXi( 2, 1, : ) = Obj % dNdXi( 2, 1, : ) / DummyReal

      ! 3
      Obj % dNdXi( 3, 1, : ) = &
        &   ( Xi( 1, : ) - X( 2 ) ) &
        & * ( Xi( 1, : ) - X( 4 ) ) &
        & + ( Xi( 1, : ) - X( 1 ) ) &
        & * ( Xi( 1, : ) - X( 4 ) ) &
        & + ( Xi( 1, : ) - X( 1 ) ) &
        & * ( Xi( 1, : ) - X( 2 ) )

      DummyReal = &
        &   ( X( 3 ) - X( 1 ) ) &
        & * ( X( 3 ) - X( 2 ) ) &
        & * ( X( 3 ) - X( 4 ) )

      Obj % dNdXi( 3, 1, : ) = Obj % dNdXi( 3, 1, : ) / DummyReal

      ! 4
      Obj % dNdXi( 4, 1, : ) = &
        &   ( Xi( 1, : ) - X( 2 ) ) &
        & * ( Xi( 1, : ) - X( 3 ) ) &
        & + ( Xi( 1, : ) - X( 1 ) ) &
        & * ( Xi( 1, : ) - X( 3 ) ) &
        & + ( Xi( 1, : ) - X( 1 ) ) &
        & * ( Xi( 1, : ) - X( 2 ) )

      DummyReal = &
        &   ( X( 4 ) - X( 1 ) ) &
        & * ( X( 4 ) - X( 2 ) ) &
        & * ( X( 4 ) - X( 3 ) )

      Obj % dNdXi( 4, 1, : ) = Obj % dNdXi( 4, 1, : ) / DummyReal

    END BLOCK
  !---------------------------------------------------------------!
  !---------------------------------------------------------------!
  CASE( 4 )
    BLOCK
      !                 define internal variables
      REAL( DFP ) :: X( 5 ), DummyReal
      !         ....................................         !
      call AllocateData( obj = obj, nsd = refelem % nsd, &
        & xidim = refelem % xidimension, nns = 5, nips = nips )

      X = RefElem % XiJ( 1, 1:5 )

      Obj % N( 1, : ) = &
        &   ( Xi( 1, : ) - X( 2 ) ) &
        & * ( Xi( 1, : ) - X( 3 ) ) &
        & * ( Xi( 1, : ) - X( 4 ) ) &
        & * ( Xi( 1, : ) - X( 5 ) ) &
        & / (     X( 1 ) - X( 2 ) ) &
        & / (     X( 1 ) - X( 3 ) ) &
        & / (     X( 1 ) - X( 4 ) ) &
        & / (     X( 1 ) - X( 5 ) )

      Obj % N( 2, : ) = &
        &   ( Xi( 1, : ) - X( 1 ) ) &
        & * ( Xi( 1, : ) - X( 3 ) ) &
        & * ( Xi( 1, : ) - X( 4 ) ) &
        & * ( Xi( 1, : ) - X( 5 ) ) &
        & / (     X( 2 ) - X( 1 ) ) &
        & / (     X( 2 ) - X( 3 ) ) &
        & / (     X( 2 ) - X( 4 ) ) &
        & / (     X( 2 ) - X( 5 ) )

      Obj % N( 3, : ) = &
        &   ( Xi( 1, : ) - X( 1 ) ) &
        & * ( Xi( 1, : ) - X( 2 ) ) &
        & * ( Xi( 1, : ) - X( 4 ) ) &
        & * ( Xi( 1, : ) - X( 5 ) ) &
        & / (     X( 3 ) - X( 1 ) ) &
        & / (     X( 3 ) - X( 2 ) ) &
        & / (     X( 3 ) - X( 4 ) ) &
        & / (     X( 3 ) - X( 5 ) )

      Obj % N( 4, : ) = &
        &   ( Xi( 1, : ) - X( 1 ) ) &
        & * ( Xi( 1, : ) - X( 2 ) ) &
        & * ( Xi( 1, : ) - X( 3 ) ) &
        & * ( Xi( 1, : ) - X( 5 ) ) &
        & / (     X( 4 ) - X( 1 ) ) &
        & / (     X( 4 ) - X( 2 ) ) &
        & / (     X( 4 ) - X( 3 ) ) &
        & / (     X( 4 ) - X( 5 ) )

      Obj % N( 5, : ) = &
        &   ( Xi( 1, : ) - X( 1 ) ) &
        & * ( Xi( 1, : ) - X( 2 ) ) &
        & * ( Xi( 1, : ) - X( 3 ) ) &
        & * ( Xi( 1, : ) - X( 4 ) ) &
        & / (     X( 5 ) - X( 1 ) ) &
        & / (     X( 5 ) - X( 2 ) ) &
        & / (     X( 5 ) - X( 3 ) ) &
        & / (     X( 5 ) - X( 4 ) )

      ! 1
      Obj % dNdXi( 1, 1, : ) = &
        &   ( Xi( 1, : ) - X( 3 ) ) &
        & * ( Xi( 1, : ) - X( 4 ) ) &
        & * ( Xi( 1, : ) - X( 5 ) ) &
        & + ( Xi( 1, : ) - X( 2 ) ) &
        & * ( Xi( 1, : ) - X( 4 ) ) &
        & * ( Xi( 1, : ) - X( 5 ) ) &
        & + ( Xi( 1, : ) - X( 2 ) ) &
        & * ( Xi( 1, : ) - X( 3 ) ) &
        & * ( Xi( 1, : ) - X( 5 ) ) &
        & + ( Xi( 1, : ) - X( 2 ) ) &
        & * ( Xi( 1, : ) - X( 3 ) ) &
        & * ( Xi( 1, : ) - X( 4 ) )

      DummyReal = &
        &   ( X( 1 ) - X( 2 ) ) &
        & * ( X( 1 ) - X( 3 ) ) &
        & * ( X( 1 ) - X( 4 ) ) &
        & * ( X( 1 ) - X( 5 ) )

      Obj % dNdXi( 1, 1, : ) = Obj % dNdXi( 1, 1, : ) / DummyReal

      ! 2
      Obj % dNdXi( 2, 1, : ) = &
        &   ( Xi( 1, : ) - X( 3 ) ) &
        & * ( Xi( 1, : ) - X( 4 ) ) &
        & * ( Xi( 1, : ) - X( 5 ) ) &
        & + ( Xi( 1, : ) - X( 1 ) ) &
        & * ( Xi( 1, : ) - X( 4 ) ) &
        & * ( Xi( 1, : ) - X( 5 ) ) &
        & + ( Xi( 1, : ) - X( 1 ) ) &
        & * ( Xi( 1, : ) - X( 3 ) ) &
        & * ( Xi( 1, : ) - X( 5 ) ) &
        & + ( Xi( 1, : ) - X( 1 ) ) &
        & * ( Xi( 1, : ) - X( 3 ) ) &
        & * ( Xi( 1, : ) - X( 4 ) )

      DummyReal = &
        &   ( X( 2 ) - X( 1 ) ) &
        & * ( X( 2 ) - X( 3 ) ) &
        & * ( X( 2 ) - X( 4 ) ) &
        & * ( X( 2 ) - X( 5 ) )

      Obj % dNdXi( 2, 1, : ) = Obj % dNdXi( 2, 1, : ) / DummyReal

      ! 3
      Obj % dNdXi( 3, 1, : ) = &
        &   ( Xi( 1, : ) - X( 2 ) ) &
        & * ( Xi( 1, : ) - X( 4 ) ) &
        & * ( Xi( 1, : ) - X( 5 ) ) &
        & + ( Xi( 1, : ) - X( 1 ) ) &
        & * ( Xi( 1, : ) - X( 4 ) ) &
        & * ( Xi( 1, : ) - X( 5 ) ) &
        & + ( Xi( 1, : ) - X( 1 ) ) &
        & * ( Xi( 1, : ) - X( 2 ) ) &
        & * ( Xi( 1, : ) - X( 5 ) ) &
        & + ( Xi( 1, : ) - X( 1 ) ) &
        & * ( Xi( 1, : ) - X( 2 ) ) &
        & * ( Xi( 1, : ) - X( 4 ) )

      DummyReal = &
        &   ( X( 3 ) - X( 1 ) ) &
        & * ( X( 3 ) - X( 2 ) ) &
        & * ( X( 3 ) - X( 4 ) ) &
        & * ( X( 3 ) - X( 5 ) )

      Obj % dNdXi( 3, 1, : ) = Obj % dNdXi( 3, 1, : ) / DummyReal

      ! 4
      Obj % dNdXi( 4, 1, : ) = &
        &   ( Xi( 1, : ) - X( 2 ) ) &
        & * ( Xi( 1, : ) - X( 3 ) ) &
        & * ( Xi( 1, : ) - X( 5 ) ) &
        & + ( Xi( 1, : ) - X( 1 ) ) &
        & * ( Xi( 1, : ) - X( 3 ) ) &
        & * ( Xi( 1, : ) - X( 5 ) ) &
        & + ( Xi( 1, : ) - X( 1 ) ) &
        & * ( Xi( 1, : ) - X( 2 ) ) &
        & * ( Xi( 1, : ) - X( 5 ) ) &
        & + ( Xi( 1, : ) - X( 1 ) ) &
        & * ( Xi( 1, : ) - X( 2 ) ) &
        & * ( Xi( 1, : ) - X( 3 ) )

      DummyReal = &
        &   ( X( 4 ) - X( 1 ) ) &
        & * ( X( 4 ) - X( 2 ) ) &
        & * ( X( 4 ) - X( 3 ) ) &
        & * ( X( 4 ) - X( 5 ) )

      Obj % dNdXi( 4, 1, : ) = Obj % dNdXi( 4, 1, : ) / DummyReal

      ! 5
      Obj % dNdXi( 5, 1, : ) = &
        &   ( Xi( 1, : ) - X( 2 ) ) &
        & * ( Xi( 1, : ) - X( 3 ) ) &
        & * ( Xi( 1, : ) - X( 4 ) ) &
        & + ( Xi( 1, : ) - X( 1 ) ) &
        & * ( Xi( 1, : ) - X( 3 ) ) &
        & * ( Xi( 1, : ) - X( 4 ) ) &
        & + ( Xi( 1, : ) - X( 1 ) ) &
        & * ( Xi( 1, : ) - X( 2 ) ) &
        & * ( Xi( 1, : ) - X( 4 ) ) &
        & + ( Xi( 1, : ) - X( 1 ) ) &
        & * ( Xi( 1, : ) - X( 2 ) ) &
        & * ( Xi( 1, : ) - X( 3 ) )

      DummyReal = &
        &   ( X( 5 ) - X( 1 ) ) &
        & * ( X( 5 ) - X( 2 ) ) &
        & * ( X( 5 ) - X( 3 ) ) &
        & * ( X( 5 ) - X( 4 ) )

      Obj % dNdXi( 5, 1, : ) = Obj % dNdXi( 5, 1, : ) / DummyReal
    END BLOCK
  !---------------------------------------------------------------!
  !---------------------------------------------------------------!
  CASE( 5 )
    BLOCK
      !                 define internal variables
      REAL( DFP ) :: X( 6 ), DummyReal
      !         ....................................         !

      call AllocateData( obj = obj, nsd = refelem % nsd, &
        & xidim = refelem % xidimension, nns = 6, nips = nips )
      X = RefElem % XiJ( 1, 1:6 )

      Obj % N( 1, : ) = &
        &   ( Xi( 1, : ) - X( 2 ) ) &
        & * ( Xi( 1, : ) - X( 3 ) ) &
        & * ( Xi( 1, : ) - X( 4 ) ) &
        & * ( Xi( 1, : ) - X( 5 ) ) &
        & * ( Xi( 1, : ) - X( 6 ) ) &
        & / (     X( 1 ) - X( 2 ) ) &
        & / (     X( 1 ) - X( 3 ) ) &
        & / (     X( 1 ) - X( 4 ) ) &
        & / (     X( 1 ) - X( 5 ) ) &
        & / (     X( 1 ) - X( 6 ) )

      Obj % N( 2, : ) = &
        &   ( Xi( 1, : ) - X( 1 ) ) &
        & * ( Xi( 1, : ) - X( 3 ) ) &
        & * ( Xi( 1, : ) - X( 4 ) ) &
        & * ( Xi( 1, : ) - X( 5 ) ) &
        & * ( Xi( 1, : ) - X( 6 ) ) &
        & / (     X( 2 ) - X( 1 ) ) &
        & / (     X( 2 ) - X( 3 ) ) &
        & / (     X( 2 ) - X( 4 ) ) &
        & / (     X( 2 ) - X( 5 ) ) &
        & / (     X( 2 ) - X( 6 ) )

      Obj % N( 3, : ) = &
        &   ( Xi( 1, : ) - X( 1 ) ) &
        & * ( Xi( 1, : ) - X( 2 ) ) &
        & * ( Xi( 1, : ) - X( 4 ) ) &
        & * ( Xi( 1, : ) - X( 5 ) ) &
        & * ( Xi( 1, : ) - X( 6 ) ) &
        & / (     X( 3 ) - X( 1 ) ) &
        & / (     X( 3 ) - X( 2 ) ) &
        & / (     X( 3 ) - X( 4 ) ) &
        & / (     X( 3 ) - X( 5 ) ) &
        & / (     X( 3 ) - X( 6 ) )

      Obj % N( 4, : ) = &
        &   ( Xi( 1, : ) - X( 1 ) ) &
        & * ( Xi( 1, : ) - X( 2 ) ) &
        & * ( Xi( 1, : ) - X( 3 ) ) &
        & * ( Xi( 1, : ) - X( 5 ) ) &
        & * ( Xi( 1, : ) - X( 6 ) ) &
        & / (     X( 4 ) - X( 1 ) ) &
        & / (     X( 4 ) - X( 2 ) ) &
        & / (     X( 4 ) - X( 3 ) ) &
        & / (     X( 4 ) - X( 5 ) ) &
        & / (     X( 4 ) - X( 6 ) )

      Obj % N( 5, : ) = &
        &   ( Xi( 1, : ) - X( 1 ) ) &
        & * ( Xi( 1, : ) - X( 2 ) ) &
        & * ( Xi( 1, : ) - X( 3 ) ) &
        & * ( Xi( 1, : ) - X( 4 ) ) &
        & * ( Xi( 1, : ) - X( 6 ) ) &
        & / (     X( 5 ) - X( 1 ) ) &
        & / (     X( 5 ) - X( 2 ) ) &
        & / (     X( 5 ) - X( 3 ) ) &
        & / (     X( 5 ) - X( 4 ) ) &
        & / (     X( 5 ) - X( 6 ) )

      Obj % N( 6, : ) = &
        &   ( Xi( 1, : ) - X( 1 ) ) &
        & * ( Xi( 1, : ) - X( 2 ) ) &
        & * ( Xi( 1, : ) - X( 3 ) ) &
        & * ( Xi( 1, : ) - X( 4 ) ) &
        & * ( Xi( 1, : ) - X( 5 ) ) &
        & / (     X( 6 ) - X( 1 ) ) &
        & / (     X( 6 ) - X( 2 ) ) &
        & / (     X( 6 ) - X( 3 ) ) &
        & / (     X( 6 ) - X( 4 ) ) &
        & / (     X( 6 ) - X( 5 ) )

      ! 1
      Obj % dNdXi( 1, 1, : ) = &
        &   ( Xi( 1, : ) - X( 3 ) ) &
        & * ( Xi( 1, : ) - X( 4 ) ) &
        & * ( Xi( 1, : ) - X( 5 ) ) &
        & * ( Xi( 1, : ) - X( 6 ) ) &
        & + ( Xi( 1, : ) - X( 2 ) ) &
        & * ( Xi( 1, : ) - X( 4 ) ) &
        & * ( Xi( 1, : ) - X( 5 ) ) &
        & * ( Xi( 1, : ) - X( 6 ) ) &
        & + ( Xi( 1, : ) - X( 2 ) ) &
        & * ( Xi( 1, : ) - X( 3 ) ) &
        & * ( Xi( 1, : ) - X( 5 ) ) &
        & * ( Xi( 1, : ) - X( 6 ) ) &
        & + ( Xi( 1, : ) - X( 2 ) ) &
        & * ( Xi( 1, : ) - X( 3 ) ) &
        & * ( Xi( 1, : ) - X( 4 ) ) &
        & * ( Xi( 1, : ) - X( 6 ) ) &
        & + ( Xi( 1, : ) - X( 2 ) ) &
        & * ( Xi( 1, : ) - X( 3 ) ) &
        & * ( Xi( 1, : ) - X( 4 ) ) &
        & * ( Xi( 1, : ) - X( 5 ) )

      DummyReal = &
        &   ( X( 1 ) - X( 2 ) ) &
        & * ( X( 1 ) - X( 3 ) ) &
        & * ( X( 1 ) - X( 4 ) ) &
        & * ( X( 1 ) - X( 5 ) ) &
        & * ( X( 1 ) - X( 6 ) )

      Obj % dNdXi( 1, 1, : ) = Obj % dNdXi( 1, 1, : ) / DummyReal

      ! 2
      Obj % dNdXi( 2, 1, : ) = &
        &   ( Xi( 1, : ) - X( 3 ) ) &
        & * ( Xi( 1, : ) - X( 4 ) ) &
        & * ( Xi( 1, : ) - X( 5 ) ) &
        & * ( Xi( 1, : ) - X( 6 ) ) &
        & + ( Xi( 1, : ) - X( 1 ) ) &
        & * ( Xi( 1, : ) - X( 4 ) ) &
        & * ( Xi( 1, : ) - X( 5 ) ) &
        & * ( Xi( 1, : ) - X( 6 ) ) &
        & + ( Xi( 1, : ) - X( 1 ) ) &
        & * ( Xi( 1, : ) - X( 3 ) ) &
        & * ( Xi( 1, : ) - X( 5 ) ) &
        & * ( Xi( 1, : ) - X( 6 ) ) &
        & + ( Xi( 1, : ) - X( 1 ) ) &
        & * ( Xi( 1, : ) - X( 3 ) ) &
        & * ( Xi( 1, : ) - X( 4 ) ) &
        & * ( Xi( 1, : ) - X( 6 ) ) &
        & + ( Xi( 1, : ) - X( 1 ) ) &
        & * ( Xi( 1, : ) - X( 3 ) ) &
        & * ( Xi( 1, : ) - X( 4 ) ) &
        & * ( Xi( 1, : ) - X( 5 ) )

      DummyReal = &
        &   ( X( 2 ) - X( 1 ) ) &
        & * ( X( 2 ) - X( 3 ) ) &
        & * ( X( 2 ) - X( 4 ) ) &
        & * ( X( 2 ) - X( 5 ) ) &
        & * ( X( 2 ) - X( 6 ) )

      Obj % dNdXi( 2, 1, : ) = Obj % dNdXi( 2, 1, : ) / DummyReal

      ! 3
      Obj % dNdXi( 3, 1, : ) = &
        &   ( Xi( 1, : ) - X( 2 ) ) &
        & * ( Xi( 1, : ) - X( 4 ) ) &
        & * ( Xi( 1, : ) - X( 5 ) ) &
        & * ( Xi( 1, : ) - X( 6 ) ) &
        & + ( Xi( 1, : ) - X( 1 ) ) &
        & * ( Xi( 1, : ) - X( 4 ) ) &
        & * ( Xi( 1, : ) - X( 5 ) ) &
        & * ( Xi( 1, : ) - X( 6 ) ) &
        & + ( Xi( 1, : ) - X( 1 ) ) &
        & * ( Xi( 1, : ) - X( 2 ) ) &
        & * ( Xi( 1, : ) - X( 5 ) ) &
        & * ( Xi( 1, : ) - X( 6 ) ) &
        & + ( Xi( 1, : ) - X( 1 ) ) &
        & * ( Xi( 1, : ) - X( 2 ) ) &
        & * ( Xi( 1, : ) - X( 4 ) ) &
        & * ( Xi( 1, : ) - X( 6 ) ) &
        & + ( Xi( 1, : ) - X( 1 ) ) &
        & * ( Xi( 1, : ) - X( 2 ) ) &
        & * ( Xi( 1, : ) - X( 4 ) ) &
        & * ( Xi( 1, : ) - X( 5 ) )

      DummyReal = &
        &   ( X( 3 ) - X( 1 ) ) &
        & * ( X( 3 ) - X( 2 ) ) &
        & * ( X( 3 ) - X( 4 ) ) &
        & * ( X( 3 ) - X( 5 ) ) &
        & * ( X( 3 ) - X( 6 ) )

      Obj % dNdXi( 3, 1, : ) = Obj % dNdXi( 3, 1, : ) / DummyReal

      ! 4
      Obj % dNdXi( 4, 1, : ) = &
        &   ( Xi( 1, : ) - X( 2 ) ) &
        & * ( Xi( 1, : ) - X( 3 ) ) &
        & * ( Xi( 1, : ) - X( 5 ) ) &
        & * ( Xi( 1, : ) - X( 6 ) ) &
        & + ( Xi( 1, : ) - X( 1 ) ) &
        & * ( Xi( 1, : ) - X( 3 ) ) &
        & * ( Xi( 1, : ) - X( 5 ) ) &
        & * ( Xi( 1, : ) - X( 6 ) ) &
        & + ( Xi( 1, : ) - X( 1 ) ) &
        & * ( Xi( 1, : ) - X( 2 ) ) &
        & * ( Xi( 1, : ) - X( 5 ) ) &
        & * ( Xi( 1, : ) - X( 6 ) ) &
        & + ( Xi( 1, : ) - X( 1 ) ) &
        & * ( Xi( 1, : ) - X( 2 ) ) &
        & * ( Xi( 1, : ) - X( 3 ) ) &
        & * ( Xi( 1, : ) - X( 6 ) ) &
        & + ( Xi( 1, : ) - X( 1 ) ) &
        & * ( Xi( 1, : ) - X( 2 ) ) &
        & * ( Xi( 1, : ) - X( 3 ) ) &
        & * ( Xi( 1, : ) - X( 5 ) )

      DummyReal = &
        &   ( X( 4 ) - X( 1 ) ) &
        & * ( X( 4 ) - X( 2 ) ) &
        & * ( X( 4 ) - X( 3 ) ) &
        & * ( X( 4 ) - X( 5 ) ) &
        & * ( X( 4 ) - X( 6 ) )

      Obj % dNdXi( 4, 1, : ) = Obj % dNdXi( 4, 1, : ) / DummyReal

      ! 5
      Obj % dNdXi( 5, 1, : ) = &
      &   ( Xi( 1, : ) - X( 2 ) ) &
      & * ( Xi( 1, : ) - X( 3 ) ) &
      & * ( Xi( 1, : ) - X( 4 ) ) &
      & * ( Xi( 1, : ) - X( 6 ) ) &
      & + ( Xi( 1, : ) - X( 1 ) ) &
      & * ( Xi( 1, : ) - X( 3 ) ) &
      & * ( Xi( 1, : ) - X( 4 ) ) &
      & * ( Xi( 1, : ) - X( 6 ) ) &
      & + ( Xi( 1, : ) - X( 1 ) ) &
      & * ( Xi( 1, : ) - X( 2 ) ) &
      & * ( Xi( 1, : ) - X( 4 ) ) &
      & * ( Xi( 1, : ) - X( 6 ) ) &
      & + ( Xi( 1, : ) - X( 1 ) ) &
      & * ( Xi( 1, : ) - X( 2 ) ) &
      & * ( Xi( 1, : ) - X( 3 ) ) &
      & * ( Xi( 1, : ) - X( 6 ) ) &
      & + ( Xi( 1, : ) - X( 1 ) ) &
      & * ( Xi( 1, : ) - X( 2 ) ) &
      & * ( Xi( 1, : ) - X( 3 ) ) &
      & * ( Xi( 1, : ) - X( 4 ) )

      DummyReal = &
        &   ( X( 5 ) - X( 1 ) ) &
        & * ( X( 5 ) - X( 2 ) ) &
        & * ( X( 5 ) - X( 3 ) ) &
        & * ( X( 5 ) - X( 4 ) ) &
        & * ( X( 5 ) - X( 6 ) )

      Obj % dNdXi( 5, 1, : ) = Obj % dNdXi( 5, 1, : ) / DummyReal

      ! 6
      Obj % dNdXi( 6, 1, : ) = &
        &   ( Xi( 1, : ) - X( 2 ) ) &
        & * ( Xi( 1, : ) - X( 3 ) ) &
        & * ( Xi( 1, : ) - X( 4 ) ) &
        & * ( Xi( 1, : ) - X( 5 ) ) &
        & + ( Xi( 1, : ) - X( 1 ) ) &
        & * ( Xi( 1, : ) - X( 3 ) ) &
        & * ( Xi( 1, : ) - X( 4 ) ) &
        & * ( Xi( 1, : ) - X( 5 ) ) &
        & + ( Xi( 1, : ) - X( 1 ) ) &
        & * ( Xi( 1, : ) - X( 2 ) ) &
        & * ( Xi( 1, : ) - X( 4 ) ) &
        & * ( Xi( 1, : ) - X( 5 ) ) &
        & + ( Xi( 1, : ) - X( 1 ) ) &
        & * ( Xi( 1, : ) - X( 2 ) ) &
        & * ( Xi( 1, : ) - X( 3 ) ) &
        & * ( Xi( 1, : ) - X( 5 ) ) &
        & + ( Xi( 1, : ) - X( 1 ) ) &
        & * ( Xi( 1, : ) - X( 2 ) ) &
        & * ( Xi( 1, : ) - X( 3 ) ) &
        & * ( Xi( 1, : ) - X( 4 ) )

      DummyReal = &
        &   ( X( 6 ) - X( 1 ) ) &
        & * ( X( 6 ) - X( 2 ) ) &
        & * ( X( 6 ) - X( 3 ) ) &
        & * ( X( 6 ) - X( 4 ) ) &
        & * ( X( 6 ) - X( 5 ) )

      Obj % dNdXi( 6, 1, : ) = Obj % dNdXi( 6, 1, : ) / DummyReal
    END BLOCK
  !---------------------------------------------------------------!
  !---------------------------------------------------------------!
  CASE DEFAULT
    BLOCK
      ! define internal variables
      REAL( DFP ) :: X( refelem % order + 1 ), DummyReal( nips ), &
        & DummyReal2( nips )
      INTEGER( I4B ) :: i, j, k, nns
      !         ....................................         !

      nns = refelem % order + 1
      call AllocateData( obj = obj, nsd = refelem % nsd, &
        & xidim = refelem % xidimension, nns = nns, nips = nips )

      X = RefElem % XiJ( 1, 1:nns )
      Obj % N = 1.0_DFP

      DO i = 1, nns
        DO k = 1, nns
          IF( i .EQ. k ) CYCLE
          Obj % N( i, : ) = &
            & Obj % N( i, : ) * ( Xi( 1, : ) - X( k ) ) / ( X( i ) - X( k ) )

          DummyReal2( : ) = 1.0_DFP
          DO j = 1, nns
            IF( j .NE. i .AND. j .NE. k ) THEN
              DummyReal2( : ) = DummyReal2( : ) * ( Xi( 1, : ) - X( j ) )
            END IF
          END DO
          Obj % dNdXi( i, 1, : ) = Obj % dNdXi( i, 1, : ) + DummyReal2( : )
        END DO

        DummyReal = 1.0_DFP
        DO j = 1, nns
          IF( i .EQ. j ) CYCLE
          DummyReal = DummyReal * ( X( i ) - X( j ) )
        END DO
        Obj % dNdXi( i, 1, : ) = Obj % dNdXi( i, 1, : ) / DummyReal
      END DO
    END BLOCK
  END SELECT
  DEALLOCATE( Xi )
END PROCEDURE Line_H1_Lagrange

END SUBMODULE Line