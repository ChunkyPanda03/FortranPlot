module plotting 
  implicit none
  
  type plotdata
    real, POINTER :: xdata(:),ydata(:),zdata(:)
  end type plotdata
  interface plot
    module procedure plot_real_2d
    module procedure plot_real_1d
    module procedure plot_int_1d
    module procedure plot_int_2d
    module procedure plotter
  end interface plot
  contains
    !------- all of these interfaces go to plotter
    
    subroutine plot_int_2d (xdata,ydata)
      implicit none
      integer, INTENT(IN):: ydata(:,:), xdata(:,:)
      call plot_real_2d(real(xdata), real(ydata))
    end subroutine plot_int_2d

    subroutine plot_int_1d (xdata,ydata)
      implicit none
      integer, INTENT(IN):: ydata(:), xdata(:)
      call plot_real_1d(real(xdata), real(ydata))
    end subroutine plot_int_1d

    subroutine plot_real_1d (xdata,ydata)
      implicit none
      integer :: i
      real, intent(in):: ydata(:), xdata(:)
      real, ALLOCATABLE,TARGET :: ydatatemp(:), xdatatemp(:)
      type(plotdata):: data(1)
      ydatatemp = ydata
      xdatatemp = xdata

      data(1)%xdata => xdatatemp
      data(1)%ydata => ydatatemp
      

      call plotter(data)
      
      
      NULLIFY(data(1)%xdata)
      NULLIFY(data(1)%ydata)
      DEALLOCATE(xdatatemp)
      DEALLOCATE(ydatatemp)
    end subroutine plot_real_1d
    
    subroutine plot_real_2d (xdata,ydata)
      implicit none
      integer :: i
      real, intent(in):: ydata(:,:), xdata(:,:)
      real, ALLOCATABLE,TARGET :: ydatatemp(:,:), xdatatemp(:,:)
      type(plotdata) :: data(size(xdata, dim=2))
      ydatatemp = ydata
      xdatatemp = xdata
      do i = 1, size(xdata, dim=2), 1
        
        data(i)%xdata => xdatatemp(:,i)
        data(i)%ydata => ydatatemp(:,i)
      end do

      call plotter(data)
      do i = 1,size(xdata, dim=2), 1
        NULLIFY(data(i)%xdata)
        NULLIFY(data(i)%ydata)
      end do
      DEALLOCATE(xdatatemp)
      DEALLOCATE(ydatatemp)
    end subroutine plot_real_2d
    
    subroutine plotter(data)
      use :: plplot
      implicit none 
      integer :: i
      real, POINTER, DIMENSION(:) :: temp
      type(plotdata) :: data(:)
      real,    parameter :: XSTEP = 0.01
      real    :: xmax, xmin, ymax, ymin, yrange, xrange
      real, ALLOCATABLE :: fulldata(:,:)
      fulldata = pdfull(data)
      yrange = maxval(fulldata(:,2)) - minval(fulldata(:,2))
      xrange = maxval(fulldata(:,1)) - minval(fulldata(:,1))
     !write (*,*) yrange
      xmin = minval(fulldata(:,1)) - xrange*.01
      xmax = maxval(fulldata(:,1)) + xrange*.01
      ymin = minval(fulldata(:,2)) - yrange*.01
      ymax = maxval(fulldata(:,2)) + yrange*.01

      call plsdev('xwin')
      call plscolbg(255,255,255) ! Set background colour (RGB).
      call plinit()
      call plscol0(1, 0,0,0)  ! Initialise PLplot.
      call plcol0(1)           ! Set foreground colour.

      call plenv(xmin, xmax, ymin, ymax, 0, 0)
      call pllab('x', 'y = 7.5 sin(x)', '2D line plot using PLplot' )
      do i = 1, size(data), 1
        call plline(data(i)%xdata,data(i)%ydata)
      end do

      call plend()
    end subroutine plotter
    function pdfull(data)
      type (plotdata), intent(in) :: data (:)
      real, ALLOCATABLE :: pdfull(:,:)
      integer :: nele = 0,i, j = 1
        
      do i = 1, SIZE(data), 1
        nele = nele + size(data(i)%ydata)
      end do
      ALLOCATE(pdfull(nele,2))
      do i = 1, SIZE(data), 1
        pdfull(j:size(data(i)%xdata),1)  = data(i)%xdata 
        pdfull(j:size(data(i)%ydata),2)  = data(i)%ydata 
        j = j + size(data(i)%ydata)                                   
      end do




    end function pdfull

    !function randomcolor()


end module plotting
