set term png
set out "convergencia.png"
set multiplot layout 2,1
set xlabel "N"
set ylabel "Energy/N"
set key bmargin center horizontal box
plot "MC.dat" index 0 using 1:2 with lines title"TEMP = 1.2","MC.dat" index 1 using 1:2 with lines title"TEMP = 1.5","MC.dat" index 2 using 1:2 with lines title"TEMP = 2.5","MC.dat" index 3 using 1:2 with lines title"TEMP = 3.5","MC.dat" index 4 using 1:2 with lines title"TEMP = 4.5"
set ylabel "MAG/N"
plot "MC.dat" index 0 using 1:4 with lines title"TEMP = 1.2","MC.dat" index 1 using 1:4 with lines title"TEMP = 1.5","MC.dat" index 2 using 1:4 with lines title"TEMP = 2.5","MC.dat" index 3 using 1:4 with lines title"TEMP = 3.5","MC.dat" index 4 using 1:4 with lines title"TEMP = 4.5"
unset multiplot