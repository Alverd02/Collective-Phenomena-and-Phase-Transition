PROGRAM CV
IMPLICIT NONE

open(11,file = "MC3.dat")

DO i = 1,n

read(11,*) T(i),E(i)

end do

CLOSE(11)

OPEN(12,file="cv.dat")

do i =1,n

WRITE(12,*) T(i)

close(12)

END PROGRAM