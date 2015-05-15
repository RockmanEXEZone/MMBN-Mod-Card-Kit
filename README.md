Mega Man Battle Network: Mod Card Kit v1.0
==========================================

The Japanese versions of Rockman EXE 4 through 6 supported the Nintendo e-Reader
in the form of "Kaizou Cards". Most of them were sold in booster packs or given
away at events. You could scan these cards with the e-Reader and then transmit
them to the game via Link Cable in order to receive rare items or boost
MegaMan's power.

Like most other bonus features of the series, these cards were never distributed
outside of Japan and did not work on the English versions of the games. In
addition, over time, some of the cards have become quite rare and hard to find.
Most of the cards have been ripped, but naturally, they are illegal to
distribute. And some cards were never ripped, leaving their contents
unobtainable.

This Mod Card Kit features custom cards that have been written from scratch and
implement the Rockman EXE e-Card transmission protocol. They can be used to send
over recreations of the original Kaizou Card data to Rockman EXE 4, Rockman EXE
5 and Rockman EXE 6. In addition, *for the first time ever, you can also send
Mod Cards to the English versions of Mega Man Battle Network 4 and Mega Man
Battle Network 5!*

To reiterate: the cards in this kit work on the English e-Reader. They do NOT
work on the Japanese Card e-Reader or Card e-Reader+. However, they CAN transfer
data to the Japanese versions of Rockman EXE 4 through 6.

Discuss this project at The Rockman EXE Zone:
http://forums.therockmanexezone.com/topic/8937347/1/

The GitHub repository of this project can be found at:
http://github.com/Prof9/mmbn-mod-card-kit/


Supported versions
------------------
The cards in this Mod Card Kit support the following versions:

| Game                      | Japanese | North American | European |
|:------------------------- |:--------:|:--------------:|:--------:|
| Mega Man Battle Network 4 |  **Yes** |    **Yes**     |  **Yes** |
| Mega Man Battle Network 5 |  **Yes** |    **Yes**     |  **Yes** |
| Mega Man Battle Network 6 |  **Yes** |       No       |     No   |


Features
--------
Of course, just implementing the transmission protocol wouldn't be any fun, so
the e-Cards in this kit have some features and differences that set them apart
from the original files.

 *  All card interface text has been fully translated into English.
 *  Multi-region support: each card works on both the English and Japanese
    versions of the game.
 *  Cards can be saved to the e-Reader's memory so you can scan them in an
    emulator, transfer your save back to your e-Reader and use the cards on your
    physical games.
 *  And of course, the cards are open source, so you can tinker with all the
    text and graphics if you want to.

This Mod Card Kit contains two types of Mod Cards: *Saveable* and
*Non-Saveable*. The difference between the two is just that: the *Saveable* Mod
Cards can be saved to the e-Reader's memory. The *Non-Saveable* cards cannot,
and act just like the official Kaizou Cards produced by Capcom. These are more
suited to being printed out on actual cards.

If you use the *Saveable* Mod Cards, note that some of them have the same name.
In order to overwrite a Mod Card with the same name, you need to delete it from
the e-Reader memory first. To do this, hold L+R when you boot up the e-Reader.


How to use
----------
In this Mod Card Kit, you will find many files ending with in `.raw`. These are
raw e-Card dump files, and you can scan these in emulators. Below you will find
instructions on scanning cards and sending them to your game using No$gba.

**Before you begin:**
1.  Gather a Nintendo DS or Nintendo DS Lite, a North American e-Reader and a
    SLOT-1 flash card that is capable of running homebrew.
2.  Download the GBA Backup Tool v0.21 homebrew and extract it to the microSD
    card of your flash card.
3.  Start up your Nintendo DS and run GBA Backup Tool.
4.  Insert the e-Reader into SLOT-2, and press the A button.
5.  The e-Reader should be detected with the game title `CARDE_READER PSAE 00`.
6.  Press R twice to switch to ROM Backup mode.
7.  Press B, then A to dump the e-Reader ROM to the flash card's microSD card.
8.  Repeat steps 4 - 7 for any Mega Man Battle Network games that you want to
    transfer e-Cards to.

**Transferring e-Cards to your game:**
1.  Download and run the No$gba emulator (gaming version).
2.  Go to `Options`, then `Emulation Setup`, and set the `Number of Emulated
    Gameboys` to `2`.
3.  Make sure `Link Cable Type` is set to `Automatic`, then click `OK`.
4.  Go to `File`, then `Cartridge menu (FileName)`.
5.  Make sure that `Autostart Cartridge` is checked, and set the dropdown menu
    beside it to `All machines`.
6.  Navigate to your Mega Man Battle Network ROM and open it.
7.  Go to `File`, then `Cartridge menu (FileName)`.
8.  Set the dropdown beside `Autostart Cartridge` to `2nd machine`.
9.  Navigate to the e-Reader ROM and open it.
10. Go to `File`, then `Load e-Reader Dotcode`.
11. Navigate to the e-Card that you want to scan and open it.
12. In the e-Reader menu, choose `Scan Card`. The e-Card will be scanned and
    loaded.
13. In Mega Man Battle Network, go to the MegaMan Screen. You should receive
    a message that a card has been received. Accept the transmission to receive
    the card data.

Note: this is not the only way to do it; there also exist versions of VisualBoy
Advance that allow you to scan e-Cards. This may be more convenient if you are
planning to transfer your Mod Cards to a pre-existing save file, as No$gba uses
an encrypted save file format by default.


English e-Card support for Rockman EXE 6
----------------------------------------
Unfortunately, all e-Reader related code was removed from the English versions
of Mega Man Battle Network 6. Nonetheless, the Rockman EXE 6 cards in this kit
can transmit the English versions to English versions of Mega Man Battle Network
6; they will just not be detected by the game.

If you are a modder, you can instruct the Rockman EXE 6 e-Cards to show English
text in your mod of the Japanese version of Rockman EXE 6. You can do this by
writing the bytes `45 43 41 52 44 5F 45 4E` to offset `7FF4FC` in the game ROM.
This works for both Cyber Beast Glaga and Cyber Beast Falzer versions, but ONLY
works for Rockman EXE 6.

If you do this, then keep the following in mind:

1.  The English text in the e-Card is encoded with the character table from the
    English version of Mega Man Battle Network 6, so make sure that your font is
    compatible with this character table.
2.  For the BattleChip transmission cards, the chip text is sent in Japanese, so
    make sure that you read this text from the ROM in your mod, instead of
    reading it from RAM as normal.


Building from source
--------------------
Before you can build e-Cards, you need to gather some tools and put them in the
`tools` folder. You need the following files:

 -  [armips.exe](https://github.com/Kingcom/armips)
 -  [nedclib.dll](https://www.caitsith2.com/ereader/devtools.htm)
 -  [nedcenc.exe](https://www.caitsith2.com/ereader/devtools.htm)
 -  [nedcmake.exe](https://www.caitsith2.com/ereader/devtools.htm)
 -  [nevpk.exe](https://www.caitsith2.com/ereader/devtools.htm)
 -  [grit\grit.exe](http://www.coranac.com/projects/grit/)

Note that `grit.exe` must be in its own folder named `grit` inside the `tools`
folder. Furthermore, the latest development version of ARMIPS is required, so
you will need to build it from the source.

In order to build an e-Card, run `compile.bat` from the command line, and pass
the path to an e-Card configuration file as the first argument. For instance:
```
compile.bat "cards\bn4\ChipTransmission\134-C001 PrixPowr.asm"
```
This will produce `card.01.bin` and `card.01.raw` in the `out` folder, as well
as `card.02.bin` and `card.02.raw` for data that could not fit onto one card.
There is no configuration file for the compile script; if you want to tweak some
build settings, modify the `compile.bat` file directly.

Additionally, you can also run `compile_all.bat`. This script will compile all
e-Card configuration files in the `cards` folder and write the resulting `.raw`
files to the `outall` folder. If one of the cards fails to build, the script
will halt and display an error, and wait for any key to be pressed before it
will exit. If this happens, you can check `log.txt` to see the build log of the
card that failed to build.


Credits
-------
 -  **caitsith2**, for the superb Nintendo e-Reader Dev Tools.
 -  **Capcom Product Dev 2**, for the amazing Mega Man Battle Network series.
 -  **exeguy11**, for the Rockman EXE 6 translation patch.
 -  **Greiga Master**, for his work on ARMIPS that made this project far easier.
 -  **Kingcom**, for the brilliant ARMIPS assembler.
 -  **Martin Korth**, for the indispensible No$gba debugger.
 -  **MidniteW**, for help with translation/editing and beta testing.
 -  **Nigoli**, the prime Rockman EXE e-Reader guru.
 -  **Nikslg**, for help with beta testing.
 -  **No-Intro**, for the e-Reader Encyclopedia.
 -  **Prof. 9**, for this Mod Card Kit.
 -  **Qwiscot**, for the extremely useful Rockman EXE card-e+ Cards guide.
 -  **Tim Schuerewegen**, for his awesome e-Reader API documentation.

Rockman, Rockman EXE, Mega Man and Mega Man Battle Network are © Capcom 1987 -
2015. All rights belong to their respective owners.


Contact:
--------
 -  Twitter: [Prof9](https://twitter.com/Prof9)
 -  E-mail: [Click to view](http://www.google.com/recaptcha/mailhide/d?k=011xR9XmnxDcnRMYcXf2AaZQ==&c=u6AlsN_NzKjGfslPbFke1Him20QejquezvWB_JXXfZY=)
 -  Forums: [The Rockman EXE Zone](http://forums.therockmanexezone.com/msg/?c=2&mid=4001168)


Changelog:
----------
**v1.0** - 15 May 2015
 -  Initial release.


License
-------
This Mod Card Kit is "licensed" under the terms of the *Unlicense*. See
`LICENSE.md` for more information.

This license does NOT apply to files in the `include` folder, which were
"borrowed" from the official Kaizou Cards produced by Capcom and contain data
necessary for the transmission program to function correctly, such as graphics.

No e-Readers were harmed in the making of this Mod Card Kit.