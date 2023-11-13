-- 92 self join 하나의 테이블에서 컬럼끼리 연관관계가 있을 때 사용
-- 정답 1
create table emp_92 (
                        empid number(10) primary key ,
                        ename varchar2(10),
                        manager_id number(10)
);

insert into emp_92 values(1, '현빈', 0);
insert into emp_92 values(2, '손예진', 1);
insert into emp_92 values(3, '이효리', 2);
insert into emp_92 values(4, '이상순', 3);

select * from emp_92;
select * from emp_92 a left outer join emp_92 b on a.EMPID = b.manager_id;

-- 93
-- 정답 3
create table 일자별매출 (
                       일자 varchar2(10),
                       매출액 number(10)
);
insert into 일자별매출 values ('2015.11.01', 1000);
insert into 일자별매출 values ('2015.11.02', 1000);
insert into 일자별매출 values ('2015.11.03', 1000);
insert into 일자별매출 values ('2015.11.04', 1000);
insert into 일자별매출 values ('2015.11.05', 1000);
insert into 일자별매출 values ('2015.11.06', 1000);
insert into 일자별매출 values ('2015.11.07', 1000);
insert into 일자별매출 values ('2015.11.08', 1000);
insert into 일자별매출 values ('2015.11.09', 1000);
insert into 일자별매출 values ('2015.11.10', 1000);

SELECT CASE WHEN '2015.11.10' > '2015.11.09' THEN 'TRUE' ELSE 'FALSE' END AS 결과 FROM DUAL;
select a.일자, sum(b.매출액) from 일자별매출 a join 일자별매출 b on a.일자 >= b.일자 group by a.일자 order by a.일자;

-- 94
-- 정답 3

-- 95
-- 정답 2
-- 서브 쿼리는 단일 행(Single Row) 또는 복수 행(Multi Row) 비교 연산자와 함께 사용할 수 있다. -> 단일행 = 비교, 복수행 in절 비교
-- 서브쿼리는 select절, from절, having절, order by 절 등에서 사용이 가능하다.
-- 서브쿼리의 결과가 복수 행(Multi Row) 결과를 반환하는 경우에는 '=', '<=', '=>' 등 연산자와 함께 사용 불가능! -> IN, ALL, ANY등의 복수 행 비교 연산자 사용해야 함
-- 연관(Correlated) 서브쿼리(주로 where절에서 사용)는 서브쿼리가 메인쿼리 컬럼을 포함하고 있는 형태의 서브쿼리, 서브쿼리 안에서 메인쿼리 컬럼값과 조인
-- 다중 컬럼 서브쿼리는 서브쿼리의 결과로 여러 개의 컬럼이 반환되어 메인쿼리의 조건과 동시에 비교되는 것을 의미하며 Oracle 및 SQL Server 등의 DBMS에서 사용할 수 있다. -> Oracle에서만 제공

-- 96
-- 정답 3
create table 사원_96 (
                       사번 varchar2(10) primary key ,
                       이름 varchar2(10),
                       나이 number(5)
);

create table 가족_96 (
                       이름 varchar2(10),
                       나이 varchar2(10),
                       부양사번 varchar2(10)
);

insert into 사원_96 values ('EMP01', '현빈', 36);
insert into 사원_96 values ('EMP02', '손예진', 36);
insert into 사원_96 values ('EMP03', '이효리', 36);
insert into 사원_96 values ('EMP04', '이상순', 36);

insert into 가족_96 values ('강아지', 5, 'EMP01');
insert into 가족_96 values ('고양이', 6, 'EMP01');
insert into 가족_96 values ('닭', 3, 'EMP04');
insert into 가족_96 values ('소', 5, 'EMP03');

select 이름 from 사원_96 where not exists (select * from 가족_96 where 사번 = 부양사번);
select 이름 from 사원_96 where exists (select * from 가족_96 where 사번 <> 부양사번); -- 동일하지 않는 부양사번 존재시 다 출력 됨

-- 97
-- 정답 3
create table 회원_97 (
                       회원번호 varchar2(10),
                       회원명 varchar2(10)
);

create table 동의항목_97 (
                         회원번호 varchar2(10),
                         약관항목코드 varchar2(10),
                         동의여부 char(1),
                         동의일시 date
);

insert into 회원_97 values ('M0001', '한빈');
insert into 회원_97 values ('M0002', '이효리');
insert into 회원_97 values ('M0003', '이상순');
insert into 회원_97 values ('M0004', '강감찬');
insert into 회원_97 values ('M0005', '손예진');
insert into 회원_97 values ('M0006', '정우성');

insert into 동의항목_97 values ('M0001', 'E0004', 'Y', TO_DATE('2023-03-01', 'YYYY-MM-DD'));
insert into 동의항목_97 values ('M0004', 'E0001', 'Y', TO_DATE('2023-03-01', 'YYYY-MM-DD'));
insert into 동의항목_97 values ('M0005', 'E0003', 'N', TO_DATE('2023-03-01', 'YYYY-MM-DD'));
insert into 동의항목_97 values ('M0006', 'E0002', 'Y', TO_DATE('2023-03-01', 'YYYY-MM-DD'));
insert into 동의항목_97 values ('M0001', 'E0004', 'N', TO_DATE('2023-03-01', 'YYYY-MM-DD'));

select a.회원번호, a.회원명
from 회원_97 a, 동의항목_97 b
where a.회원번호 = b.회원번호
group by a.회원번호, a.회원명
having count(case when b.동의여부 = 'N' then 0 else null end) >= 1 -- 동의여부가 'N'인 경우 0, 아닌 경우 null이되어 카운팅 무시, 0인 경우에만 카운팅 됨
order by a.회원번호;

select a.회원번호, a.회원명
from 회원_97 a
where 0 < (select count(*) from 동의항목_97 b where b.동의여부 = 'N') -- 회원과 동의항목이 조인이
order by a.회원번호;

-- 98
-- 정답 3
-- EXISTS 절은 구문 확인 후 true, false 반환 select절 아무단어나 넣어도 상관 없음
-- group by 절 사용 없이 having 절이 올 수 있음
create table 회원_98 (
                       회원ID varchar2(10),
                       회원명 varchar2(10),
                       가입일시 date,
                       이메일 varchar2(20)
);

create table 이벤트_98 (
                        이벤트ID varchar2(10),
                        이벤트명 varchar2(10),
                        시작일자 date,
                        종료일자 date
);

create table 메일발송_98 (
                         이벤트ID varchar2(10),
                         회원ID varchar2(10),
                         발송일시 date
);

insert into 회원_98 values ('M0001', '현빈', sysdate, 'hyeonbin@google.com');
insert into 회원_98 values ('M0002', '이효리', sysdate, 'hyori@google.com');
insert into 회원_98 values ('M0003', '이상순', sysdate, 'sangsoon@google.com');
insert into 회원_98 values ('M0004', '강감찬', sysdate, 'gamchan@google.com');
insert into 회원_98 values ('M0005', '손예진', sysdate, 'yejin@google.com');
insert into 회원_98 values ('M0006', '정우성', sysdate, 'woosung@google.com');

insert into 이벤트_98 values('E0001', '결혼이벤트', to_date('2014-10-01', 'YYYY-MM-dd'), to_date('2014-10-29', 'YYYY-MM-dd') );
insert into 이벤트_98 values('E0002', '적립금이벤트', to_date('2014-10-05', 'YYYY-MM-dd'), to_date('2014-10-09', 'YYYY-MM-dd') );
insert into 이벤트_98 values('E0003', '효도이벤트', to_date('2013-01-01', 'YYYY-MM-dd'), to_date('2013-02-01', 'YYYY-MM-dd') );
insert into 이벤트_98 values('E0004', '커피이벤트', to_date('2015-02-01', 'YYYY-MM-dd'), to_date('2015-02-15', 'YYYY-MM-dd') );
insert into 이벤트_98 values('E0005', '가전이벤트', to_date('2012-02-15', 'YYYY-MM-dd'), to_date('2012-05-15', 'YYYY-MM-dd') );

insert into 메일발송_98 values('E0001', 'M0001', to_date('2014-09-27','YYYY-MM-DD'));
insert into 메일발송_98 values('E0002', 'M0001', to_date('2014-10-01','YYYY-MM-DD'));
insert into 메일발송_98 values('E0003', 'M0001', to_date('2012-12-27','YYYY-MM-DD'));
insert into 메일발송_98 values('E0004', 'M0001', to_date('2015-01-27','YYYY-MM-DD'));
insert into 메일발송_98 values('E0005', 'M0001', to_date('2012-02-10','YYYY-MM-DD'));
insert into 메일발송_98 values('E0003', 'M0002', to_date('2012-12-17','YYYY-MM-DD'));
insert into 메일발송_98 values('E0004', 'M0002', to_date('2015-01-27','YYYY-MM-DD'));
insert into 메일발송_98 values('E0005', 'M0002', to_date('2012-02-10','YYYY-MM-DD'));


select *
from 회원_98 a
-- ㄱ
where exists(
              select *
              from 이벤트_98 b,
                   메일발송_98 c
              where b.시작일자 >= '2014-10-01'
                and b.이벤트ID = c.이벤트ID
                -- ㄴ
                and a.회원ID = c.회원ID
                -- ㄷ
              HAVING count(*) < (select count(*) -- 테이블 전체가 집계함수의 대상이 될 경우 having 절 바로 사용 가능 broup by 절 없이도 사용이 가능 함
                                 from 이벤트_98
                                 where 시작일자 >= '2014-10-01')
          );

-- 99
-- 정답 1
-- 서브쿼리 결과가 단건일 경우 '=', '<=', '>=' 등의 연산자 사용
-- 다중 행 서브쿼리 비교 연산자는 단일 행 서브쿼리의 비교 연산자로도 사용 가능 IN, ALL 등
-- 연관 서브쿼리는 메인쿼리에서 값을 제공 받기 위한 목적으로 사용, 메인쿼리 값을 제공 받는 것
-- 서브 쿼리의 실행 순서는 그때마다 다름, 조인, 서브쿼리 위치 등에 따라 다름

-- 100
-- 정답 3
-- from절 서브쿼리 : Inline View라고도 하고 동적 뷰(Dynamic View) 라고도 함, 테이블 명ㅇ이 올 수 있는 곳에서 사용할 수 있음
-- select절에 사용된 서브쿼리는 스칼라 서브쿼리라고도 함, join으로 동일한 결과를 추출할 수도 있음


