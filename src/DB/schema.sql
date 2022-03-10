DROP DATABASE IF EXISTS jsp;
CREATE DATABASE jsp;
USE jsp;

CREATE TABLE article (
	id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
	regdate DATETIME NOT NULL,
	updateDate DATETIME NOT NULL,
	title CHAR(100) NOT NULL,
	`body` TEXT NOT NULL
);

INSERT INTO article
SET regdate = NOW(),
updateDate = NOW(),
title = '제목1',
`body` = '내용1';

INSERT INTO article
SET regdate = NOW(),
updateDate = NOW(),
title = '제목2',
`body` = '내용2';

INSERT INTO article
SET regdate = NOW(),
updateDate = NOW(),
title = '제목3',
`body` = '내용3';


CREATE TABLE MEMBER (
	id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
	regdate DATETIME NOT NULL,
	updateDate DATETIME NOT NULL,
	loginId CHAR(20) NOT NULL,
	loginPw CHAR(60) NOT NULL,
	`name` CHAR(20) NOT NULL,
	authLevel SMALLINT(2) UNSIGNED DEFAULT 3 COMMENT '권한레벨 (3=일반,7=관리자)',
	nickname CHAR(20) NOT NULL,
	cellphoneNo CHAR(20) NOT NULL,
	email CHAR(50) NOT NULL,
	delstatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '탈퇴여부 (0=탈퇴전,1=탈퇴)',
	delDate DATETIME COMMENT '탈퇴날짜'
);

# 회원 테스트 관리자회원 생성
INSERT INTO MEMBER
SET regdate = NOW(),
updateDate = NOW(),
loginId = 'admin',
loginPw = 'admin',
`name` = '관리자',
authLevel = 7,
nickname = '관리자',
cellphoneNo = '01052397087',
email = 'yes3144@nate.com'


# 회원 테스트 일반회원 생성
INSERT INTO MEMBER
SET regdate = NOW(),
updateDate = NOW(),
loginId = 'user1',
loginPw = '1234',
`name` = '사용자1',
nickname = '사용자1',
cellphoneNo = '01072397087',
email = 'jjh3956@naver.com'


# 회원 테스트 일반회원2 생성
INSERT INTO MEMBER
SET regdate = NOW(),
updateDate = NOW(),
loginId = 'user2',
loginPw = '1234',
`name` = '사용자2',
nickname = '사용자2',
cellphoneNo = '01072396666',
email = 'jjh1234@naver.com'

# 게시물 테이블에 회원정보 추가
ALTER TABLE article ADD COLUMN memberId INT(10) UNSIGNED NOT NULL AFTER `updateDate`;
DESC article;

# 기존 게시물의 작성자를 2번 으로 지정
UPDATE article
SET memberId = 2
WHERE memberId = 0;

# 게시판 테이블생성
CREATE TABLE board (
	id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
	regdate DATETIME NOT NULL,
	updateDate DATETIME NOT NULL,
	`code` CHAR(50) NOT NULL UNIQUE COMMENT 'notice(공지사항),free1(자유게시판1),free2(자유게시판),...',
	`name` CHAR(50) NOT NULL UNIQUE COMMENT '게시판이름',
	delstatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '삭제여부 (0=탈퇴전,1=탈퇴)',
	delDate DATETIME COMMENT '삭제날짜'
);

# 기본 게시판 생성
INSERT INTO Board
SET regDate = NOW(),
updateDate = NOW(),
`code`= 'notice',
`name`= '공지사항'; 


# 자유 게시판 생성
INSERT INTO Board
SET regDate = NOW(),
updateDate = NOW(),
`code`= 'free1',
`name`= '자유'; 


# 게시판 테이블에 BoardId 칼럼 추가
ALTER TABLE article ADD COLUMN boardId INT(10) UNSIGNED NOT NULL AFTER memberId;
SELECT * FROM article;

# 1,2번 게시물을 공지사항 게시물로 지정
UPDATE article
SET BoardId = 1
WHERE id IN (1,2);

# 3번 게시물을 자유게시판 게시물로 지정
UPDATE article
SET BoardId = 2
WHERE id IN (3);

# 게시물 개수 늘리기
/*
insert into article
(
    regDate, updateDate, memberId, boardId, title, `body`
)
select now(), now(), floor(rand() * 2) + 1, FLOOR(RAND() * 2) + 1, concat('제목_', rand()), CONCAT('내용_', RAND())
from article;
*/