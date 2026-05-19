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

## Layout

```
lib/daisy.rb        # Corpus + Bot
bin/daisy           # CLI entry point
bin/fortune-train   # generate a .DSY from Haiku-written fortunes
test/daisy_test.rb  # minitest suite
DAISY.md            # technical write-up of the original
```
