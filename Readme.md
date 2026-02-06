# Dotfiles
My Linux configurations files and a simple bootstrapping script.

The `non-automated` folder contains files that I still have to set up bootstrapping logic for.

The `non-home` folder contains files that are above the home folder in the folder hierarchy and config files that are to be used by the bootstrapping script without being stowed.

# Before
* `pass` should be initialized and contain the following secrets:
    * `Dotfiles/email`
    * `Dotfiles/MAC/headset`
    * `Dotfiles/MAC/speaker`

* If your Firefox profile has already been personnalized, you should run the [Arkenfox cleanup script](https://github.com/arkenfox/user.js/blob/master/scratchpad-scripts/arkenfox-cleanup.js).

## Usage
Clone this repo in `~/.dotfiles`, then run:
```
bash bootstrap.sh
```
You can update the VS Codium extension list by using the following:
```
bash update.sh
```

## Notes on non-automated files
### Redirector.json
Config for the [Firefox extension](https://addons.mozilla.org/en-US/firefox/addon/redirector/).

Might be possible to automatically deploy by inserting the data in the corresponding local storage sqlite table.