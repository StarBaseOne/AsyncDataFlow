-- -----------------------------------------------------
-- Schema Health_Care
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Health_Care` ;
USE `Health_Care` ;

-- -----------------------------------------------------
-- Table `Health_Care`.`Patient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Health_Care`.`Patient` (
  `patient_ID` INT NOT NULL,
  `name` VARCHAR(150) NOT NULL,
  `age` INT NOT NULL,
  `e-mail` VARCHAR(45) NOT NULL,
  `phone` VARCHAR(30) NOT NULL,
  `address` VARCHAR(150) NOT NULL,
  `condition` VARCHAR(50) NOT NULL,
  `bmi` FLOAT NOT NULL,
  `status` VARCHAR(45) NULL,
  PRIMARY KEY (`patient_ID`),
  UNIQUE INDEX `Patient_ID_UNIQUE` (`patient_ID` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Health_Care`.`Device`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Health_Care`.`Device` (
  `device_ID` INT NOT NULL,
  `patient_ID` INT NOT NULL,
  PRIMARY KEY (`device_ID`),
  UNIQUE INDEX `Patient_ID_UNIQUE` (`device_ID` ASC) VISIBLE,
  INDEX `fk_Device_1_idx` (`patient_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Device_1`
    FOREIGN KEY (`patient_ID`)
    REFERENCES `Health_Care`.`Patient` (`patient_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Health_Care`.`Readings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Health_Care`.`Readings` (
  `reading_ID` INT NOT NULL,
  `heart_rate` INT NOT NULL,
  `blood_pressure_top` INT NOT NULL,
  `blood_pressure_bottom` INT NOT NULL,
  `body_temperature` FLOAT NOT NULL,
  `time_of_measurement` FLOAT NOT NULL,
  `coordinates` VARCHAR(45) NOT NULL,
  `patient_ID` INT NOT NULL,
  `device_ID` INT NOT NULL,
  PRIMARY KEY (`reading_ID`),
  UNIQUE INDEX `Patient_ID_UNIQUE` (`reading_ID` ASC) VISIBLE,
  INDEX `fk_Readings_2_idx` (`device_ID` ASC) VISIBLE,
  INDEX `fk_Readings_1_idx` (`patient_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Readings_1`
    FOREIGN KEY (`patient_ID`)
    REFERENCES `Health_Care`.`Patient` (`patient_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Readings_2`
    FOREIGN KEY (`device_ID`)
    REFERENCES `Health_Care`.`Device` (`device_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
