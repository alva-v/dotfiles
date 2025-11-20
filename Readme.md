# Dotfiles
My Linux configurations files and a simple bootstrapping script.

The `non-automated` folder contains files that I still have to set up bootstrapping logic for.

The `non-home` folder contains files that are above the home folder in the folder hierarchy and config files that are to be used by the bootstrapping script without being stowed.

## Usage
`pass` should be initialized and contain the following secrets:
* `Dotfiles/email`
* `Dotfiles/MAC/headset`
* `Dotfiles/MAC/speaker`

Clone this repo in `~/.dotfiles`, then run:
```
bash bootstrap.sh
```
You can update non symlinked files by using the following:
```
bash update.sh
```

## Notes on non-automated files
### Redirector.json
Config for the firefox extension.

Might be possible to automatically deploy by standardizing my Firefox profile ID and inserting the data in the corresponding local storage sqlite table.