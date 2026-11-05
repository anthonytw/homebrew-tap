# anthonytw/homebrew-tap

[Homebrew](https://brew.sh) formulae for Anthony Wertz's open-source projects.

```bash
brew install anthonytw/tap/<formula>
```

or `brew tap anthonytw/tap` once, then `brew install <formula>`.

## Formulae

| Formula | Project | What it installs |
| --- | --- | --- |
| `sempere` | [anthonytw/sempere](https://github.com/anthonytw/sempere) | the `sempere` command-line tool for Sempere vaults (macOS, Linux) |

## How a formula is maintained

Each formula is `Formula/<name>.rb` and is written by its project's release tooling, not edited by hand:
the project keeps the template, and a release fills in the version and checksums from the GitHub
Release's `SHA256SUMS`. For example, Sempere: `just formula X.Y.Z ~/dev/homebrew-tap` in the sempere
repo (`packaging/homebrew/` there).

To add a project:

1. Keep its formula template in the project (it knows its own assets and build).
2. Have its release tooling write `Formula/<name>.rb` here.
3. Add a row to the table above.

Before pushing a formula change:

```bash
brew audit --strict --online --formula Formula/<name>.rb   # add --new for a new formula
brew install --formula ./Formula/<name>.rb && brew test <name>
```

CI (`.github/workflows/tests.yml`) runs `brew style` on the whole tap, and audits, installs and tests every
changed formula on macOS and Linux (x86_64 and arm64). Run it for every formula with
**Actions ▸ tests ▸ Run workflow**.

## Reporting a problem

A problem with a formula itself (install fails, wrong checksum): an issue here. A problem with the program:
the project's own repository.
