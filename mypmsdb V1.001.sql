
CREATE TABLE clinic (
  clinic_id INT AUTO_INCREMENT PRIMARY KEY,
  clinic_logo mediumblob,
  clinic_name VARCHAR(255) NOT NULL,
  clinic_service VARCHAR(255),
  clinic_adress VARCHAR(255) NOT NULL,
  clinic_mobile VARCHAR(255) NOT NULL,
  clinic_tel VARCHAR(255) ,
  clinic_email VARCHAR(255) NOT NULL,
  clinic_website VARCHAR(255) 
);

INSERT INTO clinic (clinic_name, clinic_adress, clinic_mobile, clinic_email)
VALUES
("Dr. Qab Clinic", "JO", 0000, "clinic@clinic.com");
-- --------------------------------------------------------


CREATE TABLE users (
  user_id INT AUTO_INCREMENT PRIMARY KEY,
  user_login_name VARCHAR(50) NOT NULL,
  user_pass VARCHAR(50) NOT NULL,
  user_name VARCHAR(50) NOT NULL,
  user_pic mediumblob,
  user_role VARCHAR(50) NOT NULL,
  user_birthday DATE NOT NULL,
  user_gender VARCHAR(50) NOT NULL,
  user_adress VARCHAR(50) NOT NULL,
  user_mobile INT NOT NULL,
  user_tel INT,
  user_email VARCHAR(50) NOT NULL,
  user_note TEXT
);

INSERT INTO users (user_login_name, user_pass, user_name, user_role, user_birthday, user_gender, user_adress, user_mobile, user_tel, user_email, user_note)
VALUES 
('admin', 'admin', 'Dr. Qab', 'admin', '2020-01-01', "male", 'JO', 0000, 1111, 'aa@aa.com', 'aa'), 
('aq', '1234', 'Dr. Qab', 'Dentist', '2020-01-01', "male", 'JO', 0000, 1111, 'aa@aa.com', 'aa');
-- --------------------------------------------------------


CREATE TABLE insurance (
 insur_id INT AUTO_INCREMENT PRIMARY KEY,
 insur_name VARCHAR(255)NOT NULL,
 insur_adress VARCHAR(255),
 insur_tel INT,
 insur_note TEXT
);

INSERT INTO insurance (insur_name, insur_adress, insur_tel, insur_note)
VALUES
("private", "private", 0000, "ppp");
-- --------------------------------------------------------


CREATE TABLE colors (
 color_id INT AUTO_INCREMENT PRIMARY KEY,
 color_name VARCHAR(50) NOT NULL,
 color_code VARCHAR(7) NOT NULL
);

INSERT INTO colors (color_name, color_code)
VALUES
("black", "#000000"),
("white", "#FFFFFF"),
("silver", "#C0C0C0"),
("grey", "#808080"),
("maroon", "#800000"),
("red", "#FF0000"),
("purple", "#800080"),
("fuchsia", "#FF00FF"),
("green", "#008000"),
("lime", "#00FF00"),
("olive", "#808000"),
("yellow", "#FFFF00"),
("navy", "#000080"),
("blue", "#0000FF"),
("teal", "#008080"),
("aqua", "#00FFFF");
-- --------------------------------------------------------


CREATE TABLE patients (
 pat_id INT AUTO_INCREMENT PRIMARY KEY,
 pat_name VARCHAR(255) NOT NULL,
 pat_birthday DATE NOT NULL,
 pat_gender VARCHAR(50) NOT NULL,
 pat_adress VARCHAR(255) NOT NULL,
 pat_mobile INT NOT NULL,
 pat_tel INT,
 pat_email VARCHAR(50),
 pat_dr_id INT NOT NULL,
 pat_insur_id INT NOT NULL,
 pat_active BOOLEAN NOT NULL,
 pat_color_id INT NOT NULL,
 pat_note TEXT,
 FOREIGN KEY (pat_dr_id) REFERENCES users (user_id),
 FOREIGN KEY (pat_insur_id) REFERENCES insurance (insur_id),
 FOREIGN KEY (pat_color_id) REFERENCES colors (color_id)
);

INSERT INTO patients (pat_name, pat_birthday, pat_gender, pat_adress, pat_mobile, pat_dr_id, pat_insur_id, pat_active, pat_color_id)
VALUES
("clinic", "2020-01-01", "male", "JO", 0000, 1, 1, 1, 1),
("New Patient", "2020-01-01", "male", "JO", 0000, 1, 1, 1, 1);
-- --------------------------------------------------------

CREATE TABLE history (
 hist_id INT AUTO_INCREMENT PRIMARY KEY,
 pat_id INT NOT NULL,
 hist_date DATE NOT NULL,
 hist_info TEXT NOT NULL,
 FOREIGN KEY (pat_id) REFERENCES patients (pat_id)
);
-- --------------------------------------------------------


CREATE TABLE records (
  rec_id INT AUTO_INCREMENT PRIMARY KEY,
  pat_id INT NOT NULL,
  rec_date DATE NOT NULL,
  rec_timestamp TIMESTAMP NOT NULL DEFAULT current_timestamp(),
  rec_timestamp_edit TIMESTAMP NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  rec_user_id INT NOT NULL,
  rec_user_id_edit INT NOT NULL,
  rec_dr_id INT NOT NULL,
  rec_therapy_reg VARCHAR(255) NOT NULL,
  rec_therapy_info TEXT NOT NULL,
  rec_insur_id INT NOT NULL,
  rec_note TEXT,
  FOREIGN KEY (pat_id) REFERENCES patients (pat_id),
  FOREIGN KEY (rec_user_id) REFERENCES users (user_id),
  FOREIGN KEY (rec_user_id_edit) REFERENCES users (user_id),
  FOREIGN KEY (rec_dr_id) REFERENCES users (user_id),
  FOREIGN KEY (rec_insur_id) REFERENCES insurance (insur_id)
);
-- --------------------------------------------------------


CREATE TABLE billing (
 bill_id INT AUTO_INCREMENT PRIMARY KEY,
 pat_id INT NOT NULL,
 bill_timestamp TIMESTAMP NOT NULL DEFAULT current_timestamp(),
 bill_timestamp_edit TIMESTAMP NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
 bill_user_id INT NOT NULL,
 bill_user_id_edit INT NOT NULL,
 bill_dr_id INT NOT NULL,
 bill_therapy_reg VARCHAR(255) NOT NULL,
 bill_info TEXT NOT NULL,
 bill_fee DECIMAL(10, 2) NOT NULL,
 bill_payed DECIMAL(10, 2) NOT NULL,
 bill_rest DECIMAL(10, 2) NOT NULL,
 bill_insur_id INT NOT NULL,
 bill_igno BOOLEAN NOT NULL,
 bill_note TEXT,
 FOREIGN KEY (pat_id) REFERENCES patients (pat_id),
 FOREIGN KEY (bill_user_id) REFERENCES users (user_id),
 FOREIGN KEY (bill_user_id_edit) REFERENCES users (user_id),
 FOREIGN KEY (bill_dr_id) REFERENCES users (user_id),
 FOREIGN KEY (bill_insur_id) REFERENCES insurance (insur_id)
);
-- --------------------------------------------------------


CREATE TABLE payments (
 pay_id INT AUTO_INCREMENT PRIMARY KEY,
 bill_id INT NOT NULL,
 pay_date DATE NOT NULL,
 pay_timestamp TIMESTAMP NOT NULL DEFAULT current_timestamp(),
 pay_timestamp_edit TIMESTAMP NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
 pay_user_id INT NOT NULL,
 pay_user_id_edit INT NOT NULL,
 pay_info TEXT NOT NULL,
 FOREIGN KEY (bill_id) REFERENCES billing (bill_id),
 FOREIGN KEY (pay_user_id) REFERENCES users (user_id),
 FOREIGN KEY (pay_user_id_edit) REFERENCES users (user_id)
);
-- --------------------------------------------------------


CREATE TABLE documents (
 doc_id INT PRIMARY KEY AUTO_INCREMENT,
 pat_id INT NOT NULL,
 doc_timestamp TIMESTAMP NOT NULL DEFAULT current_timestamp(),
 doc_timestamp_edit TIMESTAMP NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
 doc_user_id INT NOT NULL,
 doc_user_id_edit INT NOT NULL,
 doc_date_save DATE NOT NULL,
 doc_date DATE NOT NULL,
 doc_info TEXT NOT NULL,
 doc_data mediumblob NOT NULL,
 FOREIGN KEY (pat_id) REFERENCES patients (pat_id),
 FOREIGN KEY (doc_user_id) REFERENCES users (user_id),
 FOREIGN KEY (doc_user_id_edit) REFERENCES users (user_id)
);
-- --------------------------------------------------------


CREATE TABLE texts (
    text_id INT PRIMARY KEY AUTO_INCREMENT,
    text_text TEXT NOT NULL
);
-- --------------------------------------------------------


CREATE TABLE medicine (
    med_id INT PRIMARY KEY AUTO_INCREMENT,
    med_name VARCHAR(255) NOT NULL,
    med_amount VARCHAR(50),
    med_type VARCHAR(50),
    med_usage VARCHAR(255) NOT NULL
);
-- --------------------------------------------------------


CREATE TABLE lab (
  lab_id INT PRIMARY KEY,
  lab_name VARCHAR(255) NOT NULL,
  lab_address VARCHAR(255) NOT NULL,
  lab_mobile VARCHAR(20) NOT NULL,
  lab_tel VARCHAR(20),
  lab_email VARCHAR(255),
  lab_note TEXT
);
-- --------------------------------------------------------


CREATE TABLE work (
  work_id INT PRIMARY KEY,
  lab_id INT NOT NULL,
  work_timestamp TIMESTAMP NOT NULL DEFAULT current_timestamp(),
  work_timestamp_edit TIMESTAMP NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  work_user_id INT NOT NULL,
  work_user_id_edit INT NOT NULL,
  work_date DATE NOT NULL,
  work_info TEXT NOT NULL,
  work_status VARCHAR(50) NOT NULL,
  work_note TEXT,
  FOREIGN KEY (lab_id) REFERENCES lab (lab_id),
  FOREIGN KEY (work_user_id) REFERENCES users (user_id),
  FOREIGN KEY (work_user_id_edit) REFERENCES users (user_id)
);
-- --------------------------------------------------------


CREATE TABLE appointment (
  appo_id INT PRIMARY KEY,
  pat_id INT NOT NULL,
  appo_timestamp TIMESTAMP NOT NULL DEFAULT current_timestamp(),
  appo_timestamp_edit TIMESTAMP NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  appo_user_id INT NOT NULL,
  appo_user_id_edit INT NOT NULL,
  appo_from TIME NOT NULL,
  appo_to TIME NOT NULL,
  appo_type VARCHAR(255),
  appo_color_id INT NOT NULL,
  appo_info TEXT NOT NULL,
  appo_status VARCHAR(20) NOT NULL,
  appo_time_waiting datetime,
  appo_time_treatment datetime,
  appo_time_completed datetime,
  appo_vip BOOLEAN NOT NULL,
  appo_temp BOOLEAN NOT NULL,
  appo_note TEXT,
  FOREIGN KEY (pat_id) REFERENCES patients (pat_id),
  FOREIGN KEY (appo_user_id) REFERENCES users (user_id),
  FOREIGN KEY (appo_user_id_edit) REFERENCES users (user_id),
  FOREIGN KEY (appo_color_id) REFERENCES colors (color_id)
);
-- --------------------------------------------------------
