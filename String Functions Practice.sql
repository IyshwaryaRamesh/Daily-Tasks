USE DDL;

select CHARINDEX('y','Iyshwarya') as "Index"
select char(65) as "Character"
select concat('Iyshwarya ','Ramesh') as "Concat"
select DATALENGTH('Iyshwarya') as "Data Length"
select DIFFERENCE('Smith','Smyth') as "Soundex"
DECLARE @d DATETIME = '2003/10/29';
SELECT FORMAT (@d, 'd', 'en-US') AS 'US English Result',
               FORMAT (@d, 'd', 'no') AS 'Norwegian Result',
               FORMAT (@d, 'd', 'zu') AS 'Zulu Result'; 
select LEFT('San03',3) as "Left Value"; 
select LTRIM('        Iyshwarya') as "LEFT TRIM"
select nchar(65)  as "Unicode Number"
select PATINDEX('%Iysh%','Iyshwarya') as 'Pattern Index'; 
select QUOTENAME('python') as "QuoteName";
select REPLACE('Iyshwarya','y','s') as "Replace String"
select REPLICATE('IysSan',5) as "Replicate";
select reverse('Iysh') as "Reverse String";

select right('m,sach dgw,VHzdsf,hsjkra',5) as "Right";
select rtrim('zd,jsbvfugky dzs          ') as "Right Trim"
select soundex('JUICY'),soundex('Jucy') as "Soundex" --doubt
select SUBSTRING('udbgkyde8',4,3) as "SubString";
select upper(LAST_NAME) "UpperCase" from dbo.MY_EMPLOYEES;
select trim('      iysh       ') as "Trim"