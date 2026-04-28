
--  Агрегатні функції, GROUP BY та HAVING

-- 1. Загальна кількість лікарів у клініці
SELECT COUNT(*) AS total_doctors FROM doctors;

-- 2. Остання дата записаного прийому
SELECT MAX(date) AS latest_appointment FROM appointments;

-- 3. Кількість прийомів у кожного лікаря
SELECT doctor_id, COUNT(*) AS appointment_count 
FROM appointments 
GROUP BY doctor_id;

-- 4. Лікарі, у яких більше одного прийому
SELECT doctor_id, COUNT(*) AS appointment_count 
FROM appointments 
GROUP BY doctor_id 
HAVING COUNT(*) > 1;


-- Об'єднання таблиць (JOINs)
-- 
-- 5. INNER JOIN: Розклад прийомів (Ім'я пацієнта, спеціалізація лікаря, час)
SELECT p.surname AS patient, d.specialization AS doctor, a.date, a.time
FROM appointments a
INNER JOIN patients p ON a.patient_id = p.patient_id
INNER JOIN doctors d ON a.doctor_id = d.doctor_id;

-- 6. LEFT JOIN: Всі пацієнти та їхні прийоми (навіть якщо вони ще не записані)
SELECT p.surname, a.date, a.reason
FROM patients p
LEFT JOIN appointments a ON p.patient_id = a.patient_id;

-- 7. RIGHT JOIN: Всі лікарі та їхні пацієнти
SELECT d.surname AS doctor, a.date
FROM appointments a
RIGHT JOIN doctors d ON a.doctor_id = d.doctor_id;


--  Підзапити (Subqueries)

-- 8. Підзапит у WHERE: Знайти пацієнтів, яким ставили діагноз "Гіпертонія"
SELECT name, surname FROM patients 
WHERE patient_id IN (
    SELECT patient_id FROM appointments 
    WHERE appointment_id IN (
        SELECT appointment_id FROM diagnoses WHERE name = 'Гіпертонія'
    )
);

-- 9. Підзапит у SELECT: Вивести лікарів та кількість їхніх прийомів
SELECT surname, specialization, 
       (SELECT COUNT(*) FROM appointments a WHERE a.doctor_id = d.doctor_id) AS total_visits 
FROM doctors d;

-- 10. Підзапит з HAVING: Знайти ID прийомів, до яких виписано рецепти
SELECT appointment_id FROM diagnoses 
WHERE diagnosis_id IN (
    SELECT diagnosis_id FROM prescriptions 
    GROUP BY diagnosis_id 
    HAVING COUNT(*) >= 1
);
