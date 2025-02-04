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
  `user_id` VARCHAR(45) NOT NULL UNIQUE,
  -- 비밀번호
  `user_password` VARCHAR(200) NOT NULL,
  -- 이메일
  `user_email` VARCHAR(100) NOT NULL UNIQUE,
  -- 주소
  `user_address` TEXT NOT NULL,
  -- 상세 주소
  `user_address_detail` TEXT NOT NULL,
  -- 이름
  `user_name` VARCHAR(45) NOT NULL,
  -- 전화번호
  `user_phone` VARCHAR(45) NOT NULL UNIQUE,
  -- 생일
  `user_birth` DATE NOT NULL,
  -- 가입 날짜
  `sign_up_date` DATETIME NOT NULL,
  -- 탈퇴 날짜
  `withdraw_date` DATETIME DEFAULT NULL
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_general_ci;

-- -----------------------------------------------------
-- Table `a1`.`products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `a1`.`products` (
  -- 고유번호
  `product_id` BIGINT AUTO_INCREMENT PRIMARY KEY,
  -- 메인 카테고리
  `main_category` ENUM('아우터', '니트', '재킷/베스트', '티셔츠', '셔츠', '팬츠', '패션잡화'),
  -- 추천 카테고리
  `recommend_category` ENUM('랭킹','세일','브랜드','신상품'),
  -- 제품번호
  `product_number` VARCHAR(255) UNIQUE NOT NULL,
  -- 제품명
  `product_name` VARCHAR(255) NOT NULL,
  -- 브랜드
  `product_brand` VARCHAR(100),
  -- 가격
  `product_price` INT NOT NULL,
  -- 재고
  `product_stock` INT DEFAULT 0,
  -- 좋아요
  `product_like` INT DEFAULT 0,
  -- 상세 설명
  `product_introduce_dtl` TEXT NOT NULL,
  -- 썸네일 이미지
  `product_thumbnail_image_url` TEXT NOT NULL,
  -- 판매량
  `product_sales_count` INT DEFAULT 0
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
  FOREIGN KEY (`product_id`) REFERENCES `products`(`product_id`) ON DELETE CASCADE
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_general_ci;

-- -----------------------------------------------------
-- Table `a1`.`product_images`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `a1`.`product_images` (
  -- 상품 이미지 테이블 PK
  `product_image_id` BIGINT AUTO_INCREMENT PRIMARY KEY,
  -- 상품 테이블 PK
  `product_id` BIGINT NOT NULL,
  -- 상품 이미지
  `product_image` TEXT NOT NULL,
  FOREIGN KEY (`product_id`) REFERENCES `products`(`product_id`) ON DELETE CASCADE
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
  `order_receipt_name` VARCHAR(45) NOT NULL,
  -- 수령인 전화번호
  `order_receipt_phone` VARCHAR(45) NOT NULL,
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
  `sale_percent` INT NOT NULL,
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
  -- 주문번호
  `order_id` BIGINT AUTO_INCREMENT PRIMARY KEY,
  -- 회원 아이디
  `user_id` BIGINT NOT NULL,
  -- 주문자 전화번호
  `order_user_phone` VARCHAR(45) NOT NULL,
  -- 할인코드
  `coupon_id` BIGINT NOT NULL,
  -- 주문 날짜
  `order_datetime` DATETIME NOT NULL,
  -- 배송지 관리 테이블 PK
  `delivery_address_id` BIGINT NOT NULL,
  -- 수령인 이름
  `order_receipt_name` VARCHAR(45) NOT NULL,
  -- 수령인 전화 번호
  `order_receipt_phone` VARCHAR(45) NOT NULL,
  -- 수령인 주소
  `order_ship_address` TEXT NOT NULL,
  -- 수령인 상세 주소
  `order_ship_address_detail` TEXT NOT NULL,
  -- 최종 결제 금액
  `order_total_price` INT NOT NULL,
  -- 주문 상태
  `order_status` ENUM('주문 완료','주문 취소') NOT NULL,
  -- 배송 회사
  `order_ship_company` VARCHAR(45),
  -- 송장번호
  `order_ship_number` VARCHAR(45) UNIQUE,
  -- 배송 메세지
  `order_ship_message` TEXT,
  FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`delivery_address_id`) REFERENCES `delivery_addresses`(`delivery_address_id`) ON DELETE CASCADE,
  FOREIGN KEY (`coupon_id`) REFERENCES `sale_coupons`(`coupon_id`) ON DELETE CASCADE
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_general_ci;

-- -----------------------------------------------------
-- Table `a1`.`order_details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `a1`.`order_details` (
  -- 주문상세 시퀀스
  `order_detail_seq` BIGINT AUTO_INCREMENT PRIMARY KEY,
  -- 주문번호
  `order_id` BIGINT NOT NULL,
  -- 제품 아이디
  `product_id` BIGINT NOT NULL,
  -- 개당 금액
  `product_price` INT NOT NULL,
  -- 제품 이름
  `product_name` VARCHAR(255) NOT NULL,
  -- 제품 이미지
  `product_image_url` TEXT NOT NULL,
  -- 갯수
  `product_count` INT NOT NULL,
  FOREIGN KEY (`order_id`) REFERENCES `orders`(`order_id`) ON DELETE CASCADE,
  FOREIGN KEY (`product_id`) REFERENCES `products`(`product_id`) ON DELETE CASCADE
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_general_ci;

-- -----------------------------------------------------
-- Table `a1`.`asks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `a1`.`asks` (
  -- 문의 번호
  `ask_id` BIGINT AUTO_INCREMENT PRIMARY KEY,
  -- 작성자 아이디
  `user_id` BIGINT NOT NULL,
  -- 문의 카테고리
  `ask_sort` ENUM('제품 문의', '배송 문의', '기타 문의') NOT NULL,
  -- 문의 제목
  `ask_title` VARCHAR(255) NOT NULL,
  -- 문의 내용
  `ask_content` TEXT NOT NULL,
  -- 문의 날짜
  `ask_datetime` DATETIME NOT NULL,
  -- 문의 상태
  `ask_status` ENUM('진행중', '답변 완료') NOT NULL,
  -- 문의 답변
  `ask_reply` TEXT,
  FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_general_ci;

-- -----------------------------------------------------
-- Table `a1`.`carts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `a1`.`carts` (
  -- 카트 시퀀스
  `cart_id` BIGINT AUTO_INCREMENT PRIMARY KEY,
  -- 유저 아이디
  `user_id` BIGINT NOT NULL,
  -- 제품 아이디
  `product_id` BIGINT NOT NULL,
  -- 제품 이름
  `cart_product_name` VARCHAR(200) NOT NULL,
  -- 제품 가격
  `cart_product_price` INT NOT NULL,
  -- 제품 썸네일 이미지
  `product_thumbnail_image_url` TEXT NOT NULL,
  -- 제품 개수
  `cart_product_amount` INT NOT NULL,
  FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`product_id`) REFERENCES `products`(`product_id`) ON DELETE CASCADE
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_general_ci;
