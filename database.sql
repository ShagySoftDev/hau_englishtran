CREATE DATABASE IF NOT EXISTS kare_kare CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE kare_kare;

CREATE TABLE users (
 id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, username VARCHAR(60) NOT NULL UNIQUE, email VARCHAR(150) NOT NULL UNIQUE, password VARCHAR(255) NOT NULL, role ENUM('admin','contributor') NOT NULL DEFAULT 'contributor', must_change_password TINYINT(1) NOT NULL DEFAULT 0, created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, last_login_at DATETIME NULL
);
CREATE TABLE translations (
 id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, hausa_word VARCHAR(255) NOT NULL, english_meaning TEXT NOT NULL, example_sentence TEXT NULL, created_by INT UNSIGNED NULL, created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, UNIQUE KEY unique_hausa_word (hausa_word), FULLTEXT KEY search_words (hausa_word, english_meaning), FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL
);
CREATE TABLE contributions (
 id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, hausa_word VARCHAR(255) NOT NULL, english_meaning TEXT NOT NULL, example_sentence TEXT NULL, contributor_id INT UNSIGNED NOT NULL, status ENUM('pending','approved','rejected') NOT NULL DEFAULT 'pending', reviewer_id INT UNSIGNED NULL, review_note TEXT NULL, created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, reviewed_at DATETIME NULL, FOREIGN KEY (contributor_id) REFERENCES users(id) ON DELETE CASCADE, FOREIGN KEY (reviewer_id) REFERENCES users(id) ON DELETE SET NULL
);
CREATE TABLE search_history (id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY, user_id INT UNSIGNED NULL, query VARCHAR(255) NOT NULL, result_count INT UNSIGNED NOT NULL DEFAULT 0, searched_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL);
CREATE TABLE login_history (id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY, user_id INT UNSIGNED NULL, username VARCHAR(60) NOT NULL, ip_address VARCHAR(45) NULL, success TINYINT(1) NOT NULL, logged_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL);
CREATE TABLE activity_logs (id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY, user_id INT UNSIGNED NULL, role VARCHAR(20) NULL, action VARCHAR(120) NOT NULL, details TEXT NULL, created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL);
INSERT INTO users (username,email,password,role,must_change_password) VALUES ('admin','admin@karekare.local','$2y$10$vLBenEDyPBg4.c8IF4dQyuKTHpsZj96vVoTZGuY.hisBm/cj6qGle','admin',1);
-- Default password is: admin
