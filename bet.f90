module bet_mod
use kind_mod, only: dp
implicit none
real(kind=dp), parameter :: tol = 1.0d-6
private
public :: bet, tol, kelly_frac, bet_value_1_turn, bet_value_2_turns
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

function kelly_frac(prob, gain, loss) result(frac)
! Kelly criterion
real(kind=dp), intent(in) :: prob
real(kind=dp), intent(in) :: gain
real(kind=dp), intent(in) :: loss
real(kind=dp)             :: frac
frac = prob/loss - (1-prob)/gain
end function kelly_frac

function bet_value_2_turns(wealth, wealth_max, prob, gain, loss, xbet) result(val)
! expected bet value with 2 turns left
real(kind=dp), intent(in)     :: xbet ! amount bet
real(kind=dp), intent(in)     :: prob ! probability of winning bet
real(kind=dp), intent(in)     :: gain ! multiplier of bet upon win
real(kind=dp), intent(in)     :: loss ! multiplier of bet upon loss
real(kind=dp), intent(in)     :: wealth_max ! maximum wealth
real(kind=dp), intent(in)     :: wealth     ! wealth before bet
real(kind=dp)                 :: val
if (wealth >= wealth_max) then
   val = wealth_max
   return
else if (xbet < 0.0_dp .or. xbet > wealth) then
   val = wealth
   return
else
   val = wealth + prob * bet_value_1_turn(wealth + xbet*gain, wealth_max, prob, gain, loss) + &
            (1 - prob) * bet_value_1_turn(wealth + xbet*loss, wealth_max, prob, gain, loss)
end if
end function bet_value_2_turns

function bet_value_1_turn(wealth, wealth_max, prob, gain, loss) result(val)
! expected bet value with 1 turn left
real(kind=dp), intent(in)     :: prob ! probability of winning bet
real(kind=dp), intent(in)     :: gain ! multiplier of bet upon win
real(kind=dp), intent(in)     :: loss ! multiplier of bet upon loss
real(kind=dp), intent(in)     :: wealth_max ! maximum wealth
real(kind=dp), intent(in)     :: wealth     ! wealth before bet
real(kind=dp)                 :: val
real(kind=dp)                 :: xbet, expect
if (wealth >= wealth_max) then
   val = wealth_max
else if (wealth <= 0.0_dp) then
   val = wealth
else
   expect = prob*gain + (1-prob)*loss
!   print*,"xbet =",xbet
   if (expect > 0) then
      xbet = min(wealth, wealth_max-wealth)
      val = wealth + xbet * expect
   else
      val = wealth
   end if
end if
end function bet_value_1_turn

end module bet_mod
