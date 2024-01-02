-- =============================================
-- �������ݿ�
-- =============================================
CREATE DATABASE EmpExam
GO

-- =============================================
-- ת���½����ݿ�
-- =============================================
USE EmpExam
GO

-- =============================================
-- �������ݱ�
-- =============================================

-- ----------------------------------------
-- ���� Department
-- ----------------------------------------
CREATE TABLE Dept
(
	deptNo		CHAR(2),			-- ���
	deptName	VARCHAR(20)	NOT NULL,	-- ����
	CONSTRAINT Department_PK PRIMARY KEY(deptNo)	
)
GO

-- ----------------------------------------
-- Ա�� Emp
-- ----------------------------------------
CREATE TABLE Emp
(
	empNo		CHAR(5),			-- ���
	empName	VARCHAR(10)	NOT NULL,	-- ����
	deptNo		CHAR(2),			-- ���ڲ���
	CONSTRAINT Emp_PK PRIMARY KEY(empNo),
	CONSTRAINT Emp_Dept_FK FOREIGN KEY(deptNo)
		 REFERENCES Dept(deptNo)
)
GO

-- ----------------------------------------
-- ��Ŀ Proj
-- ----------------------------------------
CREATE TABLE Proj
(
	projNo	CHAR(2),			-- ���
	projName	VARCHAR(20)	NOT NULL,	-- ����
	budget		INT		NOT NULL,	-- Ԥ��
	CONSTRAINT Proj_PK PRIMARY KEY(projNo)
)
GO

-- ----------------------------------------
-- �е� Works [��ϵ]
-- ----------------------------------------
CREATE TABLE Works
(
	empNo		CHAR(5),			-- Ա�����
	projNo	CHAR(2),			-- ��Ŀ���
	job		VARCHAR(10),			-- ְ��
	CONSTRAINT Works_PK PRIMARY KEY(empNo, projNo),
	CONSTRAINT Works_Emp_FK FOREIGN KEY(empNo)
		REFERENCES Emp(empNo),
	CONSTRAINT Works_Proj_FK FOREIGN KEY(projNo)
		REFERENCES Proj(projNo)
)
GO

-- =============================================
-- ��������
-- =============================================

INSERT INTO Dept VALUES ('D1', '������')
INSERT INTO Dept VALUES ('D2', '�г���')
INSERT INTO Dept VALUES ('D3', '����')
GO

INSERT INTO Emp VALUES ('02581', '�쳪', 'D2')
INSERT INTO Emp VALUES ('09031', '�', 'D2')
INSERT INTO Emp VALUES ('10102', '���ĸ�', 'D3')
INSERT INTO Emp VALUES ('18316', '����', 'D1')
INSERT INTO Emp VALUES ('28559', '������', 'D1')
GO

INSERT INTO Proj VALUES ('P1', 'ϵͳ����', 135000)
INSERT INTO Proj VALUES ('P2', '�������', 185600)
GO

INSERT INTO Works VALUES ('18316', 'P1', '�鳤')
INSERT INTO Works VALUES ('10102', 'P1', '��Ա')
INSERT INTO Works VALUES ('28559', 'P2', '�鳤')
INSERT INTO Works VALUES ('18316', 'P2', '��Ա')
INSERT INTO Works VALUES ('09031', 'P2', '��Ա')
GO

-- =============================================
-- �г����ݣ���������SQL�Ƿ�ɹ�
-- =============================================

SELECT * FROM Dept
SELECT * FROM Emp
SELECT * FROM Proj
SELECT * FROM Works
GO
