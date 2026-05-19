# Four-config comparison: baseline, +ppm, +bm25, full.
# Run from repo root: gnuplot eval/comparison.gp
#
# One output per (metric, corpus). To add a corpus, append to the CORPORA
# block below — bash macro-style via gnuplot's `do for` loop.

set terminal pngcairo size 1000,550 font ",10"
set grid
set key top left

CORPORA = "mem fortune movie5k movie100k"

# ---------- sorted latency CDFs ----------
do for [c in CORPORA] {
  set output sprintf('eval/comparison_latency_%s.png', c)
  set title  sprintf("Sorted latency (ms) — %s", c)
  set xlabel "trial (sorted)"
  set ylabel "latency (ms)"
  plot sprintf('eval/baseline_%s_latency.dat', c) using 1:2 with linespoints pt 7  ps 0.4 lw 2 title 'baseline', \
       sprintf('eval/ppm_%s_latency.dat', c)      using 1:2 with linespoints pt 5  ps 0.4 lw 2 title '+ppm', \
       sprintf('eval/bm25_%s_latency.dat', c)     using 1:2 with linespoints pt 9  ps 0.4 lw 2 title '+bm25', \
       sprintf('eval/full_%s_latency.dat', c)     using 1:2 with linespoints pt 11 ps 0.4 lw 2 title 'full'
}

# ---------- per-prompt fallthrough ----------
set yrange [0:1.05]
do for [c in CORPORA] {
  set output sprintf('eval/comparison_fallthrough_%s.png', c)
  set title  sprintf("Per-prompt fallthrough rate — %s", c)
  set xlabel "prompt index"
  set ylabel "rate"
  plot sprintf('eval/baseline_%s_per_prompt.dat', c) using 1:2 with linespoints pt 7  ps 0.6 lw 2 title 'baseline', \
       sprintf('eval/ppm_%s_per_prompt.dat', c)      using 1:2 with linespoints pt 5  ps 0.6 lw 2 title '+ppm', \
       sprintf('eval/bm25_%s_per_prompt.dat', c)     using 1:2 with linespoints pt 9  ps 0.6 lw 2 title '+bm25', \
       sprintf('eval/full_%s_per_prompt.dat', c)     using 1:2 with linespoints pt 11 ps 0.6 lw 2 title 'full'
}
