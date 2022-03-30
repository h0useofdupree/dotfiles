function cdq --wraps=cd --description 'Switches to the QTile-Config-Directory'
  cd ~/.config/qtile/
  lt -L 1
  lt modules/ -L 1
end
