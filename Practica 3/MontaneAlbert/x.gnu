set term png
set out "x.png"

set xlabel "T"
set ylabel "x*"

set key bmargin center horizontal box

plot "MC3.dat" index 0 using 1:7 with lines  title "x*" 