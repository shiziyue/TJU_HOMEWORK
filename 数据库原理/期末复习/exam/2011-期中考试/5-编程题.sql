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
	deptNo		CHAR(2),			-- ���ű��
	deptName	VARCHAR(20)	NOT NULL,	-- ��������
	location	VARCHAR(10)	NOT NULL,	-- ���ڳ���
	CONSTRAINT Department_PK PRIMARY KEY(deptNo)	
)
GO

-- ----------------------------------------
-- Ա�� Emp
-- ----------------------------------------
CREATE TABLE Emp
(
	empNo		CHAR(5),			-- Ա�����
	empName	VARCHAR(10)	NOT NULL,	-- Ա������
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
	projNo	CHAR(2),			-- ��Ŀ���
	projName	VARCHAR(20)	NOT NULL,	-- ��Ŀ����
	budget		INT		NOT NULL,	-- ��ĿԤ��
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
	enterDate	SMALLDATETIME  NOT NULL,	-- ����ʱ��
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

INSERT INTO Dept VALUES ('D1', '������', '���')
INSERT INTO Dept VALUES ('D2', '����', '����')
INSERT INTO Dept VALUES ('D3', '�г���', '�㶫')
INSERT INTO Dept VALUES ('D4', '��Ϣ������', '���')
GO

INSERT INTO Emp VALUES ('02581', '�쳪', 'D2')
INSERT INTO Emp VALUES ('09031', '�', 'D2')
INSERT INTO Emp VALUES ('10102', '���ĸ�', 'D3')
INSERT INTO Emp VALUES ('18316', '����', 'D1')
INSERT INTO Emp VALUES ('25348', '�ŷ�', 'D3')
INSERT INTO Emp VALUES ('28559', '������', 'D1')
INSERT INTO Emp VALUES ('29346', '�Զ���', 'D2')
INSERT INTO Emp VALUES ('40000', '����', 'D2')
INSERT INTO Emp VALUES ('40001', '����', 'D2')
GO

INSERT INTO Proj VALUES ('P1', '���粼��', 135000)
INSERT INTO Proj VALUES ('P2', '�������', 95000)
INSERT INTO Proj VALUES ('P3', 'ϵͳ����', 185600)
INSERT INTO Proj VALUES ('P4', '�ƻ���Ŀ1', 20000)
GO

INSERT INTO Works VALUES ('02581', 'P3', '����Ա', '2008-10-15')
INSERT INTO Works VALUES ('09031', 'P1', '����Ա', '2008-04-15')
INSERT INTO Works VALUES ('09031', 'P3', 'ְԱ', '2007-11-15')
INSERT INTO Works VALUES ('10102', 'P1', '����Ա', '2007-01-10')
INSERT INTO Works VALUES ('10102', 'P3', '����Ա', '2009-01-01')
INSERT INTO Works VALUES ('18316', 'P2', 'ְԱ', '2008-02-15')
INSERT INTO Works VALUES ('25348', 'P2', NULL, '2008-06-01')
INSERT INTO Works VALUES ('28559', 'P1', NULL, '2008-08-01')
INSERT INTO Works VALUES ('28559', 'P2', 'ְԱ', '2009-02-01')
INSERT INTO Works VALUES ('28559', 'P3', 'ְԱ', '2008-05-07')
INSERT INTO Works VALUES ('29346', 'P1', 'ְԱ', '2008-01-04')
INSERT INTO Works VALUES ('29346', 'P3', 'ְԱ', '2009-04-04')
GO

-- =============================================
-- �г����ݣ���������SQL�Ƿ�ɹ�
-- =============================================

SELECT * FROM Dept
SELECT * FROM Emp
SELECT * FROM Proj
SELECT * FROM Works
GO


-- 1
-- �����ѯ
SELECT deptName
FROM Dept
WHERE location='���'

-- 2
-- �����ѯ
SELECT projNo, COUNT(*) AS empCnt
FROM Works
GROUP BY projNo
ORDER BY projNo

-- 3
-- ���Ӳ�ѯ ������
SELECT empNo, job
FROM Proj P INNER JOIN Works W ON
	P.projNo = W.projNo
WHERE projName='ϵͳ����'

-- 4
-- ���Ӳ�ѯ 4����
SELECT W.empNo, W.enterDate
FROM Proj P INNER JOIN Works W ON P.projNo = W.projNo
                      INNER JOIN Emp E ON W.empNo = E.empNo
                      INNER JOIN Dept D ON E.deptNo = D.deptNo
WHERE P.projName='���粼��' AND D.deptName='����'

-- 5 
SELECT empNo, empName
FROM Emp E
WHERE NOT EXISTS ( 
	SELECT *
	FROM Works W
	WHERE W.empNo = E.empNo
)
-- ��
SELECT empNo, empName
FROM Emp E
WHERE empNo NOT IN ( 
	SELECT empNo
	FROM Works W
	WHERE W.empNo = E.empNo
)

-- 3
SELECT Dept.deptNo, Dept.deptName
FROM Dept
WHERE Dept.deptNo IN (
SELECT Emp.deptNo
FROM Emp
GROUP BY Emp.deptNo
HAVING COUNT(*) > 4)
