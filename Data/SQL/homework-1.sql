create table student(
    id INT Null,
    name NVARCHAR(255) Null,
    age Int Null
);

alter table student
alter column id int not null;




create table product(
    product_id int,
    product_name nvarchar(255),
    price DECIMAL(10,2),
    constraint product_id_unique UNIQUE(product_id) 
);

alter table product
drop constraint product_id_unique;

alter table product
add constraint product_id_name_unique unique(product_id, product_name);



create table orders(
    order_id int constraint order_id_primary PRIMARY key,
    customer_name nvarchar(255),
    order_date DATETIME2
);

alter table orders
drop constraint order_id_primary;

ALTER TABLE orders
ADD CONSTRAINT order_id_primary PRIMARY KEY(order_id);



create table category(
    category_id int primary key,
    category_name nvarchar(255)
)


create table item(
    item_id int primary key,
    item_name nvarchar(255),
    category_id int constraint category_id_foreing FOREIGN key REFERENCES category(category_id) 
);

alter table item
drop CONSTRAINT category_id_foreing;

alter table item
add CONSTRAINT category_id_foreing FOREIGN key (category_id) REFERENCES category(category_id);





create table account(
    account_id int PRIMARY key,
    balance DECIMAL(10, 2) constraint check_balance CHECK (balance >=0),
    account_type NVARCHAR(255) CONSTRAINT check_account_type CHECK(account_type = 'Saving' or account_type = 'Checking')
);

alter table account
drop CONSTRAINT check_balance;

alter table account
drop constraint check_account_type;


alter table account
add CONSTRAINT check_balance CHECK (balance >=0);

alter table account
add CONSTRAINT check_account_type CHECK(account_type = 'Saving' or account_type = 'Checking');


create table customer(
    customer_id int primary key,
    name NVARCHAR(255),
    city NVARCHAR(255) constraint city_default DEFAULT 'Unknown'
);

alter table customer
drop constraint city_default;

alter table customer
add constraint city_default DEFAULT 'Unknown' for city;



create table invoice(
    invoice_id int IDENTITY (1, 1),
    amount DECIMAL(10, 2)
);

set IDENTITY_INSERT invoice off;

INSERT into invoice(amount)
VALUES
    (5.5), (6.6), (7.7), (8.8), (9.9), (3.3) 


set IDENTITY_INSERT invoice on;


create table books(
    book_id int PRIMARY key IDENTITY(1, 1),
    title NVARCHAR(255) not null,
    price DECIMAL(10, 2) check (price > 0),
    genre NVARCHAR(255) DEFAULT 'Unknown'
)


insert into books(title, price, genre)
VALUES 
    ('A', 1.1, 'aaaa'),
    ('B', 2.2, 'bbb'),
    ('C', 3.3, DEfault);



create table book(
    book_id int PRIMARY key,
    title NVARCHAR(255),
    author NVARCHAR(255),
    publish_year int
);

create table member(
    member_id int PRIMARY key,
    name NVARCHAR(255),
    email NVARCHAR(255),
    phone_number NVARCHAR(255)
);

create table loan(
    loan_id int PRIMARY key,
    book_id int FOREIGN key REFERENCES book(book_id),
    member_id int FOREIGN key REFERENCES member(member_id),
    loan_date DATETIME2,
    return_date DATETIME2 not null
);


INSERT INTO book (book_id, title, author, publish_year)
VALUES
(1, 'Clean Code', 'Robert Martin', 2008),
(2, 'The Pragmatic Programmer', 'Andrew Hunt', 1999),
(3, 'Design Patterns', 'Erich Gamma', 1994);

INSERT INTO member (member_id, name, email, phone_number)
VALUES
(1, 'Ali', 'ali@gmail.com', '998901111111'),
(2, 'Vali', 'vali@gmail.com', '998902222222'),
(3, 'Sardor', 'sardor@gmail.com', '998903333333');


insert into loan(loan_id, loan_date, return_date)
VALUES
(1, GETDATE(), GETDATE() + 5),
(2, GETDATE(), GETDATE() + 5),
(3, GETDATE(), GETDATE() + 5)




