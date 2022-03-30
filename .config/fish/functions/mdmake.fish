function mdmake --description 'Makefunction for compiling md files to pdf. (mdmake <name for pdf> <md file>'
	if [ -n "$argv" ]
		pandoc -so $argv[1] $argv[2]
	else
		set -l dir (pwd)
		echo "Make every pdf file in current dir in $dir?"
		read sel
		if test $sel = "y"
			set -l filename (ls | grep *.md | awk {'print $8'} | cut -f1  -d ".")
			echo $filename
			pandoc -so $filename.pdf $filename.md
		else 
			echo "Okay."
		end
	end
end
