--1. Zjistěte jestli se nám u zákazníků neopakuje emailová adresa a pokud ano vyberte ty adresy, které jsou v databázi vícekrát.
--vyberu vsechny emaily
SELECT
IDZakaznik, jmeno, prijmeni, email
FROM
ZDA.Zakaznik
--vyberu duplicity
SELECT
COUNT(email)PocetOpakovani,email
FROM(SELECT
IDZakaznik, jmeno, prijmeni, email
FROM
ZDA.Zakaznik)
GROUP BY
email
HAVING
COUNT(email) > 1
ORDER BY
COUNT(email)DESC;

--kontrola
SELECT
email
FROM
ZDA.Zakaznik
WHERE
email LIKE 'beata.kriz%'

--2. Jaké prodejny mají prodejní plochu menší než 200.
SELECT
IDProdejna, nazev, plocha
FROM
ZDA.Prodejna
WHERE
plocha < 200
ORDER BY
plocha DESC;

--3. Najděte zaměstnance, kteří mají v měsíci červenci narozeniny a zjistěte kolik jich pracuje na které prodejně. Zajímají nás jen aktuální zaměstnanci.(SELECT
/*V první části dotazu vidím zaměstnance, kteří slaví narozeniny v červenci a jejich zařazení na prodejnu*/
SELECT
datumNarozeni, jmeno, prijmeni,IDProdejna
FROM
ZDA.Zamestnanec
WHERE
datumOdchodu IS NULL AND
TO_CHAR(datumNarozeni, 'MM') = 7
ORDER BY
IDProdejna DESC;

/*Ve druhé části dotazu vidím kolik zaměstnanců, s narozeninami v červenci, na prodejně pracuje*/
SELECT
IDProdejna, COUNT(IDProdejna) AS PocetZamestnancuNaProdejne
FROM
ZDA.Zamestnanec
WHERE
datumOdchodu IS NULL AND
TO_CHAR(datumNarozeni, 'MM') = 7
GROUP BY
IDProdejna
ORDER BY
IDProdejna DESC;

/*Pokus o spojení do jednoho selectu*/
SELECT
COUNT(IDProdejna)AS PocetZamestnancu, IDProdejna
FROM
(SELECT
datumNarozeni, jmeno, prijmeni,IDProdejna
FROM
ZDA.Zamestnanec
WHERE
datumOdchodu IS NULL AND
TO_CHAR(datumNarozeni, 'MM') = 7
ORDER BY
IDProdejna DESC)
GROUP BY
IDProdejna
ORDER BY
IDProdejna DESC;
