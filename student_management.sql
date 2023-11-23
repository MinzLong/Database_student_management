Create database Student_Management;
USE Student_Management;
CREATE TABLE Classes (
  ClassID varchar(45) NOT NULL,
  Start_Date date DEFAULT NULL,
  PRIMARY KEY (ClassID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE Major (
  MajorID varchar(45) NOT NULL,
  Major_Name varchar(45) DEFAULT NULL,
  PRIMARY KEY (MajorID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE Students (
  StudentID varchar(45) NOT NULL,
  Name varchar(45) DEFAULT NULL,
  Date_of_Birth date DEFAULT NULL,
  Gender enum('Male','Female') DEFAULT NULL,
  Address varchar(45) DEFAULT NULL,
  Phone_Number varchar(45) DEFAULT NULL,
  Email varchar(45) DEFAULT NULL,
  MajorID varchar(45) NOT NULL,
  PRIMARY KEY (StudentID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE Study (
  StudentID varchar(45) NOT NULL,
  UnitID varchar(45) NOT NULL,
  ClassID varchar(45) NOT NULL,
  Term_Name varchar(45) NOT NULL,
  Status varchar(45) DEFAULT NULL,
  Grade float DEFAULT NULL,
  PRIMARY KEY (StudentID, UnitID, ClassID, Term_Name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE Unit (
  UnitID varchar(45) NOT NULL,
  Unit_Name varchar(45) DEFAULT NULL,
  MajorID varchar(45) NOT NULL,
  PRIMARY KEY (UnitID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE Term (
  Term_Name varchar(45) NOT NULL,
  Start_Date date DEFAULT NULL,
  End_Date date DEFAULT NULL,
  PRIMARY KEY (Term_Name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

ALTER TABLE Unit
ADD CONSTRAINT FK_major_unit
FOREIGN KEY (MajorID) REFERENCES major(MajorID);

ALTER TABLE Students
ADD CONSTRAINT FK_major_student
FOREIGN KEY (MajorID) REFERENCES major(MajorID);

ALTER TABLE Study
ADD CONSTRAINT FK_student_study
FOREIGN KEY (StudentID) REFERENCES students(StudentID);

ALTER TABLE Study
ADD CONSTRAINT FK_unit_study
FOREIGN KEY (UnitID) REFERENCES unit(UnitID);

ALTER TABLE Study
ADD CONSTRAINT FK_classes_study
FOREIGN KEY (ClassID) REFERENCES classes(ClassID);

ALTER TABLE Study
ADD CONSTRAINT FK_term_study
FOREIGN KEY (Term_Name) REFERENCES term(Term_Name);