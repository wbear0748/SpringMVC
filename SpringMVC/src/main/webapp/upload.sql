create table attachfile (
 attachfileno int auto_increment PRIMARY KEY,
 filename varchar(50) NOT NULL,
 filetype varchar(30),
 filesize int,
 postno int
);

ALTER TABLE attachfile ADD FOREIGN KEY(postno) REFERENCES post(postno) ON UPDATE CASCADE ON DELETE CASCADE;

SELECT * FROM (SELECT * FROM post ORDER BY postno DESC) a LIMIT 1

alter table attachfile drop foreign key postno;

drop table attachfile

update attachfile set postno=64 where attachfileno=1

select * from attachfile

select * from post

SELECT postno, title FROM post
		WHERE boardcode = 'free' AND postno > 50 AND division2 is null
		ORDER BY division1 ASC