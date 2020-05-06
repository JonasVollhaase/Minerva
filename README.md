# Minerva

Minerva is an open source [Autohotkey](https://www.autohotkey.com/) replacement for [Georgias Emailtemplates](https://chrome.google.com/webstore/detail/gorgias-templates-email-t/lmcngpkjkplipamgflhioabnhnopeabf?hl=en)

Minerva uses a hotkey combination to bring up a menu, from where users can quickly insert prewritten text from .rtf documents. The contextmenu will be autopopulated with text and folders from the folder that Minerva lives in.

## Installation

If you've already installed AutoHotKey, just open Minerva.ahk with AutoHotkey.

### Executable
You can also use Minerva.exe, which can work standalone w/o AutoHotKey.

## Usage
By default, `Crtl+space` brings up the Minerva menu. From here, navigate to the desired folder, and choose the text you wish to insert.
Use the numbers in front of an entry as hotkeys to open and/or insert that selection.

### Example
A folder structure like this ... 

    ├── Minerva.exe
    ├── Minerva.ahk
    ├── Hotstrings.txt
    ├──
    ├── Goodbye Messages
    │   ├── SeeYa.rtf
    │   ├── SeeYa.txt
    │   ├── Later.rtf
    ├── Some Other Messages
    │   ├── FillerText.rtf
    ├── Welcome Messages
    │   ├── Hello.rtf
    │   ├── Goodmorning.rtf

... will result in a popup like this

![MinervaFolders](https://user-images.githubusercontent.com/22538066/80595865-b7c84580-8a25-11ea-921e-8b6b6848039e.PNG)

## User programmable hotstrings
Some text is shorter in nature, and does not require an entire popupmenu to execute. For this, put a document called "Hotstrings.txt" next to Minerva and make your own. Hotstrings are either inserted right as you press the key-combination, or when you press the keycombination followed by either `space`, `tab` or `enter`.

In this project, I have supplied an example that'll get you going.

## Additional hotstrings
* Type `,sd` to insert short-date. It will look like "060520" 
* Type `,dt` to insert date-time. It will look like "06-05-2020 05:44"
* Type `,t` to insert time. It will look like "05:44"
* Type `,d` to insert date. It will look like "06-05-2020"

## TODO
* Make Minerva accept .txt, .docx and other .ahk in addition to the .rtf files
* Make Minerva look recursively to enable nested folders
* Performance optimize
* Make .ini file 