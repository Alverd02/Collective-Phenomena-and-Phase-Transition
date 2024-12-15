set term png
set out "e.png"

set xlabel "T"
set ylabel "e"

set key bmargin center horizontal box

plot "MC3.dat" index 0 using 1:2  title "" 