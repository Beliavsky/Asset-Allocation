program xbet_n_turns
! test bet_value_n_turns
use kind_mod, only: dp
use bet_mod , only: bet_value_1_turn, bet_value_2_turns, bet_value_n_turns
implicit none
real(kind=dp), parameter :: prob = 0.60_dp, gain = 1.0_dp, loss = -1.0_dp, &
                            wealth_max = 10.0_dp
integer :: ibet, iw, nturns
real(kind=dp) :: wealth, val, xbet
character (len=*), parameter :: fmt_cr = "(a20,':',*(1x,f8.4))"
print fmt_cr,"maximum wealth", wealth_max
print fmt_cr,"prob gain", prob
print fmt_cr,"gain", gain
print fmt_cr,"loss", loss
nturns = 10
print "(/,*(a8))", "wealth", "value"
do iw=0,nint(wealth_max)
   wealth = real(iw, kind=dp)
   val = bet_value_1_turn(wealth, wealth_max, prob, gain, loss)
   print "(*(f8.2))", wealth, val
end do
print "(/,*(a8))", "wealth", "bet", "value_2", "value_n"
do iw=0,nint(wealth_max)
   wealth = real(iw, kind=dp)
   do ibet=0,iw
      xbet = real(ibet, kind=dp)
      if (wealth + xbet <= wealth_max) then
         val = bet_value_2_turns(wealth, wealth_max, prob, gain, loss, xbet)
         print "(*(f8.2))", wealth, xbet, val, bet_value_n_turns(nturns, wealth, wealth_max, prob, gain, loss, xbet)
      end if
   end do
end do
end program xbet_n_turns