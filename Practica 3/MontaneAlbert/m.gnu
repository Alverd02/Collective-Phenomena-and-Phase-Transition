set term png
set out "m.png"

set xlabel "T"
set ylabel "<|m|>"

set key bmargin center horizontal box

plot "MC3.dat" index 0 using 1:4:5 with yerrorbars  title "<|m|>" 