# Comparison charts split into two families to keep curves legible:
#   BM25 family:    baseline, +bm25, +bm25 T=0.7, +bm25 T=0.5
#   PPM family:     baseline, +ppm:2, +ppm:4, +full (ppm:4 + bm25)
# Run from repo root: gnuplot eval/comparison.gp

set terminal pngcairo size 1000,550 font ",10"
set grid
set key top left

CORPORA = "mem fortune movie5k movie100k"

# ---------- BM25 family fallthrough ----------
set yrange [0:1.05]
set xlabel "prompt index"
set ylabel "rate"
do for [c in CORPORA] {
  set output sprintf('eval/comparison_fallthrough_bm25_%s.png', c)
  set title  sprintf("Per-prompt fallthrough — BM25 family — %s", c)
  plot sprintf('eval/baseline_%s_per_prompt.dat', c) using 1:2 with linespoints pt 7  ps 0.6 lw 2 title 'baseline', \
       sprintf('eval/bm25_%s_per_prompt.dat', c)     using 1:2 with linespoints pt 9  ps 0.6 lw 2 title '+bm25', \
       sprintf('eval/bm25seed_%s_per_prompt.dat', c)      using 1:2 with linespoints pt 11 ps 0.6 lw 2 title '+bm25+seed', \
       sprintf('eval/bm25seed_ppm2_%s_per_prompt.dat', c) using 1:2 with linespoints pt 13 ps 0.6 lw 2 title '+bm25+seed+ppm:2'
}

# ---------- PPM family fallthrough ----------
do for [c in CORPORA] {
  set output sprintf('eval/comparison_fallthrough_ppm_%s.png', c)
  set title  sprintf("Per-prompt fallthrough — PPM family — %s", c)
  plot sprintf('eval/baseline_%s_per_prompt.dat', c) using 1:2 with linespoints pt 7  ps 0.6 lw 2 title 'baseline', \
       sprintf('eval/ppm2_%s_per_prompt.dat', c)     using 1:2 with linespoints pt 5  ps 0.6 lw 2 title '+ppm:2', \
       sprintf('eval/ppm_%s_per_prompt.dat', c)      using 1:2 with linespoints pt 9  ps 0.6 lw 2 title '+ppm:4', \
       sprintf('eval/full_%s_per_prompt.dat', c)     using 1:2 with linespoints pt 11 ps 0.6 lw 2 title 'full'
}

# ---------- BM25 family latency ----------
unset yrange
set xlabel "trial (sorted)"
set ylabel "latency (ms)"
do for [c in CORPORA] {
  set output sprintf('eval/comparison_latency_bm25_%s.png', c)
  set title  sprintf("Sorted latency (ms) — BM25 family — %s", c)
  plot sprintf('eval/baseline_%s_latency.dat', c) using 1:2 with linespoints pt 7  ps 0.4 lw 2 title 'baseline', \
       sprintf('eval/bm25_%s_latency.dat', c)     using 1:2 with linespoints pt 9  ps 0.4 lw 2 title '+bm25', \
       sprintf('eval/bm25seed_%s_latency.dat', c)      using 1:2 with linespoints pt 11 ps 0.4 lw 2 title '+bm25+seed', \
       sprintf('eval/bm25seed_ppm2_%s_latency.dat', c) using 1:2 with linespoints pt 13 ps 0.4 lw 2 title '+bm25+seed+ppm:2'
}

do for [c in CORPORA] {
  set output sprintf('eval/comparison_latency_ppm_%s.png', c)
  set title  sprintf("Sorted latency (ms) — PPM family — %s", c)
  plot sprintf('eval/baseline_%s_latency.dat', c) using 1:2 with linespoints pt 7  ps 0.4 lw 2 title 'baseline', \
       sprintf('eval/ppm2_%s_latency.dat', c)     using 1:2 with linespoints pt 5  ps 0.4 lw 2 title '+ppm:2', \
       sprintf('eval/ppm_%s_latency.dat', c)      using 1:2 with linespoints pt 9  ps 0.4 lw 2 title '+ppm:4', \
       sprintf('eval/full_%s_latency.dat', c)     using 1:2 with linespoints pt 11 ps 0.4 lw 2 title 'full'
}
