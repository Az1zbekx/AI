DROP TABLE IF EXISTS test_identity;

CREATE TABLE test_identity(
    ID int IDENTITY,
    NAME NVARCHAR(10)
)

INSERT INTO test_identity(NAME)
VALUES 
    ('A'),
    ('B'),
    ('C'),
    ('D'),
    ('E')


SELECT * FROM test_identity;


DELETE test_identity;

INSERT INTO test_identity(NAME)
VALUES 
    ('A'),
    ('B'),
    ('C'),
    ('D'),
    ('E')


/*
DELETE ishlatilgan paytida table ichidagi datalar tozalanadi va table o'chib ketmaydi
*/


SELECT * FROM test_identity

TRUNCATE TABLE test_identity;

INSERT INTO test_identity(NAME)
VALUES 
    ('A'),
    ('B'),
    ('C'),
    ('D'),
    ('E')

/*
TRUNCATE ishlatilgan paytda esa table o'chib ketib qaytadan yaraladi.
*/

DROP TABLE test_identity;

/*
DROP esa table o'chirib yuboradi yoki database ni
*/



DROP TABLE IF EXISTS data_type_demo;
CREATE TABLE data_type_demo (
    id INT,
    big_number BIGINT,
    small_number SMALLINT,
    tiny_number TINYINT,
    decimal_value DECIMAL(10,2),
    numeric_value NUMERIC(10,3),
    float_value FLOAT,
    real_value REAL,
    money_value MONEY,
    small_money SMALLMONEY,
    bit_value BIT,
    char_value CHAR(10),
    varchar_value VARCHAR(50),
    text_value TEXT,
    nchar_value NCHAR(10),
    nvarchar_value NVARCHAR(50),
    ntext_value NTEXT,
    date_value DATE,
    time_value TIME,
    datetime_value DATETIME,
    datetime2_value DATETIME2,
    smalldatetime_value SMALLDATETIME,
    datetimeoffset_value DATETIMEOFFSET,
    binary_value BINARY(5),
    varbinary_value VARBINARY(10),
    unique_id UNIQUEIDENTIFIER
);


INSERT INTO data_type_demo VALUES (
    1,
    9000000000,
    32000,
    200,
    12345.67,
    98765.432,
    123.456,
    78.90,
    1500.75,
    500.50,
    1,
    'Hello',
    'SQL Server',
    'This is text',
    N'World',
    N'Unicode text',
    N'Unicode long text',
    '2026-02-26',
    '15:30:00',
    '2026-02-26 15:30:00',
    '2026-02-26 15:30:00.1234567',
    '2026-02-26 15:30:00',
    '2026-02-26 15:30:00 +05:00',
    0x1234567890,
    0x123456,
    NEWID()
);


SELECT * FROM data_type_demo;



DROP TABLE IF EXISTS student;

CREATE TABLE student(
    classes INT,
    tuition_per_class INT,
    total_tuition as (classes * tuition_per_class)
);


INSERT INTO student(classes, tuition_per_class)
VALUES
    (1,2),
    (3,4),
    (5,6),
    (7,8)


SELECT * FROM student;



