set term png
set out "x.png"

set xlabel "T"
set ylabel "x*"

set key bmargin center horizontal box

plot "MC3-8.dat" index 0 using 1:7 title "L=8" ,"MC3-16.dat" index 0 using 1:7 title "L=16","MC3-32.dat" index 0 using 1:7 title "L=32","MC3-48.dat" index 0 using 1:7 title "L=48","MC3-64.dat" index 0 using 1:7 title "L=64"    