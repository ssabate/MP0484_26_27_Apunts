---
layout: default
title: Oracle SQL · Combinacions i funcions
hero_title: Combina dades. Descobreix funcions.
description: Lliçó pràctica en català sobre operacions de conjunts, funcions d'Oracle SQL i l'esquema HR.
---

### En aquesta lliçó

- [Operacions de conjunts](#combinacions)
- [Funcions predefinides](#funcions)
- [Funcions numèriques](#numeriques)
- [Funcions de caràcter](#caracters)
- [Dates i conversió](#dates)
- [Funcions d’agregació](#agregacio)
- [Esquema de recursos humans](#esquema-hr)
- [Exercicis](#exercicis)

> **Una idea clau.** Practica les consultes a Oracle amb l’esquema HR abans de comparar els resultats.

## 1. Operacions de conjunts {#combinacions}

### Una consulta, més d’una font

Les operacions de conjunts combinen els resultats de dues consultes compatibles. Cada consulta ha de retornar el mateix nombre de columnes i els tipus corresponents han de ser compatibles, posició per posició.

| Operació | Resultat |
| --- | --- |
| `UNION` | Uneix les files i n’elimina els duplicats. |
| `UNION ALL` | Uneix les files i conserva els duplicats. |
| `INTERSECT` | Retorna les files comunes als dos resultats. |
| `MINUS` | Retorna les files de la primera consulta que no són a la segona. |

> **Compatibilitat i ordre.** El nom de les columnes de sortida prové de la primera consulta. No confiïs en l’ordre natural del resultat: si necessites ordenar-lo, afegeix un únic `ORDER BY` al final de tota l’operació.

### Exemple · noms d’empleats i departaments · `UNION`

```sql
SELECT nom
FROM emp
UNION
SELECT nom_dept
FROM dept
ORDER BY nom;
```

Les dues consultes retornen una columna de text. Els valors repetits només apareixen una vegada.

### Conserva les repeticions · `UNION ALL`

```sql
SELECT nom FROM emp
UNION ALL
SELECT nom FROM emp;
```

Amb cinc files a `EMP`, aquesta consulta retorna deu files. No aplica eliminació de duplicats.

### Valors compartits · `INTERSECT`

```sql
SELECT num_dept FROM emp
INTERSECT
SELECT num_dept FROM dept;
```

En l’exemple docent, retorna els departaments 10, 20, 30 i 40 presents als dos conjunts.

### Exemple · diferència entre resultats · `MINUS`

```sql
SELECT num_dept
FROM emp
MINUS
SELECT comissio
FROM emp;
```

Exemple original del material: en les dades de mostra, el resultat és 20, 30 i 40. És una comparació didàctica entre dos conjunts numèrics.

## 2. Funcions integrades {#funcions}

### Transforma una dada en un resultat

Una funció rep arguments i retorna un valor d’un tipus determinat. Pot actuar sobre una columna, un valor literal o, en alguns casos, no necessitar cap argument (com `SYSDATE`).

1. **Entrada:** una expressió o un valor compatible amb la funció.
2. **Transformació:** una operació numèrica, textual, temporal o d’agregació.
3. **Retorn:** un valor que es pot mostrar, comparar o combinar.

> **Compte amb `NULL` i els tipus.** Moltes funcions escalares retornen `NULL` si reben `NULL`, però no totes: les agregacions ignoren els nuls i `COUNT(*)` compta totes les files. Oracle pot convertir alguns tipus automàticament; és més segur indicar el format amb funcions com `TO_DATE` o `TO_NUMBER`.

## 3. Funcions numèriques {#numeriques}

Operacions habituals per calcular, arrodonir i comparar valors numèrics.

### Funcions numèriques d’Oracle SQL

| Funció | Què fa | Exemple |
| --- | --- | --- |
| `ABS(n)` | Retorna el valor absolut. | `ABS(-12)` → `12` |
| `CEIL(n)` | Enter més petit que és més gran o igual que `n`. | `CEIL(11.7)` → `12` |
| `FLOOR(n)` | Enter més gran que és més petit o igual que `n`. | `FLOOR(12.7)` → `12` |
| `SIN(n)`, `COS(n)` | Retornen sinus i cosinus; l’angle s’expressa en radians. | `COS(3.14159265359)` → `-1` |
| `EXP(n)` | Eleva el nombre *e* a `n`. | `EXP(1)` → aproximadament `2.71828` |
| `LN(n)` | Logaritme neperià de `n`. | `LN(2.71828183)` → aproximadament `1` |
| `LOG(m, n)` | Logaritme de `n` en base `m`. | `LOG(10, 100)` → `2` |
| `MOD(m, n)` | Resta de dividir `m` entre `n`. Si `n = 0`, retorna `m`. | `MOD(4, 3)` → `1` |
| `POWER(m, n)` | Eleva `m` a `n`. | `POWER(10, 2)` → `100` |
| `ROUND(m[, n])` | Arrodoneix a `n` decimals; si s’omet, arrodoneix a un enter. | `ROUND(15.193, 1)` → `15.2` |
| `SIGN(n)` | Retorna `-1`, `0` o `1` segons el signe. | `SIGN(-2)` → `-1` |
| `SQRT(n)` | Arrel quadrada. | `SQRT(100)` → `10` |
| `TRUNC(m[, n])` | Trunca a `n` decimals; si s’omet, trunca a un enter. | `TRUNC(14.79, 1)` → `14.7` |

### Arrodonir o truncar · `ROUND` i `TRUNC`

```sql
SELECT ROUND(14.79, 1) AS arrodonit,
       TRUNC(14.79, 1) AS truncat
FROM dual;
```

Resultat: `14.8` i `14.7`. `DUAL` és una taula especial d’una sola fila, útil per a expressions.

## 4. Funcions de caràcter {#caracters}

Algunes funcions retornen cadenes i d’altres retornen informació numèrica sobre una cadena.

### Funcions de caràcter que retornen caràcters

| Funció | Què fa | Exemple |
| --- | --- | --- |
| `CHR(n)` | Retorna el caràcter corresponent al codi numèric del joc de caràcters de la base de dades. | `CHR(65)` → `A` (en un joc compatible amb ASCII) |
| `CONCAT(a, b)` | Concatena dues cadenes. Per a més parts, també es pot fer servir `||`. | `CONCAT('Santi ', 'Sabaté')` |
| `LOWER(a)` | Converteix la cadena a minúscules. | `LOWER('SANTI')` → `santi` |
| `UPPER(a)` | Converteix la cadena a majúscules. | `UPPER('Black and Blue')` → `BLACK AND BLUE` |
| `INITCAP(a)` | Posa en majúscula la inicial de cada paraula i la resta en minúscula. | `INITCAP('SANTI SABATÉ')` → `Santi Sabaté` |
| `LPAD(a, n, b)`, `RPAD(a, n, b)` | Completen fins a `n` caràcters afegint `b` a l’esquerra o a la dreta. | `LPAD('a.', 8, '*-')` |
| `LTRIM(a, b)`, `RTRIM(a, b)` | Eliminen de l’esquerra o la dreta els caràcters inicials que pertanyen al conjunt `b`. | `LTRIM('xyxSanti', 'xy')` → `Santi` |
| `REPLACE(a, b, c)` | Substitueix a `a` cada aparició de `b` per `c`. | `REPLACE('Jack and Jue', 'J', 'Bl')` → `Black and Blue` |
| `SUBSTR(a, n, m)` | Extreu `m` caràcters a partir de la posició `n` (comptant des d’1). | `SUBSTR('Santi Sabaté', 7, 6)` → `Sabaté` |
| `TRANSLATE(a, b, c)` | Canvia cada caràcter de `b` pel caràcter de la mateixa posició a `c`; els caràcters de `b` sense correspondència s’eliminen. | `TRANSLATE('2a3b11c', '123abc', 'XYZ')` → `YZXX` |

### Funcions de caràcter que retornen números

| Funció | Què fa | Exemple |
| --- | --- | --- |
| `ASCII(c)` | Retorna el valor numèric del primer caràcter segons el joc de caràcters de la base de dades. | `ASCII('A')` → `65` en un joc compatible amb ASCII |
| `INSTR(a, b[, n[, m]])` | Busca la m-èsima aparició de `b` dins d’`a`, començant a `n`, i retorna la posició. | `INSTR('CORPORATE FLOOR', 'OR', 3, 2)` → `14` |
| `LENGTH(a)` | Retorna la longitud de la cadena en caràcters. | `LENGTH('Black and Blue')` → `14` |

## 5. Dates, formats i conversió {#dates}

### Dona forma a les dates

Les dates d’Oracle poden contenir dia i hora. Els formats permeten interpretar textos com a dates i presentar dates o nombres de manera llegible.

> **Tipus de dades de referència.** `VARCHAR2(n)` emmagatzema cadenes de fins a `n` caràcters (fins a 4.000 bytes en la configuració estàndard indicada al material original), per exemple `VARCHAR2(8)`. `NUMBER(p,s)` defineix precisió i escala: `p` va d’1 a 38 i `s`, de −84 a 127; per exemple, `NUMBER(5,2)` pot representar `365.36`. `DATE` emmagatzema data i hora, des de l’any 4712 aC fins al 9999 dC; una data literal portable és `DATE '2003-11-10'`.

### Elements habituals dels formats de data

| Element | Significat |
| --- | --- |
| `HH`, `HH12` | Hora en format de 12 hores (1–12). |
| `HH24` | Hora en format de 24 hores (0–23). |
| `MI` | Minuts (0–59). |
| `DD` | Dia del mes (1–31, segons el mes). |
| `D` | Dia de la setmana (el número depèn de la configuració territorial). |
| `MM` | Mes numèric (1–12). |
| `MON`, `MONTH` | Nom abreujat o complet del mes, segons l’idioma de sessió. `MONTH` pot completar-se amb espais; `FMMonth` els elimina. |
| `YY`, `YYYY` | Any amb dos o quatre dígits. |

### Elements habituals dels formats numèrics

| Element | Significat |
| --- | --- |
| `9` | Dígit opcional del 0 al 9. |
| `0` | Dígit obligatori; mostra zeros inicials o decimals. |
| `MI`, `S` | Mostren el signe negatiu al final o el signe positiu/negatiu, respectivament. |
| `G`, `D` | Separadors de grups i decimals segons la configuració NLS de la sessió. |
| `L` | Símbol de moneda local, segons la configuració NLS. |
| `.`, `,` | Caràcters literals de punt i coma en la màscara de format. |

### Conversions explícites · `TO_CHAR`, `TO_DATE` i `TO_NUMBER`

```sql
SELECT TO_CHAR(hire_date, 'DD/MM/YYYY') AS data_text,
       TO_DATE('10/11/2003', 'DD/MM/YYYY') AS data_valor,
       TO_NUMBER('100,00', '999D99',
                 'NLS_NUMERIC_CHARACTERS='',.''') AS nombre
FROM employees
WHERE employee_id = 100;
```

`TO_CHAR` també pot formatar nombres, per exemple `TO_CHAR(-10000, 'L99G999D99MI')`; el resultat depèn de la configuració monetària i numèrica de la sessió.

### Funcions de data més utilitzades

| Funció | Què fa | Exemple |
| --- | --- | --- |
| `SYSDATE` | Data i hora del sistema de la base de dades. | `SELECT SYSDATE FROM dual` |
| `ADD_MONTHS(d, n)` | Afegeix `n` mesos a una data. | `ADD_MONTHS(DATE '2003-11-12', 3)` |
| `MONTHS_BETWEEN(d, e)` | Retorna els mesos entre dues dates; pot incloure una fracció. | `MONTHS_BETWEEN(DATE '2004-02-01', DATE '2003-11-01')` |
| `LAST_DAY(d)` | Últim dia del mes de la data indicada. | `LAST_DAY(DATE '2004-02-01')` → 29/02/2004 |
| `NEXT_DAY(d, c)` | Data del següent dia de la setmana indicat; el nom depèn de l’idioma de sessió. | `NEXT_DAY(SYSDATE, 'MONDAY')` |

## 6. Funcions d’agregació {#agregacio}

### Agrega un grup de files

Les funcions d’agregació calculen un resultat a partir d’un conjunt de valors d’una columna. A diferència de les funcions escalars, el resultat resumeix diverses files.

| Funció | Què fa | Exemple |
| --- | --- | --- |
| `AVG(col)` | Mitjana dels valors numèrics no nuls. Admet `DISTINCT` o `ALL` (per defecte). | `AVG(DISTINCT salary)` |
| `COUNT(col)` | Compta els valors no nuls. Amb `DISTINCT`, només els valors diferents. | `COUNT(commission_pct)` |
| `COUNT(*)` | Compta totes les files, incloses les que tenen valors nuls o duplicats. | `COUNT(*)` |
| `MAX(col)`, `MIN(col)` | Valor màxim o mínim. També funcionen amb dades ordenables de caràcter o data. | `MAX(hire_date)` |
| `SUM(col)` | Suma els valors numèrics no nuls. Admet `DISTINCT` o `ALL`. | `SUM(salary)` |

> **Valors nuls.** `AVG`, `SUM`, `MIN` i `MAX` ignoren els nuls i retornen `NULL` si no hi ha cap valor no nul. `COUNT(col)` no compta els nuls; `COUNT(*)` compta les files.

### Resum de sous a l’esquema HR · agregacions

```sql
SELECT MAX(salary) AS sou_maxim,
       MIN(salary) AS sou_minim,
       AVG(salary) AS sou_mitja,
       SUM(salary) AS suma_sous
FROM employees;
```

Per comptar les comissions no informades, fes servir `COUNT(*)` amb el filtre `commission_pct IS NULL`.

Resultats dels exemples originals amb la taula `EMP` didàctica de cinc files:

| Consulta de mostra | Resultat | Què il·lustra |
| --- | --- | --- |
| `AVG(salari)` | `1220` | Mitjana de tots els salaris no nuls. |
| `AVG(DISTINCT salari)` | `1275` | Mitjana dels salaris diferents. |
| `COUNT(salari)` / `COUNT(DISTINCT salari)` | `5` / `4` | Valors no nuls i valors diferents. |
| `COUNT(*)` | `5` | Totes les files de la taula. |
| `MAX(comissio)` / `MIN(comissio)` | `10` / `0` | Extrems de la columna de comissió. |
| `SUM(salari)` / `SUM(DISTINCT salari)` | `6100` / `5100` | Suma amb i sense duplicats. |

## 7. Esquema de recursos humans · HR {#esquema-hr}

### Recursos humans · HR

Les consultes i els exercicis fan servir les taules de mostra d’Oracle HR. Les dades concretes poden variar segons la versió i la instal·lació; els noms de taula i de columna són la referència principal.

Relacions principals: `REGIONS` → `COUNTRIES` → `LOCATIONS` → `DEPARTMENTS` → `EMPLOYEES`; `JOBS` → `EMPLOYEES`; `EMPLOYEES` → `JOB_HISTORY`.

### Taules i columnes de l’esquema HR

| Taula | Columnes principals | Ús |
| --- | --- | --- |
| `REGIONS` | `REGION_ID` (NUMBER), `REGION_NAME` (VARCHAR2) | Regions geogràfiques. Exemples: Europe, Americas, Asia. |
| `COUNTRIES` | `COUNTRY_ID` (CHAR), `COUNTRY_NAME` (VARCHAR2), `REGION_ID` (NUMBER) | Països vinculats a una regió. |
| `LOCATIONS` | `LOCATION_ID` (NUMBER), `STREET_ADDRESS`, `POSTAL_CODE`, `CITY`, `STATE_PROVINCE` (VARCHAR2), `COUNTRY_ID` (CHAR) | Adreces i localitats. Exemples de ciutat: Roma, Tokyo, Seattle, Toronto, London. |
| `DEPARTMENTS` | `DEPARTMENT_ID` (NUMBER), `DEPARTMENT_NAME` (VARCHAR2), `MANAGER_ID` (NUMBER), `LOCATION_ID` (NUMBER) | Departaments com Administration, Marketing, Sales, IT i Finance. |
| `EMPLOYEES` | `EMPLOYEE_ID` (NUMBER), `FIRST_NAME`, `LAST_NAME`, `EMAIL`, `PHONE_NUMBER` (VARCHAR2), `HIRE_DATE` (DATE), `JOB_ID` (VARCHAR2), `SALARY`, `COMMISSION_PCT`, `MANAGER_ID`, `DEPARTMENT_ID` (NUMBER) | Empleats, contractes, sous, responsables i comissions. El material original indica 107 empleats a la seva mostra. |
| `JOBS` | `JOB_ID` (VARCHAR2), `JOB_TITLE` (VARCHAR2), `MIN_SALARY`, `MAX_SALARY` (NUMBER) | Catàleg d’ocupacions i rang salarial. |
| `JOB_HISTORY` | `EMPLOYEE_ID`, `DEPARTMENT_ID` (NUMBER), `START_DATE`, `END_DATE` (DATE), `JOB_ID` (VARCHAR2) | Historial de llocs de treball i departaments de cada empleat. |

### Exemples de regions i països

**Exemples de regions:** Europe, Americas, Asia, Middle East and Africa.  
**Exemples de països (països de mostra):** AR Argentina, AU Australia, BE Belgium, BR Brazil, CA Canada, CH Switzerland, CN China, DE Germany, DK Denmark, EG Egypt, FR France, HK Hong Kong, IL Israel, IN India, IT Italy, JP Japan, KW Kuwait, MX Mexico, NG Nigeria, NL Netherlands, SG Singapore, UK United Kingdom, US United States of America, ZM Zambia i ZW Zimbabwe.  

### Exemples de `JOB_ID`

**Exemples de `JOB_ID`:** `AD_PRES` President, `AD_VP` Administration Vice President, `AD_ASST` Administration Assistant, `FI_MGR` Finance Manager, `FI_ACCOUNT` Accountant, `AC_MGR` Accounting Manager, `AC_ACCOUNT` Public Accountant, `SA_MAN` Sales Manager, `SA_REP` Sales Representative, `PU_MAN` Purchasing Manager, `PU_CLERK` Purchasing Clerk, `ST_MAN` Stock Manager, `ST_CLERK` Stock Clerk, `SH_CLERK` Shipping Clerk, `IT_PROG` Programmer, `MK_MAN` Marketing Manager, `MK_REP` Marketing Representative, `HR_REP` Human Resources Representative, `PR_REP` Public Relations Representative.

### Exemple · compta empleats per departament · HR

```sql
SELECT department_id, COUNT(*) AS nombre_empleats
FROM employees
GROUP BY department_id
ORDER BY department_id;
```

Els departaments sense empleats no apareixen en aquesta consulta, perquè l’agregació parteix de les files d’`EMPLOYEES`.

## 8. Exercicis {#exercicis}

Resol primer els exercicis sense consultar cap solució. Els deu primers reprodueixen les propostes del material original, amb els noms de taula de l’esquema HR quan escau. Després tens una nova sèrie de pràctica.

### A. Combinacions i funcions · sèrie original

*10 exercicis del document de referència.*

1. Mostra `FIRST_NAME` de cada empleat i el text «comença per vocal» si el nom comença per vocal; altrament, «comença per consonant». Ordena pel text de manera ascendent i pel nom de manera descendent. Conserva els repetits.
2. Modifica la consulta anterior perquè no es repeteixin els noms.
3. Fes la intersecció entre `DEPARTMENT_ID` de `DEPARTMENTS` i `MANAGER_ID` de `EMPLOYEES`. Quina informació aporta el resultat?
4. Obté els identificadors (`EMPLOYEE_ID`) dels empleats que no tenen historial a `JOB_HISTORY`.
5. Mostra el nom i cognom dels empleats (`FIRST_NAME` i `LAST_NAME`) el salari dels quals, dividit per 100, és parell.
6. Mostra els noms dels departaments amb la primera lletra en minúscula i la resta en majúscules.
7. Obté l’identificador dels empleats que han treballat en un mateix lloc durant més de 12 mesos, segons el seu historial d’ocupacions.
8. Mostra el nom i la data de contractació dels empleats amb el format dia, mes i any (per exemple, 17 juny 1987). Fes que el resultat no depengui de l’idioma de sessió.
9. Compta quants empleats tenen la comissió (`COMMISSION_PCT`) nul·la.
10. Construeix un resultat de quatre files: sou màxim, sou mínim, mitjana dels sous i suma dels sous dels empleats.

### B. Nous reptes · esquema HR

*Aplica les operacions de conjunts i les funcions.*

11. Mostra en una sola columna els codis de país que apareixen a `COUNTRIES` o a `LOCATIONS`. Cada codi hi ha d’aparèixer una sola vegada i el resultat ha d’estar ordenat.
12. Mostra, amb una única consulta, els noms d’empleat duplicats i els noms de departament, conservant totes les files. Etiqueta cada fila amb «Empleat» o «Departament».
13. Obté els identificadors de departament que existeixen a `DEPARTMENTS` però no tenen cap empleat assignat.
14. Mostra per a cada empleat el nom complet en majúscules i el nombre de caràcters del nom complet. Separa el nom i el cognom amb un espai.
15. Mostra el nom de cada empleat i el sou arrodonit a centenars. Ordena de sou arrodonit més alt a més baix i, en cas d’empat, pel cognom.
16. Mostra, per a cada departament, el nom i el salari mitjà amb dues xifres decimals. Inclou només departaments amb empleats i ordena de mitjana més alta a més baixa.
17. Mostra els empleats contractats durant l’any 1998, amb la data en format `DD/MM/YYYY`. Evita aplicar una funció a `HIRE_DATE` dins del filtre.
18. Mostra quants mesos, incloses les fraccions, hi ha des d’avui fins a l’últim dia del mes actual. Fes servir funcions de data i presenta el resultat com a valor numèric.

> **Solucions per a docents i autocorrecció.** Les solucions dels nous exercicis són en un fitxer SQL independent i no es mostren en aquesta pàgina: <a href="solutions/exercicis-hr-solucions.sql" download>descarrega el fitxer de solucions</a>.

---

*Fi de la lliçó · Una consulta clara comença per una bona pregunta.*
