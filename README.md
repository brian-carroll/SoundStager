# SoundStager

Sound effects manager for amateur theatre productions.

(The software my theatre group is currently using is horrible so I made my own.)


## Goals
- Select a set of sound files to be played in a sequence
- Auto-save the sequence for the next time the app loads (no user action)
- Start each sound on user keypress (spacebar or something obvious)
- Auto-select next sound when current sound finished
- Easily insert new sound files anywhere in the list
- Easily reorder exising sounds
- Easily add the same sound to multiple places in the list (duplicate & drag?)
- If you need to, jump to a different sound and then resume the sequence
- Easily add all files in a given folder

## Implementation
- Desktop application build with Electron and Elm.
- Files are loaded from anywhere on the host machine
    - Application doesn't move or copy them, just remembers the paths
    - If you move files while it's trying to play them, expect errors! (Could make something go red when this happens I guess)
- HTML5 audio
