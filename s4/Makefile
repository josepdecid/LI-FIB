sudoku = sudoku
packing = packing

$(sudoku): $(sudoku).pl
	swipl -quiet -O -g main --stand_alone=true -o $(sudoku) -c $(sudoku).pl

$(packing): $(packing).pl
	swipl -quiet -O -g main --stand_alone=true -o $(packing) -c $(packing).pl


