DROP DATABASE IF EXISTS jsp;
create database jsp;
use jsp;

create table article (
	id int(10) unsigned not null primary key auto_increment,
	regdate datetime not null,
	updateDate datetime not null,
	title char(100) not null,
	`body` text not null
);

insert into article
set regdate = now(),
updateDate = now(),
title = '제목1',
`body` = '내용1';

insert into article
set regdate = now(),
updateDate = now(),
title = '제목2',
`body` = '내용2';

insert into article
set regdate = now(),
updateDate = now(),
title = '제목3',
`body` = '내용3';


create table member (
	id int(10) unsigned not null primary key auto_increment,
	regdate datetime not null,
	updateDate datetime not null,
	loginId char(20) not null,
	loginPw char(60) not null,
	`name` char(20) not null,
	authLevel smallint(2) unsigned default 3 comment '권한레벨 (3=일반,7=관리자)',
	nickname char(20) not null,
	cellphoneNo char(20) not null,
	email char(50) not null,
	delstatus tinyint(1) unsigned not null default 0 comment '탈퇴여부 (0=탈퇴전,1=탈퇴)',
	delDate datetime comment '탈퇴날짜'
);

# 회원 테스트 관리자회원 생성
insert into member
set regdate = now(),
updateDate = now(),
loginId = 'admin',
loginPw = 'admin',
`name` = '관리자',
authLevel = 7,
nickname = '관리자',
cellphoneNo = '01052397087',
email = 'yes3144@nate.com'


# 회원 테스트 일반회원 생성
insert into member
set regdate = now(),
updateDate = now(),
loginId = 'user1',
loginPw = '1234',
`name` = '사용자1',
nickname = '사용자1',
cellphoneNo = '01072397087',
email = 'jjh3956@naver.com'


# 회원 테스트 일반회원2 생성
insert into member
set regdate = now(),
updateDate = now(),
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
create table board (
	id int(10) unsigned not null primary key auto_increment,
	regdate datetime not null,
	updateDate datetime not null,
	`code` char(50) not null unique comment 'notice(공지사항),free1(자유게시판1),free2(자유게시판),...',
	`name` char(50) not null unique comment '게시판이름',
	delstatus tinyint(1) unsigned not null default 0 comment '삭제여부 (0=탈퇴전,1=탈퇴)',
	delDate datetime comment '삭제날짜'
);

# 기본 게시판 생성
insert into Board
set regDate = now(),
updateDate = now(),
`code`= 'notice',
`name`= '공지사항'; 


# 자유 게시판 생성
insert into Board
set regDate = now(),
updateDate = now(),
`code`= 'free1',
`name`= '자유'; 


# 게시판 테이블에 BoardId 칼럼 추가
alter table article add COLUMN boardId int(10) unsigned not null after memberId;
select * from article;

# 1,2번 게시물을 공지사항 게시물로 지정
update article
set BoardId = 1
where id in (1,2);

# 3번 게시물을 자유게시판 게시물로 지정
update article
set BoardId = 2
where id in (3);
select * from article;
select * from board;

# 테스트 게시물 데이터
insert into article (
    regDate, updateDate, memberId, boardId, title, `body`
)
select now(), now(), floor(rand() * 2) + 1, FLOOR(RAND() * 2) + 1, concat('제목_', rand()), CONCAT('내용_', RAND())
from article;


# 게시물 테이블 hitCount 칼럼 추가
alter table article add column hitCount int(10) unsigned not null default 0;


# 리액션포인트 테이블
create table reactionPoint (
	id int(10) unsigned not null primary key AUTO_INCREMENT,
	regdate datetime not null,
	updateDate datetime not null,
	memberId int(10) unsigned not null,
	relTypeCode char(30) not null comment '관련데이터타입코드',
	relId int(10) unsigned not null comment '관련데이터번호',
	`point` smallint(2) not null
);

# 리액션포인트 테스트 데이터
## 1번 회원이 1번 article에 대해 싫어요
insert into reactionPoint
set regdate = now(),
	updateDate = now(),
	memberId = 1,
	relTypeCode = 'article',
	relId = 1,
	`point` = -1;
	
## 1번 회원이 2번 article에 대해 좋아요
insert into reactionPoint
set regdate = now(),
	updateDate = now(),
	memberId = 1,
	relTypeCode = 'article',
	relId = 2,
	`point` = 1;
	
## 2번 회원이 1번 article에 대해 싫어요
insert into reactionPoint
set regdate = now(),
	updateDate = now(),
	memberId = 2,
	relTypeCode = 'article',
	relId = 1,
	`point` = -1;
	
## 2번 회원이 2번 article에 대해 좋아요
insert into reactionPoint
set regdate = now(),
	updateDate = now(),
	memberId = 2,
	relTypeCode = 'article',
	relId = 2,
	`point` = 1;
	
## 3번 회원이 1번 article에 대해 좋아요
insert into reactionPoint
set regdate = now(),
	updateDate = now(),
	memberId = 3,
	relTypeCode = 'article',
	relId = 1,
	`point` = 1;
	
	
# 게시물 테이블 goodReactionPoint 칼럼을 추가
ALTER TABLE article
ADD COLUMN goodReactionPoint INT(10) UNSIGNED NOT NULL DEFAULT 0;

# 게시물 테이블 badReactionPoint 칼럼을 추가
ALTER TABLE article
ADD COLUMN badReactionPoint INT(10) UNSIGNED NOT NULL DEFAULT 0;


# 각 게시물 별, 좋아요, 싫어요 총합
/*
select RP.relId,
SUM(IF(RP.point > 0, RP.point, 0)) as goodReactionPoint,
SUM(IF(RP.point < 0, RP.point * -1, 0)) AS badReactionPoint
from reactionPoint AS RP
WHERE relTypeCode = 'article'
GROUP BY RP.relTypeCode, RP.relId
*/

# 기존 게시물의 goodReactionPoint 필드와 badReactionPoint 필드의 값 채우기
UPDATE article AS A
INNER JOIN (
    SELECT RP.relId,
    SUM(IF(RP.point > 0, RP.point, 0)) AS goodReactionPoint,
    SUM(IF(RP.point < 0, RP.point * -1, 0)) AS badReactionPoint
    FROM reactionPoint AS RP
    WHERE relTypeCode = 'article'
    GROUP BY RP.relTypeCode, RP.relId
) AS RP_SUM
ON A.id = RP_SUM.relId
SET A.goodReactionPoint = RP_SUM.goodReactionPoint,
A.badReactionPoint = RP_SUM.badReactionPoint;

	
