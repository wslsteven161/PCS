drop table members cascade constraint purge;
drop table obat cascade constraint purge;
drop table satuan cascade constraint purge;
drop table stok cascade constraint purge;
drop table supplier cascade constraint purge;
drop table htrans cascade constraint purge;
drop table dtrans cascade constraint purge;
drop table hbeli cascade constraint purge;
drop table dbeli cascade constraint purge;
drop table hretur cascade constraint purge;
drop table dretur cascade constraint purge;

create table members (
	member_id varchar2(5),
	member_nama varchar2(30) not null,
	member_telepon varchar2(13) not null,
	member_alamat varchar2(200) not null,
	constraint pk_members primary key (member_id)
);

create table satuan(
	satuan_id varchar2(4),
	satuan_nama varchar2(20) not null,
	constraint pk_satuan primary key(satuan_id)
);

create table obat (
	obat_id varchar2(5),
	obat_nama varchar2(30) not null,
	obat_brand varchar2(20) not null,
	obat_dosis varchar2(20) not null,
	obat_satuan varchar2(4),
	obat_harga number not null,
    obat_status number not null,
	constraint pk_obat primary key (obat_id),
	constraint fk_satuan foreign key(obat_satuan) references satuan(satuan_id)
);

create table stok (
	stok_obat_id varchar2(5),
	stok_jumlah_obat number(11) not null,
	stok_satuan_id varchar2(4),
	constraint fk_stok foreign key (stok_obat_id) references obat (obat_id),
	constraint fk_stok_satuan foreign key(stok_satuan_id) references satuan(satuan_id)
);

create table supplier (
	supplier_id varchar2(6),
	supplier_nama varchar2(30) not null,
	supplier_alamat varchar2(200) not null,
	supplier_kota varchar2(20) not null,
	supplier_telepon varchar2(13) not null,
	constraint pk_supplier primary key (supplier_id)
);

create table htrans (
	htrans_nota varchar2(13),
	htrans_member_id varchar2(5),
	htrans_total number not null,
	constraint pk_htrans primary key (htrans_nota),
	constraint fk_htrans foreign key (htrans_member_id) references members(member_id)
);

create table dtrans (
	dtrans_nota varchar2(13),
	dtrans_obat_id varchar2(5),
	dtrans_qty number not null,
	dtrans_harga number not null,
	dtrans_subtotal number not null,
	dtrans_instruksi varchar2(100) not null,
	constraint fk_dtrans foreign key (dtrans_nota) references htrans (htrans_nota),
	constraint fk_obat foreign key (dtrans_obat_id) references obat(obat_id)
);

create table hbeli (
	hbeli_nota varchar2(13),
	hbeli_supplier_id varchar2(7),
	hbeli_total number not null,
	no_surat_jalan varchar2(200) not null,
	constraint pk_hbeli primary key (hbeli_nota),
	constraint fk_hbeli foreign key (hbeli_supplier_id) references supplier (supplier_id)
);

create table dbeli (
	dbeli_nota varchar2(13),
	dbeli_obat_id varchar2(5),
	dbeli_qty number not null,
	dbeli_harga number not null,
	dbeli_subtotal number not null,
	constraint fk_dbeli foreign key (dbeli_nota) references hbeli (hbeli_nota),
	constraint fk_barang foreign key (dbeli_obat_id) references obat (obat_id)
);

create table hretur(
	hretur_nota varchar2(13),
	hretur_htrans_nota varchar2(13),
	hretur_member_id varchar2(5),
	hretur_total number not null,
	constraint pk_hretur primary key(hretur_nota),
	constraint fk_hretur foreign key(hretur_member_id) references members(member_id),
	constraint fk_hretur_htrans_nota foreign key(hretur_htrans_nota) references htrans(htrans_nota)
);

create table dretur(
	dretur_nota varchar2(13),
	dretur_obat_id varchar2(5),
	dretur_tanggal_expired date,
	dretur_qty number,
	dretur_harga number,
	dretur_subtotal number,
	dretur_keterangan varchar2(100) not null,
	constraint fk_dretur foreign key(dretur_nota) references hretur(hretur_nota),
	constraint fk_dretur_obat foreign key(dretur_obat_id) references obat(obat_id)
);

--member
insert into members values ('AN001', 'Andi', '08197901999', 'Kenjeren');
insert into members values ('AR001', 'Arnold', '08197901888', 'Mulyosari');
insert into members values ('BU001', 'Budi', '081979017777', 'Ngagel');
insert into members values ('CH001', 'Charles', '08197901888', 'Bratang');
insert into members values ('DA001', 'Danny', '08197901666', 'Lebak');
insert into members values ('RI001', 'Riki', '085122199712', 'Tambaksari');
insert into members values ('CL001', 'Clara', '085132199714', 'Mulyorejo');
insert into members values ('NI001', 'Nikita', '085162199716', 'Tegalsari');
insert into members values ('AL001', 'Alex', '085172199716', 'Wiyung');
insert into members values ('JO001', 'Johny', '08197901666', 'Ngagel');
insert into members values ('VI001', 'Vina', '081123123123', 'Kenjeren');
insert into members values ('AR002', 'Ary', '081213212212', 'Mulyosari');
insert into members values ('BU002', 'Bunga', '081212121212', 'Ngagel');
insert into members values ('CH002', 'Charlie', '08197901878', 'Bratang');
insert into members values ('SA001', 'Sandy', '08197901776', 'Lebak');
insert into members values ('TE001', 'Teddy', '089758920112', 'Dukuh Kupang');
insert into members values ('AN002', 'Anita', '082382847128', 'Pucang');
insert into members values ('BR001', 'Bramasta', '08193399777', 'Manyar');
insert into members values ('CH003', 'Christian', '08999777888', 'Wiyung');
insert into members values ('DE001', 'Deni', '08158479008', 'Manyar');


--satuan
insert into satuan values ('S001', 'Kapsul');
insert into satuan values ('S002', 'Botol');
insert into satuan values ('S003', 'Biji');
insert into satuan values ('S004', 'Strip');
insert into satuan values ('S005', 'Sirup');
insert into satuan values ('S006', 'Pcs ');
insert into satuan values ('S007', 'Tube');
insert into satuan values ('S008', 'Tablet ');
insert into satuan values ('S009', 'Pack ');
insert into satuan values ('S010', 'Box ');

--obat
insert into obat values ('DE001', 'Dekongestan', 'Generik', '100 mg', 'S001', 50000, 1);
insert into obat values ('AS001', 'Asam Mefenamat', 'Generik', '500 mg', 'S002', 100000,1);
insert into obat values ('AN001', 'Antasida Doen', 'Generik', '50 mg', 'S003', 30000,1);
insert into obat values ('AM001', 'Ambroxol', 'Generik', '30 mg', 'S004', 60000,1);
insert into obat values ('PA001', 'Paracetamol', 'Value Choi', '500 mg', 'S005', 5000,1);
insert into obat values ('DE002', 'Depakote', 'Generik', '250 mg', 'S002', 150000,1);
insert into obat values ('UR001', 'Urief', 'Generik', '500 mg', 'S004', 100000,1);
insert into obat values ('DE003', 'Decolgen', 'Generik', '400 mg', 'S004', 5000,1);
insert into obat values ('KO001', 'Konidin', 'Generik', '300 mg', 'S004', 5000,1);
insert into obat values ('AV001', 'Avodart', 'Generik', '1 mg', 'S004', 100000,1);
insert into obat values ('AC001', 'Acarbose', 'Antidiabetes', '50 mg', 'S001', 70000, 1);
insert into obat values ('AC002', 'Acrios', 'Antidiabetes', '50 mg', 'S003', 70000,1);
insert into obat values ('CA001', 'Capribose', 'Antidiabetes', '50 mg', 'S002', 70000,1);
insert into obat values ('CA002', 'Carbotrap', 'Antidiabetes', '200 mg', 'S001', 75000,1);
insert into obat values ('DI001', 'Ditrium', 'Antidiabetes', '200 mg', 'S001', 75000,1);
insert into obat values ('AB001', 'Absolute', 'Generik', '100 mg', 'S006',  14400, 1);
insert into obat values ('AL001', 'Alco Plus DMP', 'Interbat', '5 mg', 'S002', 46900,1);
insert into obat values ('ET001', 'Ethambutol', 'Generik', '30 mg', 'S008', 9000,1);
insert into obat values ('NI001', 'Nitrokaf Retard', 'Generik', '5 mg', 'S008', 20000,1);
insert into obat values ('SI001', 'Simvastatin', 'Generik', '20 mg', 'S010', 23000,1);

--stok
insert into stok values ('DE001', 10, 'S001');
insert into stok values ('AS001', 10, 'S002');
insert into stok values ('AN001', 10, 'S003');
insert into stok values ('AM001', 10, 'S004');
insert into stok values ('PA001', 10, 'S005');
insert into stok values ('DE002', 10, 'S002');
insert into stok values ('UR001', 10, 'S002');
insert into stok values ('DE003', 10, 'S002');
insert into stok values ('KO001', 10, 'S002');
insert into stok values ('AV001', 10, 'S002');
insert into stok values ('AC001', 10, 'S001');
insert into stok values ('AC002', 10, 'S003');
insert into stok values ('CA001', 10, 'S002');
insert into stok values ('CA002', 10, 'S001');
insert into stok values ('DI001', 10, 'S001');
insert into stok values ('AB001', 10, 'S006');
insert into stok values ('AL001', 10, 'S002');
insert into stok values ('ET001', 10, 'S008');
insert into stok values ('NI001', 10, 'S008');
insert into stok values ('SI001', 10, 'S010');

--supplier
insert into supplier values ('SUP001', 'Evan', 'Cengkareng', 'Jakarta', '087855791678');
insert into supplier values ('SUP002', 'Johnson', 'Cikarang', 'Tangerang', '087855791123');
insert into supplier values ('SUP003', 'Billy', 'Cengkareng', 'Jakarta', '087855799879');
insert into supplier values ('SUP004', 'Richard', 'Mulyorejo', 'Surabaya', '087855791678');
insert into supplier values ('SUP005', 'Fanny', 'Negara', 'Bali', '087855792386');
insert into supplier values ('SUP006', 'Irene', 'Cengkareng', 'Jakarta', '087845791876');
insert into supplier values ('SUP007', 'Intan', 'Cikarang', 'Jakarta', '087755791321');
insert into supplier values ('SUP008', 'Annisa', 'Cengkareng', 'Surabaya', '087899799987');
insert into supplier values ('SUP009', 'Farah', 'Mulyorejo', 'Surabaya', '087745791876');
insert into supplier values ('SUP010', 'Sarah', 'Negara', 'Jakarta', '087788798623');
insert into supplier values ('SUP011', 'Evir', 'Cengkareng', 'Jakarta', '087855791678');
insert into supplier values ('SUP012', 'Jonny', 'Cikarang', 'Tangerang', '087855791123');
insert into supplier values ('SUP013', 'Berry', 'Cengkareng', 'Jakarta', '087855799879');
insert into supplier values ('SUP014', 'Rid', 'Mulyorejo', 'Surabaya', '087855791678');
insert into supplier values ('SUP015', 'Ferry', 'Negara', 'Bali', '087855792386');
insert into supplier values ('SUP016', 'Kristian', 'Ngagel', 'Surabaya', '089842514678');
insert into supplier values ('SUP017', 'Kevin', 'Cikarang', 'Tangerang', '081855512123');
insert into supplier values ('SUP018', 'Johnatan', 'Lasem', 'Rembang', '082852356279');
insert into supplier values ('SUP019', 'Sony', 'Mulyosari', 'Surabaya', '081123531678');
insert into supplier values ('SUP020', 'Felicia', 'Denpasar', 'Bali', '087855325486');

--htrans
insert into htrans values ('T201904120001', 'AN001', 100000);
insert into htrans values ('T201904130001', 'AR001', 100000);
insert into htrans values ('T201904140001', 'BU001', 150000);
insert into htrans values ('T201904150001', 'CH001', 300000);
insert into htrans values ('T201904160001', 'DA001', 50000);
insert into htrans values ('T201904170001', 'RI001', 150000);
insert into htrans values ('T201904180001', 'CL001', 100000);
insert into htrans values ('T201904190001', 'NI001', 25000);
insert into htrans values ('T201904200001', 'AL001', 25000);
insert into htrans values ('T201904210001', 'JO001', 100000);
insert into htrans values ('T201904220001', 'VI001', 100000);
insert into htrans values ('T201904230001', 'AR001', 100000);
insert into htrans values ('T201904240001', 'BU002', 150000);
insert into htrans values ('T201904250001', 'CH002', 300000);
insert into htrans values ('T201904260001', 'SA001', 50000);
insert into htrans values ('T201904270001', 'TE001', 14400);
insert into htrans values ('T201904280001', 'AN002', 46900);
insert into htrans values ('T201904290001', 'BR001', 27000);
insert into htrans values ('T201904300001', 'CH002', 100000);
insert into htrans values ('T201905010001', 'DE001', 46000);

--dtrans
insert into dtrans values ('T201904120001', 'DE001', 2, 50000, 100000, '-');
insert into dtrans values ('T201904130001', 'AS001', 1, 100000, 100000, '-');
insert into dtrans values ('T201904140001', 'AN001', 5, 30000, 150000, '-');
insert into dtrans values ('T201904150001', 'AM001', 5, 60000, 300000, '-');
insert into dtrans values ('T201904160001', 'PA001', 10, 5000, 50000, '-');
insert into dtrans values ('T201904170001', 'DE002', 1, 150000, 150000, '-');
insert into dtrans values ('T201904180001', 'UR001', 1, 100000, 100000, '-');
insert into dtrans values ('T201904190001', 'DE003', 5, 5000, 25000, '-');
insert into dtrans values ('T201904200001', 'KO001', 5, 5000, 25000, '-');
insert into dtrans values ('T201904210001', 'AV001', 1, 100000, 100000, '-');
insert into dtrans values ('T201904220001', 'CA002', 2, 50000, 100000, '-');
insert into dtrans values ('T201904230001', 'AC001', 1, 100000, 100000, '-');
insert into dtrans values ('T201904240001', 'AC002', 5, 30000, 150000, '-');
insert into dtrans values ('T201904250001', 'CA001', 5, 60000, 300000, '-');
insert into dtrans values ('T201904260001', 'DI001', 10, 5000, 50000, '-');
insert into dtrans values ('T201904270001', 'AB001', 1, 14400, 14400, '-');
insert into dtrans values ('T201904280001', 'AL001', 1, 46900, 46900, '-');
insert into dtrans values ('T201904290001', 'ET001', 3, 9000, 27000, '-');
insert into dtrans values ('T201904300001', 'NI001', 5, 20000, 100000, '-');
insert into dtrans values ('T201905010001', 'SI001', 2, 23000, 46000, '-');

--hbeli
insert into hbeli values ('B201904120001', 'SUP001', 100000, 'SJ001');
insert into hbeli values ('B201904130001', 'SUP002', 100000, 'SJ002');
insert into hbeli values ('B201904140001', 'SUP003', 150000, 'SJ003');
insert into hbeli values ('B201904150001', 'SUP004', 300000, 'SJ004');
insert into hbeli values ('B201904160001', 'SUP005', 50000, 'SJ005');
insert into hbeli values ('B201904170001', 'SUP006', 100000, 'SJ007');
insert into hbeli values ('B201904180001', 'SUP007', 100000, 'SJ007');
insert into hbeli values ('B201904190001', 'SUP008', 150000, 'SJ008');
insert into hbeli values ('B201904200001', 'SUP009', 300000, 'SJ009');
insert into hbeli values ('B201904210001', 'SUP010', 50000, 'SJ010');
insert into hbeli values ('B201904220001', 'SUP011', 100000, 'SJ006');
insert into hbeli values ('B201904230001', 'SUP012', 100000, 'SJ007');
insert into hbeli values ('B201904240001', 'SUP013', 150000, 'SJ008');
insert into hbeli values ('B201904250001', 'SUP014', 300000, 'SJ009');
insert into hbeli values ('B201904260001', 'SUP015', 50000, 'SJ010');
insert into hbeli values ('B201904270001', 'SUP016', 50000, 'SJ011');
insert into hbeli values ('B201904280001', 'SUP017', 200000, 'SJ012');
insert into hbeli values ('B201904290001', 'SUP018', 175000, 'SJ013');
insert into hbeli values ('B201904300001', 'SUP019', 250000, 'SJ014');
insert into hbeli values ('B201905010001', 'SUP020', 75000, 'SJ015');

--dbeli
insert into dbeli values ('B201904120001', 'DE001', 2, 50000, 100000);
insert into dbeli values ('B201904130001', 'AS001', 1, 100000, 100000);
insert into dbeli values ('B201904140001', 'AN001', 5, 30000, 150000);
insert into dbeli values ('B201904150001', 'AM001', 5, 60000, 300000);
insert into dbeli values ('B201904160001', 'PA001', 10, 5000, 50000);
insert into dbeli values ('B201904120001', 'DE002', 1, 150000, 150000);
insert into dbeli values ('B201904130001', 'UR001', 1, 100000, 100000);
insert into dbeli values ('B201904140001', 'DE003', 5, 5000, 25000);
insert into dbeli values ('B201904150001', 'KO001', 5, 5000, 25000);
insert into dbeli values ('B201904160001', 'AV001', 1, 100000, 100000);
insert into dbeli values ('B201904220001', 'CA002', 2, 50000, 100000);
insert into dbeli values ('B201904230001', 'AC001', 1, 100000, 100000);
insert into dbeli values ('B201904240001', 'AC002', 5, 30000, 150000);
insert into dbeli values ('B201904250001', 'CA001', 5, 60000, 300000);
insert into dbeli values ('B201904260001', 'DI001', 10, 5000, 50000);
insert into dbeli values ('B201904270001', 'AB001', 5, 10000, 50000);
insert into dbeli values ('B201904280001', 'AL001', 5, 40000, 200000);
insert into dbeli values ('B201904290001', 'ET001', 10, 5000, 50000);
insert into dbeli values ('B201904300001', 'NI001', 5, 15000, 75000);
insert into dbeli values ('B201905010001', 'SI001', 10, 20000, 200000);

--hretur
insert into hretur values ('R201904120001', 'T201904120001', 'AN001', 100000);
insert into hretur values ('R201904130001', 'T201904130001', 'AR001', 100000);
insert into hretur values ('R201904140001', 'T201904140001', 'BU001', 150000);
insert into hretur values ('R201904150001', 'T201904150001', 'CH001', 300000);
insert into hretur values ('R201904160001', 'T201904160001', 'DA001', 50000);
insert into hretur values ('R201904170001', 'T201904170001', 'RI001', 150000);
insert into hretur values ('R201904180001', 'T201904180001', 'CL001', 100000);
insert into hretur values ('R201904190001', 'T201904190001', 'NI001', 25000);
insert into hretur values ('R201904200001', 'T201904200001', 'AL001', 25000);
insert into hretur values ('R201904210001', 'T201904210001', 'JO001', 100000);
insert into hretur values ('R201904220001', 'T201904220001', 'VI001', 100000);
insert into hretur values ('R201904230001', 'T201904230001', 'AR001', 100000);
insert into hretur values ('R201904240001', 'T201904240001', 'BU002', 150000);
insert into hretur values ('R201904250001', 'T201904250001', 'CH001', 300000);
insert into hretur values ('R201904260001', 'T201904260001', 'SA001', 50000);
insert into hretur values ('R201904270001', 'T201904270001', 'TE001', 14400);
insert into hretur values ('R201904280001', 'T201904280001', 'AN002', 46900);
insert into hretur values ('R201904290001', 'T201904290001', 'BR001', 27000);
insert into hretur values ('R201904300001', 'T201904300001', 'CH003', 100000);
insert into hretur values ('R201905010001', 'T201905010001', 'DE001', 46000);

--dretur
insert into dretur values ('R201904120001', 'DE001', to_date ('08-01-2020', 'DD-MM-YYYY'), 2, 50000, 100000, '-');
insert into dretur values ('R201904130001', 'AS001', to_date ('17-01-2020', 'DD-MM-YYYY'), 1, 100000, 100000, '-');
insert into dretur values ('R201904140001', 'AN001', to_date ('18-01-2020', 'DD-MM-YYYY'), 5, 30000, 150000, '-');
insert into dretur values ('R201904150001', 'AM001', to_date ('24-01-2020', 'DD-MM-YYYY'), 5, 60000, 300000, '-');
insert into dretur values ('R201904160001', 'PA001', to_date ('18-02-2020', 'DD-MM-YYYY'), 10, 5000, 50000, '-');
insert into dretur values ('R201904170001', 'DE002', to_date ('25-02-2020', 'DD-MM-YYYY'), 1, 150000, 150000, '-');
insert into dretur values ('R201904180001', 'UR001', to_date ('28-02-2020', 'DD-MM-YYYY'), 1, 100000, 100000, '-');
insert into dretur values ('R201904190001', 'DE003', to_date ('06-03-2020', 'DD-MM-YYYY'), 5, 5000, 25000, '-');
insert into dretur values ('R201904200001', 'KO001', to_date ('08-03-2020', 'DD-MM-YYYY'), 5, 5000, 25000, '-');
insert into dretur values ('R201904210001', 'AV001', to_date ('16-03-2020', 'DD-MM-YYYY'), 1, 100000, 100000, '-');
insert into dretur values ('R201904220001', 'CA002', to_date ('26-03-2020', 'DD-MM-YYYY'), 2, 50000, 100000, '-');
insert into dretur values ('R201904230001', 'AC001', to_date ('26-03-2020', 'DD-MM-YYYY'), 1, 100000, 100000, '-');
insert into dretur values ('R201904240001', 'AC002', to_date ('01-04-2020', 'DD-MM-YYYY'), 5, 30000, 150000, '-');
insert into dretur values ('R201904250001', 'CA001', to_date ('04-04-2020', 'DD-MM-YYYY'), 5, 60000, 300000, '-');
insert into dretur values ('R201904260001', 'DI001', to_date ('07-04-2020', 'DD-MM-YYYY'), 10, 5000, 50000, '-');
insert into dretur values ('R201904270001', 'AB001', to_date ('08-04-2020', 'DD-MM-YYYY'), 5, 10000, 50000, '-');
insert into dretur values ('R201904280001', 'AL001', to_date ('16-04-2020', 'DD-MM-YYYY'), 5, 40000, 200000, '-');
insert into dretur values ('R201904290001', 'ET001', to_date ('29-04-2020', 'DD-MM-YYYY'), 10, 5000, 50000, '-');
insert into dretur values ('R201904300001', 'NI001', to_date ('03-05-2020', 'DD-MM-YYYY'), 5, 15000, 75000, '-');
insert into dretur values ('R201905010001', 'SI001', to_date ('07-05-2020', 'DD-MM-YYYY'), 10, 20000, 200000, '-');

create or replace trigger autoGenMemberId
before insert on members
for each row
declare
    depan varchar2(1);
    belakang varchar2(1);
    id varchar2(2);
    x number;
    angka number;
    hasil varchar2(5);
begin
    x := instr(:new.member_nama,' ',-1,1);
    if(x > 1) then
        depan := upper(substr(:new.member_nama,1,1));
        belakang := upper(substr(:new.member_nama,-1,1));
    else
        depan := upper(substr(:new.member_nama,1,1));
        belakang := upper(substr(:new.member_nama,2,1));
    end if;
    id := depan || belakang;
    select nvl(max(substr(member_id,3,3)),0) + 1 into angka from members where substr(member_id,1,2) = id;
    hasil := id || lpad(angka,3,0);
    :new.member_id := hasil;
end;
/
show err;

create or replace trigger autoGenIdObat
before insert on obat
for each row
declare
    depan varchar2(1);
    belakang varchar2(1);
    id varchar2(2);
    angka number;
    hasil varchar2(6);
begin
    depan := upper(substr(:new.obat_nama,1,1));
    belakang := upper(substr(:new.obat_nama,2,1));
    id := depan || belakang;
    select nvl(max(substr(obat_id,3,4)),0) + 1 into angka from obat where substr(obat_id,1,2) = id;
    hasil := id || lpad(angka,4,0);
    :new.obat_id := hasil;
end;
/
show err;

create or replace trigger autoGenSatuanId
before insert on satuan
for each row
declare
    angka number;
    id varchar2(4);
begin
    select nvl(max(substr(satuan_id,3,3)),0) + 1 into angka from satuan;
    id := 'S' || lpad(angka,3,0);
    :new.satuan_id := id;
end;
/
show err;

create or replace trigger autoGenSupplierId
before insert on supplier
for each row
declare
    angka number;
    id varchar2(6);
begin
    select nvl(max(substr(supplier_id,4,3)),0) + 1 into angka from supplier;
    id := 'SUP' || lpad(angka,3,0);
    :new.supplier_id := id;
end;
/
show err;

create or replace trigger autoGenHtransNota
before insert on htrans
for each row
declare
    year varchar2(4);
    month varchar2(2);
    day varchar2(2);
    nota varchar2(13);
    id varchar2(9);
    angka number;
begin
    year := to_char(sysdate,'YYYY');
    month := to_char(sysdate,'MM');
    day := to_char(sysdate,'DD');
    id := 'T' ||  year || month || day;
    select nvl(max(substr(htrans_nota,11,13)),0) + 1 into angka from htrans where htrans_nota like id || '%';
    nota := id || lpad(angka,4,0);
    :new.htrans_nota := nota;
end;
/
show err;

create or replace trigger autoGenHbeliNota
before insert on hbeli
for each row
declare
    year varchar2(4);
    month varchar2(2);
    day varchar2(2);
    nota varchar2(13);
    id varchar2(9);
    angka number;
begin
    year := to_char(sysdate,'YYYY');
    month := to_char(sysdate,'MM');
    day := to_char(sysdate,'DD');
    id := 'B' ||  year || month || day;
    select nvl(max(substr(hbeli_nota,11,13)),0) + 1 into angka from hbeli where hbeli_nota like id || '%';
    nota := id || lpad(angka,4,0);
    :new.hbeli_nota := nota;
end;
/
show err;

create or replace trigger autoGenHreturNota
before insert on hretur
for each row
declare
    year varchar2(4);
    month varchar2(2);
    day varchar2(2);
    nota varchar2(13);
    id varchar2(9);
    angka number; 
begin
    year := to_char(sysdate,'YYYY');
    month := to_char(sysdate,'MM');
    day := to_char(sysdate,'DD');
    id := 'R' ||  year || month || day;
    select nvl(max(substr(hretur_nota,11,13)),0) + 1 into angka from hretur where substr(hretur_nota,1,9) = id;
    nota := id || lpad(angka,4,0);
    :new.hretur_nota := nota;
end;
/
show err;

CREATE OR REPLACE TRIGGER autoGenStok_Trans
AFTER INSERT ON dtrans
FOR EACH ROW 
DECLARE 
    QUANTITY NUMBER;
    ERR EXCEPTION;
BEGIN 
    SELECT STOK_JUMLAH_OBAT INTO QUANTITY FROM STOK WHERE STOK_OBAT_ID = :NEW.DTRANS_OBAT_ID;
    IF(QUANTITY >= :NEW.DTRANS_QTY) THEN 
        UPDATE STOK SET STOK_JUMLAH_OBAT = (QUANTITY - :NEW.DTRANS_QTY) WHERE STOK_OBAT_ID = :NEW.DTRANS_OBAT_ID;
    ELSE 
        RAISE ERR;
    END IF;
EXCEPTION
    WHEN ERR THEN RAISE_APPLICATION_ERROR('-20001', 'JUMLAH STOK TIDAK MEMENUHI'); 
END;
/
SHOW ERR;

CREATE OR REPLACE TRIGGER autoGenStok_Beli
AFTER INSERT ON dbeli
FOR EACH ROW 
DECLARE 
    QUANTITY NUMBER;
BEGIN 
    SELECT STOK_JUMLAH_OBAT INTO QUANTITY FROM STOK WHERE STOK_OBAT_ID = :NEW.DBELI_OBAT_ID;
    UPDATE STOK SET STOK_JUMLAH_OBAT = QUANTITY + :NEW.DBELI_QTY WHERE STOK_OBAT_ID = :NEW.DBELI_OBAT_ID;
END;
/
SHOW ERR;

CREATE OR REPLACE TRIGGER checkRetur_qty
BEFORE INSERT ON dretur 
FOR EACH ROW 
DECLARE 
    QUANTITY NUMBER;
    ERR EXCEPTION;
BEGIN 
    SELECT DT.DTRANS_QTY INTO QUANTITY FROM DTRANS DT JOIN HRETUR HR ON HR.HRETUR_NOTA = :NEW.DRETUR_NOTA AND HR.HRETUR_HTRANS_NOTA = DT.DTRANS_NOTA;
    IF QUANTITY > :NEW.DRETUR_QTY THEN 
        RAISE ERR;
    END IF;
EXCEPTION 
    WHEN ERR THEN RAISE_APPLICATION_ERROR('-20001', 'JUMLAH RETUR LEBIH BANYAK DIBANDING JUMLAH DI TRANSAKSI');
END;
/
SHOW ERR;

CREATE OR REPLACE VIEW NEW_HRETUR AS 
SELECT HR.HRETUR_NOTA "NOTA", HR.HRETUR_HTRANS_NOTA "HTRANS_NOTA", M.MEMBER_NAMA "NAMA", HR.HRETUR_TOTAL "TOTAL", TO_DATE(SUBSTR(HR.HRETUR_NOTA,2,8), 'YYYYMMDD') "TANGGAL_NOTA"
FROM HRETUR HR
JOIN MEMBERS M ON HR.HRETUR_MEMBER_ID = M.MEMBER_ID;

CREATE OR REPLACE VIEW NEW_HTRANS AS 
SELECT HT.HTRANS_NOTA "NOTA", M.MEMBER_NAMA "NAMA", HT.HTRANS_TOTAL "TOTAL",TO_DATE(SUBSTR(HT.HTRANS_NOTA,2,8), 'YYYYMMDD')"TANGGAL_NOTA"
FROM HTRANS HT
JOIN MEMBERS M ON HT.HTRANS_MEMBER_ID = M.MEMBER_ID;

CREATE OR REPLACE VIEW NEW_HBELI AS 
SELECT HB.HBELI_NOTA "NOTA", S.SUPPLIER_NAMA "NAMA", HB.NO_SURAT_JALAN "SURAT", HB.HBELI_TOTAL "TOTAL", TO_DATE(SUBSTR(HB.HBELI_NOTA,2,8), 'YYYYMMDD') "TANGGAL_NOTA"
FROM HBELI HB
JOIN SUPPLIER S ON HB.HBELI_SUPPLIER_ID = S.SUPPLIER_ID;

COMMIT;