-- =============================================
-- ת���½����ݿ�
-- =============================================
USE tempdb
GO

DROP TABLE [Borrow]
DROP TABLE [Book]
DROP TABLE [Category]
DROP TABLE [Reader]

-- =============================================
-- �������ݱ�
-- =============================================

-- ----------------------------------------
-- ͼ�����
-- ----------------------------------------
CREATE TABLE [Category]
(
	[id]		CHAR(2),
	[name]		VARCHAR(20)	NOT NULL,		-- ͼ���������
	CONSTRAINT [Category_PK] PRIMARY KEY([id])
)
GO

-- ----------------------------------------
-- ͼ��
-- ----------------------------------------
CREATE TABLE [Book]
(
	[id]		CHAR(2),	
	[title]		VARCHAR(80)	NOT NULL,		-- ����
	[author]	VARCHAR(80)	NOT NULL,		-- ����
	[publisher]	VARCHAR(80)	NOT NULL,
	[pubDate]	DATETIME	NOT NULL,		-- ��������
	[copyCount]	INT		NOT NULL,		-- ��������
	[categoryId]	CHAR(2)	NOT NULL,
	CONSTRAINT [Book_PK] PRIMARY KEY([id]),
	CONSTRAINT [Book_Category_FK] FOREIGN KEY([categoryId]) REFERENCES [Category]([id])
)
GO

-- ----------------------------------------
-- ����
-- ----------------------------------------
CREATE TABLE [Reader]
(
	[id]		CHAR(2),
	[name]		VARCHAR(20)	NOT NULL,		-- ��������
	[gender]	CHAR(2)	NOT NULL,		-- �Ա�
	[birthday]	DATETIME	NOT NULL,		-- ��������
	[tel]		VARCHAR(20)	NOT NULL,		-- �绰����
	CONSTRAINT [Reader_PK] PRIMARY KEY([id])
)
GO

-- ----------------------------------------
-- ���� ��ϵ
-- ----------------------------------------
CREATE TABLE [Borrow]
(
	[readerId]	CHAR(2),
	[bookId]	CHAR(2),
	[borrowDate]	DATETIME	NOT NULL,		-- ��������
	[returnDate]	DATETIME,				-- ��������
	CONSTRAINT [Borrow_PK] PRIMARY KEY([bookId], [readerId]),
	CONSTRAINT [Borrow_Book_FK] FOREIGN KEY([bookId]) REFERENCES [Book]([id]),
	CONSTRAINT [Borrow_Reader_FK] FOREIGN KEY([readerId]) REFERENCES [Reader]([id])
)
GO

-- =============================================
-- ������������
-- =============================================

INSERT INTO [Category] VALUES ('C1', '�Ƽ�')
INSERT INTO [Category] VALUES ('C2', '��ѧ')

INSERT INTO [Book] VALUES ('B1', 'ʱ���ʷ', '����', '��', '2008-10-01', 5,'C1')
INSERT INTO [Book] VALUES ('B2', '��������', '�޹���', '��', '2009-06-01', 10,'C2')

INSERT INTO [Reader] VALUES ('R1', '����', '��', '1991-02-19',	'13811122233')
INSERT INTO [Reader] VALUES ('R2', '����', 'Ů', '1990-01-09',	'13911122233')

INSERT INTO [Borrow] VALUES ('R1', 'B1', '2010-06-21', NULL)
INSERT INTO [Borrow] VALUES ('R1', 'B2', '2010-06-21', NULL)
INSERT INTO [Borrow] VALUES ('R2', 'B2', '2010-06-21', NULL)
GO

-- =============================================
-- ��������SQL�Ƿ�ɹ�
-- =============================================

SELECT * FROM [Category]
SELECT * FROM [Book]
SELECT * FROM [Reader]
SELECT * FROM [Borrow]
GO
