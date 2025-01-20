-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mmbs_database` DEFAULT CHARACTER SET utf8mb4;
USE `mmbs_database`;
-- -----------------------------------------------------
-- Table `mmbs_database`.`order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mmbs_database`.`orders` (
  -- 주문번호 uuid
  `order_number` VARCHAR(45),
  -- 회원여부
  `order_user_whether` boolean not null,
  -- 비회원 비밀번호
  `order_guest_password` VARCHAR(20),
  -- 회원 아이디
  `order_user_id` VARCHAR(45),
  -- 사은품
  `order_gift_code` int,
  -- 주문자 이름
  `order_user_name` VARCHAR(45) NOT NULL,
  -- 주문자 전화번호
  `order_user_phone` VARCHAR(45) NOT NULL,
  -- 주문자 이메일
  `order_user_email` VARCHAR(45) NOT NULL,
  -- 주문 날짜
  `order_datetime` DATETIME NOT NULL,
  -- 수령인 이름
  `order_reciept_name` VARCHAR(45) NOT NULL,
  -- 수령인 전화 번호
  `order_reciept_phone` VARCHAR(45) NOT NULL,
  -- 수령인 주소
  `order_ship_address` TEXT NOT NULL,
  -- 수령인 상세 주소
  `order_ship_address_detail` TEXT NOT NULL,
  -- 최종 결제 금액
  `order_total_price` INT NOT NULL,
  -- 주문 상태
  `order_status` INT NOT NULL,
  -- 배송 회사
  `order_ship_company` VARCHAR(45),
  -- 송장번호
  `order_ship_number` INT,
  -- 배송 메세지
  `order_ship_message` TEXT,
  PRIMARY KEY (`order_number`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_general_ci;
-- -----------------------------------------------------
-- Table `mmbs_database`.`order_detail`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mmbs_database`.`order_detail` (
  -- 주문상세 시퀀스
  `order_detail_seq` int AUTO_INCREMENT,
  -- 주문번호
  `order_number` VARCHAR(50) NOT NULL,
  -- 제품 아이디
  `product_id` int NOT NULL,
  -- 개당 금액
  `product_price` int NOT NULL,
  -- 갯수
  `product_count` int NOT NULL,
  PRIMARY KEY (`order_detail_seq`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_general_ci;
-- -----------------------------------------------------
-- Table `mmbs_database`.`like`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mmbs_database`.`like` (
  -- 좋아요 시퀀스
  `like_seq` int AUTO_INCREMENT,
  -- 좋아요한 제품 아이디
  `like_product_id` int NOT NULL,
  -- 좋아요한 유저의 아이디
  `like_user_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`like_seq`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_general_ci;
-- -----------------------------------------------------
-- Table `mmbs_database`.`product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mmbs_database`.`product` (
  -- 고유번호
  `product_seq` INT AUTO_INCREMENT NOT NULL,
  -- 장르 [국내도서, 외국도서, 전집, 토이/교구, 부모님의 서재]
  `product_genre` VARCHAR(45) NOT NULL,
  -- 세부장르
  `product_sub_genre` VARCHAR(45) NOT NULL,
  -- 고유번호
  `product_isbn` INT,
  -- 제목
  `product_title` text NOT NULL,
  -- 저자
  `product_writer` VARCHAR(45) NULL,
  -- 출판사
  `product_publisher` VARCHAR(45),
  -- 연령 [0~3세, 4~7세, 부모]
  `product_age` VARCHAR(45),
  -- 연랑 세부 장르
  `product_sub_age` VARCHAR(45),
  -- 출판일
  `product_publication_date` DATE NOT NULL,
  -- 가격
  `product_price` INT NOT NULL,
  -- 할인가격
  `product_sales_price` INT NOT NULL,
  -- 재고
  `product_stock` INT DEFAULT 0,
  -- 좋아요
  `product_like` INT DEFAULT 0,
  -- 상세 설명
  `product_introduce_dtl` text NOT NULL,
  -- 이미지
  `product_image_url` text NOT NULL,
  -- 판매량
  `product_sales_count` int DEFAULT 0,
  PRIMARY KEY (`product_seq`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_general_ci;
-- -----------------------------------------------------
-- Table `mmbs_database`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mmbs_database`.`user` (
  -- 아이디
  `user_id` VARCHAR(45) NOT NULL,
  -- 비밀번호
  `user_password` VARCHAR(200) NOT NULL,
  -- 이메일
  `user_email` VARCHAR(45) NOT NULL,
  -- 주소
  `user_address` TEXT NOT NULL,
  -- 상세 주소
  `user_address_detail` TEXT NOT NULL,
  -- 이름
  `user_name` VARCHAR(45) NOT NULL,
  -- 전화번호
  `user_phone` VARCHAR(45) NOT NULL,
  -- 아이 생일
  `user_kid_birth` VARCHAR(45) DEFAULT NULL,
  -- 가입 날짜
  `user_sign_up_date` DATETIME NOT NULL,
  -- 탈퇴 날짜
  `user_withdraw` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_general_ci;
-- -----------------------------------------------------
-- Table `mmbs_database`.`recommend`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mmbs_database`.`recommend` (
    -- 추천인 테이블 시퀀스
  `recommend_seq` int AUTO_INCREMENT,
    -- 추천인 (추천 당한 사람)
    `recommended_user_id` VARCHAR(45) NOT NULL,
    -- 추천 (추천한 사람)
    `recommending_user_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`recommend_seq`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_general_ci;
-- -----------------------------------------------------
-- Table `mmbs_database`.`ask`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mmbs_database`.`ask` (
    -- 문의 번호
  `ask_id` int NOT NULL AUTO_INCREMENT,
    -- 작성자 아이디 (참조)
  `ask_writer` VARCHAR(45) NOT NULL,
    -- 문의 카테고리
  `ask_sort` VARCHAR(45) NOT NULL,
    -- 문의 내용
  `ask_content` TEXT NOT NULL,
    -- 문의 날짜
  `ask_datetime` VARCHAR(10) NOT NULL,
    -- 문의 상태
  `ask_status` VARCHAR(45),
    -- 문의 답변
    `ask_reply` TEXT,
  PRIMARY KEY (`ask_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_general_ci;
-- -----------------------------------------------------
-- Table `mmbs_database`.`cart`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mmbs_database`.`cart` (
    -- 카트 시퀀스
  `cart_id` int NOT NULL AUTO_INCREMENT,
  -- 유저 아이디
  `cart_user_id` VARCHAR(45) NOT NULL,
  -- 제품 아이디
  `cart_product_id` INT NOT NULL,
  -- 제품 이름
  `cart_product_name` VARCHAR(200) NOT NULL,
  -- 제품 이미지
  `cart_product_image` VARCHAR(200) NOT NULL,
  -- 제품 개당 가격
  `cart_product_price` INT,
  -- 제품 개 수
  `cart_product_amount` INT,
  PRIMARY KEY (`cart_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_general_ci;
-- -----------------------------------------------------
-- Table `mmbs_database`.`gift`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mmbs_database`.`gift` (
    -- 사은품 코드
  `gift_code` VARCHAR(2),
    -- 사은품 이름
    `gift_name` VARCHAR(255) NOT NULL,
    -- 사은품 이미지
    `gift_image` TEXT NOT NULL,
  PRIMARY KEY (`gift_code`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_general_ci;