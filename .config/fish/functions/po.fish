function po
  colorscript -r
  echo "Good Bye"
  for i in (seq 5 1)
    echo "Poweroff in $i"
    sleep 1
  end
  echo "Shutting down"
  poweroff 
end
