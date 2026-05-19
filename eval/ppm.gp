# Comparison charts: classic vs PPM at order 4.
# gnuplot eval/ppm.gp

set terminal pngcairo size 900,500 font ",10"
set grid

# Sorted latency CDFs, classic vs PPM:4, one panel per corpus
set output 'eval/ppm_latency_mem.png'
set title  "Sorted latency (ms) — MEM.DSY: classic vs PPM:4"
set xlabel "trial (sorted)"
set ylabel "latency (ms)"
set key top left
plot 'eval/baseline_mem_latency.dat' using 1:2 with linespoints pt 7 ps 0.4 lw 2 title 'classic', \
     'eval/ppm4_mem_latency.dat'     using 1:2 with linespoints pt 5 ps 0.4 lw 2 title 'PPM:4'

set output 'eval/ppm_latency_fortune.png'
set title  "Sorted latency (ms) — fortune-haiku: classic vs PPM:4"
plot 'eval/baseline_fortune_latency.dat' using 1:2 with linespoints pt 7 ps 0.4 lw 2 title 'classic', \
     'eval/ppm4_fortune_latency.dat'     using 1:2 with linespoints pt 5 ps 0.4 lw 2 title 'PPM:4'

# Per-prompt fallthrough comparison, classic vs PPM:4, one panel per corpus
set yrange [0:1.05]
set output 'eval/ppm_fallthrough_mem.png'
set title  "Per-prompt fallthrough — MEM.DSY: classic vs PPM:4"
set xlabel "prompt index"
set ylabel "rate"
plot 'eval/baseline_mem_per_prompt.dat' using 1:2 with linespoints pt 7 ps 0.6 lw 2 title 'classic', \
     'eval/ppm4_mem_per_prompt.dat'     using 1:2 with linespoints pt 5 ps 0.6 lw 2 title 'PPM:4'

set output 'eval/ppm_fallthrough_fortune.png'
set title  "Per-prompt fallthrough — fortune-haiku: classic vs PPM:4"
plot 'eval/baseline_fortune_per_prompt.dat' using 1:2 with linespoints pt 7 ps 0.6 lw 2 title 'classic', \
     'eval/ppm4_fortune_per_prompt.dat'     using 1:2 with linespoints pt 5 ps 0.6 lw 2 title 'PPM:4'
