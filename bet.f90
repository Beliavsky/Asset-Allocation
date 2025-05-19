module bet_mod
use kind_mod, only: dp
implicit none
real(kind=dp), parameter :: tol = 1.0d-6
private
public :: bet, tol
contains
subroutine bet(xbet, prob, gain, loss, wealth_max, wealth, ierr)
! make a binary bet with specified probability of winning and size of gain and loss
real(kind=dp), intent(in)     :: xbet ! amount bet
real(kind=dp), intent(in)     :: prob ! probability of winning bet
real(kind=dp), intent(in)     :: gain ! multiplier of bet upon win
real(kind=dp), intent(in)     :: loss ! multiplier of bet upon loss
real(kind=dp), intent(in)     :: wealth_max ! maximum wealth
real(kind=dp), intent(in out) :: wealth     ! wealth before and after bet
integer      , intent(out)    :: ierr ! error flag
real(kind=dp)                 :: xran, max_bet
ierr = 0
max_bet = (wealth_max - wealth)/gain
if (wealth <= 0.0_dp .or. xbet < 0.0_dp .or. xbet > wealth + tol) then
   print*,"need 0 <= bet <= wealth"
   ierr = 1
   return
else if (xbet > max_bet) then
   print*,"cannot bet more than", max_bet
   ierr = 2
end if
if (ierr /= 0) return
call random_number(xran)
wealth = wealth + xbet * merge(gain, loss, xran < prob)
end subroutine bet

end module bet_mod
