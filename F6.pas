unit F6;


interface
uses sysutils, crt, F1, F3, TampungSemuaVariabel;

var
	i, j, k, l, m, n, sum, jumlahbahanolahan : longint;
	makanan, start : string;
	cekbahanolah, cekbahanmentah, cekjumlah : boolean;



procedure OlahBahan();

implementation
procedure OlahBahan();
begin
		//Input nama makan yang diolah
	write('Makanan yang mau diolah : ');
	readln(makanan);
	write('Jumlah makanan yang mau diolah : ');
	readln(sum);
	i := 1;
	j := 1;
	k := 1;
	l := 1;
	cekjumlah := true;
	cekbahanmentah := true;
	jumlahbahanolahan := 0;
	cekbahanolah := false;
	
	repeat
	if (ArrayFileOlahan[i].namaolah = makanan) then //cek apakah input makanan olahan ada di file bahan olahan
		begin
			cekbahanolah := true;
		end else 
		begin
			i := i + 1;
		end;
	until ((i = NBahanOlahan + 1) or (cekbahanolah = true));

	if (cekbahanolah = true) then 
	begin
			repeat //untuk mengecek apakah semua bahan mentah tersedia untuk mengolah bahan tersebut (cek nama bahan mentahnya)
				if (ArrayFileOlahan[i].bahan_ke[k] = ArrayInventoriMentah[l].namamentah) and (ArrayInventoriMentah[l].jumlah > 0) then
				begin
					cekbahanmentah := true;
					k := k + 1;
					l := 1;
				end else
				begin
					l := l + 1;
				end;
				if (l = NInventoriBahanMentah + 1) then
				begin
					cekbahanmentah := false; 
				end;
			until ((cekbahanmentah = false) or ((k) > ArrayFileOlahan[i].jumlahbhn));


			if (cekbahanmentah = false) then
			begin
				cekjumlah := false;
				writeln('Bahan mentah yang diperlukan tidak ada.');
			end;
			if (cekbahanmentah = true) then//bahan mentah tersedia untuk mengolah bahan (belum dicek jumlahnya berapa)
			begin
				l := 1;
				k := 1;
				repeat //untuk mengecek apakah semua bahan mentah tersedia untuk mengolah bahan tersebut (cek jumlahnya)
					if (ArrayFileOlahan[i].bahan_ke[k] <> ArrayInventoriMentah[l].namamentah) then //nama bahan mentah dengan kebutuhan bahan olahan tidak sama
						begin
							l := l + 1;
						end;
					if (ArrayFileOlahan[i].bahan_ke[k] = ArrayInventoriMentah[l].namamentah) then
						begin
							if ((ArrayInventoriMentah[l].jumlah >= sum) and (cekjumlah = true)) then //bahan mentah yang dimaksud jumlahnya cukup
							begin
								k := k + 1;
								l := 1;
								cekjumlah := true;
							end else
							
							if ((ArrayInventoriMentah[l].jumlah < sum) or (l = NInventoriBahanMentah + 1)) then//jumlahnya kurang atau tidak ketemu
							begin
								cekjumlah := false;
							end;

						end;
				until ((cekjumlah = false) or ((k) > ArrayFileOlahan[i].jumlahbhn));

				if (cekjumlah = false) then //bahan mentah tidak cukup
				begin
					writeln('Bahan mentah yang diperlukan tidak cukup.');
				end else if (cekjumlah = true) then //bahan mentah cukup semua
				begin
				l := 1;
				k := 1;
				repeat //untuk mengecek apakah semua bahan mentah tersedia untuk mengolah bahan tersebut (cek jumlahnya)
					if (ArrayFileOlahan[i].bahan_ke[k] <> ArrayInventoriMentah[l].namamentah) then //nama bahan mentah dengan kebutuhan bahan olahan tidak sama
						begin
							l := l + 1;
						end;
					if (ArrayFileOlahan[i].bahan_ke[k] = ArrayInventoriMentah[l].namamentah) and (ArrayInventoriMentah[l].jumlah > 0) then
						begin
							if ((ArrayInventoriMentah[l].jumlah >= sum)) then //bahan mentah yang dimaksud jumlahnya cukup
							begin
								ArrayInventoriMentah[l].jumlah := ArrayInventoriMentah[l].jumlah - sum;
								k := k + 1;
								l := 1;
								cekjumlah := true;
							end;
						end else if (ArrayFileOlahan[i].bahan_ke[k] = ArrayInventoriMentah[l].namamentah) and (ArrayInventoriMentah[l].jumlah = 0) then
						begin
							l := l + 1;
						end;
				until ((k) > ArrayFileOlahan[i].jumlahbhn);
				end;
				end;
			
			if (cekjumlah = true) then
			begin
					for n := 1 to (NInventoriBahanOlahan + 1) do //untuk mengecek jumlah bahan olahan yang ada di inventori
					begin
						jumlahbahanolahan := jumlahbahanolahan + ArrayInventoriOlahan[n].jumlah; //total jumlah bahan olahan yang ada di inventori
					end;
			

					if (jumlahbahanolahan + sum <= ArraySimulasi[nosimulasi].kapasitasmaksinventori) then //kapasitas inventori cukup
					begin
						NInventoriBahanOlahan := NInventoriBahanOlahan + 1;
						ArrayInventoriOlahan[NInventoriBahanOlahan].namaolahan := makanan;
						ArrayInventoriOlahan[NInventoriBahanOlahan].hari := ArraySimulasi[nosimulasi].hari;
						ArrayInventoriOlahan[NInventoriBahanOlahan].bulan := ArraySimulasi[nosimulasi].bulan;
						ArrayInventoriOlahan[NInventoriBahanOlahan].tahun := ArraySimulasi[nosimulasi].tahun;
						ArrayInventoriOlahan[NInventoriBahanOlahan].jumlah := ArrayInventoriOlahan[m].jumlah + sum;
						ArraySimulasi[nosimulasi].jumlahenergi := ArraySimulasi[nosimulasi].jumlahenergi - 1;
						ArraySimulasi[nosimulasi].bahanolahanbuat := ArraySimulasi[nosimulasi].bahanolahanbuat + sum;
						writeln('Makanan olahan ', makanan, ' sebanyak ', sum, ' berhasil diolah.');
					end else if ((jumlahbahanolahan + sum <= ArraySimulasi[nosimulasi].kapasitasmaksinventori)) then //kapasitas inventori tidak cukup
					begin
						writeln('Inventori penuh. Tingkatkan kapsitas segera.');
					end;
			end;
	end else
	writeln('Makanan yang ingin Anda olah tidak ada.');
end;
end.