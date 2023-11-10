-- 82
-- 정답 2
create table emp (
                     empno number(10) primary key ,
                     ename varchar2(50),
                     job varchar2(50)
);

insert into emp values (7369, 'SMITH', 'CLERK');
insert into emp values (7368, 'SMITH', 'CLERK');
insert into emp values (7359, 'SMITH', 'CLERK');
insert into emp values (7566, 'JONES', 'MANAGER');
insert into emp values (7123, 'SMITH', 'CLERK');
insert into emp values (7090, 'SMITH', 'CLERK');

-- union all을 통한 alias는 첫번째 select절의 as가적용 됨
select ename AAA, job AAB
from emp
where empno = 7369
union all
select ename BBA,  job BBB
from emp
where empno = 7566
order by 1, 2; -- select 절 컬럼 순서, ename asc, job asc 동일

-- 83
-- 정답 1
create table tbl1 (
                      col1 varchar2(10) primary key,
                      col2 varchar2(10)
);
create table tbl2 (
                      col1 varchar2(10) primary key,
                      col2 varchar2(10)
);

insert into tbl1 values ('AA', 'A1');
insert into tbl1 values ('AB', 'A2');
insert into tbl2 values ('AA', 'A1');
insert into tbl2 values ('AB', 'A2');
insert into tbl2 values ('AC', 'A3');
insert into tbl2 values ('AD', 'A4');

-- union과 union all 함께 사용,
select A.col1, A.col2, count(*) as cnt from (
                                                select col1, col2
                                                from tbl1
                                                union all
                                                select col1, col2
                                                from tbl2
                                                union
                                                select col1, col2
                                                from tbl1) A
group by col1, col2;

-- 87
-- 정답 C
create table 계층구조 (
                      c1 number(1) primary key ,
                      c2 number(1),
                      c3 varchar2(10)
);

insert into 계층구조 values (1, null, 'A');
insert into 계층구조 values (2, 1, 'B');
insert into 계층구조 values (3, 1, 'C');
insert into 계층구조 values (4, 2, 'D');

select a.*, level -- 루트 노드의 level값은 1
from 계층구조 a
    start with c2 is null -- 계층 구조의 시작점을 지정
connect by prior c1 = c2 -- prior 읽은 값,
order siblings by c3 desc; -- 형제 노드(동일 level) 사이에서 정렬 수행

-- 89
-- 정답 1
create table 사원 (
                    사원번호 number(10) primary key ,
                    사원명 varchar2(10),
                    입사일자 varchar2(10),
                    매니저사원번호 number(10)
);

insert into 사원 values (001, '홍길동', '2012-01-01', null);
insert into 사원 values (002, '강감찬', '2012-01-01', 001);
insert into 사원 values (003, '이순신', '2013-01-01', 001);
insert into 사원 values (004, '이민정', '2013-01-01', 001);
insert into 사원 values (005, '이병헌', '2013-01-01', null);
insert into 사원 values (006, '안성기', '2014-01-01', 005);
insert into 사원 values (007, '이수근', '2014-01-01', 005);
insert into 사원 values (008, '김병만', '2014-01-01', 005);

select a.*, level, lpad(' ', 5*(level-1)) || a.사원번호, prior a.사원번호 from 사원 a
start with 매니저사원번호 is null
connect by prior 사원번호 = 매니저사원번호
       and 입사일자 between '2013-01-01' and '2013-12-31' -- 게층형 쿼리에서 조건절 start with구문에 해당하는 절은 조건에 상관없이 select 됨
order siblings by 사원번호;

/* SQL server 계층형 질의문 재귀 호출
with 사원_with as (
    select 사원번호, 사원명, 입사일자, 매니저사원번호, 1 as custom_level from 사원 d where 매니저사원번호 is null
union all
select d.사원번호, d.사원명, d.입사일자, d.매니저사원번호, c.custom_level + 1 from 사원 d join 사원_with c on c.사원번호 = d.사원번호
)
select * from 사원_with;
*/

-- 91 계층 역방향전개, 순방향전개, union
-- 정답 1
create table 부서 (
                    부서코드 number(10) primary key ,
                    부서명 varchar2(100),
                    부서상위코드 number(10),
                    constraint 부서코드_fk foreign key (부서상위코드) references 부서(부서코드)
);

create table 매출 (
                    부서코드 number(10),
                    매출액 varchar2(10)
);

insert into 부서 values (100, '아시아부', null);
insert into 부서 values(110, '한국지사', 100);
insert into 부서 values(111, '서울지점', 110);
insert into 부서 values(112, '부산지점', 110);
insert into 부서 values(120, '일본지사', 100);
insert into 부서 values(121, '도쿄지점', 120);
insert into 부서 values(122, '오사카지점', 120);
insert into 부서 values(130, '중국지사', 100);
insert into 부서 values(131, '베이징지점', 130);
insert into 부서 values(132, '상하이지점', 130);
insert into 부서 values(200, '남유럽지부', null);
insert into 부서 values(210, '스페인지사', 200);
insert into 부서 values(211, '마드리드지점', 210);
insert into 부서 values(212, '그라나다지점', 210);
insert into 부서 values(220, '포르투갈지사', 200);
insert into 부서 values(221, '리스본지점', 220);
insert into 부서 values(222, '포르투지점', 220);

insert into 매출 values(111, '1000');
insert into 매출 values(112, '2000');
insert into 매출 values(121, '1500');
insert into 매출 values(122, '1000');
insert into 매출 values(131, '1500');
insert into 매출 values(132, '2000');
insert into 매출 values(211, '2000');
insert into 매출 values(222, '2000');
insert into 매출 values(212, '1500');
insert into 매출 values(221, '1000');

select a.부서코드, a.부서명, a.부서상위코드, b.매출액, lvl
from (
         select 부서코드, 부서명, 부서상위코드, level as lvl
         from 부서
                  start with 부서코드 = 120
         connect by prior 부서상위코드 = 부서코드  -- 역방향 전개
         union
         select 부서코드, 부서명, 부서상위코드, level as lvl
         from 부서
         start with 부서코드 = 120
         connect by 부서상위코드 = prior 부서코드 -- 순방향 전개
     ) a left outer join 매출 b
                         on (a.부서코드 = b.부서코드)
order by a.부서코드;

select a.부서코드, a.부서명, a.부서상위코드, b.매출액, lvl
from (
         select 부서코드, 부서명, 부서상위코드,level as lvl from 부서
                                                        start with 부서코드 = (select 부서코드
                            from 부서
                            where 부서상위코드 is null    -- 조건절은 계층구조 완료된 후 처리 됨
                            start with 부서코드 = 120
                            connect by prior 부서상위코드 = 부서코드  -- prior 부모 = 자식 역방향전개
                        )
         connect by 부서상위코드 = prior 부서코드
     ) a left outer join 매출 b
                         on (a.부서코드 = b.부서코드)
order by a.부서코드;