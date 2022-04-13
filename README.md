# XKB Layout Group Manager

# Intro
Often we have such problem if we are using more than two keyboard layouts, you need to switch over and over to reach the desirable one.

Some of this layouts we are using more often than others. So it's good to have groups of layouts to switch between them quikly.

Oh and recently I've discovered that there is 4 layouts limit so this script is easy way to use it as workaround.

For example in my case I wanna have:

  US, UA and sometimes switch to PL or CZ. So I can switch layout inside group by CTRL+SHIFT and select group by binded key in my window manager.

So this script perfoms looping over array elemnts and pass `setxkbmap` parameters to set desirable settings.
  
# Configuration
On the top of script you will find declaration that you need to modify for your purposes:

```bash
kbmodel="pc105"

declare -a kblayoutsarr=( 'us,ua' 'pl,cz' 'de,us' )
declare -a kbvariantsarr=( ',winkeys' ',' ',' )
declare -a kboptionsarr=( 'grp:ctrl_shift_toggle,eurosign:e,lv3:ralt_switch' 'grp:ctrl_shift_toggle' 'grp:ctrl_shift_toggle' )
declare -a vislayoutsarr=( 'US UA' 'PL CZ' 'DE US' )

```

1. Models (kbmodel) you can get by command:

`$ localectl list-x11-keymap-models`

You can replace with selected but usually pc105 suits to most of keyboards. 


Next XKB arrays to set groups in example you can see 3 group if you want to 2 groups just delete every third element (if you want more just add new elements to each array)

2. Layouts (kblayoutsarr) you can get list by:

`$ localectl list-x11-keymap-layouts`

Set few of them and separate by comma.

3. Variants (kbvariantsarr). Usually you don't need to use it but anyway kepp in mind that amount of commas should be the same as amount of commas in layouts. You can get list of available options by:

`$ localectl list-x11-keymap-variants us`

4. Options (kboptionsarr) different stuff here modifiers for example the you favorite to switch layouts or euro sign position. You can get list of options by:

`$ localectl list-x11-keymap-options`

5. Visualization (vislayoutsarr) the name which will be appeared in notification of your desktop during changing group (Keyboard Group 1: US UA).

When you've done with setting your values. You need to make script executable to do that run:

`$ chmod 777 layoutgroupmgr.sh`

After that you can test script:

`$ ./layoutgroupmgr.sh`

If it works fine you can bind it to some shortcut.

For example Mate Desktop go to System->Control Center->Keyboard Shortcuts. Press Add and set any name and path to this script

It is allowed backward change (just pass some parameter actually it can be any):

`$ ./layoutgroupmgr.sh b`

If your desktop doesn't allow pass argument from keyboard shortcut you can use layoutback.sh and bind it to some shortcut to.

You can add script to autostart. In this case first array parameters will be activated at boot.

Note: 

In Mate to see tray indicator you need to add more than one layout in keyboard settings manually (annoying thing) but anyway switching will work fine.

In KDE you need to mark checkbox to show indicator even if only one layout added.
