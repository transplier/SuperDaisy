# Four-config comparison: baseline, +ppm, +bm25, full.
# Run from repo root: gnuplot eval/comparison.gp

set terminal pngcairo size 1000,550 font ",10"
set grid
set key top left

# ---------- sorted latency ----------
set output 'eval/comparison_latency_mem.png'
set title  "Sorted latency (ms) — MEM.DSY"
set xlabel "trial (sorted)"
set ylabel "latency (ms)"
plot 'eval/baseline_mem_latency.dat' using 1:2 with linespoints pt 7 ps 0.4 lw 2 title 'baseline', \
     'eval/ppm_mem_latency.dat'      using 1:2 with linespoints pt 5 ps 0.4 lw 2 title '+ppm', \
     'eval/bm25_mem_latency.dat'     using 1:2 with linespoints pt 9 ps 0.4 lw 2 title '+bm25', \
     'eval/full_mem_latency.dat'     using 1:2 with linespoints pt 11 ps 0.4 lw 2 title 'full'

set output 'eval/comparison_latency_fortune.png'
set title  "Sorted latency (ms) — fortune-haiku"
plot 'eval/baseline_fortune_latency.dat' using 1:2 with linespoints pt 7 ps 0.4 lw 2 title 'baseline', \
     'eval/ppm_fortune_latency.dat'      using 1:2 with linespoints pt 5 ps 0.4 lw 2 title '+ppm', \
     'eval/bm25_fortune_latency.dat'     using 1:2 with linespoints pt 9 ps 0.4 lw 2 title '+bm25', \
     'eval/full_fortune_latency.dat'     using 1:2 with linespoints pt 11 ps 0.4 lw 2 title 'full'

# ---------- per-prompt fallthrough ----------
set yrange [0:1.05]
set output 'eval/comparison_fallthrough_mem.png'
set title  "Per-prompt fallthrough rate — MEM.DSY"
set xlabel "prompt index"
set ylabel "rate"
plot 'eval/baseline_mem_per_prompt.dat' using 1:2 with linespoints pt 7 ps 0.6 lw 2 title 'baseline', \
     'eval/ppm_mem_per_prompt.dat'      using 1:2 with linespoints pt 5 ps 0.6 lw 2 title '+ppm', \
     'eval/bm25_mem_per_prompt.dat'     using 1:2 with linespoints pt 9 ps 0.6 lw 2 title '+bm25', \
     'eval/full_mem_per_prompt.dat'     using 1:2 with linespoints pt 11 ps 0.6 lw 2 title 'full'

set output 'eval/comparison_fallthrough_fortune.png'
set title  "Per-prompt fallthrough rate — fortune-haiku"
plot 'eval/baseline_fortune_per_prompt.dat' using 1:2 with linespoints pt 7 ps 0.6 lw 2 title 'baseline', \
     'eval/ppm_fortune_per_prompt.dat'      using 1:2 with linespoints pt 5 ps 0.6 lw 2 title '+ppm', \
     'eval/bm25_fortune_per_prompt.dat'     using 1:2 with linespoints pt 9 ps 0.6 lw 2 title '+bm25', \
     'eval/full_fortune_per_prompt.dat'     using 1:2 with linespoints pt 11 ps 0.6 lw 2 title 'full'
