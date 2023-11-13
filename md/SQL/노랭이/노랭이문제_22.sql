-- 22
-- 22
-- 정답 1, 3

create table 고객22 (
                      고객ID varchar2(20) not null primary key,
                      고객명 varchar2(20) null ,
                      가입일시 date not null
);

create table 주문22 (
                      주문번호 varchar2(20) not null,
                      고객ID varchar2(20) not null,
                      주문일시 date not null,
                      constraint 주문번호_PK primary key (주문번호),
                      constraint 고객ID_FK foreign key (고객ID) references 고객22 (고객ID) on delete set null
);

select * from 고객22;
delete from 고객22;
INSERT INTO 고객22 VALUES ('C001', '홍길동', '2013-12-12');
INSERT INTO 고객22 VALUES ('C002', '이순신', '2013-12-13');

INSERT INTO 주문22 VALUES ('0001', 'C001', '2013-12-24');
INSERT INTO 주문22 VALUES ('0002', 'C001', '2013-12-25');
INSERT INTO 주문22 VALUES ('0003', 'C002', '2013-12-26');
INSERT INTO 주문22 VALUES ('0004', 'C002', '2013-12-27');



INSERT INTO 고객22 VALUES ('C003', '강감찬', '2014-01-01');
-- 에러 무결성 제약조건(고객ID_FK)위배 되었습니다.-부모키가 없습니다.
INSERT INTO 주문22 VALUES  ('0005', 'C003', '2013-12-28');
DELETE FROM 주문22 WHERE 주문번호 IN ('0001', '0002');
-- 고객22 테이블의 정보를 삭제 했을 때 주문22에서 삭제 된 고객ID를 참조하고 있으면 SET NULL로 업데이트 하도록 생성했지만 주문22테이블의 고객ID가 NOT NULL로 제약조건이 걸려있기 때문에 NULL값으로 세팅할 수 없다.
DELETE FROM 고객22 WHERE 고객ID = 'C002';
