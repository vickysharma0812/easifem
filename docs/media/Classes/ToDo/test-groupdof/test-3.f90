! check performance of associate and pointer

program main
  use easifem
  implicit none

  type(groupdof_), target :: rhs, rhs_fixed, v, v0, u0, a0
  real(dfp), pointer, dimension( : ) :: PTRrhs, PTRrhsfixed, PTRv, PTRu0

  integer :: i, n = 100000, m = 10000, j, tdof = 3

  real( dfp ) :: t1, t2

  rhs = groupdof( [m], ["u"], [tdof], "Space")
  rhs_fixed = groupdof( [m], ["u"], [tdof], "Space")
  v = groupdof( [m], ["u"], [tdof], "Space")
  v0 = groupdof( [m], ["u"], [tdof], "Space")
  u0 = groupdof( [m], ["u"], [tdof], "Space")
  a0 = groupdof( [m], ["u"], [tdof], "Space")


  CALL CPU_TIME( t1 )
  ASSOCIATE( rhs => rhs % DOF, rhs_fixed => rhs_fixed % DOF, &
    & v => v % DOF, u0 => u0 % DOF )

    DO j = 1, n
      DO i = 1, tdof
        PTRrhs => rhs( i ) % Val; PTRrhsfixed => rhs_fixed( i ) % Val
        PTRv => v( i ) % Val
        PTRu0 => u0( i ) % Val
        PTRrhsfixed = PTRrhs
        PTRv = 1.0_DFP
        PTRu0 = PTRu0 + 0.1_dfp * PTRv
      END DO
    END DO

  END ASSOCIATE

  CALL CPU_TIME( t2 )

  PRINT *, "time = ", t2-t1


end program main