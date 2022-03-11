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
-- insert into article
-- (
--     regDate, updateDate, memberId, boardId, title, `body`
-- )
-- select now(), now(), floor(rand() * 2) + 1, FLOOR(RAND() * 2) + 1, concat('제목_', rand()), CONCAT('내용_', RAND())
-- from article;


# 게시물 테이블 hitCount 칼럼 추가
alter table article add column hitCount int(10) unsigned not null default 0;


