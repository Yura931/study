-- 101
-- 정답 2


-- 102
-- 정답 3
create table 부서_102 (
                        부서코드 varchar2(20) primary key ,
                        대표이사 varchar2(20),
                        상위부서코드 varchar2(20),
                        담당자 varchar2(10)
);

create table 부서임시_102 (
                          변경일자 date,
                          부서코드 varchar2(20),
                          담당자 varchar2(20),
                          constraint 부서임시_102_pk primary key (변경일자, 부서코드)
);

insert into 부서_102 values('A001', '대표이사', null, '김대표');
insert into 부서_102 values('A002', '영업본부', 'A001', '홍길동');
insert into 부서_102 values('A003', '경영지원본부', 'A001', '이순신');
insert into 부서_102 values('A004', '마케팅본부', 'A001', '강감찬');
insert into 부서_102 values('A005', '해외영업팀', 'A002', '이청용');
insert into 부서_102 values('A006', '국내영업팀', 'A002', '박지성');
insert into 부서_102 values('A007', '총무팀', 'A003', '차두리');
insert into 부서_102 values('A008', '인사팀', 'A003', '이민정');
insert into 부서_102 values('A009', '해외마케팅팀', 'A004', '이병헌');
insert into 부서_102 values('A0010', '국내마케팅팀', 'A004', '차승원');

insert into 부서임시_102 values (TO_DATE('2014.01.23', 'YYYY.MM.dd'), 'A007', '이달자');
insert into 부서임시_102 values (TO_DATE('2015.01.25', 'YYYY.MM.dd'), 'A007', '홍경민');
insert into 부서임시_102 values (TO_DATE('2015.01.25', 'YYYY.MM.dd'), 'A008', '유재석');

select * from 부서_102;

update 부서_102 a set 담당자 =
                        (
                            select b.담당자 from 부서임시_102 b
                            where b.부서코드 = a.부서코드
                              and b.변경일자 = (select MAX(c.변경일자) from 부서임시_102 c where c.부서코드 = b.부서코드)
                        )
where a.부서코드 in (select 부서코드 from 부서임시_102); -- update문은 where절이 없으면 전체가 수정 됨 항상 where절 조건 확인

update 부서_102 a set 담당자 = (select c.담당자
                           from (select 부서코드, MAX(변경일자) as 변경일자
                                 from 부서임시_102
                                 group by 부서코드) b, 부서임시_102 c
                           where b.부서코드 = c.부서코드
                             and b.변경일자 = c.변경일자
                             and a.부서코드 = c.부서코드)
where 부서코드 in (select 부서코드 from 부서임시_102);

delete from 부서_102;

-- 103
-- 정답 2
-- 뷰는 단지 정의만을 가지고 있으며, 실행 시점에 질의를 재작성하여 수행
-- 뷰는 복잡한 SQL 문장을 단순화 시켜주는 장점이 있는 반면, 테이블 구조가 변경되면 응용 프로그램을 변경해 주어야 한다. -> 테이블 구조는 테이블 대로 변경이 되고, 뷰는 실행 할 때 잠깐 재작성해서 사용하면 되는 것, 응용프로그램 변경 필요 없음
-- 뷰는 보안을 강화하기 위한 목적으로도 활용할 수 있다. -> 테이블에 민감한 정보가 있는 컬럼이 있는 경우 그 컬럼을 제외하고 뷰를 생성 후 뷰에 대한 권한만 주기도 함
-- 실제 데이터를 저장하고 있는 뷰를 생성하는 기능을 지원하는 DBMS도 있다. -> 테이블이 변하면 뷰의 데이터도 변경되야하는 경우도 있음 데이터 용량이 큰 테이블의 경우 유의해서 사용

-- 104
-- 정답 2
create table tbl_104 (
                         c1 varchar2(1),
                         c2 number(5)
);
insert into tbl_104 values ('A', 100);
insert into tbl_104 values ('B', 200);
insert into tbl_104 values ('B', 100);
insert into tbl_104 values ('B', null);
insert into tbl_104 values (null, 200);

select * from tbl_104;

create view v_tbl_104
as
select * from tbl_104
where c1 = 'B' or c1 is null;

select * from v_tbl_104;
select sum(c2) c2
from v_tbl_104
where c2 >= 200 and c1 = 'B';