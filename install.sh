#!/bin/bash
startTime=$(date +%s)

if [ -x "$(command -v brew)" ]; then
  brew install \
    lazygit \
    ripgrep \
    zellij \
    ranger \
    procs \
    dust \
    fzf
fi

if [ -x "$(command -v bash)" ]; then
  echo "Configuring bash..." &&
    {
      echo 'HISTTIMEFORMAT="|%Y-%m-%d %T| "'
      echo 'export FZF_DEFAULT_COMMAND="rg --files"'
      echo "export SHELL=$(which bash)"
    } >> ~/.bashrc &&
    echo "Done!"

  echo "Adding bash aliases..." &&
    {
      echo "alias ranger='. ranger'"
      echo "alias dust='dust -i'"
      echo "alias cloudcmd='npx -y cloudcmd'"
      echo "alias install-spacevim='curl -sLf https://spacevim.org/install.sh | bash'"
    } >> ~/.bash_aliases &&
    echo "Done!"

  echo "Installing Ble.sh (https://github.com/akinomyoga/ble.sh)..." &&
    curl -L https://github.com/akinomyoga/ble.sh/releases/download/nightly/ble-nightly.tar.xz | tar xJf - &&
    rm -rf blesh &&
    mv ble-nightly* blesh &&
    rm -rf ~/.local/share/blesh &&
    mkdir -p ~/.local/share &&
    mv blesh/ ~/.local/share &&
    echo 'source ~/.local/share/blesh/ble.sh' >> ~/.bashrc &&
    echo "Done!"

  # shellcheck source=/dev/null
  source ~/.bashrc

  # shellcheck source=/dev/null
  source ~/.bash_aliases
fi

endTime=$(date +%s)

echo "Install finished in $((endTime-startTime)) seconds."
