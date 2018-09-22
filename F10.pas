unit F10;
interface
        uses TampungSemuaVariabel, F3, F1, crt;
        

        procedure f10istirahat();
implementation
        procedure f10istirahat();
        begin
                if (statchef.jumlahistirahat < 6) then
                begin
                        statchef.jumlahistirahat := statchef.jumlahistirahat + 1;
                        if (ArraySimulasi[nosimulasi].jumlahenergi < 10) then
                        begin
                                ArraySimulasi[nosimulasi].jumlahenergi := ArraySimulasi[nosimulasi].jumlahenergi + 1;
                                writeln('-- Istirahat berhasil.')
                        end else
                        begin
                                writeln('-- Energi sudah penuh');
                        end;
                end else {jumlahistirahat = 6}
                begin
                        writeln('-- Jumlah maksimum istirahat sudah tercapai');
                end;
        end;
end.


