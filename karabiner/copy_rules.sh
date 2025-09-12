: <<'END'
This bash script copies a configuration file for Karabiner elements that prevents registration of duplicate keypresses on my keyboard. It is caused by the faulty keyboard on macbookpro 2016. The problems currently affects my s key.

Manual actions are required to enable:
(1) Open karabiner elements settings
(2) Go to 'complex modifications'
(3) Click 'add predefined rule'
(4) Select enable on rule 'keep s from being presseed twice'
END

mkdir -p $HOME/.config/karabiner/assets/complex_modifications && cp $HOME/.dotfiles/karabiner/*.json $HOME/.config/karabiner/assets/complex_modifications/


