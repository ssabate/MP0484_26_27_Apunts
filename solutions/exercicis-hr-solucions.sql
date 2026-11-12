-- Solucions dels nous exercicis d'Oracle SQL amb l'esquema de mostra HR.
-- Aquest fitxer no forma part de la pàgina de lliçó.
-- Les consultes assumeixen que l'usuari té accés a les taules HR.

-- 11. Codis de país presents a COUNTRIES o a LOCATIONS, sense duplicats.
SELECT country_id AS codi_pais
FROM countries
UNION
SELECT country_id
FROM locations
ORDER BY codi_pais;

-- 12. Noms d'empleat i de departament, conservant totes les files.
SELECT 'Empleat' AS tipus, first_name AS nom
FROM employees
UNION ALL
SELECT 'Departament', department_name
FROM departments
ORDER BY tipus, nom;

-- 13. Departaments que no tenen cap empleat assignat.
SELECT department_id
FROM departments
MINUS
SELECT department_id
FROM employees
WHERE department_id IS NOT NULL
ORDER BY department_id;

-- 14. Nom complet en majúscules i nombre de caràcters.
SELECT UPPER(first_name || ' ' || last_name) AS nom_complet,
       LENGTH(first_name || ' ' || last_name) AS longitud
FROM employees
ORDER BY last_name, first_name;

-- 15. Sou arrodonit a centenars, del més alt al més baix.
SELECT first_name,
       last_name,
       ROUND(salary, -2) AS sou_arrodonit
FROM employees
ORDER BY sou_arrodonit DESC, last_name;

-- 16. Salari mitjà per departament amb empleats, amb dues xifres decimals.
SELECT d.department_name,
       ROUND(AVG(e.salary), 2) AS salari_mitja
FROM departments d
JOIN employees e
  ON e.department_id = d.department_id
GROUP BY d.department_id, d.department_name
ORDER BY salari_mitja DESC, d.department_name;

-- 17. Contractacions durant 1998. El filtre deixa HIRE_DATE sense funcions.
SELECT first_name,
       last_name,
       TO_CHAR(hire_date, 'DD/MM/YYYY') AS data_contractacio
FROM employees
WHERE hire_date >= DATE '1998-01-01'
  AND hire_date < DATE '1999-01-01'
ORDER BY hire_date, employee_id;

-- 18. Mesos entre la data d'avui i l'últim dia del mes actual.
SELECT MONTHS_BETWEEN(LAST_DAY(SYSDATE), SYSDATE) AS mesos_fins_final_de_mes
FROM dual;
