unit F1;


interface
	uses sysutils, TampungSemuaVariabel;


	//interface unit
	procedure load();
	procedure LoadFileMentah();
	procedure LoadFileOlahan();
	procedure InventoriBahanMentah();
	procedure InventoriBahanOlahan();
	procedure BacaResep();
	procedure BacaFileSimulasi();


implementation
	procedure load();
		begin
			LoadFileMentah();
			LoadFileOlahan();
			InventoriBahanMentah();
			InventoriBahanOlahan();
			BacaResep();
			BacaFileSimulasi();

			writeln('---------------------------- Loading file sukses. ---------------------------------');
			writeln();
			writeln('-- Ketik "lihatfitur" untuk melihat seluruh fitur');
			writeln('-- Ketik "startsimulasi" untuk memulai simulasi');
			writeln('-- Ketik "exit" untuk keluar dari program simulasi');
		end;

	procedure LoadFileMentah();
	begin
		assign(filebahanmentah, 'bahanmentah.txt');
		reset(filebahanmentah);

		i := 1;
		while (not(eof(filebahanmentah))) do
			begin
				readln(filebahanmentah, BacaFileMentah[i]);
				i := i + 1;
			end;
		close(filebahanmentah);
		N := i - 1; 
		NBahanMentah := N;
	
		if (N = 0) then
		begin
			writeln('-- Bahan mentah Anda kosong. Beli dahulu.');
		end else
		begin
			for j := 1 to N do
			begin
				pospis := pos('|', BacaFileMentah[j]); //Cari posisi guard pertama di mana
				ArrayFileMentah[j].namamentah := copy(BacaFileMentah[j], 1, (pospis - 2)); //Input nama mentah ke array
				BacaFileMentah[j] := copy(BacaFileMentah[j], (pospis + 2), length(BacaFileMentah[j])); //Inisialisasi posisi guard baru

				pospis := pos('|', BacaFileMentah[j]); //Cari posisi kedua di mana
				ArrayFileMentah[j].hargabeli := StrToInt(copy(BacaFileMentah[j], 1, (pospis - 2))); //Input harga beli ke array
				BacaFileMentah[j] := copy(BacaFileMentah[j], (pospis + 2), length(BacaFileMentah[j])); //Inisialiasi posisi guard baru
			
				ArrayFileMentah[j].expire := StrToInt(BacaFileMentah[j]); //Input kedaluarsa ke array
			end;
		end;
	end;


	procedure LoadFileOlahan();
	begin
		assign(filebahanolahan, 'bahanolahan.txt');
		reset(filebahanolahan);

		i := 1;
		while (not(eof(filebahanolahan))) do
		begin
			readln(filebahanolahan, BacaFileOlahan[i]);
			i := i + 1;
		end;
		close(filebahanolahan);
		N := i - 1;
		NBahanOlahan := N;
	
		if (N = 0) then
		begin
			writeln('-- Bahan olahan Anda kosong. Olahlah dahulu.');
		end else
		begin
			for j := 1 to N do
			begin
				pospis := pos('|', BacaFileOlahan[j]); //Cari posisi guard pertama di mana
				ArrayFileOlahan[j].namaolah := copy(BacaFileOlahan[j], 1, (pospis - 2)); //Input nama olahan ke array
				BacaFileOlahan[j] := copy(BacaFileOlahan[j], (pospis + 2), length(BacaFileOlahan[j])); //Inisialisasi posisi guard baru

				pospis := pos('|', BacaFileOlahan[j]); //Cari posisi kedua di mana
				ArrayFileOlahan[j].hargajual := StrToInt(copy(BacaFileOlahan[j], 1, (pospis - 2))); //Input harga jual ke array
				BacaFileOlahan[j] := copy(BacaFileOlahan[j], (pospis + 2), length(BacaFileOlahan[j])); //Inisialiasi posisi guard baru

				pospis := pos('|', BacaFileOlahan[j]); //Cari posisi guard ketiga di mana
				ArrayFileOlahan[j].jumlahbhn := StrToInt(copy(BacaFileOlahan[j], 1, (pospis - 2))); //Input jumlah bahan olahan ke array
				BacaFileOlahan[j] := copy(BacaFileOlahan[j], (pospis + 2), length(BacaFileOlahan[j])); //Inisialiasi posisi guard baru

				k := 1;
				while (ArrayFileOlahan[j].jumlahbhn > k) do
				begin
					pospis := pos('|', BacaFileOlahan[j]);
					ArrayFileOlahan[j].bahan_ke[k] := copy(BacaFileOlahan[j], 1, (pospis - 2)); //Input bahan mentah ke- ke array
					BacaFileOlahan[j] := copy(BacaFileOlahan[j], (pospis + 2), length(BacaFileOlahan[j])); //Inisialisasi posisi guard baru
					k := k + 1;
				end;
				ArrayFileOlahan[j].bahan_ke[k] := BacaFileOlahan[j];
			end;
		end;
	end;

	procedure InventoriBahanMentah();
	begin
		assign(inventorimentah, 'inventoribahanmentah.txt');
		reset(inventorimentah);

		i := 1;
		while (not(eof(inventorimentah))) do
		begin
			readln(inventorimentah, BacaInventoriMentah[i]);
			i := i + 1;
		end;
		close(inventorimentah);
		N := i - 1;
		NInventoriBahanMentah := N;
	
		if (N = 0) then //jika file kosong
		begin
			writeln('-- Inventori bahan mentah Anda kosong. Beli dahulu!');
		end else
		begin
			for j := 1 to N do
			begin
				pospis := pos('|', BacaInventoriMentah[j]); //Cari posisi guard pertama di mana
				ArrayInventoriMentah[j].namamentah := copy(BacaInventoriMentah[j], 1, (pospis - 2)); //Input nama mentah ke array
				BacaInventoriMentah[j] := copy(BacaInventoriMentah[j], (pospis + 2), length(BacaInventoriMentah[j])); //Inisialisasi posisi guard baru

				pospis := pos('/', BacaInventoriMentah[j]); //Cari posisi garis miring pertama di mana
				ArrayInventoriMentah[j].hari := StrToInt(copy(BacaInventoriMentah[j], 1, (pospis - 1))); //Input hari ke array
				BacaInventoriMentah[j] := copy(BacaInventoriMentah[j], (pospis + 1), length(BacaInventoriMentah[j])); //Inisialiasi posisi guard baru

				pospis := pos('/', BacaInventoriMentah[j]); //Cari posisi garis miring kedua di mana
				ArrayInventoriMentah[j].bulan := StrToInt(copy(BacaInventoriMentah[j], 1, (pospis - 1))); //Input bulan ke array
				BacaInventoriMentah[j] := copy(BacaInventoriMentah[j], (pospis + 1), length(BacaInventoriMentah[j])); //Inisialiasi posisi guard baru

				pospis := pos('|', BacaInventoriMentah[j]); //Cari posisi guard pertama di mana
				ArrayInventoriMentah[j].tahun := StrToInt(copy(BacaInventoriMentah[j], 1, (pospis - 2))); //Input nama mentah ke array
				BacaInventoriMentah[j] := copy(BacaInventoriMentah[j], (pospis + 2), length(BacaInventoriMentah[j])); //Inisialisasi posisi guard baru

				ArrayInventoriMentah[j].jumlah := StrtoInt(BacaInventoriMentah[j]);
			end;
		end;
	end;

	procedure InventoriBahanOlahan();
	begin
		assign(inventoriolahan, 'inventoribahanolahan.txt');
		reset(inventoriolahan);

		i := 1;
		while (not(eof(inventoriolahan))) do
		begin
			readln(inventoriolahan, BacaInventoriOlahan[i]);
			i := i + 1;
		end;
		close(inventoriolahan);
		N := i - 1;
		NInventoriBahanOlahan := N;

		if (N = 0) then //jika file kosong
		begin
			writeln('-- Inventori bahan olahan Anda kosong. Olah dahulu!');
		end else
		begin
			for j := 1 to N do
			begin
				pospis := pos('|', BacaInventoriOlahan[j]); //Cari posisi guard pertama di mana
				ArrayInventoriOlahan[j].namaolahan := copy(BacaInventoriOlahan[j], 1, (pospis - 2)); //Input nama mentah ke array
				BacaInventoriOlahan[j] := copy(BacaInventoriOlahan[j], (pospis + 2), length(BacaInventoriOlahan[j])); //Inisialisasi posisi guard baru

				pospis := pos('/', BacaInventoriOlahan[j]); //Cari posisi garis miring pertama di mana
				ArrayInventoriOlahan[j].hari := StrToInt(copy(BacaInventoriOlahan[j], 1, (pospis - 1))); //Input hari ke array
				BacaInventoriOlahan[j] := copy(BacaInventoriOlahan[j], (pospis + 1), length(BacaInventoriOlahan[j])); //Inisialiasi posisi guard baru

				pospis := pos('/', BacaInventoriOlahan[j]); //Cari posisi garis miring kedua di mana
				ArrayInventoriOlahan[j].bulan := StrToInt(copy(BacaInventoriOlahan[j], 1, (pospis - 1))); //Input bulan ke array
				BacaInventoriOlahan[j] := copy(BacaInventoriOlahan[j], (pospis + 1), length(BacaInventoriOlahan[j])); //Inisialiasi posisi guard baru

				pospis := pos('|', BacaInventoriOlahan[j]); //Cari posisi guard pertama di mana
				ArrayInventoriOlahan[j].tahun := StrToInt(copy(BacaInventoriOlahan[j], 1, (pospis - 2))); //Input nama mentah ke array
				BacaInventoriOlahan[j] := copy(BacaInventoriOlahan[j], (pospis + 2), length(BacaInventoriOlahan[j])); //Inisialisasi posisi guard baru

				ArrayInventoriOlahan[j].jumlah := StrtoInt(BacaInventoriOlahan[j]);
			end;
		end;
	end;

	procedure BacaResep();
	begin
		assign(resep, 'fileresep.txt');
		reset(resep);

		i := 1;
		while (not(eof(resep))) do
		begin
			readln(resep, BacaFileResep[i]);
			i := i + 1;
		end;
		close(resep);
		N := i - 1;	
		NBacaResep := N;

		if (N = 0) then
		begin
			writeln('-- Resep Anda kosong. Buatlah dahulu.');
		end else
		begin
			for j := 1 to N do
			begin
				pospis := pos('|', BacaFileResep[j]); //Cari posisi guard pertama di mana
				ArrayFileResep[j].namaresep := copy(BacaFileResep[j], 1, (pospis - 2)); //Input nama resep ke array
				BacaFileResep[j] := copy(BacaFileResep[j], (pospis + 2), length(BacaFileResep[j])); //Inisialisasi posisi guard baru

				pospis := pos('|', BacaFileResep[j]); //Cari posisi kedua di mana
				ArrayFileResep[j].hargajual := StrToInt(copy(BacaFileResep[j], 1, (pospis - 2))); //Input harga jual ke array
				BacaFileResep[j] := copy(BacaFileResep[j], (pospis + 2), length(BacaFileResep[j])); //Inisialiasi posisi guard baru

				pospis := pos('|', BacaFileResep[j]); //Cari posisi guard ketiga di mana
				ArrayFileResep[j].jumlahbhn := StrToInt(copy(BacaFileResep[j], 1, (pospis - 2))); //Input jumlah bahan olahan ke array
				BacaFileResep[j] := copy(BacaFileResep[j], (pospis + 2), length(BacaFileResep[j])); //Inisialiasi posisi guard baru

				k := 1;
				while (ArrayFileResep[j].jumlahbhn > k) do
				begin
					pospis := pos('|', BacaFileResep[j]);
					ArrayFileResep[j].bahan_ke[k] := copy(BacaFileResep[j], 1, (pospis - 2)); //Input bahan mentah/olahan ke- ke array
					BacaFileResep[j] := copy(BacaFileResep[j], (pospis + 2), length(BacaFileResep[j])); //Inisialisasi posisi guard baru
					k := k + 1;
				end;
				ArrayFileResep[j].bahan_ke[k] := BacaFileResep[j];
			end;
		end;
	end;

	procedure BacaFileSimulasi();
	begin
		assign(simulasi, 'filesimulasi.txt');
		reset(simulasi);

		i := 1;
		while (not(eof(simulasi))) do
		begin
			readln(simulasi, BacaSimulasi[i]);
			i := i + 1;
		end;
		close(simulasi);
		N := i - 1;
		NFileSimulasi := N;

		if (N = 0) then //jika file kosong
		begin
			writeln('-- Tidak ada data simulasi. Isilah dahulu.');
		end else
		begin
			for j := 1 to N do
			begin
				pospis := pos('|', BacaSimulasi[j]); //Cari posisi guard pertama di mana
				ArraySimulasi[j].nomorsimulasi := StrToInt(copy(BacaSimulasi[j], 1, (pospis - 2))); //Input nomor simulasi ke array
				BacaSimulasi[j] := copy(BacaSimulasi[j], (pospis + 2), length(BacaSimulasi[j])); //Inisialisasi posisi guard baru

				pospis := pos('/', BacaSimulasi[j]); //Cari posisi guard pertama di mana
				ArraySimulasi[j].hari := StrToInt(copy(BacaSimulasi[j], 1, (pospis - 1))); //Input tanggal simulasi ke array
				BacaSimulasi[j] := copy(BacaSimulasi[j], (pospis + 1), length(BacaSimulasi[j])); //Inisialisasi posisi guard baru

				pospis := pos('/', BacaSimulasi[j]); //Cari posisi guard pertama di mana
				ArraySimulasi[j].bulan := StrToInt(copy(BacaSimulasi[j], 1, (pospis - 1))); //Input bulan simulasi ke array
				BacaSimulasi[j] := copy(BacaSimulasi[j], (pospis + 1), length(BacaSimulasi[j])); //Inisialisasi posisi guard baru				

				pospis := pos('|', BacaSimulasi[j]); //Cari posisi guard pertama di mana
				ArraySimulasi[j].tahun := StrToInt(copy(BacaSimulasi[j], 1, (pospis - 2))); //Input tahun simulasi ke array
				BacaSimulasi[j] := copy(BacaSimulasi[j], (pospis + 2), length(BacaSimulasi[j])); //Inisialisasi posisi guard baru

				pospis := pos('|', BacaSimulasi[j]); //Cari posisi guard pertama di mana
				ArraySimulasi[j].jumlahhidup := StrToInt(copy(BacaSimulasi[j], 1, (pospis - 2))); //Input jumlah hidup ke array
				BacaSimulasi[j] := copy(BacaSimulasi[j], (pospis + 2), length(BacaSimulasi[j])); //Inisialisasi posisi guard baru

				pospis := pos('|', BacaSimulasi[j]); //Cari posisi guard pertama di mana
				ArraySimulasi[j].jumlahenergi := StrToInt(copy(BacaSimulasi[j], 1, (pospis - 2))); //Input jumlah energi ke array
				BacaSimulasi[j] := copy(BacaSimulasi[j], (pospis + 2), length(BacaSimulasi[j])); //Inisialisasi posisi guard baru

				pospis := pos('|', BacaSimulasi[j]); //Cari posisi guard pertama di mana
				ArraySimulasi[j].kapasitasmaksinventori := StrToInt(copy(BacaSimulasi[j], 1, (pospis - 2))); //Input kapasitas maksimal inventori ke array
				BacaSimulasi[j] := copy(BacaSimulasi[j], (pospis + 2), length(BacaSimulasi[j])); //Inisialisasi posisi guard baru

				pospis := pos('|', BacaSimulasi[j]); //Cari posisi guard pertama di mana
				ArraySimulasi[j].bahanmentahbeli := StrToInt(copy(BacaSimulasi[j], 1, (pospis - 2))); //Input bahan mentah yang dibeli ke array
				BacaSimulasi[j] := copy(BacaSimulasi[j], (pospis + 2), length(BacaSimulasi[j])); //Inisialisasi posisi guard baru

				pospis := pos('|', BacaSimulasi[j]); //Cari posisi guard pertama di mana
				ArraySimulasi[j].bahanolahanbuat := StrToInt(copy(BacaSimulasi[j], 1, (pospis - 2))); //Input bahan olahan yang dibuat ke array
				BacaSimulasi[j] := copy(BacaSimulasi[j], (pospis + 2), length(BacaSimulasi[j])); //Inisialisasi posisi guard baru

				pospis := pos('|', BacaSimulasi[j]); //Cari posisi guard pertama di mana
				ArraySimulasi[j].bahanolahanjual := StrToInt(copy(BacaSimulasi[j], 1, (pospis - 2))); //Input bahan olahan yang dijual ke array
				BacaSimulasi[j] := copy(BacaSimulasi[j], (pospis + 2), length(BacaSimulasi[j])); //Inisialisasi posisi guard baru

				pospis := pos('|', BacaSimulasi[j]); //Cari posisi guard pertama di mana
				ArraySimulasi[j].resepjual := StrToInt(copy(BacaSimulasi[j], 1, (pospis - 2))); //Input resep yang dijual ke array
				BacaSimulasi[j] := copy(BacaSimulasi[j], (pospis + 2), length(BacaSimulasi[j])); //Inisialisasi posisi guard baru

				pospis := pos('|', BacaSimulasi[j]); //Cari posisi guard pertama di mana
				ArraySimulasi[j].pemasukan := StrToInt(copy(BacaSimulasi[j], 1, (pospis - 2))); //Input pemasukan ke array
				BacaSimulasi[j] := copy(BacaSimulasi[j], (pospis + 2), length(BacaSimulasi[j])); //Inisialisasi posisi guard baru

				pospis := pos('|', BacaSimulasi[j]); //Cari posisi guard pertama di mana
				ArraySimulasi[j].pengeluaran := StrToInt(copy(BacaSimulasi[j], 1, (pospis - 2))); //Input pengeluaran ke array
				BacaSimulasi[j] := copy(BacaSimulasi[j], (pospis + 2), length(BacaSimulasi[j])); //Inisialisasi posisi guard baru

				ArraySimulasi[j].totaluang := StrToInt(BacaSimulasi[j]); //Input total uang ke array			
			end;
		end;
	end;
end.