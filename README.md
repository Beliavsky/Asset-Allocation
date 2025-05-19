# Asset-Allocation
Simulations of bet-sizing and asset allocation problems. The program `xbet_strategy.f90` simulates a betting game described on p16 of the book [The Missing Billionaires: A Guide to Better Financial Decisions](https://www.wiley.com/en-us/The+Missing+Billionaires%3A+A+Guide+to+Better+Financial+Decisions-p-9781119747918) (2023), by Victor Haghani and James White. For a bet that you have a 60% of winning, with gains and losses of equal size, with a capped payout of 10 times initial wealth, with up to 300 bets placed, the optimal bet size as a fraction of wealth is between 10% and 20%, consistent with the Table 2.1 of the book on p18.

Sample output:
```
      initial wealth:  25.0000
      maximum wealth: 250.0000
           prob gain:   0.6000
                gain:   1.0000
                loss:  -1.0000
   maximum # of bets:      300
          # of paths:   100000

stats on terminal wealth vs. fractional bet size
 frac_bet     mean      min      max prob_max
   0.0500 218.2454   8.5235 250.0000   0.7120
   0.1000 241.7309   1.1118 250.0000   0.9447
   0.1500 241.6671   0.0401 250.0000   0.9545
   0.2000 238.0118   0.0032 250.0000   0.9422
   0.2500 230.7173   0.0000 250.0000   0.9135
   0.3000 218.9336   0.0000 250.0000   0.8676
   0.3500 202.7334   0.0000 250.0000   0.8044
   0.4000 182.2087   0.0000 250.0000   0.7243
   0.4500 159.9138   0.0000 250.0000   0.6366
   0.5000 138.4099   0.0000 250.0000   0.5524
   0.5500 119.3370   0.0000 250.0000   0.4768
   0.6000 105.0780   0.0000 250.0000   0.4202
   0.6500  92.4122   0.0000 250.0000   0.3696
   0.7000  82.9475   0.0000 250.0000   0.3318
   0.7500  74.7900   0.0000 250.0000   0.2992
   0.8000  67.6300   0.0000 250.0000   0.2705
   0.8500  63.4175   0.0000 250.0000   0.2537
   0.9000  58.1600   0.0000 250.0000   0.2326
   0.9500  53.2900   0.0000 250.0000   0.2132
   1.0000  48.1350   0.0000 250.0000   0.1925
```
`
