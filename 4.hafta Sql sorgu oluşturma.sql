--1. ADIM SQL ÝLE TABLO OLUÞTURMA--
CREATE TABLE UYELER( --Uyeler tablosu oluþturmak --
UyeNo INT IDENTITY (1,1),
UyeAdi VARCHAR(30),
UyeSoyadi VARCHAR(30),
Cinsiyet VARCHAR(2),
Telefon VARCHAR(20),
E_Posta VARCHAR(50),
AdresNo INT,
PRIMARY KEY("UyeNo")
);
ALTER TABLE UYELER ADD CONSTRAINT "ADRESLER_UYELER"  --Foreýgn key atamak--
FOREIGN KEY(AdresNo) REFERENCES ADRESLER(AdresNo);


CREATE TABLE ADRESLER(
AdresNo INT IDENTITY(1,1),  --Adresler tablosu oluþturmak--
Cadde VARCHAR(30),
Mahalle VARCHAR(30),
BinaNo VARCHAR(10),
Sehir VARCHAR(20),
PostaKodu VARCHAR(20),
Ulke VARCHAR(20),
PRIMARY KEY("AdresNo") 
);

CREATE TABLE EMANET(
EmanetNo INT IDENTITY(1,1), --Emanet tablosu oluþturmak--
ISBN VARCHAR(30) NOT NULL,
UyeNo INT NOT NULL,
KutuphaneNo INT NOT NULL,
EmanetTarihi DATETIME,
TeslimTarihi DATETIME,
PRIMARY KEY ("EmanetNo")
);
ALTER TABLE EMANET ADD CONSTRAINT "EMANET1_KUTUPHANE" FOREIGN KEY(KutuphaneNo) REFERENCES KUTUPHANE(KutuphaneNo); --Foreýgn key atamak--
ALTER TABLE EMANET	ADD CONSTRAINT "EMANET_KITAPLAR" FOREIGN KEY(ISBN) REFERENCES KITAPLAR(ISBN);
ALTER TABLE EMANET	ADD CONSTRAINT "EMANET_UYELER" FOREIGN KEY(UyeNo) REFERENCES UYELER(UyeNo);


 CREATE TABLE KUTUPHANE(
	KutuphaneNo INT IDENTITY(1,1), --kütüphane tablosu oluþturmak--
	KutuphaneAdi VARCHAR(20),
	Aciklama VARCHAR(20),
	AdresNo INT,
	PRIMARY KEY ("KutuphaneNo")
);

CREATE TABLE KITAPLAR( --kitaplar tablosu oluþturmak--
	ISBN VARCHAR(30),
	KitapAdi VARCHAR(20),
	YayinTarihi VARCHAR(30),
	S_Sayisi INT,
	PRIMARY KEY ("ISBN")
);

CREATE TABLE KATEGORILER(
	KategoriNo INT IDENTITY(1,1), --kategori tablosu oluþturmak--
	KategoriAdi VARCHAR(15),
	PRIMARY KEY ("KategoriNo")
);

CREATE TABLE YAZARLAR(
	YazarNo INT IDENTITY(1,1), --Yazarlar tablosu oluþturmak--
	YazarAdi VARCHAR(20),
	YazarSoyadi VARCHAR(20),
	PRIMARY KEY ("YazarNo")
);

CREATE TABLE KITAP_KUTUPHANE1( --Kitap kütüphane tablosu oluþturmak--
	KutuphaneNo INT NOT NULL,
	ISBN VARCHAR(20) NOT NULL,
	Miktar INT,
	CONSTRAINT "KITAP1_KUTUPHANE_PK" PRIMARY KEY ("KutuphaneNo", "ISBN"),
	CONSTRAINT "KITAP1_KUTUPHANE_FK" FOREIGN KEY ("KutuphaneNo") REFERENCES KATEGORILER1(KategoriNo)
);
ALTER TABLE KITAP_KUTUPHANE ADD CONSTRAINT "KITAP_KUTUPHANE_KITAPLAR" FOREIGN KEY ("ISBN") REFERENCES KITAPLAR1(ISBN);

CREATE TABLE KITAP_KATEGORI( --kitap kategori tablosu oluþturmak--
	ISBN VARCHAR(30) NOT NULL,
	KategoriNo INT NOT NULL,
	CONSTRAINT "KITAP_KATEGORI_PK"
	PRIMARY KEY ("KategoriNo", "ISBN")
);

CREATE TABLE KITAP_YAZAR( --kitap yazar tablosu oluþturmak--
	ISBN VARCHAR(30) NOT NULL,
	YazarNo INT NOT NULL,
	CONSTRAINT "KITAP_YAZAR_PK" PRIMARY KEY ("YazarNo", "ISBN")
);


--ALIÞTIRMALAR 2.ADIM (EKLEME,GÜNCELLEME,SÝLME ÝÞLEMLERÝ)--
INSERT INTO ADRESLER (AdresNo, Cadde,Mahalle,BinaNo,Sehir,PostaKodu,Ulke)
VALUES('9','Beyaz','Saadet','78','Kayseri','38020','Türkiye');  /* adresler tablosuna veri giriþi*/

INSERT INTO UYELER(UyeNo,UyeAdi,UyeSoyadi,Cinsiyet,AdresNo,Telefon,E_Posta)
VALUES ('11','Sevgi','Aslan','0','9','3524778989','sa@mail.com');  /* üyeler tablosuna veri giriþi*/

INSERT INTO KUTUPHANE(KutuphaneNo,AdresNo, KutuphaneIsmi,Acýklama)
VALUES ('6','9','Gülhan','Ekim 2023 te açýldý.');   /* kütüphane tablosuna veri giriþi*/

INSERT INTO EMANET(EmanetNo,ISBN,UyeNo,KutuphaneNo,EmanetTarihi,TeslimTarihi)
VALUES('20','5869324512','9','1','2023-10-26','2023-10-30'); /* emanet tablosuna veri giriþi*/

INSERT INTO KITAPLAR(ISBN,KitapAdi,YayinTarihi,S_Sayisi)
VALUES('5869324512','Kürk Mantolu Madonna','2023-12-14','220');  /* kitaplar tablosuna veri giriþi*/

INSERT INTO YAZARLAR(YazarNo,YazarAdi,YazarSoyadi)
VALUES('19','Sabahattin','Ali');  /* yazarlar tablosuna veri giriþi*/

INSERT INTO KATEGORI(KategoriNo,KategoriAdi)
VALUES ('12','Çocuk Kitaplarý');  /* kategori tablosuna veri giriþi*/

INSERT INTO KITAP_KUTUPHANE(KutuphaneNo,ISBN,Miktar)
VALUES ('6','5869324512','50');  /* kitap-kütüphane tablosuna veri giriþi*/

INSERT INTO KITAP_KATEGORI(ISBN,KategoriNo)
VALUES('5869324512','4');  /* kitap-kategori tablosuna veri giriþi*/

INSERT INTO KITAP_YAZAR(ISBN,YazarNo)
VALUES('5869324512','19');  /* kitap-yazar tablosuna veri giriþi*/

UPDATE ADRESLER
SET Cadde='Karlý', Mahalle='Yýlmaz',Sehir='Kayseri'  /* adres tablosuna güncelleme*/
WHERE AdresNo=4;

UPDATE EMANET
SET EmanetTarihi='2023-03-25', TeslimTarihi='2023-03-26' /* emanet tablosuna güncelleme*/
WHERE EmanetNo=9;

UPDATE KATEGORI
SET KategoriAdi='Þiir'  /* kategori tablosuna güncelleme*/
WHERE KategoriNo=12;

UPDATE KITAP_KATEGORI   /* kitap-kategori tablosuna güncelleme*/
SET KategoriNo=9
WHERE ISBN ='6051061436';

UPDATE KITAP_KUTUPHANE  /* kitap-kutuphane tablosuna güncelleme*/
SET Miktar=7 
WHERE ISBN='6055937522';

UPDATE KITAP_YAZAR    /* kitap-yazar tablosuna güncelleme*/
SET YazarNo=7
WHERE ISBN='6055937188';

UPDATE KITAPLAR
SET YayinTarihi='2010-02-05',S_Sayisi=360  /* kitaplar tablosuna güncelleme*/
WHERE ISBN='6054125234';

UPDATE KUTUPHANE
SET KutuphaneIsmi='Seher'  /* kütüphane tablosuna güncelleme*/
WHERE KutuphaneNo=2;

UPDATE UYELER
SET UyeNo=10   /* üyeler tablosuna güncelleme*/
WHERE UyeNo=11;

UPDATE YAZARLAR
SET YazarNo=18  /* yazarlar tablosuna güncelleme*/
WHERE YazarNo=19;

DELETE FROM ADRESLER /* adresler tablosundan kayýt silme*/
WHERE AdresNo=8;

DELETE FROM EMANET
WHERE TeslimTarihi='2009-10-17'; /* emanet tablosundan kayýt silme*/

DELETE FROM KATEGORI /* kategori tablosundan kayýt silme*/
WHERE KategoriNo=12;

DELETE FROM KITAP_KATEGORI  /* kitap-kategori tablosundan kayýt silme*/
WHERE ISBN='6053950899';

DELETE FROM KITAP_KUTUPHANE  /* kitap-kutuphane tablosundan kayýt silme*/
WHERE ISBN='6053950899';

DELETE FROM KITAP_YAZAR  /* kitap-yazar tablosundan kayýt silme*/
WHERE ISBN='6053950899';

DELETE FROM KITAPLAR
WHERE ISBN='6053950899';  /* kitap tablosundan kayýt silme*/

DELETE FROM KUTUPHANE
WHERE KutuphaneNo=6;  /* kutuphane tablosundan kayýt silme*/

DELETE FROM UYELER  /* uyeler tablosundan kayýt silme*/
WHERE UyeNo=10;   

DELETE FROM YAZARLAR /* yazarlar tablosundan kayýt silme*/
WHERE YazarNo=18;

/*3.ADIM ARTAN SAYIDA SÜTUN SIRALAMA*/
SELECT UyeNo
FROM UYELER
ORDER BY UyeNo ASC; /*Order by sýralama iþlemi yapar ASC küçükten büyüðe ,DSC büyükten küçüðe olur. */

--4.ADIM 2023TEn SONRA EMANET ALINAN KÝTAPLAR--
SELECT*
FROM EMANET
WHERE EmanetTarihi>='2023-01-01';

--5.ADIM --
SELECT UyeAdi, U.UyeSoyadi, U.Telefon, A.Sehir
FROM UYELER U
JOIN ADRESLER A ON U.AdresNo = A.AdresNo
WHERE A.Sehir = 'Kayseri' AND U.TELEFON LIKE '%6%';

--6.Adým Teslim tarihi 30 günden küçük olanlarý getiren sorgu
SELECT *
FROM Emanet
WHERE DATEDIFF(day, GETDATE(), TeslimTarihi) < 30;

--7.Adým -- :(

--8.Adým 
SELECT DISTINCT A.Sehir
FROM UYELER U
INNER JOIN ADRESLER A ON U.AdresNo = A.AdresNo
ORDER BY A.Sehir;

--9.ADIM 
SELECT COUNT(*) AS EmanetSayisi
FROM Emanet
WHERE YEAR(EmanetTarihi) = 2020;

--10.ADIM
SELECT *
FROM Emanet
WHERE kutuphaneNo = (SELECT kutuphaneNo FROM Kutuphane WHERE kutuphaneIsmi = 'Kayseri Belediyesi Merkez Kütüphanesi')
      AND DATEDIFF(MONTH, EmanetTarihi, TeslimTarihi) > 6;
--11.ADIM
SELECT COUNT(*) AS EskiþehirdeYasayanUyeSayisi
FROM UYELER
WHERE AdresNo IN (SELECT AdresNo FROM ADRESLER WHERE Sehir = 'Eskiþehir')

--12.ADIM
SELECT YayinTarihi
FROM KITAPLAR
WHERE DATEDIFF(YEAR, YayinTarihi, GETDATE()) > 3;

--13.ADIM
SELECT ISBN, 
       MAX(DATEDIFF(DAY, EmanetTarihi, TeslimTarihi)) AS EnUzunEmanetSuresi,
       MIN(DATEDIFF(DAY, EmanetTarihi, TeslimTarihi)) AS EnKisaEmanetSuresi
FROM Emanet
GROUP BY ISBN;

--14.Adým
SELECT KITAPLAR.ISBN, KITAPLAR.KitapAdi, UYELER.UyeAdi, UYELER.UyeSoyadi
FROM EMANET
INNER JOIN KITAPLAR ON EMANET.ISBN = KITAPLAR.ISBN
INNER JOIN UYELER ON EMANET.UyeNo = UYELER.UyeNo;
