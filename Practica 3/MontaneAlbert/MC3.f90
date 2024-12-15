PROGRAM P3
IMPLICIT NONE

INTEGER*4 L,SEED,i,j,MCTOT,n,IMC,IPAS,suma,DE,k,MCINI,MCD,ISEED,NSEED,TPAS
INTEGER (kind=2),dimension (:,:),allocatable :: S
INTEGER (kind=4),dimension (:),allocatable :: PBC
REAL*8 genrand_real2,TEMP,delta,ene,magne,MAG,ENEBIS,SUM,SUME,SUME2,SUMM,SUMM2,SUMAM,TIME1,TIME2,W(-8:8),DT,TEMPF,TEMP0,c_v,x
CHARACTER :: DATE

CALL CPU_TIME(TIME1)

NSEED = 4
SEED = 48185051
CALL init_genrand(SEED)


WRITE(*,*) "Dimensió de la xarxa (L):"
READ(*,*) L 
WRITE(*,*) "Passos total de Makarov (MCTOT):"
READ(*,*) MCTOT

MCINI = 2000
MCD = 20

allocate(S(1:L,1:L))
allocate(PBC(0:L+1))

N = L*L

PBC(0) = L
PBC(L+1) = 1

DO i =1,L
    PBC(i) = i
END DO


OPEN(11,file="MC3.dat")

TEMP0 = 1.4d0
TEMPF = 3.4D0
DT = 0.01D0
TPAS = (-TEMP0+TEMPF)/DT

DO k=0,TPAS
TEMP = TEMP0 +K*DT

DO DE = -8,8

W(DE) = dexp(-1d0*DE/TEMP)

END DO

DO ISEED = 1,NSEED
SUM = 0.d0
SUME = 0.d0
SUME2 = 0.d0

SUMM = 0.0D0
SUMM2 = 0.d0
SUMAM = 0.D0

    DO i = 1, L
        DO j = 1, L
            IF (genrand_real2().LT.0.5D0) THEN
                S(i, j) = 1
            ELSE
                S(i, j) = -1
            END IF
        END DO
    END DO

CALL ENERG(ENE,S,L,PBC)

DO IMC = 1,MCTOT
    DO IPAS = 1,N
    i = ceiling(genrand_real2()*L)
    j = ceiling(genrand_real2()*L) 
    suma = S(i,PBC(j+1)) + S(i,PBC(j-1)) + S(PBC(1+i),j) + S(PBC(i-1),j)
    DE = 2*suma*S(i,j)
    IF (DE.LE.0.0D0) THEN
    S(i,j) = -S(i,j)
    ENE = ENE + DE
    ELSE
        delta = genrand_real2()
        IF (delta.lt.W(DE)) then
            S(i,j) = -S(i,j)
            ENE = ENE + DE
        END IF
    END IF
    END DO

    IF (((IMC.GT.MCINI)).AND.(mod(IMC,MCD).EQ.0)) THEN
        MAG = MAGNE(S,L)  
        SUM = SUM + 1.D0

        SUME = SUME + ENE
        SUME2 = SUME2 + ENE*ENE

        SUMM = SUMM + MAG
        SUMAM = SUMAM + DABS(MAG)
        SUMM2 = SUMM2 + MAG*MAG
    END IF

END DO

END DO

SUME = SUME/(SUM*N)
SUME2 = SUME2/(SUM*N**2)
SUMM = SUMM/(SUM*N)
SUMAM = SUMAM/(SUM*N)
SUMM2 = SUMM2/(SUM*N**2)

c_v  = N*((SUME2-SUME*SUME)/TEMP*TEMP)
x = N*((SUMM2-SUMAM*SUMAM)/TEMP)

WRITE(11,*) TEMP,SUME,SUME2-SUME*SUME,SUMAM,SUMM2-SUMM*SUMM,c_v,x


END DO

CLOSE(11)

CALL CPU_TIME(TIME2)
CALL FDATE(DATE)

WRITE(*,*) DATE
WRITE(*,*) "CPUTIME = ", TIME2-TIME1

END PROGRAM

SUBROUTINE ENERG(ENE,S,L,PBC)
IMPLICIT NONE
INTEGER*2 S(1:L,1:L)
INTEGER*4 i,j,L,PBC(0:L+1) 
REAL*8 ENE 
ENE = 0.0D0
DO i = 1,L 
DO j = 1,L 
ENE = ENE - S(i,j)*S(PBC(i+1),j) - S(i,j)*S(i,PBC(J+1))
END DO
END DO
RETURN
END

REAL*8 FUNCTION MAGNE(S,L)
IMPLICIT NONE
INTEGER*2 L
INTEGER*2 S(1:L,1:L),j,i,sum
REAL*8 m
sum = 0
DO i=1,L 
    DO j=1,L
        sum = sum + S(i,j)
    END DO
END DO
m = sum
RETURN
END

      subroutine init_genrand(s)
      integer s
      integer N
      integer DONE
      integer ALLBIT_MASK
      parameter (N=624)
      parameter (DONE=123456789)
      integer mti,initialized
      integer mt(0:N-1)
      common /mt_state1/ mti,initialized
      common /mt_state2/ mt
      common /mt_mask1/ ALLBIT_MASK
!
      call mt_initln
      mt(0)=iand(s,ALLBIT_MASK)
      do 100 mti=1,N-1
        mt(mti)=1812433253*ieor(mt(mti-1),ishft(mt(mti-1),-30))+mti
        mt(mti)=iand(mt(mti),ALLBIT_MASK)
  100 continue
      initialized=DONE
!
      return
      end
!-----------------------------------------------------------------------
!     initialize by an array with array-length
!     init_key is the array for initializing keys
!     key_length is its length
!-----------------------------------------------------------------------
      subroutine init_by_array(init_key,key_length)
      integer init_key(0:*)
      integer key_length
      integer N
      integer ALLBIT_MASK
      integer TOPBIT_MASK
      parameter (N=624)
      integer i,j,k
      integer mt(0:N-1)
      common /mt_state2/ mt
      common /mt_mask1/ ALLBIT_MASK
      common /mt_mask2/ TOPBIT_MASK
!
      call init_genrand(19650218)
      i=1
      j=0
      do 100 k=max(N,key_length),1,-1
        mt(i)=ieor(mt(i),ieor(mt(i-1),ishft(mt(i-1),-30))*1664525)+init_key(j)+j
        mt(i)=iand(mt(i),ALLBIT_MASK)
        i=i+1
        j=j+1
        if(i.ge.N)then
          mt(0)=mt(N-1)
          i=1
        endif
        if(j.ge.key_length)then
          j=0
        endif
  100 continue
      do 200 k=N-1,1,-1
        mt(i)=ieor(mt(i),ieor(mt(i-1),ishft(mt(i-1),-30))*1566083941)-i
        mt(i)=iand(mt(i),ALLBIT_MASK)
        i=i+1
        if(i.ge.N)then
          mt(0)=mt(N-1)
          i=1
        endif
  200 continue
      mt(0)=TOPBIT_MASK
!
      return
      end
!-----------------------------------------------------------------------
!     generates a random number on [0,0xffffffff]-interval
!-----------------------------------------------------------------------
      function genrand_int32()
      integer genrand_int32
      integer N,M
      integer DONE
      integer UPPER_MASK,LOWER_MASK,MATRIX_A
      integer T1_MASK,T2_MASK
      parameter (N=624)
      parameter (M=397)
      parameter (DONE=123456789)
      integer mti,initialized
      integer mt(0:N-1)
      integer y,kk
      integer mag01(0:1)
      common /mt_state1/ mti,initialized
      common /mt_state2/ mt
      common /mt_mask3/ UPPER_MASK,LOWER_MASK,MATRIX_A,T1_MASK,T2_MASK
      common /mt_mag01/ mag01
!
      if(initialized.ne.DONE)then
        call init_genrand(21641)
      endif
!
      if(mti.ge.N)then
        do 100 kk=0,N-M-1
          y=ior(iand(mt(kk),UPPER_MASK),iand(mt(kk+1),LOWER_MASK))
          mt(kk)=ieor(ieor(mt(kk+M),ishft(y,-1)),mag01(iand(y,1)))
  100   continue
        do 200 kk=N-M,N-1-1
          y=ior(iand(mt(kk),UPPER_MASK),iand(mt(kk+1),LOWER_MASK))
          mt(kk)=ieor(ieor(mt(kk+(M-N)),ishft(y,-1)),mag01(iand(y,1)))
  200   continue
        y=ior(iand(mt(N-1),UPPER_MASK),iand(mt(0),LOWER_MASK))
        mt(kk)=ieor(ieor(mt(M-1),ishft(y,-1)),mag01(iand(y,1)))
        mti=0
      endif
!
      y=mt(mti)
      mti=mti+1
!
      y=ieor(y,ishft(y,-11))
      y=ieor(y,iand(ishft(y,7),T1_MASK))
      y=ieor(y,iand(ishft(y,15),T2_MASK))
      y=ieor(y,ishft(y,-18))
!
      genrand_int32=y
      return
      end
!-----------------------------------------------------------------------
!     generates a random number on [0,0x7fffffff]-interval
!-----------------------------------------------------------------------
      function genrand_int31()
      integer genrand_int31
      integer genrand_int32
      genrand_int31=int(ishft(genrand_int32(),-1))
      return
      end
!-----------------------------------------------------------------------
!     generates a random number on [0,1]-real-interval
!-----------------------------------------------------------------------
      function genrand_real1()
      double precision genrand_real1,r
      integer genrand_int32
      r=dble(genrand_int32())
      if(r.lt.0.d0)r=r+2.d0**32
      genrand_real1=r/4294967295.d0
      return
      end
!-----------------------------------------------------------------------
!     generates a random number on [0,1)-real-interval
!-----------------------------------------------------------------------
      function genrand_real2()
      double precision genrand_real2,r
      integer genrand_int32
      r=dble(genrand_int32())
      if(r.lt.0.d0)r=r+2.d0**32
      genrand_real2=r/4294967296.d0
      return
      end
!-----------------------------------------------------------------------
!     generates a random number on (0,1)-real-interval
!-----------------------------------------------------------------------
      function genrand_real3()
      double precision genrand_real3,r
      integer genrand_int32
      r=dble(genrand_int32())
      if(r.lt.0.d0)r=r+2.d0**32
      genrand_real3=(r+0.5d0)/4294967296.d0
      return
      end
!-----------------------------------------------------------------------
!     generates a random number on [0,1) with 53-bit resolution
!-----------------------------------------------------------------------
      function genrand_res53()
      double precision genrand_res53
      integer genrand_int32
      double precision a,b
      a=dble(ishft(genrand_int32(),-5))
      b=dble(ishft(genrand_int32(),-6))
      if(a.lt.0.d0)a=a+2.d0**32
      if(b.lt.0.d0)b=b+2.d0**32
      genrand_res53=(a*67108864.d0+b)/9007199254740992.d0
      return
      end
!-----------------------------------------------------------------------
!     initialize large number (over 32-bit constant number)
!-----------------------------------------------------------------------
      subroutine mt_initln
      integer ALLBIT_MASK
      integer TOPBIT_MASK
      integer UPPER_MASK,LOWER_MASK,MATRIX_A,T1_MASK,T2_MASK
      integer mag01(0:1)
      common /mt_mask1/ ALLBIT_MASK
      common /mt_mask2/ TOPBIT_MASK
      common /mt_mask3/ UPPER_MASK,LOWER_MASK,MATRIX_A,T1_MASK,T2_MASK
      common /mt_mag01/ mag01
!    TOPBIT_MASK = Z'80000000'
!    ALLBIT_MASK = Z'ffffffff'
!    UPPER_MASK  = Z'80000000'
!    LOWER_MASK  = Z'7fffffff'
!    MATRIX_A    = Z'9908b0df'
!    T1_MASK     = Z'9d2c5680'
!    T2_MASK     = Z'efc60000'
      TOPBIT_MASK=1073741824
      TOPBIT_MASK=ishft(TOPBIT_MASK,1)
      ALLBIT_MASK=2147483647
      ALLBIT_MASK=ior(ALLBIT_MASK,TOPBIT_MASK)
      UPPER_MASK=TOPBIT_MASK
      LOWER_MASK=2147483647
      MATRIX_A=419999967
      MATRIX_A=ior(MATRIX_A,TOPBIT_MASK)
      T1_MASK=489444992
      T1_MASK=ior(T1_MASK,TOPBIT_MASK)
      T2_MASK=1875247104
      T2_MASK=ior(T2_MASK,TOPBIT_MASK)
      mag01(0)=0
      mag01(1)=MATRIX_A
      return
      end