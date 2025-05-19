program xbet_strategy
   use kind_mod, only: dp
   use bet_mod, only: bet, tol
   implicit none
   real(kind=dp), parameter :: prob = 0.60_dp, gain = 1.0_dp, loss = -1.0_dp, &
                               wealth_init = 25.0_dp, wealth_max = 250.0_dp, &
                               frac_min = 0.05_dp, frac_h = 0.05_dp
   integer, parameter :: max_bets = 300, npaths = 10**5, nfrac = 20
   integer :: i, ierr, ifrac, ipath
   real(kind=dp) :: wealth, bet_size, frac, wealth_term(npaths)
   logical, parameter :: verbose = .false.
   print "('maximum wealth: ',f0.1)", wealth_max
   print "('maximum # of bets: ', i0)", max_bets
   print "('# of paths: ', i0)", npaths
   print "(/,'stats on terminal wealth vs. fractional bet size')"
   print "(*(a9))", "frac_bet", "mean", "min", "max", "prob_max"
   do ifrac = 1, nfrac
      frac = frac_min + (ifrac - 1)*frac_h
      do ipath = 1, npaths
         wealth = wealth_init
         do i = 1, max_bets
            if (verbose) write (*, "(/,'bet #', i0, /, 'wealth = ',f0.1)") i, wealth
            bet_size = min(frac*wealth, wealth_max - wealth)
            call bet(bet_size, prob, gain, loss, wealth_max, wealth, ierr)
            if (wealth <= 0.0_dp) then
               if (verbose) print *, "lost all money"
               exit
            else if (wealth + tol >= wealth_max) then
               if (verbose) print *, "achieved maximum wealth"
               exit
            end if
         end do
         if (verbose) print "(/,a,f8.1)", "final wealth: ", wealth
         wealth_term(ipath) = wealth
      end do
      print "(*(f9.4))", &
         frac, sum(wealth_term)/npaths, minval(wealth_term), maxval(wealth_term), &
         count(wealth_max - wealth_term < tol) / real(npaths, kind=dp)
   end do
end program xbet_strategy
