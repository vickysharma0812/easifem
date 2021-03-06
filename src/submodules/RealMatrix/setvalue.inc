
!----------------------------------------------------------------------------
!                                                        setValues@setValues
!----------------------------------------------------------------------------

INTERFACE
!! Add values in [[realmatrix_]]

!> authors: Dr. Vikas Sharma
!
! This subroutine set `Obj % Val` to `Val`

MODULE PURE SUBROUTINE realmat_setValues_1( Obj, Val )
  TYPE( RealMatrix_ ), INTENT( INOUT ) :: Obj
  REAL( DFP ), INTENT( IN ) :: Val( :, : )
END SUBROUTINE realmat_setValues_1
END INTERFACE

INTERFACE
!! Set values in [[realmatrix_]]

!> authors: Dr. Vikas Sharma
!
! This subroutine set values in `Obj % Val`
! `Obj % Val( i, j ) = Val`

MODULE PURE SUBROUTINE realmat_setValues_2( Obj, Val, Row, Col )
  TYPE( RealMatrix_ ), INTENT( INOUT ) :: Obj
  REAL( DFP ), INTENT( IN ) :: Val
  INTEGER( I4B ), INTENT( IN ) :: Col, Row
END SUBROUTINE realmat_setValues_2
END INTERFACE

INTERFACE
!! Set values in [[realmatrix_]]

!> authors: Dr. Vikas Sharma
!
! This subroutine set values in `Obj % Val`

MODULE PURE SUBROUTINE realmat_setValues_3( Obj, Val, Row, Col )
  TYPE( RealMatrix_ ), INTENT( INOUT ) :: Obj
  REAL( DFP ), INTENT( IN ) :: Val( :, : )
  INTEGER( I4B ), INTENT( IN ) :: Col( : ), Row( : )
END SUBROUTINE realmat_setValues_3
END INTERFACE

INTERFACE
!! Set values in [[realmatrix_]]

!> authors: Dr. Vikas Sharma
!
! This subroutine set values in `Obj % val`
! - If `ExtraOption=0` then diagonal values are set; and `Indx` denotes
!   diagonal number with `0` being the main diagonal
! - If `Extraoption=1` then row values are set; `Indx` then denotes row number
! - If `Extraoption=2` then col values are set; `Indx` then denotes col number

MODULE PURE SUBROUTINE realmat_setValues_4( Obj, Val, Indx, ExtraOption )
  TYPE( RealMatrix_ ), INTENT( INOUT ) :: Obj
  REAL( DFP ), INTENT( IN ) :: Val( : )
  INTEGER( I4B ), INTENT( IN ) :: ExtraOption, Indx
END SUBROUTINE realmat_setValues_4
END INTERFACE

INTERFACE
!! Set values in [[realmatrix_]]

!> authors: Dr. Vikas Sharma
!
! This subroutine set values in `Obj % val`
! - If `ExtraOption=0` then diagonal values are set; and `Indx` denotes
!   diagonal number with `0` being the main diagonal
! - If `Extraoption=1` then row values are set; `Indx` then denotes row number
! - If `Extraoption=2` then col values are set; `Indx` then denotes col number

MODULE PURE SUBROUTINE realmat_setValues_5( Obj, Val, Indx, ExtraOption )
  TYPE( RealMatrix_ ), INTENT( INOUT ) :: Obj
  REAL( DFP ), INTENT( IN ) :: Val( :, : )
  INTEGER( I4B ), INTENT( IN ) :: Indx ( : ), ExtraOption
END SUBROUTINE realmat_setValues_5
END INTERFACE

INTERFACE setValues
  MODULE PROCEDURE realmat_setValues_1, realmat_setValues_2, &
    & realmat_setValues_3, realmat_setValues_4, &
    & realmat_setValues_5
END INTERFACE setValues

PUBLIC :: setValues

!----------------------------------------------------------------------------
!                                                  addContribution@setValues
!----------------------------------------------------------------------------

INTERFACE
!! Add contribution in values of [[realmatrix_]]

!> authors: Dr. Vikas Sharma
!
! This subroutine adds contribution in values of `Obj % Val`
!
! ```fortran
! obj % val = obj % val *Op* scale * val
! ```

MODULE PURE SUBROUTINE realmat_addVal_1( Obj, Val, Scale, Op )
  TYPE( RealMatrix_ ), INTENT( INOUT) :: Obj
  REAL( DFP ), INTENT( IN ) :: Val( :, : ), Scale
    !! Scaling for `Val`
  CHARACTER( LEN = 1 ), INTENT( IN ) :: Op
    !! operator symbol; `+, -, *, /`
END SUBROUTINE realmat_addVal_1
END INTERFACE

INTERFACE
!! Add contribution in values of [[realmatrix_]]

!> authors: Dr. Vikas Sharma
!
! This subroutine adds contribution in values of `Obj % Val`
!
! ```fortran
! obj % val = obj % val *Op* scale * val
! ```


MODULE PURE SUBROUTINE realmat_addVal_2( Obj, Val, Row, Col, Scale, Op )
  TYPE( RealMatrix_ ), INTENT( INOUT) :: Obj
  REAL( DFP ), INTENT( IN ) :: Val, Scale
  INTEGER( I4B ), INTENT( IN ) :: Row, Col
  CHARACTER( LEN = 1 ), INTENT( IN ) :: Op
END SUBROUTINE realmat_addVal_2
END INTERFACE

INTERFACE
!! Add contribution in values of [[realmatrix_]]

!> authors: Dr. Vikas Sharma
!
! This subroutine adds contribution in values of `Obj % Val`
!
! ```fortran
! obj % val = obj % val *Op* scale * val
! ```

MODULE PURE SUBROUTINE realmat_addVal_3( Obj, Val, Row, Col, Scale, Op )
  TYPE( RealMatrix_ ), INTENT( INOUT) :: Obj
  REAL( DFP ), INTENT( IN ) :: Val( :, : ), Scale
  INTEGER( I4B ), INTENT( IN ) :: Row( : ), Col( : )
  CHARACTER( LEN = 1 ), INTENT( IN ) :: Op
END SUBROUTINE realmat_addVal_3
END INTERFACE

INTERFACE
!! Add contribution in values of [[realmatrix_]]

!> authors: Dr. Vikas Sharma
!
! This subroutine adds contribution in values of `Obj % Val`
!
! ```fortran
! obj % val = obj % val *Op* scale * val
! ```

MODULE PURE SUBROUTINE realmat_addVal_4( Obj, Val, Indx, ExtraOption, Scale, Op )
  TYPE( RealMatrix_ ), INTENT( INOUT) :: Obj
  REAL( DFP ), INTENT( IN ) :: Val( : ), Scale
  INTEGER( I4B ), INTENT( IN ) :: Indx, ExtraOption
  CHARACTER( LEN = 1 ), INTENT( IN ) :: Op
END SUBROUTINE realmat_addVal_4
END INTERFACE

INTERFACE
!! Add contribution in values of [[realmatrix_]]

!> authors: Dr. Vikas Sharma
!
! This subroutine adds contribution in values of `Obj % Val`
!
! ```fortran
! obj % val = obj % val *Op* scale * val
! ```

MODULE PURE SUBROUTINE realmat_addVal_5( Obj, Val, Indx, ExtraOption, Scale, Op )
  TYPE( RealMatrix_ ), INTENT( INOUT) :: Obj
  REAL( DFP ), INTENT( IN ) :: Val( :, : ), Scale
  INTEGER( I4B ), INTENT( IN ) :: Indx( : ), ExtraOption
  CHARACTER( LEN = 1 ), INTENT( IN ) :: Op
END SUBROUTINE realmat_addVal_5
END INTERFACE

INTERFACE addContribution
  MODULE PROCEDURE realmat_addVal_1, realmat_addVal_2, realmat_addVal_3, &
    & realmat_addVal_4, realmat_addVal_5
END INTERFACE addContribution

PUBLIC :: addContribution