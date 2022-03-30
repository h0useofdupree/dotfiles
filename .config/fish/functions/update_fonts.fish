function update_fonts
  set -l fonts (exa ~/Downloads/Fonts/ttf/*.ttf)
  mv ~/Downloads/Fonts/ttf/*.ttf ~/.local/share/fonts/
  fc-cache &
  printf "\n\n\nAdded following fonts:\n\n\n"
  echo $fonts
  echo "Cached new fonts. Done."
end
