-- MySQL Script generated by MySQL Workbench
-- Mon Jun  4 20:34:08 2018
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema tp_bd
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema tp_bd
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `tp_bd` DEFAULT CHARACTER SET utf8 ;
USE `tp_bd` ;

-- -----------------------------------------------------
-- Table `tp_bd`.`TB_ENDERECO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tp_bd`.`TB_ENDERECO` (
  `ID_ENDERECO` INT NOT NULL,
  `NM_PAIS` VARCHAR(45) NULL,
  `NM_ESTADO` VARCHAR(45) NULL,
  `NM_CIDADE` VARCHAR(45) NULL,
  `NM_BAIRRO` VARCHAR(45) NULL,
  `DS_CEP` VARCHAR(45) NULL,
  `NM_LOGRADOURO` VARCHAR(45) NULL,
  `NR_NUMERO` VARCHAR(45) NULL,
  PRIMARY KEY (`ID_ENDERECO`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tp_bd`.`TB_AEROPORTO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tp_bd`.`TB_AEROPORTO` (
  `ID_AEROPORTO` INT NOT NULL,
  `NM_NOME_AEROPORTO` VARCHAR(90) NULL,
  `DT_DATA_INAUGURACAO` DATE NULL,
  `ID_ENDERECO` INT NOT NULL,
  PRIMARY KEY (`ID_AEROPORTO`),
  INDEX `fk_TB_AEROPORTO_TB_ENDERECO_idx` (`ID_ENDERECO` ASC),
  CONSTRAINT `fk_TB_AEROPORTO_TB_ENDERECO`
    FOREIGN KEY (`ID_ENDERECO`)
    REFERENCES `tp_bd`.`TB_ENDERECO` (`ID_ENDERECO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tp_bd`.`TB_COMPANHIA_AEREA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tp_bd`.`TB_COMPANHIA_AEREA` (
  `ID_COMPANHIA_AEREA` INT NOT NULL,
  `NM_NOME_COMPANHIA` VARCHAR(45) NULL,
  `NM_PROGRAMA_MILHAGENS` VARCHAR(45) NULL,
  PRIMARY KEY (`ID_COMPANHIA_AEREA`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tp_bd`.`TB_OPERACAO_AEROPORTO_CIA_AEREA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tp_bd`.`TB_OPERACAO_AEROPORTO_CIA_AEREA` (
  `ID_AEROPORTO` INT NOT NULL,
  `ID_COMPANHIA_AEREA` INT NOT NULL,
  PRIMARY KEY (`ID_AEROPORTO`, `ID_COMPANHIA_AEREA`),
  INDEX `fk_TB_AEROPORTO_has_TB_COMPANHIA_AEREA_TB_COMPANHIA_AEREA1_idx` (`ID_COMPANHIA_AEREA` ASC),
  INDEX `fk_TB_AEROPORTO_has_TB_COMPANHIA_AEREA_TB_AEROPORTO1_idx` (`ID_AEROPORTO` ASC),
  CONSTRAINT `fk_TB_AEROPORTO_has_TB_COMPANHIA_AEREA_TB_AEROPORTO1`
    FOREIGN KEY (`ID_AEROPORTO`)
    REFERENCES `tp_bd`.`TB_AEROPORTO` (`ID_AEROPORTO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_TB_AEROPORTO_has_TB_COMPANHIA_AEREA_TB_COMPANHIA_AEREA1`
    FOREIGN KEY (`ID_COMPANHIA_AEREA`)
    REFERENCES `tp_bd`.`TB_COMPANHIA_AEREA` (`ID_COMPANHIA_AEREA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tp_bd`.`TB_AERONAVE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tp_bd`.`TB_AERONAVE` (
  `ID_AERONAVE` INT NOT NULL,
  `ID_COMPANHIA_AEREA` INT NOT NULL,
  `NM_MODELO` VARCHAR(8) NULL,
  `NR_QUANTIDADE_ASSENTOS` INT NULL,
  PRIMARY KEY (`ID_AERONAVE`),
  INDEX `fk_TB_AERONAVE_TB_COMPANHIA_AEREA1_idx` (`ID_COMPANHIA_AEREA` ASC),
  CONSTRAINT `fk_TB_AERONAVE_TB_COMPANHIA_AEREA1`
    FOREIGN KEY (`ID_COMPANHIA_AEREA`)
    REFERENCES `tp_bd`.`TB_COMPANHIA_AEREA` (`ID_COMPANHIA_AEREA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tp_bd`.`TB_CARGO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tp_bd`.`TB_CARGO` (
  `ID_CARGO` INT NOT NULL,
  `NM_CARGO` VARCHAR(45) NULL,
  PRIMARY KEY (`ID_CARGO`),
  UNIQUE INDEX `NM_CARGO_UNIQUE` (`NM_CARGO` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tp_bd`.`TB_FUNCIONARIO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tp_bd`.`TB_FUNCIONARIO` (
  `ID_FUNCIONARIO` INT NOT NULL,
  `ID_COMPANHIA_AEREA` INT NOT NULL,
  `ID_CARGO` INT NOT NULL,
  `VL_SALARIO` DOUBLE NULL,
  `NM_NOME` VARCHAR(90) NULL,
  PRIMARY KEY (`ID_FUNCIONARIO`),
  INDEX `fk_TB_FUNCIONARIO_TB_COMPANHIA_AEREA1_idx` (`ID_COMPANHIA_AEREA` ASC),
  INDEX `fk_TB_FUNCIONARIO_TB_CARGO1_idx` (`ID_CARGO` ASC),
  CONSTRAINT `fk_TB_FUNCIONARIO_TB_COMPANHIA_AEREA1`
    FOREIGN KEY (`ID_COMPANHIA_AEREA`)
    REFERENCES `tp_bd`.`TB_COMPANHIA_AEREA` (`ID_COMPANHIA_AEREA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_TB_FUNCIONARIO_TB_CARGO1`
    FOREIGN KEY (`ID_CARGO`)
    REFERENCES `tp_bd`.`TB_CARGO` (`ID_CARGO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tp_bd`.`TB_VOO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tp_bd`.`TB_VOO` (
  `ID_VOO` INT NOT NULL,
  `NR_VOO` INT NULL,
  `ID_COMPANHIA_AEREA` INT NOT NULL,
  `ID_AEROPORTO_ORIGEM` INT NOT NULL,
  `ID_AEROPORTO_DESTINO` INT NOT NULL,
  PRIMARY KEY (`ID_VOO`),
  INDEX `fk_TB_VOO_TB_COMPANHIA_AEREA1_idx` (`ID_COMPANHIA_AEREA` ASC),
  INDEX `fk_TB_VOO_TB_AEROPORTO1_idx` (`ID_AEROPORTO_ORIGEM` ASC),
  INDEX `fk_TB_VOO_TB_AEROPORTO2_idx` (`ID_AEROPORTO_DESTINO` ASC),
  CONSTRAINT `fk_TB_VOO_TB_COMPANHIA_AEREA1`
    FOREIGN KEY (`ID_COMPANHIA_AEREA`)
    REFERENCES `tp_bd`.`TB_COMPANHIA_AEREA` (`ID_COMPANHIA_AEREA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_TB_VOO_TB_AEROPORTO1`
    FOREIGN KEY (`ID_AEROPORTO_ORIGEM`)
    REFERENCES `tp_bd`.`TB_AEROPORTO` (`ID_AEROPORTO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_TB_VOO_TB_AEROPORTO2`
    FOREIGN KEY (`ID_AEROPORTO_DESTINO`)
    REFERENCES `tp_bd`.`TB_AEROPORTO` (`ID_AEROPORTO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tp_bd`.`TB_OCORRENCIA_VOO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tp_bd`.`TB_OCORRENCIA_VOO` (
  `ID_OCORRENCIA_VOO` INT NOT NULL,
  `ID_VOO` INT NOT NULL,
  `ID_AERONAVE` INT NOT NULL,
  `HR_HORA_PARTIDA` TIME NULL,
  `HR_HORA_CHEGADA` TIME NULL,
  `DT_DATA_OCORRENCIA` DATE NULL,
  PRIMARY KEY (`ID_OCORRENCIA_VOO`),
  INDEX `fk_TB_OCORRENCIA_VOO_TB_VOO1_idx` (`ID_VOO` ASC),
  INDEX `fk_TB_OCORRENCIA_VOO_TB_AERONAVE1_idx` (`ID_AERONAVE` ASC),
  CONSTRAINT `fk_TB_OCORRENCIA_VOO_TB_VOO1`
    FOREIGN KEY (`ID_VOO`)
    REFERENCES `tp_bd`.`TB_VOO` (`ID_VOO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_TB_OCORRENCIA_VOO_TB_AERONAVE1`
    FOREIGN KEY (`ID_AERONAVE`)
    REFERENCES `tp_bd`.`TB_AERONAVE` (`ID_AERONAVE`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tp_bd`.`TB_EMPRESA_ALIMENTACAO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tp_bd`.`TB_EMPRESA_ALIMENTACAO` (
  `ID_EMPRESA_ALIMENTACAO` INT NOT NULL,
  `NM_EMPRESA_ALIMENTACAO` VARCHAR(45) NULL,
  PRIMARY KEY (`ID_EMPRESA_ALIMENTACAO`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tp_bd`.`TB_SERVICO_PRESTADO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tp_bd`.`TB_SERVICO_PRESTADO` (
  `ID_COMPANHIA_AEREA` INT NOT NULL,
  `ID_EMPRESA_ALIMENTACAO` INT NOT NULL,
  `DS_TIPO_CARDAPIO` VARCHAR(45) NULL,
  `VL_PRECO_CARDAPIO` DOUBLE NULL,
  INDEX `fk_TB_EMPRESA_ALIMENTACAO_has_TB_COMPANHIA_AEREA_TB_COMPANH_idx` (`ID_COMPANHIA_AEREA` ASC),
  INDEX `fk_TB_EMPRESA_ALIMENTACAO_has_TB_COMPANHIA_AEREA_TB_EMPRESA_idx` (`ID_EMPRESA_ALIMENTACAO` ASC),
  PRIMARY KEY (`ID_COMPANHIA_AEREA`, `ID_EMPRESA_ALIMENTACAO`),
  CONSTRAINT `fk_TB_EMPRESA_ALIMENTACAO_has_TB_COMPANHIA_AEREA_TB_EMPRESA_A2`
    FOREIGN KEY (`ID_EMPRESA_ALIMENTACAO`)
    REFERENCES `tp_bd`.`TB_EMPRESA_ALIMENTACAO` (`ID_EMPRESA_ALIMENTACAO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_TB_EMPRESA_ALIMENTACAO_has_TB_COMPANHIA_AEREA_TB_COMPANHIA2`
    FOREIGN KEY (`ID_COMPANHIA_AEREA`)
    REFERENCES `tp_bd`.`TB_COMPANHIA_AEREA` (`ID_COMPANHIA_AEREA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tp_bd`.`TB_SERVICO_PRESTADO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tp_bd`.`TB_SERVICO_PRESTADO` (
  `ID_COMPANHIA_AEREA` INT NOT NULL,
  `ID_EMPRESA_ALIMENTACAO` INT NOT NULL,
  `DS_TIPO_CARDAPIO` VARCHAR(45) NULL,
  `VL_PRECO_CARDAPIO` DOUBLE NULL,
  INDEX `fk_TB_EMPRESA_ALIMENTACAO_has_TB_COMPANHIA_AEREA_TB_COMPANH_idx` (`ID_COMPANHIA_AEREA` ASC),
  INDEX `fk_TB_EMPRESA_ALIMENTACAO_has_TB_COMPANHIA_AEREA_TB_EMPRESA_idx` (`ID_EMPRESA_ALIMENTACAO` ASC),
  PRIMARY KEY (`ID_COMPANHIA_AEREA`, `ID_EMPRESA_ALIMENTACAO`),
  CONSTRAINT `fk_TB_EMPRESA_ALIMENTACAO_has_TB_COMPANHIA_AEREA_TB_EMPRESA_A2`
    FOREIGN KEY (`ID_EMPRESA_ALIMENTACAO`)
    REFERENCES `tp_bd`.`TB_EMPRESA_ALIMENTACAO` (`ID_EMPRESA_ALIMENTACAO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_TB_EMPRESA_ALIMENTACAO_has_TB_COMPANHIA_AEREA_TB_COMPANHIA2`
    FOREIGN KEY (`ID_COMPANHIA_AEREA`)
    REFERENCES `tp_bd`.`TB_COMPANHIA_AEREA` (`ID_COMPANHIA_AEREA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tp_bd`.`TB_ESCALA_FUNCIONARIOS_OCV`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tp_bd`.`TB_ESCALA_FUNCIONARIOS_OCV` (
  `ID_FUNCIONARIO` INT NOT NULL,
  `ID_OCORRENCIA_VOO` INT NOT NULL,
  INDEX `fk_TB_FUNCIONARIO_has_TB_OCORRENCIA_VOO_TB_OCORRENCIA_VOO1_idx` (`ID_OCORRENCIA_VOO` ASC),
  INDEX `fk_TB_FUNCIONARIO_has_TB_OCORRENCIA_VOO_TB_FUNCIONARIO1_idx` (`ID_FUNCIONARIO` ASC),
  CONSTRAINT `fk_TB_FUNCIONARIO_has_TB_OCORRENCIA_VOO_TB_FUNCIONARIO1`
    FOREIGN KEY (`ID_FUNCIONARIO`)
    REFERENCES `tp_bd`.`TB_FUNCIONARIO` (`ID_FUNCIONARIO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_TB_FUNCIONARIO_has_TB_OCORRENCIA_VOO_TB_OCORRENCIA_VOO1`
    FOREIGN KEY (`ID_OCORRENCIA_VOO`)
    REFERENCES `tp_bd`.`TB_OCORRENCIA_VOO` (`ID_OCORRENCIA_VOO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
