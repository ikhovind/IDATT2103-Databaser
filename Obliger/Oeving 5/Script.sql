#Øving 5a Transaksjoner oppgave 1
SET SESSION TRANSACTION LEVEL READ UNCOMMITTED ;
START TRANSACTION;
SELECT * FROM konto WHERE kontonr = 1;
UPDATE konto SET saldo = 1 where kontonr = 1;
commit;