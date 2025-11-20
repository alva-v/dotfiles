# Dotfiles
My Linux configurations files and a simple bootstrapping script.

This is a very incomplete work in progress.

The `non-automated` folder contains files that I still have to set up bootstrapping logic for.

## Usage
Clone this repo in `~/.dotfiles`, then run:
```
bash bootstrap.sh
```

## Notes on non-automated files
### Redirector.json
Config for the firefox extension

Might be possible to automatically deploy by standardizing my Firefox profile ID and inserting the data in the corresponding local storage sqlite table.