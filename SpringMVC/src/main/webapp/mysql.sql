CREATE TABLE member (
	memberno int auto_increment PRIMARY KEY,
	userid varchar(20) NOT NULL,
    pwd varchar(20) NOT NULL,
    name varchar(20) NOT NULL,
    nickname varchar(20) NOT NULL,
    email varchar(60) NOT NULL,
    phone varchar(20) NOT NULL
);

CREATE TABLE board (
	boardcode varchar(20) PRIMARY KEY,
	boardname varchar(40) NOT NULL
);

CREATE TABLE post (
	postno int auto_increment PRIMARY KEY,
	title varchar(100) NOT NULL,
	contents text NOT NULL,
	writer varchar(20) NOT NULL,
	hits int NOT NULL,
	writeday datetime NOT NULL,
	division1 int DEFAULT 1,
	division2 varchar(20),
	commentcount int NOT NULL,
	boardcode varchar(20)
);

CREATE TABLE comment (
	commentno int auto_increment PRIMARY KEY,
	commentwriter varchar(20) NOT NULL,
	commentcontents text NOT NULL,
	division1 int DEFAULT 1,
	division2 int,
	writeday datetime NOT NULL,
	del bit DEFAULT 0,
	postno int
);

ALTER TABLE post ADD FOREIGN KEY(boardcode) REFERENCES board(boardcode) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE comment ADD FOREIGN KEY(postno) REFERENCES post(postno) ON UPDATE CASCADE ON DELETE CASCADE;

alter table comment change division2 division2 int default 1
 
insert into board(boardname) values('Q&A게시판');
select * from member;
select * from comment;
select * from post;
select * from board;

drop table comment;
drop table post;

delete from post;
delete from comment;

show tables;

desc 
desc post;
desc comment;

delete from post where boardcode='free' and division1=5;

select IFNULL(MAX(division1),0) from comment a where postno=1

alter table member auto_increment=1;
alter table post auto_increment=1;
alter table comment auto_increment=1;

INSERT INTO board VALUES ('free','자유게시판');
INSERT INTO board VALUES ('qna','Q&A게시판');
INSERT INTO board VALUES ('data','자료실');

INSERT INTO post (title, contents, writer, hits, writeday, commentcount, division1, division2, boardcode)
VALUES('re: re: 첫번째 글의 두번째 답글1', 'c1', '1', 0, now(), 0, 1, 'ba', 'free');


select IFNULL(substr((select MAX(division2) from post a where boardcode='free' and division1=1 and division2 like 'a%' and length(division2) > length('a')), -1), '`') from post

select ifnull((select division2 from post where boardcode='free' and division1=2 and division2 like 'a%'), 'a')

select IFNULL(MAX(division2),'a') from post a where boardcode='free' and division1=1

SELECT CHAR(77,121,83,81,'76');

insert into post(title, contents, writer, hits, writeday, division1,
		commentcount, boardcode)
		values('title1', 'contents1', 'writer1', 0, now(), 1, 0, 'qna');
		insert into post(title, contents, writer, hits, writeday, division1,
		commentcount, boardcode)
		values('title2', 'contents2', 'writer2', 0, now(), 2, 0, 'qna');
		insert into post(title, contents, writer, hits, writeday, division1,
		commentcount, boardcode)
		values('title3', 'contents3', 'writer3', 0, now(), 3, 0, 'qna');
		
	select del from comment where division1=1 and division2 is null and postno=1
		
		
select exists(select * from comment where division1=1 and division2 is not null and postno=14)


SELECT * FROM (SELECT @RNUM := @RNUM + 1 AS NO, a.* FROM (SELECT * FROM post WHERE boardcode='free' ORDER BY division1 DESC, division2 ASC) a, (SELECT @RNUM := 0) b) a WHERE NO BETWEEN 1 AND 30