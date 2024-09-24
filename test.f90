program test
  use plotting
  implicit none
  type :: IntPointer
    integer, pointer, DIMENSION(:) :: ptr
  end type
  type(IntPointer), ALLOCATABLE :: pt(:)
  INTEGER, target, ALLOCATABLE :: z(:), r(:)
  integer :: g,h
  integer :: tempx(5,2), tempy(5,2)
  z = (/1,2,3,4,5,6,7,8,9,10,11,12,13/)
  r = (/8,7,6,5,4,3,2,1/)
  ALLOCATE(pt(0:1))
  pt(0)%ptr => z
  
  pt(1)%ptr => r
 ! write (*,*) pt(1)%ptr

  !write (*,*) pt
  !pt => z
  !pt1 => r
  tempx(:,1) = (/1,2,3,4,5/)
  tempx(:,2) = (/1,2,3,4,5/)
  tempy(:,1) = (/1,2,3,4,5/)
  tempy(:,2) = -1 * (/1,2,3,4,5/)
  
  call plot(tempx,tempy)
end program test
