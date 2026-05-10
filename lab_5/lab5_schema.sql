-- Очищення попередніх таблиць перед створенням нової нормалізованої схеми
DROP TABLE IF EXISTS prescriptions CASCADE;
DROP TABLE IF EXISTS diagnoses CASCADE;
DROP TABLE IF EXISTS appointments CASCADE;
DROP TABLE IF EXISTS doctors CASCADE;
DROP TABLE IF EXISTS patients CASCADE;

-- СХЕМА В 3NF

CREATE TABLE patients (
    patient_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    surname VARCHAR(100) NOT NULL,
    birth_date DATE NOT NULL,
    phone VARCHAR(20) UNIQUE,
    address TEXT,
    email VARCHAR(100) UNIQUE
);

CREATE TABLE doctors (
    doctor_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    surname VARCHAR(100) NOT NULL,
    specialization VARCHAR(100) NOT NULL,
    phone VARCHAR(20) UNIQUE,
    room_number VARCHAR(10)
);

CREATE TABLE appointments (
    appointment_id SERIAL PRIMARY KEY,
    date DATE NOT NULL,
    time TIME NOT NULL,
    reason TEXT,
    patient_id INTEGER REFERENCES patients(patient_id),
    doctor_id INTEGER REFERENCES doctors(doctor_id)
);

CREATE TABLE diagnoses (
    diagnosis_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    date DATE NOT NULL DEFAULT CURRENT_DATE,
    appointment_id INTEGER REFERENCES appointments(appointment_id)
);

CREATE TABLE prescriptions (
    prescription_id SERIAL PRIMARY KEY,
    medicine VARCHAR(255) NOT NULL,
    dosage VARCHAR(100),
    duration VARCHAR(100),
    notes TEXT,
    diagnosis_id INTEGER REFERENCES diagnoses(diagnosis_id)
);