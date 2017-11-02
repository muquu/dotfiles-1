# fish_greeting はしない
function fish_greeting
end

# alias nvim
function vi
  nvim $argv
end

# alias keychain
function kc
  if status --is-interactive
    keychain --eval --quiet -Q $argv;
    source ~/.keychain/(hostname)-fish
  end
end

# alias npm list global packages
function ngl
  npm list -g --depth=0 2>/dev/null
end

# alias npm list local packages
function nll
  npm list --depth=0 2>/dev/null
end

# local setting
source $HOME/.local.fish
