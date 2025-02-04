-- -----------------------------------------------------
DROP DATABASE IF EXISTS `a1`;
CREATE SCHEMA IF NOT EXISTS `a1` DEFAULT CHARACTER SET utf8mb4;
USE `a1`;
-- -----------------------------------------------------
-- Table `a1`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `a1`.`users` (
  -- 회원 정보 PK
  `id` BIGINT AUTO_INCREMENT PRIMARY KEY,
  -- 아이디
  `user_id` VARCHAR(45) NOT NULL ,
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
  -- 생일
  `user_birth` VARCHAR(45) NOT NULL,
  -- 가입 날짜
  `sign_up_date` DATETIME NOT NULL,
  -- 탈퇴 날짜
  `withdraw_date` DATETIME NULL DEFAULT NULL
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_general_ci;

-- -----------------------------------------------------
-- Table `a1`.`product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `a1`.`products` (
  -- 고유번호
  `product_id` BIGINT AUTO_INCREMENT PRIMARY KEY,
  -- 메인 카테고리 [아우터, 니트, 재킷/베스트, 티셔츠, 셔츠, 팬츠, 패션잡화]
  `main_category` ENUM('아우터', '니트', '재킷/베스트', '티셔츠', '셔츠', '팬츠', '패션잡화'),
  -- 추천 카테고리 [BEST_SELLERS 랭킹, SALE 세일, BRAND 브랜드, NEW_ARRIVALS 신상]
  `recommend_category` ENUM('랭킹','세일','브랜드','신상품'),
  -- 제품번호
  `product_number` VARCHAR(255),
  -- 제품명
  `product_name` VARCHAR(255) NOT NULL,
  -- 브랜드
  `product_brand` VARCHAR(45),
  -- 가격
  `product_price` INT NOT NULL,
  -- 재고
  `product_stock` INT DEFAULT 0,
  -- 좋아요
  `product_like` INT DEFAULT 0,
  -- 상세 설명
  `product_introduce_dtl` text NOT NULL,
  -- 썸네일 이미지
  `product_thunbnail_image_url` text NOT NULL,
  -- 판매량
  `product_sales_count` int DEFAULT 0
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_general_ci;

-- -----------------------------------------------------
-- Table `a1`.`product_options`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `a1`.`product_options` (
	-- 제품 옵션 테이블 PK
    `product_option_id` BIGINT AUTO_INCREMENT PRIMARY KEY,
    -- 제품 테이블 PK (FOREIGN KEY)
    `product_id` BIGINT NOT NULL,
	-- 사이즈
    `product_size` VARCHAR(45) NOT NULL,
    -- 색상
    `product_color` VARCHAR(45) NOT NULL,
	FOREIGN KEY (product_id) REFERENCES `products`(product_id) ON DELETE CASCADE
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_general_ci;

-- -----------------------------------------------------
-- Table `a1`.`product_image`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `a1`.`product_images` (
	-- 상품 이미지 테이블 PK
    `product_image_id` BIGINT auto_increment PRIMARY KEY, 
    -- 상품 테이블 PK
    `product_id`BIGINT NOT NULL,
	-- 상품 이미지
    `product_image` TEXT NOT NULL,
    FOREIGN KEY (product_id) REFERENCES `products` (product_id) ON DELETE CASCADE
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_general_ci;

-- -----------------------------------------------------
-- Table `a1`.`delivery_addresses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `a1`.`delivery_addresses` (
  -- 배송지 관리 테이블 PK
  `delivery_address_id` BIGINT AUTO_INCREMENT PRIMARY KEY,
  -- 수령인 이름
  `order_reciept_name` VARCHAR(45) NOT NULL,
  -- 수령인 전화 번호
  `order_reciept_phone` VARCHAR(45) NOT NULL,
  -- 수령인 주소
  `order_ship_address` TEXT NOT NULL,
  -- 수령인 상세 주소
  `order_ship_address_detail` TEXT NOT NULL
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_general_ci;

-- -----------------------------------------------------
-- Table `a1`.`sale_coupons`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `a1`.`sale_coupons` (
    -- 할인 코드
    `coupon_id` BIGINT AUTO_INCREMENT PRIMARY KEY,
    -- 쿠폰 이름
    `coupon_name` VARCHAR(255) NOT NULL,
    -- 쿠폰 할인율
    `sale_percents` INT NOT NULL,
    -- 쿠폰 발급일
    `coupon_issue_date` DATE NOT NULL,
    -- 쿠폰 만료일
    `coupon_expiration_date` DATE NOT NULL
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_general_ci;

-- -----------------------------------------------------
-- Table `a1`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `a1`.`orders` (
  -- 주문번호 uuid
  `order_id` BIGINT AUTO_INCREMENT PRIMARY KEY,
  -- 회원 아이디 *****
  `id` BIGINT NOT NULL,
  -- 주문자 전화번호
  `order_user_phone` VARCHAR(45) NOT NULL,
  
  -- 할인코드 *******
  `coupon_id` BIGINT NOT NULL,
  
  -- 주문 날짜
  `order_datetime` DATETIME NOT NULL,
  
  -- 배송지 관리 테이블 PK *****
  `delivery_address_id` BIGINT NOT NULL,
  
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
  -- 주문 상태 (ENUM)
  `order_status` ENUM('주문 완료','주문 취소') NOT NULL,
  -- 배송 회사
  `order_ship_company` VARCHAR(45),
  -- 송장번호
  `order_ship_number` INT,
  -- 배송 메세지
  `order_ship_message` TEXT,
  FOREIGN KEY (delivery_address_id) REFERENCES `delivery_addresses` (delivery_address_id)  ON DELETE CASCADE,
  FOREIGN KEY (coupon_id) REFERENCES `sale_coupons` (coupon_id) ON DELETE CASCADE,
  FOREIGN KEY (id) REFERENCES `users` (id) ON DELETE CASCADE
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_general_ci;

-- -----------------------------------------------------
-- Table `a1`.`order_detail`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `a1`.`order_details` (
  -- 주문상세 시퀀스
  `order_detail_seq` BIGINT AUTO_INCREMENT PRIMARY KEY,
  -- 주문번호 ******
  `order_id` BIGINT NOT NULL,
  -- 제품 아이디 *****
  `product_id` BIGINT NOT NULL,
  -- 개당 금액
  `product_price` int NOT NULL,
  -- 제품 이름
  `product_title` VARCHAR(255),
  -- 제품 이미지
  `product_image_url` VARCHAR(255),
  -- 갯수
  `product_count` int NOT NULL,
  FOREIGN KEY (order_id) REFERENCES `orders`(order_id)  ON DELETE CASCADE,
  FOREIGN KEY (product_id) REFERENCES `products`(product_id)  ON DELETE CASCADE
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_general_ci;

-- -----------------------------------------------------
-- Table `a1`.`asks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `a1`.`asks` (
    -- 문의 번호
	`ask_id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    -- 작성자 아이디 (참조) *****
	`id`BIGINT NOT NULL,
    -- 문의 카테고리
	`ask_sort` ENUM('제품 문의','배송 문의','기타 문의') NOT NULL,
	-- 문의 제목
	`ask_title` VARCHAR(255) NOT NULL,
    -- 문의 내용
	`ask_content` TEXT NOT NULL,
    -- 문의 날짜
	`ask_datetime` VARCHAR(10) NOT NULL,
    -- 문의 상태 (진행 중, 답변 완료)
	`ask_status` VARCHAR(45),
    -- 문의 답변
	`ask_reply` TEXT,
    FOREIGN KEY (id) REFERENCES `users`(id) ON DELETE CASCADE
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_general_ci;

-- -----------------------------------------------------
-- Table `a1`.`carts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `a1`.`carts` (
	-- 카트 시퀀스
  `cart_id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  -- 유저 아이디 *****
  `id` BIGINT NOT NULL,
  -- 제품 아이디 *****
  `product_id` BIGINT NOT NULL,
  -- 제품 이름
  `cart_product_name` VARCHAR(200) NOT NULL,
  -- 제품 가격
  `cart_product_price` INT,
  -- 제품 썸네일 이미지
  `product_thunbnail_image_url` VARCHAR(200) NOT NULL,
  -- 제품 개수
  `cart_product_amount` INT,
  FOREIGN KEY (id) REFERENCES `users`(id) ON DELETE CASCADE,
  FOREIGN KEY (product_id) REFERENCES `products`(product_id) ON DELETE CASCADE
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_general_ci;

-- -----------------------------------------------------
-- Table `a1`.`like`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `a1`.`likes` (
  -- 좋아요 시퀀스
  `like_id` BIGINT AUTO_INCREMENT PRIMARY KEY,
  -- 좋아요한 제품 아이디
  `product_id` BIGINT NOT NULL,
  -- 좋아요한 유저의 아이디
  `id` BIGINT NOT NULL
  )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_general_ci;

-- -----------------------------------------------------
-- Table `a1`.`order_checks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `a1`.`order_checks` (
	-- 주문 내역 확인 아이디 
    `order_check_id` BIGINT PRIMARY KEY AUTO_INCREMENT,
    -- 주문 아이디
    `order_id`  BIGINT NOT NULL,
    -- 재품 아이디
    `product_id`  BIGINT NOT NULL,
    -- 개당 금액
    `product_price` INT,
    -- 제품 이름
    `product_title` VARCHAR(255),
    -- 제품 이미지
    `product_image_url` VARCHAR(255),
    -- 갯수
    `product_count` INT,
	-- 주문 날짜
    `order_datetime` DATE,
    -- 주문 상태
    `order_status` INT,
    -- 최종 결제 금액
    `order_total_price` INT,
    -- 배송 회사
    `order_ship_company` VARCHAR(255),
    FOREIGN KEY (order_id) REFERENCES `orders`(order_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES `products`(product_id) ON DELETE CASCADE
 )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_general_ci;

-- -----------------------------------------------------
-- Table `a1`.`reviews`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `a1`.`reviews` (
    `review_id` BIGINT AUTO_INCREMENT PRIMARY KEY,
    -- 리뷰 작성자 아이디
    `id` BIGINT NOT NULL,
    -- 제품 목록
    `product_id` BIGINT NOT NULL ,
    -- 별점
    `review_score` INT,
    -- 리뷰 내용
    `review_content` TEXT,
    -- 리뷰 이미지
    `review_image` VARCHAR(255),
    -- 리뷰 날짜
    `review_datetime` DATE,
    FOREIGN KEY (id) REFERENCES `users` (id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES `products`(product_id) ON DELETE CASCADE
 )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_general_ci;