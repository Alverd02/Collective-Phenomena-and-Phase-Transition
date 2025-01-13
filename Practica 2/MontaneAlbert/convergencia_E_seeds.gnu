set term png
set out "conv_e_seeds.png"
set xlabel "N"
set ylabel "Energy"
set key bmargin center horizontal box
plot "convergencia_48185051.dat" index 0 using 1:2 with lines title"SEED = 48185051","convergencia_48185052.dat" index 0 using 1:2 with lines title"SEED = 48185052","convergencia_48185053.dat" index 0 using 1:2 with lines title"SEED = 48185053","convergencia_48185054.dat" index 0 using 1:2 with lines title"SEED = 48185054","convergencia_48185055.dat" index 0 using 1:2 with lines title"SEED = 48185055"