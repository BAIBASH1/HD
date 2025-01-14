-- 1. Типы оборудования
CREATE TABLE EquipmentType (
    equipment_type_id SERIAL PRIMARY KEY,
    type_name VARCHAR(100) NOT NULL,
    description TEXT
);

-- 2. Оборудование
CREATE TABLE Equipment (
    equipment_id SERIAL PRIMARY KEY,
    equipment_type_id INT NOT NULL REFERENCES EquipmentType(equipment_type_id),
    brand VARCHAR(100) NOT NULL,
    model VARCHAR(100) NOT NULL,
    size VARCHAR(50),
    is_available BOOLEAN NOT NULL DEFAULT TRUE
);

-- 3. Клиенты
CREATE TABLE Customer (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    phone VARCHAR(50),
    email VARCHAR(100)
);

-- 4. Прокат
CREATE TABLE Rental (
    rental_id SERIAL PRIMARY KEY,
    equipment_id INT NOT NULL REFERENCES Equipment(equipment_id),
    customer_id INT NOT NULL REFERENCES Customer(customer_id),
    rental_date DATE NOT NULL,
    return_date DATE,
    status VARCHAR(50) NOT NULL
);

-- 5. Сотрудники
CREATE TABLE Employee (
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    position VARCHAR(100) NOT NULL
);

-- 6. Назначение сотрудника
CREATE TABLE EmployeeAssignment (
    employee_assignment_id SERIAL PRIMARY KEY,
    employee_id INT NOT NULL REFERENCES Employee(employee_id),
    rental_id INT NOT NULL REFERENCES Rental(rental_id),
    assignment_date DATE NOT NULL
);

-- 7. Шаги обслуживания оборудования
CREATE TABLE MaintenanceStep (
    step_id SERIAL PRIMARY KEY,
    equipment_id INT NOT NULL REFERENCES Equipment(equipment_id),
    step_number INT NOT NULL,
    description TEXT NOT NULL
);
