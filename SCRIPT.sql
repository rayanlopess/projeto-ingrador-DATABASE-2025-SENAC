SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;

-- -----------------------------------------------------
-- Schema pi_2025
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pi_2025` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `pi_2025`;

-- -----------------------------------------------------
-- Table `users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `usuario` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `senha` VARCHAR(255) NOT NULL,
  `cpf` CHAR(14) NOT NULL,
  `nascimento` DATE NOT NULL,
  `nome` VARCHAR(100) NOT NULL,
  `is_verified` TINYINT(1) DEFAULT 0,
  `is_master_admin` TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE (`usuario`),
  UNIQUE (`email`),
  UNIQUE (`cpf`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- -----------------------------------------------------
-- Table `codigos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `codigos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `codigo` CHAR(8) NOT NULL,
  `expiracao` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_verify_codes_users_idx` (`user_id`),
  CONSTRAINT `fk_verify_codes_users`
    FOREIGN KEY (`user_id`) REFERENCES `users`(`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- -----------------------------------------------------
-- Table `hospitais`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospitais` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(255) NOT NULL,
  `lati` DECIMAL(10,8) NOT NULL,
  `longi` DECIMAL(11,8) NOT NULL,
  `uf` CHAR(2) NOT NULL,
  `cidade` VARCHAR(255) NOT NULL,
  `bairro` VARCHAR(45) NOT NULL,
  `logradouro` VARCHAR(255) NOT NULL,
  `foto` LONGBLOB NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- -----------------------------------------------------
-- Table `fila_espera`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fila_espera` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `qtd_laranja` INT DEFAULT 0,
  `qtd_amarelo` INT DEFAULT 0,
  `qtd_verde` INT DEFAULT 0,
  `qtd_azul` INT DEFAULT 0,
  `tempo_espera` INT NOT NULL,
  `hospitais_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_fila_espera_hospitais1_idx` (`hospitais_id`),
  CONSTRAINT `fk_fila_espera_hospitais1`
    FOREIGN KEY (`hospitais_id`) REFERENCES `hospitais`(`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- -----------------------------------------------------
-- Table `qtd_medicos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `qtd_medicos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `qtd` INT NOT NULL,
  `qtd_livres` DECIMAL(3,2) NOT NULL,
  `hospitais_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_qtd_medicos_hospitais1_idx` (`hospitais_id`),
  CONSTRAINT `fk_qtd_medicos_hospitais1`
    FOREIGN KEY (`hospitais_id`) REFERENCES `hospitais`(`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- -----------------------------------------------------
-- Table `sessoes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sessoes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `token` VARCHAR(64) NOT NULL,
  `expiracao` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_sessoes_users_idx` (`user_id`),
  CONSTRAINT `fk_sessoes_users`
    FOREIGN KEY (`user_id`) REFERENCES `users`(`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

insert into users (id, usuario, email, secodigoscodigoscodigosusuarionha, cpf, nascimento, nome, is_verified, is_master_admin) values (1, "FilaMedAdmin", "noreplyfilamedpi@gmail.com", "$2a$12$bEZ/RhnVCHzvwSY5Dkc1p.FffOIXX7uNS4tAwFLm2qns3iakFWWlW", "000.000.001-01", "2000-01-01", "Admin do FilaMed", 1, 1);
