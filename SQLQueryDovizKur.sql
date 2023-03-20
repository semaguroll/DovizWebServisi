CREATE TABLE dbo.DovizKurlari
(
Id INT IDENTITY(1,1) PRIMARY KEY,
Tarih DATETIME,
Birim  varchar(50), 
KurAdi varchar(100) ,
ParaBirimi varchar(100),
DegerAlis float  ,
DegerSatis float,
EfektifAlis float,
EfektifSatis float
)
go
   sp_configure 'show advanced options' , 1
go
   Reconfigure with Override
go
   sp_configure 'Ole Automation Procedures' , 1
go
   Reconfigure with Override
go

 
CREATE PROC DovizKurbilgisi
AS
DECLARE @url AS VARCHAR (8000) ;
SET @url = 'https://www.tcmb.gov.tr/kurlar/today.xml' ;
DECLARE @OBJ AS INT ;
DECLARE @RESULT AS INT ;
EXEC @RESULT = sp_OACreate 'MSXML2.XMLHTTP', @OBJ OUT ;
EXEC @RESULT = sp_OAMethod @OBJ, 'open', NULL, 'GET', @url, false ;
EXEC @RESULT = sp_OAMethod @OBJ, send, NULL, '' ;
CREATE TABLE #XML
(STRXML VARCHAR (MAX)) ;
INSERT INTO #XML
(STRXML)
EXEC @RESULT = sp_OAGetProperty @OBJ, 'responseXML.xml' ;

DECLARE @XML AS XML ;
SELECT @XML = STRXML
FROM #XML ;
DROP TABLE #XML ;
DECLARE @HDOC AS INT ;
EXEC sp_xml_preparedocument @HDOC OUTPUT, @XML ;
DELETE FROM DovizKurlari
WHERE Tarih = CONVERT( DATE, GETDATE()) ;
INSERT INTO DovizKurlari
(
Tarih
, Birim
, KurAdi
, ParaBirimi
, DegerAlis
, DegerSatis
, EfektifAlis
, EfektifSatis)
SELECT CONVERT( DATE, GETDATE())
, *
FROM
OPENXML( @HDOC, 'Tarih_Date/Currency' )
WITH
(
Birim VARCHAR ( 50 ) 'Unit'
, KurAdi VARCHAR ( 100 ) 'Isim'
, ParaBirimi VARCHAR ( 100 ) 'CurrencyName'
, DegerAlis FLOAT 'ForexBuying'
, DegerSatis FLOAT 'ForexSelling'
, EfektifAlis FLOAT 'BanknoteBuying'
, EfektifSatis FLOAT 'BanknoteSelling') 

GO

ALTER PROC DovizKurbilgisi
AS
DECLARE @url AS VARCHAR (8000) ;
SET @url = 'https://www.tcmb.gov.tr/kurlar/today.xml' ;
DECLARE @OBJ AS INT ;
DECLARE @RESULT AS INT ;
EXEC @RESULT = sp_OACreate 'MSXML2.XMLHTTP', @OBJ OUT ;
EXEC @RESULT = sp_OAMethod @OBJ, 'open', NULL, 'GET', @url, false ;
EXEC @RESULT = sp_OAMethod @OBJ, send, NULL, '' ;
CREATE TABLE #XML
(STRXML VARCHAR (MAX)) ;
INSERT INTO #XML
(STRXML)
EXEC @RESULT = sp_OAGetProperty @OBJ, 'responseXML.xml' ;

DECLARE @XML AS XML ;
SELECT @XML = STRXML
FROM #XML ;
DROP TABLE #XML ;
DECLARE @HDOC AS INT ;
EXEC sp_xml_preparedocument @HDOC OUTPUT, @XML ;
DELETE FROM DovizKurlari
WHERE Tarih = CONVERT( DATE, GETDATE()) ;
INSERT INTO DovizKurlari
(

Tarih
, Birim
, KurAdi
, ParaBirimi
, DegerAlis
, DegerSatis
, EfektifAlis
, EfektifSatis)
SELECT GETDATE()
, *
FROM
OPENXML( @HDOC, 'Tarih_Date/Currency' )
WITH
(Birim VARCHAR ( 50 ) 'Unit'
, KurAdi VARCHAR ( 100 ) 'Isim'
, ParaBirimi VARCHAR ( 100 ) 'CurrencyName'
, DegerAlis FLOAT 'ForexBuying'
, DegerSatis FLOAT 'ForexSelling'
, EfektifAlis FLOAT 'BanknoteBuying'
, EfektifSatis FLOAT 'BanknoteSelling') ;

 EXEC DovizKurbilgisi
 
 SELECT * FROM dbo.DovizKurlari