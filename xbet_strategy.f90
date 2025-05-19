program xbet_strategy
   ! simulate betting a fraction of wealth
   use kind_mod  , only: dp
   use bet_mod   , only: bet, tol
   use random_mod, only: random_seed_init
   implicit none
   real(kind=dp), parameter :: prob = 0.60_dp, gain = 1.0_dp, loss = -1.0_dp, &
                               wealth_init = 25.0_dp, wealth_max = 250.0_dp, &
                               frac_min = 0.05_dp, frac_h = 0.05_dp
   integer, parameter :: max_bets = 300, npaths = 10**5, nfrac = 20
   integer :: i, ierr, ifrac, ipath, nbets(npaths)
   real(kind=dp) :: wealth, bet_size, frac, wealth_term(npaths), frac_use
   logical, parameter :: verbose = .false.
   logical, parameter :: vary_frac = .true. ! allow bet size to increase when few bets remain?
   character (len=*), parameter :: fmt_cr = "(a20,':',*(1x,f8.4))", fmt_ci = "(a20,':',*(1x,i8))"
   call random_seed_init(123)
   print fmt_cr,"initial wealth", wealth_init
   print fmt_cr,"maximum wealth", wealth_max
   print fmt_cr,"prob gain", prob
   print fmt_cr,"gain", gain
   print fmt_cr,"loss", loss
   print fmt_ci,"maximum # of bets", max_bets
   print fmt_ci,"# of paths", npaths
   print "(a20,':',*(1x,l1))", "vary_frac", vary_frac
   print "(/,'stats on terminal wealth vs. fractional bet size')"
   print "(*(a12))", "frac_bet", "mean", "min", "max", "prob_max", "mean_#bets"
   do ifrac = 1, nfrac
      frac = frac_min + (ifrac - 1)*frac_h
      nbets = max_bets
      do ipath = 1, npaths
         wealth = wealth_init
         do i = 1, max_bets
            if (verbose) write (*, "(/,'bet #', i0, /, 'wealth = ',f0.1)") i, wealth
            if (vary_frac) then
               frac_use = min(1.0_dp, max(frac, (wealth_max/wealth)**(1.0_dp/(max_bets-i+1)) - 1.0_dp))
            else
               frac_use = frac
            end if
            bet_size = min(frac_use*wealth, wealth_max - wealth)
            call bet(bet_size, prob, gain, loss, wealth_max, wealth, ierr)
            if (wealth <= 0.0_dp) then
               if (verbose) print *, "lost all money"
               nbets(ipath) = i
               exit
            else if (wealth + tol >= wealth_max) then
               if (verbose) print *, "achieved maximum wealth"
               nbets(ipath) = i
               exit
            end if
         end do
         if (verbose) print "(/,a,f8.1)", "final wealth: ", wealth
         wealth_term(ipath) = wealth
      end do
      print "(*(f12.4))", &
         frac, sum(wealth_term)/npaths, minval(wealth_term), maxval(wealth_term), &
         count(wealth_max - wealth_term < tol) / real(npaths, kind=dp), &
         sum(nbets) / real(npaths, kind=dp)
   end do
end program xbet_strategy
