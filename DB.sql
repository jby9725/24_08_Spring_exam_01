CREATE DATABASE `24_08_Spring`;

USE `24_08_Spring`;

SHOW TABLES;

SELECT * FROM article;

DROP TABLE article;

CREATE TABLE article (
    `id` INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `regDate` DATETIME NOT NULL,
    `updateDate` DATETIME NOT NULL,
    `title` VARCHAR(50) NOT NULL,
    `body` TEXT NOT NULL
);

-- 문자열 붙이기 + 랜덤 수 출력
INSERT INTO article
SET regDate = NOW(),
    updateDate = NOW(),
    title = CONCAT('제목', SUBSTRING(RAND() * 1000 FROM 1 FOR 2)),
    `body` = CONCAT('내용', SUBSTRING(RAND() * 1000 FROM 1 FOR 2));
    
SELECT * FROM article;

-- 마지막에 추가된 데이터의 아이디
SELECT LAST_INSERT_ID();

-- 1부터 3까지 랜덤 수
SELECT CEILING(RAND() * 100);

-- 문자열 붙이기 + 랜덤 수 출력 업데이트
-- INSERT INTO article
-- SET regDate = NOW(),
--     updateDate = NOW(),
--     author = CEILING(RAND() * 3),   
--     title = CONCAT('제목', SUBSTRING(RAND() * 1000 FROM 1 FOR 2)),
--     `body` = CONCAT('내용', SUBSTRING(RAND() * 1000 FROM 1 FOR 2));