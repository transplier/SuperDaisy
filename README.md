# DAISY (Ruby port)

A modern Ruby port of Greg Leedberg's DAISY v1.1 (2000), a learning chatbot that
generates responses by sampling a Markov walk over a flat token-list corpus.
See `DAISY.md` for a full algorithmic write-up of the original.

Self-contained: Ruby stdlib only, no gems.

## Install

Nothing to install. You need Ruby (>= 2.7 should be fine):

```
chmod +x bin/daisy
```

## One-shot mode

Respond to a single prompt and exit:

```
./bin/daisy --personality MEM.DSY -p "hello daisy"
```

Optionally learn from the prompt (and persist the new tokens to the
personality file on exit):

```
./bin/daisy --personality MEM.DSY -p "the quick brown fox" --learn
```

## Interactive mode

Drop the `-p` flag for a REPL. Type `exit`, `quit`, or send EOF (Ctrl-D) to
leave. With `--learn`, every line you type is appended to the corpus and the
file is rewritten on exit.

```
./bin/daisy --personality MEM.DSY
./bin/daisy --personality MEM.DSY --learn
```

## Personality files

DAISY uses the original `.DSY` plaintext format:

```
<bot name>
<1 or 0 — learn-mode flag>
<token>
<token>
...
***
<token>
...
***
```

`***` separates sentences. The shipped `MEM.DSY` from the 2000 distribution
(under `daisy11 original freepascal/`) works as-is. To start fresh, create a
file with just the two header lines.

## Generating a personality with `fortune-train`

`bin/fortune-train` builds a fresh `.DSY` by asking Claude Haiku for fortunes
seeded on random dictionary words. Requires `ANTHROPIC_API_KEY`; stdlib only.

```
export ANTHROPIC_API_KEY=sk-ant-...
./bin/fortune-train --out fortune.DSY                 # 250 fortunes, /usr/share/dict/words
./bin/fortune-train --count 50 --out tiny.DSY         # smaller run
./bin/fortune-train --dict /usr/share/dict/american-english --out fortune.DSY
./bin/daisy --personality fortune.DSY                 # chat with the result
```

Flags: `--dict FILE` (default `/usr/share/dict/words`), `--out FILE` (default
`fortune.DSY`), `--count N` (default 250), `--model NAME` (default
`claude-haiku-4-5-20251001`), `--bot-name NAME` (default `Daisy`). Progress
prints on stderr; Ctrl-C saves whatever has been collected so far.

## Tests

```
ruby -Ilib test/daisy_test.rb
```

## Demo

`./demo.sh` copies the original `MEM.DSY` to a temp file, launches DAISY against
it in interactive mode with `--learn`, and cleans up on exit — so you can chat
without dirtying the shipped corpus.

## Evaluation

`bin/eval` runs a fixed prompt set against a corpus and reports fallthrough
rate, ugliness rate, distinct-N, bigram KL vs. corpus, latency percentiles,
plus a JSON data dump for future drift comparisons. Charts via gnuplot.

```
bin/eval --personality MEM.DSY --report eval/run.md --data eval/run.json
gnuplot eval/baseline.gp
```

See [`eval/baseline.md`](eval/baseline.md) for the classic SuperDaisy
reference numbers and the stop conditions for evaluating future swaps.

## Layout

```
lib/daisy.rb              # original-faithful port: Corpus + Bot
lib/super_daisy.rb        # orchestrator over swappable components
lib/super_daisy/components/  # one file per pipeline stage
bin/daisy                 # CLI (--model daisy | super_daisy)
bin/eval                  # eval harness
bin/fortune-train         # generate a .DSY from Haiku-written fortunes
test/daisy_test.rb        # minitest, original Daisy
test/super_daisy_test.rb  # minitest, SuperDaisy + components
benchmark/respond.rb      # timing harness
eval/                     # prompt set, baseline numbers, charts
DAISY.md                  # technical write-up of the original
SUPER_DAISY.md            # design doc for the modern-LM exploration
```

## Changes relative to the original

Algorithmic behavior matches the original DAISY where it counts; the deltas
below are either modernizations of the runtime or deliberate simplifications.
See `DAISY.md` for the original's design.

**Kept the same:**
- `.DSY` file format (header + one token per line, `***` sentence separators)
- 1st-order Markov walk with stride-3 emission (`Response` → `generate_sentence`)
- Rarest-input-word keyword extraction as IDF surrogate (`Percent` → `keywords`)
- Generate / filter-by-keyword / rerank-by-overlap pipeline (`BestResponse`)
- Learned terminator bigrams as stop condition (`term.bfb` → `terminator_bigrams`)
- "Ugly" sentence flag for local cycles and overlong outputs (the original's
  `#14` sentinel char becomes a plain boolean)
- Cross-turn keyword carryover (`LastSubs` → `@last_keywords`)
- Append-only online learning (`Learn`)

**Changed / dropped:**
- **No DOS TUI.** The Pascal popup-window UI, F-key menus, colors, and the
  per-character typing animation (`Writer`) are gone in favor of a plain
  `stdin`/`stdout` CLI plus a REPL.
- **No UDLP2 link mode or plug-ins.** `LinkMode`, `Expansion`, `PlugIn`,
  `WRITER.EXE`, and `LINK.EXE` have no Ruby equivalent.
- **No spell-correction UI.** The interactive corpus-rewrite tool
  (`CorrectSpell`) is omitted; edit the `.DSY` file directly if you need to.
- **No name-reflection trick.** The `#3`-sentinel substitution in `parse`/`Okay`
  that swaps the user's name and the bot's name on echo is dropped — the CLI
  doesn't have a user-name concept.
- **No on-disk scratch files.** `buffer.bfb` (pre-warmed candidate pool) and
  `term.bfb` (terminator n-grams) are in-memory and rebuilt as needed.
- **No buffer pre-warm.** The original generated 50 sentences at startup to
  hide Markov-scan latency on 2000-era hardware; modern CPUs don't need it.
- **Both an iteration cap and a wall-clock cap.** The original used only a
  wall-clock timeout (3 s default, "max thinking time"). The port keeps a
  wall-clock cap (default 0.5 s; `--timeout` on the CLI, `0` to disable) but
  also adds a `max_candidates` cap (default 1000) — the rejection loop exits
  on whichever fires first. Same "give up gracefully" semantics, just snappier
  on modern hardware and deterministic when the wall-clock is disabled.
- **Cached, character-preserving speedups.** Same outputs as the original
  algorithm, but the inner loops avoid repeated O(N) scans:
  - `token_frequency` is backed by a `Hash<cleaned_lowercase_word, count>`
    built once and invalidated on `learn()`.
  - The Markov inner loop uses an inverted index `Hash<token, [positions]>`
    instead of scanning the token list for every step.
  - `sentences` and `terminator_bigrams` are cached on the corpus,
    invalidated on `learn()`.
  - Keyword cleaning is hoisted out of the candidate-rerank loop.
  Combined effect: `respond()` median goes from ~3 s to ~30 ms on a
  12K-token corpus (see `benchmark/respond.rb`).
- **Seedable RNG.** `--seed N` flag on the CLI and `rng:` keyword on
  `Daisy::Bot.new` for deterministic output (helpful for tests and
  benchmarks). The original used Pascal's global `random()`.
