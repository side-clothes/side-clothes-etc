CREATE DATABASE IF NOT EXISTS mmbs_db ;
USE mmbs_db;

create table ask(
 id INT AUTO_INCREMENT PRIMARY KEY ,
 ask_writer VARCHAR(100) NOT NULL,
 ask_sort INT,
 ask_title VARCHAR(100) NOT NULL,
 ask_content TEXT NOT NULL,
 ask_datetime DATETIME ,
 ask_status INT,
 ask_reply VARCHAR(255)
); 

create table cart(
 id INT AUTO_INCREMENT PRIMARY KEY,
 cart_user_id VARCHAR(100) ,
 cart_product_id INT ,
 cart_product_mame VARCHAR(50),
 cart_product_image VARCHAR(255),
 cart_product_price INT,
 cart_product_amount INT
);

create table gift(
 gift_code INT PRIMARY KEY,
 gift_name VARCHAR(255),
 gift_image VARCHAR(255)
); 

create table `like`(
 id INT PRIMARY KEY AUTO_INCREMENT,
 like_product_id int,
 like_user_id VARCHAR(50)
);

create table order_check(
 order_number BIGINT PRIMARY KEY,
 product_price INT,
 product_title VARCHAR(100),
 product_image_url VARCHAR(255),
 product_count INT,
 order_datetime DATETIME,
 order_status INT,
 order_total_price INT,
 order_ship_company VARCHAR(100)
);

create table order_detail(
 order_detail_seq INT PRIMARY KEY AUTO_INCREMENT,
 order_number INT,
 product_id INT,
 product_price INT,
 product_title VARCHAR(100),
 product_image_url VARCHAR(255),
 product_count INT
);

create table `order`(
 order_number BIGINT PRIMARY KEY,
 order_user_whether BOOLEAN,
 order_guest_password VARCHAR(50),
 order_user_id VARCHAR(50),
 order_gift_code INT,
 order_user_name VARCHAR(50),
 order_user_phone VARCHAR(50),
 order_user_email VARCHAR(50),
 order_datetime DATETIME,
 order_reciept_name VARCHAR(50),
 order_reciept_phone VARCHAR(50),
 order_ship_address VARCHAR(50),
 order_ship_address_detail VARCHAR(50),
 order_total_price INT,
 order_status INT,
 order_ship_company VARCHAR(50),
 order_ship_number INT,
 order_ship_message VARCHAR(50)
);

create table product(     -- 수정 -- 
 id BIGINT PRIMARY KEY AUTO_INCREMENT,
 productGenre VARCHAR(50),
 productSubGenre VARCHAR(50),
 productIsbn BIGINT,
 productTitle VARCHAR(50),
 product_manufacturer VARCHAR(50),
 productPublicationDate DATETIME,
 productPrice INT,
 productSalesPrice INT,
 productStock INT,
 productLike INT,
 productIntroduceDtl VARCHAR(255),
 productImageUrl VARCHAR(255),
 productSalesCount INT
);


create table recommend(
 id BIGINT PRIMARY KEY AUTO_INCREMENT,
 recommended_user_id VARCHAR(50),
 recommending_user_id VARCHAR(50)
);

create table review(
 id BIGINT PRIMARY KEY AUTO_INCREMENT,
 review_writer_id INT,
 review_score INT,
 review_content TEXT,
 review_image VARCHAR(255),
 review_datetime DATETIME
);

create table user(
 id VARCHAR(50) PRIMARY KEY,
 user_password VARCHAR(50),
 user_email VARCHAR(50),
 user_address VARCHAR(50),
 user_address_detail VARCHAR(50),
 user_name VARCHAR(50),
 user_phone VARCHAR(50),
 user_birth DATE,
 user_sign_up_date DATE,
 user_withdraw DATE 
);

