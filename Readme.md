# Dotfiles
My Linux configuration files and a simple bootstrapping script. Managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Repository layout

- **Stowable files** — everything not excluded by `.stow-local-ignore` is symlinked into `$HOME` by `bootstrap.sh`
- **`non-home/`** — files deployed outside `$HOME` or used by bootstrap without being stowed.
- **`non-automated/`** — configs not yet bootstrapped

## Prerequisites

- `pass` must be initialised and contain:
  - `Dotfiles/email`
  - `Dotfiles/MAC/headset`
  - `Dotfiles/MAC/speaker`
- If your Firefox profile has already been personalised, run the [Arkenfox cleanup script](https://github.com/arkenfox/user.js/blob/master/scratchpad-scripts/arkenfox-cleanup.js) first
- Close Firefox before running bootstrap.sh

## Usage

Clone this repo in `~/.dotfiles`, then run:
```bash
bash bootstrap.sh
```



To update the VSCodium extension list from your currently installed extensions:
```bash
bash update.sh
```


## Notes on non-automated files
### Redirector.json
Might be possible to automatically deploy by inserting the data in the corresponding local storage sqlite table.