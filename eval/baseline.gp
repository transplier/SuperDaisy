# Charts for the SuperDaisy baseline eval. Produces PNGs in eval/.
# Run from repo root: gnuplot eval/baseline.gp

set terminal pngcairo size 900,500 font ",10"
set grid

# ---------- latency CDFs (one curve per corpus) ----------
set output 'eval/baseline_latency.png'
set title  "Response latency (sorted, ms) — Super-DAISY classic"
set xlabel "trial (sorted by latency)"
set ylabel "latency (ms)"
set key top left
plot 'eval/baseline_mem_latency.dat'     using 1:2 with linespoints pt 7 ps 0.4 lw 2 title 'MEM.DSY (92 sentences)', \
     'eval/baseline_fortune_latency.dat' using 1:2 with linespoints pt 7 ps 0.4 lw 2 title 'fortune-haiku (250 sentences)'

# ---------- response-length histograms ----------
set output 'eval/baseline_lengths.png'
set title  "Response length distribution (tokens) — Super-DAISY classic"
set xlabel "tokens per response"
set ylabel "count"
set style fill solid 0.4 border -1
set boxwidth 0.8
set key top right
plot 'eval/baseline_mem_lengths.dat'     using 1:2 with boxes title 'MEM.DSY', \
     'eval/baseline_fortune_lengths.dat' using 1:2 with boxes title 'fortune-haiku'

# ---------- per-prompt fallthrough & ugliness ----------
set output 'eval/baseline_per_prompt.png'
set title  "Per-prompt fallthrough & ugliness rates (10 seeds each) — MEM.DSY"
set xlabel "prompt index"
set ylabel "rate"
set yrange [0:1.05]
set key top right
plot 'eval/baseline_mem_per_prompt.dat' using 1:2 with linespoints pt 7 ps 0.6 lw 2 title 'fallthrough', \
     'eval/baseline_mem_per_prompt.dat' using 1:3 with linespoints pt 5 ps 0.6 lw 2 title 'ugly'

set output 'eval/baseline_per_prompt_fortune.png'
set title  "Per-prompt fallthrough & ugliness rates (10 seeds each) — fortune-haiku"
plot 'eval/baseline_fortune_per_prompt.dat' using 1:2 with linespoints pt 7 ps 0.6 lw 2 title 'fallthrough', \
     'eval/baseline_fortune_per_prompt.dat' using 1:3 with linespoints pt 5 ps 0.6 lw 2 title 'ugly'
