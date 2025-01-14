/*
  HUB-ТАБЛИЦЫ
*/

/* HubEquipment: ключевые данные об оборудовании */
CREATE TABLE HubEquipment (
    equipment_key BIGSERIAL PRIMARY KEY,
    equipment_id INT UNIQUE NOT NULL,         -- Бизнес-ключ (из реальной системы)
    load_date TIMESTAMP NOT NULL,
    record_source VARCHAR(50) NOT NULL
);

/* HubCustomer: ключевые данные о клиентах */
CREATE TABLE HubCustomer (
    customer_key BIGSERIAL PRIMARY KEY,
    customer_id INT UNIQUE NOT NULL,          -- Уникальный идентификатор клиента
    load_date TIMESTAMP NOT NULL,
    record_source VARCHAR(50) NOT NULL
);

/* HubEmployee: ключевые данные о сотрудниках */
CREATE TABLE HubEmployee (
    employee_key BIGSERIAL PRIMARY KEY,
    employee_id INT UNIQUE NOT NULL,          -- Уникальный идентификатор сотрудника
    load_date TIMESTAMP NOT NULL,
    record_source VARCHAR(50) NOT NULL
);

/*
  LINK-ТАБЛИЦЫ
*/

/* LinkRental: связь «Прокат» между оборудованием и клиентом */
CREATE TABLE LinkRental (
    rental_key BIGSERIAL PRIMARY KEY,
    equipment_key BIGINT NOT NULL REFERENCES HubEquipment(equipment_key),
    customer_key BIGINT NOT NULL REFERENCES HubCustomer(customer_key),
    load_date TIMESTAMP NOT NULL,
    record_source VARCHAR(50) NOT NULL
);

/* LinkEmployeeAssignment: связь между сотрудником и конкретной арендой (прокатом) */
CREATE TABLE LinkEmployeeAssignment (
    employee_assignment_key BIGSERIAL PRIMARY KEY,
    employee_key BIGINT NOT NULL REFERENCES HubEmployee(employee_key),
    rental_key BIGINT NOT NULL REFERENCES LinkRental(rental_key),
    load_date TIMESTAMP NOT NULL,
    record_source VARCHAR(50) NOT NULL
);

/*
  SATELLITE-ТАБЛИЦЫ
*/

/* SatEquipment: описательные данные об оборудовании */
CREATE TABLE SatEquipment (
    equipment_key BIGINT NOT NULL REFERENCES HubEquipment(equipment_key),
    brand VARCHAR(100) NOT NULL,
    model VARCHAR(100) NOT NULL,
    size VARCHAR(50),
    is_available BOOLEAN NOT NULL,
    load_date TIMESTAMP NOT NULL,
    record_source VARCHAR(50) NOT NULL,
    PRIMARY KEY (equipment_key, load_date)
);

/* SatCustomer: описательные данные о клиенте */
CREATE TABLE SatCustomer (
    customer_key BIGINT NOT NULL REFERENCES HubCustomer(customer_key),
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    phone VARCHAR(50),
    email VARCHAR(100),
    load_date TIMESTAMP NOT NULL,
    record_source VARCHAR(50) NOT NULL,
    PRIMARY KEY (customer_key, load_date)
);

/* SatEmployee: описательные данные о сотруднике */
CREATE TABLE SatEmployee (
    employee_key BIGINT NOT NULL REFERENCES HubEmployee(employee_key),
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    position VARCHAR(100) NOT NULL,
    load_date TIMESTAMP NOT NULL,
    record_source VARCHAR(50) NOT NULL,
    PRIMARY KEY (employee_key , load_date)
);

/* SatRental: атрибуты факта проката (датa начала, статус, дата возврата и т.д.) */
CREATE TABLE SatRental (
    rental_key BIGINT NOT NULL REFERENCES LinkRental(rental_key),
    rental_date DATE,
    return_date DATE,
    status VARCHAR(50),
    load_date TIMESTAMP NOT NULL,
    record_source VARCHAR(50) NOT NULL,
    PRIMARY KEY (rental_key, load_date)
);

/* SatEmployeeAssignment: описательные данные о назначении сотрудника
   (например, дата назначения, вид обязанности) */
CREATE TABLE SatEmployeeAssignment (
    employee_assignment_key BIGINT NOT NULL REFERENCES LinkEmployeeAssignment(employee_assignment_key),
    assignment_date DATE,
    duty_description TEXT,
    load_date TIMESTAMP NOT NULL,
    record_source VARCHAR(50) NOT NULL,
    PRIMARY KEY (employee_assignment_key, load_date)
);
