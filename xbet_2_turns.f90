program xbet_2_turns
! simulate betting a fraction of wealth
use kind_mod  , only: dp
use bet_mod, only: bet_value_1_turn
implicit none
real(kind=dp), parameter :: prob = 0.60_dp, gain = 1.0_dp, loss = -1.0_dp, &
                            wealth_max = 10.0_dp
integer :: iw
real(kind=dp) :: wealth, val
character (len=*), parameter :: fmt_cr = "(a20,':',*(1x,f8.4))"
print fmt_cr,"maximum wealth", wealth_max
print fmt_cr,"prob gain", prob
print fmt_cr,"gain", gain
print fmt_cr,"loss", loss
do iw=0,nint(wealth_max)
   wealth = real(iw, kind=dp)
   val = bet_value_1_turn(wealth, wealth_max, prob, gain, loss)
   print "(*(f6.2))", wealth, val
end do
end program xbet_2_turns