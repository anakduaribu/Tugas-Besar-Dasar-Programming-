unit F3;

interface
	uses sysutils, F1, TampungSemuaVariabel;

	procedure StartSimulasi();

	var 
	inputstart : string;
	nosimulasi : integer;

implementation
procedure StartSimulasi();
begin
	write('> ');
	readln(inputstart);
	pospis := pos(' ', inputstart);
	nosimulasi := StrToInt(copy(inputstart, (pospis + 1), length(inputstart)));
	statchef.jumlahmakan := 0;
	statchef.jumlahistirahat := 0;
	statchef.jumlahtidur := 0;
	writeln('-- Simulasi ', nosimulasi, ' dimulai.');
end;
end.