#!/usr/bin/gnuplot

# for GNUPLOT5.0
reset
set output "populations.eps"
set term post eps color enh "Times-Bold" 28
set encoding utf8
#set grid

#set title "{/Symbol abcdefghijklmnopqrstuvwxyz   \245}"
#set ylabel "d^2{/Symbol s}/dp/d{/Symbol W} (mb/(MeV/c)/str)" 1,0
#set xlabel "K^+ Momentum (GeV/c)"

set multiplot layout 1,1 font ",18" \
margins 0.25,0.85,0.29,0.90 \
              spacing 0.00,0.00
#margins <left>,<right>,<bottom>,<top>

unset title
set key maxcolumns 2 maxrows 4
set xrange [0 : 700 ]
show xrange
set yrange [0 : 1.0]
show yrange
set xlabel "t (fs)"
set ylabel "P"
#set xtics ("0" 0, "100" 20, "200" 40, "300" 60, "400" 80,"500" 100)
#set ytics ("8780" 0, "8785" 250, "8790" 500, "8795" 750, "8800" 1000)
set mytics 2
set mxtics 2
set border linewidth 1
#set border 8	# this defines border position

LW=3.5
plot 'state1.pop' w l lt 5 lw LW t "S_0",\
     'state2.pop' w l lw LW t "S_1",\
     'state3.pop' w l lw LW t "S_2",\
     'state4.pop' w l lw LW t "S_3",\
     'state5.pop' w l lt 8 lw LW dt 2 t "T_1",\
     'state6.pop' w l lw LW dt 6 t "T_2",\
     'state7.pop' w l lw LW dt 2 t "T_3",\
     'state8.pop' w l lt 1 lw LW dt 6 t "T_4" 

unset multiplot
set term x11

