function ltx --description 'Creates a directory for a LaTeX-Defaults-File'
  mkdir $argv
  cd $argv
  cp ~/Documents/LaTeX/default.tex ./$argv.tex
  cp ~/Documents/LaTeX/latex-listings-powershell.tex .
  echo "Created directory $argv"
  echo "Created copied default LaTeX and listings syntax file to $argv"
end
