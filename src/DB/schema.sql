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