function install-fisher-plugins --description='Force installs fisher plugins i use'
    if type -q fisher
        fisher install blackjid/plugin-kubectl
        fisher install jethrokuan/z
        fisher install jorgebucaran/autopair.fish
        fisher install jorgebucaran/fisher
        fisher install jorgebucaran/getopts.fish
        fisher install jorgebucaran/hydro
        fisher install jorgebucaran/replay.fish
        fisher install lewisacidic/fish-git-abbr
        # fisher install meaningful-ooo/sponge
        fisher install nickeb96/puffer-fish
        fisher install patrickf1/fzf.fish
    else
        echo "No fisher installed, install first!"
    end
end
