set term png
set out "conv_e.png"
set xlabel "N"
set ylabel "Energy"
set key bmargin center horizontal box
plot "convergencia.dat" index 0 using 1:2 with lines title"TEMP = 1.8","convergencia.dat" index 1 using 1:2 with lines title"TEMP = 2.1","convergencia.dat" index 2 using 1:2 with lines title"TEMP = 2.3","convergencia.dat" index 3 using 1:2 with lines title"TEMP = 2.6","convergencia.dat" index 4 using 1:2 with lines title"TEMP = 2.8","convergencia.dat" index 5 using 1:2 with lines title"TEMP = 3.1"
