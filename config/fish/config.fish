function fish_greeting
end

function vi
  nvim $argv
end

function kc
  if status --is-interactive
    keychain --eval --quiet -Q $argv;
    source ~/.keychain/(hostname)-fish
  end
end
