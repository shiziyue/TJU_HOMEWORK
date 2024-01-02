-- =============================================
-- �������ݿ�
-- =============================================
USE master

IF EXISTS (SELECT * 
	   FROM   master..sysdatabases 
	   WHERE  name = N'StudentCourseTeacher')
	DROP DATABASE StudentCourseTeacher
GO

CREATE DATABASE StudentCourseTeacher
GO

-- =============================================
-- ת���½����ݿ�
-- =============================================
USE StudentCourseTeacher
GO

-- =============================================
-- �������ݱ�
-- =============================================

-- ----------------------------------------
-- ѧ��
-- ----------------------------------------
CREATE TABLE Student
(
	sno			CHAR(5),
	sname		VARCHAR(10)	NOT NULL,
	sgender		CHAR(2)		NOT NULL,
	sbirth		DATETIME	NOT NULL,
	sdept		CHAR(2)		NOT NULL,
	CONSTRAINT Student_PK PRIMARY KEY(sno)
)
GO

-- ----------------------------------------
-- ��ʦ
-- ----------------------------------------
CREATE TABLE Teacher
(
	tno			CHAR(5),
	tname		VARCHAR(10)	NOT NULL,
	tdept		CHAR(2)		NOT NULL,
	CONSTRAINT Teacher_PK PRIMARY KEY(tno)
)
GO

-- ----------------------------------------
-- �γ�
-- ----------------------------------------
CREATE TABLE Course
(
	cno		SMALLINT,
	cname		VARCHAR(20)	NOT NULL,
	ccredit		SMALLINT	NOT NULL,
	tno		CHAR(5),
	CONSTRAINT Course_PK PRIMARY KEY(cno),
	CONSTRAINT Course_Teacher_FK FOREIGN KEY(tno) REFERENCES Teacher(tno)
)
GO

-- ----------------------------------------
-- ѧ��ѡ�� ��ϵ
-- ----------------------------------------
CREATE TABLE SC
(
	sno		CHAR(5),
	cno		SMALLINT,
	score		CHAR(5),
	
	CONSTRAINT SC_PK PRIMARY KEY(sno, cno),
	CONSTRAINT SC_Student_FK FOREIGN KEY(sno) REFERENCES Student(sno),
	CONSTRAINT SC_Course_FK FOREIGN KEY(cno) REFERENCES Course(cno)
)
GO


-- =============================================
-- ������������
-- =============================================

INSERT INTO Student VALUES ('08001', '����', '��', '1988-02-19', 'CS')
INSERT INTO Student VALUES ('08002', '����', 'Ů', '1989-01-09', 'CS')
INSERT INTO Student VALUES ('08003', '����', 'Ů', '1990-12-08', 'CE')
INSERT INTO Student VALUES ('08004', '����', '��', '1989-08-30', 'IS')
GO

INSERT INTO Teacher VALUES ('05001', '��С��', 'CS')
INSERT INTO Teacher VALUES ('05002', '��С��', 'IS')
INSERT INTO Teacher VALUES ('05003', '��Сǿ', 'CS')
INSERT INTO Teacher VALUES ('05004', '��С��', 'CE')
GO

INSERT INTO Course VALUES (1, '�ߵ���ѧ', 4, '05003')
INSERT INTO Course VALUES (2, '���ݿ�ԭ��', 5, '05003')
INSERT INTO Course VALUES (3, '����ϵͳ', 3, '05001')
INSERT INTO Course VALUES (4, '��Ϣϵͳ', 4, '05002')
GO

INSERT INTO SC VALUES ('08001', 1, 92)
INSERT INTO SC VALUES ('08001', 2, 85)
INSERT INTO SC VALUES ('08001', 3, 88)
INSERT INTO SC VALUES ('08002', 2, 90)
INSERT INTO SC VALUES ('08002', 3, 80)
GO

-- =============================================
-- ��������SQL�Ƿ�ɹ�
-- =============================================
SELECT * FROM Student
SELECT * FROM Teacher
SELECT * FROM Course
SELECT * FROM SC
GO

-- 1 �г�ѡ���������ڵ���2�Ŀγ̵ı�š����Ƽ�ѡ�������������γ̱�ŵ��������򣨽�ѡ������������Ϊcount������5�֣�
SELECT cno, COUNT(sno) AS cnt
FROM SC
GROUP BY cno
HAVING COUNT(*) >= 2
ORDER BY cno

-- 2 ��ѯѡ�ޡ����ݿ�ԭ����ѧ����ѧ�š�������ϵ�𡣣�5�֣�
SELECT S.sno, S.sname, S.sdept
FROM Student S INNER JOIN SC ON	S.sno = SC.sno
               INNER JOIN Course C ON SC.cno = C.cno
WHERE C.cname='���ݿ�ԭ��';


-- 5 ������и���
INSERT INTO Course VALUES (5, '�߼����ݿ�', 2, '05004')

UPDATE Course
SET ccredit = ccredit * 1.5
WHERE cname = '�߼����ݿ�';
  
DELETE FROM Course WHERE tno =
(SELECT tno FROM Teacher WHERE tname = '��С��');

-- 6 ��ѯѡ����ȫ���γ̵�ѧ����ѧ�ź�����
SELECT S.sno, S.sname
FROM Student AS S
WHERE NOT EXISTS
	(SELECT *
	 FROM Course AS C
	 WHERE NOT EXISTS
		(SELECT *
		 FROM SC
		 WHERE SC.sno = S.sno AND SC.cno = C.cno)
	);