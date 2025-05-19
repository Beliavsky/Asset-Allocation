program xbet
! interactive version of betting program
use kind_mod, only: dp
use bet_mod , only: bet, tol
implicit none
real(kind=dp), parameter :: prob = 0.60_dp, gain=1.0_dp, loss=-1.0_dp, &
   wealth_init = 10.0_dp, wealth_max = 100.0_dp
integer, parameter :: max_bets = 10
integer :: i, ierr
real(kind=dp) :: wealth, bet_size
wealth = wealth_init
print "('maximum wealth: ',f0.1)", wealth_max
print "('maximum # of bets: ', i0)", max_bets
do i=1,max_bets
   write (*,"(/,'bet #', i0, /, 'wealth = ',f0.1,/, 'bet size? ')", &
      advance="no") i, wealth
   read (*,*) bet_size
   call bet(bet_size, prob, gain, loss, wealth_max, wealth, ierr)
   if (wealth <= 0.0_dp) then
      print*,"lost all money"
      exit
   else if (wealth + tol >= wealth_max) then
      print*,"achieved maximum wealth"
      exit
   end if
end do
print "(/,a,f8.1)", "final wealth: ", wealth
end program xbet