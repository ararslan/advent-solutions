program aocday1

implicit none

real :: mass, fuel_sum, total_fuel_sum
real, dimension(:), allocatable :: masses
integer :: i

masses = read_file("input")

fuel_sum = 0
total_fuel_sum = 0
do i = 1, size(masses)
    mass = masses(i)
    fuel_sum = fuel_sum + fuel(mass)
    total_fuel_sum = total_fuel_sum + total_fuel(mass)
end do

write(*,*) fuel_sum
write(*,*) total_fuel_sum

contains

function read_file(fname) result(xs)
    character(len=*), intent(in) :: fname
    real, dimension(:), allocatable :: xs
    real :: x
    integer, parameter :: file_unit = 10
    integer :: stat
    allocate(xs(0))
    open(unit=file_unit, file=fname)
    do
        read(file_unit, fmt=*, iostat=stat) x
        if (stat /= 0) exit
        xs = [xs, x]
    end do
    close(file_unit)
end function read_file

real function fuel(mass)
    real :: mass
    fuel = max(0, floor(mass / 3) - 2)
end function fuel

real function total_fuel(mass)
    real :: mass
    total_fuel = 0
    do while (mass > 0)
        mass = fuel(mass)
        total_fuel = total_fuel + mass
    end do
end function total_fuel

end program aocday1
