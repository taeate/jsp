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