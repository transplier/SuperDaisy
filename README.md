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
test/daisy_test.rb  # minitest suite
DAISY.md            # technical write-up of the original
```
