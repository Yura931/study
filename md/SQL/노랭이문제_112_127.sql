-- 112
-- 정답 3
-- Partition과 group by 구문은 의미적으로 유사
-- partition 구문이 없으면 전체 집합을 하나의 Partition으로 정의한 것과 동일
-- 윈도우 함수 처리로 인해 결과 건수가 줄어든다 X -> 건수가 줄어드는 것이 아닌 윈도우 함수 컬럼이 추가되는 것
-- 윈도우 함수 적용 범위는 Partition을 넘을 수 없다.

-- 113
-- 정답 1
create table 고객_113 (
                        고객번호 number(10) primary key ,
                        고객명 varchar2(10)
);

create table 월별매출_113 (
                          월 varchar2(10),
                          고객번호 number(10),
                          매출액 number(10),
                          constraint 월별매출_113_PK primary key (월, 고객번호)
);

drop table 월별매출_113;

insert into 고객_113 values (001, '홍길동');
insert into 고객_113 values (002, '이순신');
insert into 고객_113 values (003, '강감찬');
insert into 고객_113 values (004, '이상황');
insert into 고객_113 values (005, '이규혁');

insert into 월별매출_113 values ('201301', 001, 200);
insert into 월별매출_113 values ('201301', 002, 300);
insert into 월별매출_113 values ('201301', 003, 250);
insert into 월별매출_113 values ('201301', 004, 300);
insert into 월별매출_113 values ('201301', 005, 250);
insert into 월별매출_113 values ('201302', 001, 150);
insert into 월별매출_113 values ('201302', 002, 150);
insert into 월별매출_113 values ('201302', 004, 200);
insert into 월별매출_113 values ('201302', 005, 100);
insert into 월별매출_113 values ('201303', 002, 100);
insert into 월별매출_113 values ('201303', 003, 100);
insert into 월별매출_113 values ('201303', 004, 200);
insert into 월별매출_113 values ('201303', 005, 350);

select 고객번호, 고객명, 매출액, rank() over (order by 매출액 desc) as 순위
from (select a.고객번호,
             a.고객명,
             sum(b.매출액) as 매출액
--       RANK() over(ORDER BY sum(b.매출액) DESC) as 순위
      from 고객_113 a
               inner join 월별매출_113 b on (a.고객번호 = b.고객번호)
      group by a.고객번호, a.고객명)
order by 순위;

select 고객번호 from 월별매출_113 group by 고객번호 order by 고객번호;
select a.*, b.* from 고객_113 a
                         left outer join 월별매출_113 b on (a.고객번호 = b.고객번호);

-- 114 RANK() 활동점수 동일한 경우 동일등수 후 건너뜀
-- 정답 4
-- select 게임상품ID, 고객ID, 활동점수, 순위 from (select rank() over(partition by 게임상품ID order by 활동점수 desc) as 순위, 고객ID, 게임상품ID, 활동점수 from 고객활동)
-- 게임상품 별 활동점수 높은 순으로 순위 매기기

-- 115
-- 정답 3
create table 추천내역_115 (
                          추천경로 varchar2(15),
                          추천인 varchar2(10),
                          피추천인 varchar2(10),
                          추천점수 number(5)
);

alter table 추천내역_115 modify 추천경로 varchar2(20);

insert into 추천내역_115 values ('SNS', '나한일', '강감찬', 75);
insert into 추천내역_115 values ('SNS', '이순신', '강감찬', 80);
insert into 추천내역_115 values ('이벤트 응모', '홍길동', '강감찬', 88);
insert into 추천내역_115 values ('이벤트 응모', '저절로', '이순신', 78);
insert into 추천내역_115 values ('홈페이지', '저절로', '이대로', 93);
insert into 추천내역_115 values ('홈페이지', '홍두깨', '심청이', 98);

select 추천경로, 추천인, 피추천인, 추천점수
from
    (select 추천경로, 추천인, 피추천인, 추천점수,
            ROW_NUMBER() over(partition by 추천경로 order by 추천점수 desc) as rnum
     from 추천내역_115)
where rnum = 1;


-- 116
-- 정답 3

-- 117
-- 정답 1
create table 사원_117 (
                        사원ID number(10),
                        부서ID number(10),
                        사원명 varchar2(10),
                        연봉 number(10)
);

insert into 사원_117 values (001, 100, '홍길동', 2500);
insert into 사원_117 values (002, 100, '강감찬', 3000);
insert into 사원_117 values (003, 200, '김유신', 4500);
insert into 사원_117 values (004, 200, '김선달', 3000);
insert into 사원_117 values (005, 200, '유학생', 2500);
insert into 사원_117 values (006, 300, '변사또', 4500);
insert into 사원_117 values (007, 300, '박문수', 3000);

select Y.* from
    (select 사원ID, MAX(연봉) over ( partition by 부서ID ) as 최고연봉 from 사원_117) X -- 사원ID, 각부서 최고연봉 출력 됨
              , 사원_117 Y
where X.사원ID = Y.사원ID
  and X.최고연봉 = Y.연봉;

-- 118
-- 정답
create table tbl118 (
                        id varchar(10),
                        start_val number,
                        end_val number
);

insert into tbl118 values ('A', 10, 14);
insert into tbl118 values ('A', 14, 15);
insert into tbl118 values ('A', 15, 15);
insert into tbl118 values ('A', 15, 18);
insert into tbl118 values ('A', 20, 25);
insert into tbl118 values ('A', 25, null);

select id
     , start_val
     , nvl(end_val, 99) end_val
     , lag(end_val) over ( partition by id order by start_val, nvl(end_val, 99)) as lagval
, lead(start_val) over ( partition by id order by start_val, nvl(end_val, 99)) as leadval
, (case when start_val = lag(end_val) over ( partition by id order by start_val, nvl(end_val, 99 )) then 1 else 0 end) flag1
     , (case when end_val = lead(start_val) over ( partition by id order by start_val, nvl(end_val, 99)) then 1 else 0 end) flag2
from tbl118;
