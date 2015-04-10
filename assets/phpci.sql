CREATE DATABASE `phpci` CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
GRANT ALL PRIVILEGES ON `phpci`.* TO 'phpci'@'localhost' IDENTIFIED BY 'secret';
FLUSH PRIVILEGES;