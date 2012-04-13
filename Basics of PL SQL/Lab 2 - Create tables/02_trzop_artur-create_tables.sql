-- ##################################################
--
--	Baza danych dla portalu spo�eczno�ciowego o ksi��kach
-- 	2010 Copyright (c) Artur Trzop 12K2
--	Script v. 2.0.0
--
-- ##################################################

-- wyk.3, str.46 ustawianie domyslnego sposobu wyswietlania daty
ALTER SESSION SET NLS_DATE_FORMAT = 'yyyy/mm/dd hh24:mi:ss';

CLEAR SCREEN;
PROMPT ----------------------------------------------;
PROMPT Czyszczenie ekranu;
PROMPT ----------------------------------------------;
PROMPT ;


-- ##################################################
PROMPT ;
PROMPT ----------------------------------------------;
PROMPT Usuwanie kluczy obcych;
PROMPT Kasowanie danych z tabel oraz calych tabel;
PROMPT ----------------------------------------------;
PROMPT ;

-- Kolejnosc kasowania jest istotna!
ALTER TABLE KOMENTARZE_DO_RECENZJI DROP CONSTRAINT CSR_FK1_KOM_REC;
ALTER TABLE KOMENTARZE_DO_RECENZJI DROP CONSTRAINT CSR_FK2_KOM_UZY;
DELETE FROM KOMENTARZE_DO_RECENZJI;
DROP TABLE KOMENTARZE_DO_RECENZJI CASCADE CONSTRAINTS;

ALTER TABLE WERSJE_WYDANIA_KSIAZEK DROP CONSTRAINT CSR_FK1_WWK_KSI;
ALTER TABLE WERSJE_WYDANIA_KSIAZEK DROP CONSTRAINT CSR_FK2_WWK_UZY;
ALTER TABLE WERSJE_WYDANIA_KSIAZEK DROP CONSTRAINT CSR_FK3_WWK_WER;
DELETE FROM WERSJE_WYDANIA_KSIAZEK;
DROP TABLE WERSJE_WYDANIA_KSIAZEK CASCADE CONSTRAINTS;

ALTER TABLE AUK_AUTORZY_KSIAZKI DROP CONSTRAINT CSR_FK1_AUK_AUT;
ALTER TABLE AUK_AUTORZY_KSIAZKI DROP CONSTRAINT CSR_FK2_AUK_KSI;
DELETE FROM AUK_AUTORZY_KSIAZKI;
DROP TABLE AUK_AUTORZY_KSIAZKI CASCADE CONSTRAINTS;

ALTER TABLE ULUBIONE_KSIAZKI DROP CONSTRAINT CSR_FK1_ULU_KSI;
ALTER TABLE ULUBIONE_KSIAZKI DROP CONSTRAINT CSR_FK2_ULU_UZY;
DELETE FROM ULUBIONE_KSIAZKI;
DROP TABLE ULUBIONE_KSIAZKI CASCADE CONSTRAINTS;

ALTER TABLE OPINIE_DO_KSIAZEK DROP CONSTRAINT CSR_FK1_OPI_KSI;
ALTER TABLE OPINIE_DO_KSIAZEK DROP CONSTRAINT CSR_FK2_OPI_UZY;
DELETE FROM OPINIE_DO_KSIAZEK;
DROP TABLE OPINIE_DO_KSIAZEK CASCADE CONSTRAINTS;

ALTER TABLE CYTATY_Z_KSIAZEK DROP CONSTRAINT CSR_FK1_CYT_KSI;
ALTER TABLE CYTATY_Z_KSIAZEK DROP CONSTRAINT CSR_FK2_CYT_UZY;
DELETE FROM CYTATY_Z_KSIAZEK;
DROP TABLE CYTATY_Z_KSIAZEK CASCADE CONSTRAINTS;

ALTER TABLE OCENY_KSIAZEK DROP CONSTRAINT CSR_FK1_OCE_KSI;
ALTER TABLE OCENY_KSIAZEK DROP CONSTRAINT CSR_FK2_OCE_UZY;
DELETE FROM OCENY_KSIAZEK;
DROP TABLE OCENY_KSIAZEK CASCADE CONSTRAINTS;

ALTER TABLE RECENZJE_KSIAZEK DROP CONSTRAINT CSR_FK1_REC_KSI;
ALTER TABLE RECENZJE_KSIAZEK DROP CONSTRAINT CSR_FK2_REC_UZY;
DELETE FROM RECENZJE_KSIAZEK;
DROP TABLE RECENZJE_KSIAZEK CASCADE CONSTRAINTS;

ALTER TABLE WERSJA_WYDANIA DROP CONSTRAINT CSR_FK_WER_WYD;
DELETE FROM WERSJA_WYDANIA;
DROP TABLE WERSJA_WYDANIA CASCADE CONSTRAINTS;

ALTER TABLE ULA_ULUBIENI_AUTORZY DROP CONSTRAINT CSR_FK1_ULA_AUT;
ALTER TABLE ULA_ULUBIENI_AUTORZY DROP CONSTRAINT CSR_FK2_ULA_UZY;
DELETE FROM ULA_ULUBIENI_AUTORZY;
DROP TABLE ULA_ULUBIENI_AUTORZY CASCADE CONSTRAINTS;

ALTER TABLE KSIAZKI DROP CONSTRAINT CSR_FK1_KSI_KAT;
ALTER TABLE KSIAZKI DROP CONSTRAINT CSR_FK2_KSI_UZY;
DELETE FROM KSIAZKI;
DROP TABLE KSIAZKI CASCADE CONSTRAINTS;

ALTER TABLE WYDAWNICTWO DROP CONSTRAINT CSR_FK_WYD_MIA;
DELETE FROM WYDAWNICTWO;
DROP TABLE WYDAWNICTWO CASCADE CONSTRAINTS;

ALTER TABLE KATEGORIE_KSIAZEK DROP CONSTRAINT CSR_FK_KAT_KAT;
DELETE FROM KATEGORIE_KSIAZEK;
DROP TABLE KATEGORIE_KSIAZEK CASCADE CONSTRAINTS;

ALTER TABLE AUTORZY DROP CONSTRAINT CSR_FK_AUT_UZY;
DELETE FROM AUTORZY;
DROP TABLE AUTORZY CASCADE CONSTRAINTS;

ALTER TABLE SESJE_UZYTKOWNIKOW DROP CONSTRAINT CSR_FK_SES_UZY;
DELETE FROM SESJE_UZYTKOWNIKOW;
DROP TABLE SESJE_UZYTKOWNIKOW CASCADE CONSTRAINTS;

ALTER TABLE UZYTKOWNICY DROP CONSTRAINT CSR_FK_UZY_MIA;
ALTER TABLE UZYTKOWNICY DROP CONSTRAINT CSR_UQ_UZY_LOGIN;
DELETE FROM UZYTKOWNICY;
DROP TABLE UZYTKOWNICY CASCADE CONSTRAINTS;

DELETE FROM MIASTO;
DROP TABLE MIASTO CASCADE CONSTRAINTS;



-- ####################################################################################################



-- ##################################################
PROMPT ;
PROMPT ----------------------------------------------;
PROMPT Tworzenie tabel;
PROMPT ----------------------------------------------;
PROMPT ;

-- Kolejnosc tworzenia jest istotna!
CREATE TABLE MIASTO 
(
  MIAK_1_ID INT NOT NULL 
, MIA_MIASTO VARCHAR2(100) NOT NULL
, MIA_WSPOLRZEDNE VARCHAR2(254) 
);
-- Tworzenie klucza glownego do tabeli wyzej
ALTER TABLE MIASTO
ADD CONSTRAINT CSR_PK_MIASTO
PRIMARY KEY (MIAK_1_ID);


CREATE TABLE UZYTKOWNICY 
(
  UZYK_1_ID INT NOT NULL 
, UZY_LOGIN VARCHAR2(20) NOT NULL 
, UZY_HASLO_HASH VARCHAR2(40) NOT NULL 
, UZY_STATUS CHAR(1) NOT NULL 
, UZY_CZY_ADMIN CHAR(1) NOT NULL 
, UZY_IMIE VARCHAR2(30) 
, UZY_PLEC CHAR(1) 
, UZY_DATA_URODZENIA DATE 
, UZY_EMAIL VARCHAR2(100) NOT NULL 
, UZY_DOLACZYL DATE NOT NULL 
, MIA_ID INT 
);
-- Tworzenie klucza glownego do tabeli wyzej
ALTER TABLE UZYTKOWNICY
ADD CONSTRAINT CSR_PK_UZYTKOWNICY
PRIMARY KEY (UZYK_1_ID);
-- Tworzenie kluczy obcych
ALTER TABLE UZYTKOWNICY ADD CONSTRAINT CSR_FK_UZY_MIA 
FOREIGN KEY (MIA_ID)
REFERENCES MIASTO (MIAK_1_ID) ENABLE;
-- Ustawiamy klucz unikatowy
ALTER TABLE UZYTKOWNICY ADD CONSTRAINT CSR_UQ_UZY_LOGIN  
UNIQUE (UZY_LOGIN);


CREATE TABLE SESJE_UZYTKOWNIKOW 
(
  SESK_1_ID INT NOT NULL 
, UZY_ID INT NOT NULL 
, SES_KLUCZ VARCHAR2(40) NOT NULL 
, SES_IP VARCHAR2(100) 
, SES_ZALOGOWANO DATE NOT NULL 
, SES_WAZNOSC DATE NOT NULL 
);
-- Tworzenie klucza glownego do tabeli wyzej
ALTER TABLE SESJE_UZYTKOWNIKOW
ADD CONSTRAINT CSR_PK_SESJE_UZYTKOWNIKOW
PRIMARY KEY (SESK_1_ID);
-- Tworzenie kluczy obcych
ALTER TABLE SESJE_UZYTKOWNIKOW ADD CONSTRAINT CSR_FK_SES_UZY 
FOREIGN KEY (UZY_ID)
REFERENCES UZYTKOWNICY (UZYK_1_ID) ENABLE;


--domy�lnie je�li jest to g��wna kategoria to nie b�dzie mie� nadrzednej, wtedy wartosc pola KAT_RODZIC_KATEGORII to NULL
CREATE TABLE KATEGORIE_KSIAZEK 
(
  KATK_1_ID INT NOT NULL 
, KAT_NAZWA VARCHAR2(150) NOT NULL 
, KAT_RODZIC_KATEGORII INT DEFAULT NULL 
);
-- Tworzenie klucza glownego do tabeli wyzej
ALTER TABLE KATEGORIE_KSIAZEK
ADD CONSTRAINT CSR_PK_KATEGORIE_KSIAZEK
PRIMARY KEY (KATK_1_ID);
-- Tworzenie kluczy obcych
ALTER TABLE KATEGORIE_KSIAZEK ADD CONSTRAINT CSR_FK_KAT_KAT 
FOREIGN KEY (KAT_RODZIC_KATEGORII)
REFERENCES KATEGORIE_KSIAZEK (KATK_1_ID) ENABLE;


-- rok smierci moze byc null poniewaz autor moze nadal zyc
CREATE TABLE AUTORZY 
(
  AUTK_1_ID INT NOT NULL 
, UZY_ID INT NOT NULL 
, AUT_IMIE VARCHAR2(100) NOT NULL 
, AUT_NAZWISKO VARCHAR2(150) NOT NULL 
, AUT_PSEUDONIM VARCHAR2(100) 
, AUT_ROK_URODZENIA DATE NOT NULL 
, AUT_ROK_SMIERCI DATE 
, AUT_BIOGRAFIA CLOB NOT NULL
, AUT_LICZBA_KSIAZEK INT DEFAULT 0  
);
-- Tworzenie klucza glownego do tabeli wyzej
ALTER TABLE AUTORZY
ADD CONSTRAINT CSR_PK_AUTORZY
PRIMARY KEY (AUTK_1_ID);
-- Tworzenie kluczy obcych
ALTER TABLE AUTORZY ADD CONSTRAINT CSR_FK_AUT_UZY 
FOREIGN KEY (UZY_ID)
REFERENCES UZYTKOWNICY (UZYK_1_ID) ENABLE;


CREATE TABLE KSIAZKI 
(
  KSIK_1_ID INT NOT NULL 
, UZY_ID INT NOT NULL 
, KAT_ID INT NOT NULL 
, KSI_TYTUL VARCHAR2(254) NOT NULL 
, KSI_DODANO DATE NOT NULL 
);
-- Tworzenie klucza glownego do tabeli wyzej
ALTER TABLE KSIAZKI
ADD CONSTRAINT CSR_PK_KSIAZKI
PRIMARY KEY (KSIK_1_ID);
-- Tworzenie kluczy obcych
ALTER TABLE KSIAZKI ADD CONSTRAINT CSR_FK1_KSI_KAT 
FOREIGN KEY (KAT_ID)
REFERENCES KATEGORIE_KSIAZEK (KATK_1_ID) ENABLE;
ALTER TABLE KSIAZKI ADD CONSTRAINT CSR_FK2_KSI_UZY 
FOREIGN KEY (UZY_ID)
REFERENCES UZYTKOWNICY (UZYK_1_ID) ENABLE;


CREATE TABLE CYTATY_Z_KSIAZEK 
(
  CYTK_1_ID INT NOT NULL 
, UZY_ID INT NOT NULL 
, KSI_ID INT NOT NULL 
, CYT_CYTAT CLOB NOT NULL 
, CYT_DODANO DATE NOT NULL 
);
-- Tworzenie klucza glownego do tabeli wyzej
ALTER TABLE CYTATY_Z_KSIAZEK
ADD CONSTRAINT CSR_PK_CYTATY_Z_KSIAZEK
PRIMARY KEY (CYTK_1_ID);
-- Tworzenie kluczy obcych
ALTER TABLE CYTATY_Z_KSIAZEK ADD CONSTRAINT CSR_FK1_CYT_KSI 
FOREIGN KEY (KSI_ID)
REFERENCES KSIAZKI (KSIK_1_ID) ENABLE;
ALTER TABLE CYTATY_Z_KSIAZEK ADD CONSTRAINT CSR_FK2_CYT_UZY 
FOREIGN KEY (UZY_ID)
REFERENCES UZYTKOWNICY (UZYK_1_ID) ENABLE;


CREATE TABLE OCENY_KSIAZEK 
(
  UZY_ID INT NOT NULL 
, KSI_ID INT NOT NULL 
, OCE_OCENA DECIMAL(10, 1) NOT NULL 
);
-- Tworzenie klucza glownego do tabeli wyzej
ALTER TABLE OCENY_KSIAZEK
ADD CONSTRAINT CSR_PK_OCENY_KSIAZEK
PRIMARY KEY (UZY_ID, KSI_ID);
-- Tworzenie kluczy obcych
ALTER TABLE OCENY_KSIAZEK ADD CONSTRAINT CSR_FK1_OCE_KSI 
FOREIGN KEY (KSI_ID)
REFERENCES KSIAZKI (KSIK_1_ID) ENABLE;
ALTER TABLE OCENY_KSIAZEK ADD CONSTRAINT CSR_FK2_OCE_UZY 
FOREIGN KEY (UZY_ID)
REFERENCES UZYTKOWNICY (UZYK_1_ID) ENABLE;


CREATE TABLE ULUBIONE_KSIAZKI 
(
  UZY_ID INT NOT NULL 
, KSI_ID INT NOT NULL 
, ULU_DODANO DATE NOT NULL 
);
-- Tworzenie klucza glownego do tabeli wyzej
ALTER TABLE ULUBIONE_KSIAZKI
ADD CONSTRAINT CSR_PK_ULUBIONE_KSIAZKI
PRIMARY KEY (UZY_ID, KSI_ID);
-- Tworzenie kluczy obcych
ALTER TABLE ULUBIONE_KSIAZKI ADD CONSTRAINT CSR_FK1_ULU_KSI 
FOREIGN KEY (KSI_ID)
REFERENCES KSIAZKI (KSIK_1_ID) ENABLE;
ALTER TABLE ULUBIONE_KSIAZKI ADD CONSTRAINT CSR_FK2_ULU_UZY 
FOREIGN KEY (UZY_ID)
REFERENCES UZYTKOWNICY (UZYK_1_ID) ENABLE;


CREATE TABLE AUK_AUTORZY_KSIAZKI 
(
  AUT_ID INT NOT NULL 
, KSI_ID INT NOT NULL 
);
-- Tworzenie klucza glownego do tabeli wyzej
ALTER TABLE AUK_AUTORZY_KSIAZKI 
ADD CONSTRAINT CSR_PK_AUK_AUTORZY_KSIAZKI 
PRIMARY KEY (AUT_ID, KSI_ID) ENABLE; 
-- Tworzenie kluczy obcych
ALTER TABLE AUK_AUTORZY_KSIAZKI ADD CONSTRAINT CSR_FK1_AUK_AUT 
FOREIGN KEY (AUT_ID) 
REFERENCES AUTORZY (AUTK_1_ID) ENABLE;
ALTER TABLE AUK_AUTORZY_KSIAZKI ADD CONSTRAINT CSR_FK2_AUK_KSI 
FOREIGN KEY (KSI_ID)
REFERENCES KSIAZKI (KSIK_1_ID) ENABLE;


CREATE TABLE ULA_ULUBIENI_AUTORZY 
(
  UZY_ID INT NOT NULL 
, AUT_ID INT NOT NULL 
, ULA_DODANO DATE NOT NULL 
);
-- Tworzenie klucza glownego do tabeli wyzej
ALTER TABLE ULA_ULUBIENI_AUTORZY
ADD CONSTRAINT CSR_PK_ULA_ULUBIENI_AUTORZY
PRIMARY KEY (UZY_ID, AUT_ID);
-- Tworzenie kluczy obcych
ALTER TABLE ULA_ULUBIENI_AUTORZY ADD CONSTRAINT CSR_FK1_ULA_AUT FOREIGN KEY (AUT_ID)
REFERENCES AUTORZY (AUTK_1_ID) ENABLE;
ALTER TABLE ULA_ULUBIENI_AUTORZY ADD CONSTRAINT CSR_FK2_ULA_UZY 
FOREIGN KEY (UZY_ID)
REFERENCES UZYTKOWNICY (UZYK_1_ID) ENABLE;


CREATE TABLE RECENZJE_KSIAZEK 
(
  RECK_1_ID INT NOT NULL 
, UZY_ID INT NOT NULL 
, KSI_ID INT NOT NULL 
, REC_TYTUL VARCHAR2(254) NOT NULL 
, REC_TRESC CLOB NOT NULL 
, REC_DODANO DATE NOT NULL 
);
-- Tworzenie klucza glownego do tabeli wyzej
ALTER TABLE RECENZJE_KSIAZEK
ADD CONSTRAINT CSR_PK_RECENZJE_KSIAZEK
PRIMARY KEY (RECK_1_ID);
-- Tworzenie kluczy obcych
ALTER TABLE RECENZJE_KSIAZEK ADD CONSTRAINT CSR_FK1_REC_KSI 
FOREIGN KEY (KSI_ID)
REFERENCES KSIAZKI (KSIK_1_ID) ENABLE;
ALTER TABLE RECENZJE_KSIAZEK ADD CONSTRAINT CSR_FK2_REC_UZY 
FOREIGN KEY (UZY_ID)
REFERENCES UZYTKOWNICY (UZYK_1_ID) ENABLE;


CREATE TABLE KOMENTARZE_DO_RECENZJI 
(
  KOMK_1_ID INT NOT NULL 
, REC_ID INT NOT NULL 
, UZY_ID INT NOT NULL 
, KOM_KOMENTARZ CLOB NOT NULL 
, KOM_DODANO DATE NOT NULL 
);
-- Tworzenie klucza glownego do tabeli wyzej
ALTER TABLE KOMENTARZE_DO_RECENZJI
ADD CONSTRAINT CSR_PK_KOMENTARZE_DO_RECENZJI
PRIMARY KEY (KOMK_1_ID);
-- Tworzenie kluczy obcych
ALTER TABLE KOMENTARZE_DO_RECENZJI ADD CONSTRAINT CSR_FK1_KOM_REC 
FOREIGN KEY (REC_ID)
REFERENCES RECENZJE_KSIAZEK (RECK_1_ID) ENABLE;
ALTER TABLE KOMENTARZE_DO_RECENZJI ADD CONSTRAINT CSR_FK2_KOM_UZY 
FOREIGN KEY (UZY_ID)
REFERENCES UZYTKOWNICY (UZYK_1_ID) ENABLE;


CREATE TABLE OPINIE_DO_KSIAZEK 
(
  OPIK_1_ID INT NOT NULL 
, UZY_ID INT NOT NULL 
, KSI_ID INT NOT NULL 
, OPI_TRESC CLOB NOT NULL 
, OPI_DODANO DATE NOT NULL 
);
-- Tworzenie klucza glownego do tabeli wyzej
ALTER TABLE OPINIE_DO_KSIAZEK
ADD CONSTRAINT CSR_PK_OPINIE_DO_KSIAZEK
PRIMARY KEY (OPIK_1_ID);
-- Tworzenie kluczy obcych
ALTER TABLE OPINIE_DO_KSIAZEK ADD CONSTRAINT CSR_FK1_OPI_KSI 
FOREIGN KEY (KSI_ID)
REFERENCES KSIAZKI (KSIK_1_ID) ENABLE;
ALTER TABLE OPINIE_DO_KSIAZEK ADD CONSTRAINT CSR_FK2_OPI_UZY 
FOREIGN KEY (UZY_ID)
REFERENCES UZYTKOWNICY (UZYK_1_ID) ENABLE;


CREATE TABLE WYDAWNICTWO 
(
  WYDK_1_ID INT NOT NULL 
, WYD_NAZWA_WYDAWNICTWA VARCHAR2(254) NOT NULL 
, MIA_ID INT NOT NULL 
, WYD_ULICA VARCHAR2(100) NOT NULL 
, WYD_TELEFON VARCHAR2(254) NOT NULL 
, WYD_EMAIL VARCHAR2(150) NOT NULL 
);
-- Tworzenie klucza glownego do tabeli wyzej
ALTER TABLE WYDAWNICTWO
ADD CONSTRAINT CSR_PK_WYDAWNICTWO
PRIMARY KEY (WYDK_1_ID);
-- Tworzenie kluczy obcych
ALTER TABLE WYDAWNICTWO ADD CONSTRAINT CSR_FK_WYD_MIA 
FOREIGN KEY (MIA_ID)
REFERENCES MIASTO (MIAK_1_ID) ENABLE;


CREATE TABLE WERSJA_WYDANIA 
(
  WERK_1_ID INT NOT NULL 
, WYD_ID INT NOT NULL 
, WER_OPIS CLOB NOT NULL 
, WER_ROK_WYDANIA DATE NOT NULL 
, WER_ISBN VARCHAR2(25) NOT NULL 
, WER_OKLADKA BLOB 
);
-- Tworzenie klucza glownego do tabeli wyzej
ALTER TABLE WERSJA_WYDANIA
ADD CONSTRAINT CSR_PK_WERSJA_WYDANIA
PRIMARY KEY (WERK_1_ID);
-- Tworzenie kluczy obcych
ALTER TABLE WERSJA_WYDANIA ADD CONSTRAINT CSR_FK_WER_WYD 
FOREIGN KEY (WYD_ID)
REFERENCES WYDAWNICTWO (WYDK_1_ID) ENABLE;


CREATE TABLE WERSJE_WYDANIA_KSIAZEK 
(
  KSI_ID INT NOT NULL 
, WER_ID INT NOT NULL 
, UZY_ID INT NOT NULL 
, WWK_DODANO DATE 
);
-- Tworzenie klucza glownego do tabeli wyzej
ALTER TABLE WERSJE_WYDANIA_KSIAZEK
ADD CONSTRAINT CSR_PK_WERSJA_WYDANIA_KSIAZKI
PRIMARY KEY (KSI_ID, WER_ID);
-- Tworzenie kluczy obcych
ALTER TABLE WERSJE_WYDANIA_KSIAZEK ADD CONSTRAINT CSR_FK1_WWK_KSI 
FOREIGN KEY (KSI_ID)
REFERENCES KSIAZKI (KSIK_1_ID) ENABLE;
ALTER TABLE WERSJE_WYDANIA_KSIAZEK ADD CONSTRAINT CSR_FK2_WWK_UZY 
FOREIGN KEY (UZY_ID)
REFERENCES UZYTKOWNICY (UZYK_1_ID) ENABLE;
ALTER TABLE WERSJE_WYDANIA_KSIAZEK ADD CONSTRAINT CSR_FK3_WWK_WER 
FOREIGN KEY (WER_ID)
REFERENCES WERSJA_WYDANIA (WERK_1_ID) ENABLE;



-- ####################################################################################################


COMMIT;