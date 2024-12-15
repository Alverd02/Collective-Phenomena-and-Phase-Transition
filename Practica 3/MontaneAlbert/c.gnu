set term png
set out "c.png"

set xlabel "T"
set ylabel "c_v"

set key bmargin center horizontal box

plot "MC3.dat" index 0  using 1:6 with lines    title "c_v" 