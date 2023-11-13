### 테이블 선언 시 참조 옵션
```sql
CREATE TABLE T
    (C INTEGER PRIMARY KEY,
    D INTEGER);

CREATE TABLE S
    (B INTEGER PRIMARY KEY,
    C INTEGER REFERENCES T(C) ON DELETE CASCADE);   -- T테이블의 C를 참조, T가 삭제되면 함께 삭제하라는 의미

CREATE TABLE R
    (A INTEGER PRIMARY KEY,
    B INTEGER REFERENCES S(B) ON DELETE SET NULL);  -- S테이블의 B 참조, S테이블의 B가 삭제되면 해당 컬럼에 NULL로 대체
```

### INDEX
- 데이터베이스에서 검색 속도를 빠르게 도와주는 역할
```sql
CREATE TABLE EMP (
    EMP_NO VARCHAR2(10) PRIMARY_KEY,
    EMP_NM VARCHAR2(30) NOT NULL,
    DEPT_CODE VARCHAR2(4) DEFAULT '0000' NOT NULL,
    REGIST_DATE DATE NULL,
)
CREATE INDEX IDX_EMP_01 ON EMP (JOIN_DATE);

CREATE TABLE EMP (
   EMP_NO VARCHAR2(10),
   EMP_NM VARCHAR2(30) NOT NULL,
   DEPT_CODE VARCHAR2(4) DEFAULT '0000' NOT NULL,
   REGIST_DATE DATE NULL,
)            
ALTER TABLE EMP ADD CONSTRAINT EMP_PK PRIMARY KEY (EMP_NO);
CREATE INDEX IDX_EMP_01 ON EMP (JOIN_DATE);

CREATE INDEX 인덱스명 ON 테이블명 (컬럼)
```

### 컬럼 삭제
- ALTER TABLE EMP DROP COLUMN COMM

### 테이블 이름 변경
- RENAME TABLE STADIUM TO STADIUM_JSC;

### 외래키 참조동작
- CASCADE
- RESTRICT
- AUTOMATIC

### AUTO COMMIT
- 오라클
  - DDL 문장 수행 후 자동으로 COMMIT을 수행
  - ORACLE에서 DDL 문장의 수행은 내부적으로 트랜잭션을 종료 시키므로 테이블 생성 됨
- SQL Server
  - DDL 문장 수행 후 자동으로 COMMIT을 수행하지 않음
  - SQL Server에서는 CREATE TABLE 문장도 TRANSACTION의 범주에 포함, ROLLBACK 문장에 의해 테이블 생성이 되지 않을 수 있음

### 저장점(SAVEPOINT)
- 롤백(ROLLBACK) 시 트랜잭션에 포함된 전체 작업을 롤백하는 것이 아니라 현 시점에서 SAVEPOINT까지 트랜잭션의 일부만 롤백할 수 있다.
- 오라클, SQL Server 문법 다름
- 오라클
  - SAVEPOINT SVPT1;  
    ROLLBACK TO SVPT1;
- SQL Server
  - SAVE TRANSACTION SVTR1;  
    ROLLBACK TRANSACTION SVTR1;

### 연산자의 우선순위
1. 괄호로 묶은 연산
2. 부정 연산자(NOT)
3. 비교 연산자(=, >, >=, <=)와 SQL 비교 연산자(BETWEEN a AND b, IN (list), LIKE, IS NULL)
4. 논리 연산자 중 AND, OR의 순으로 처리

### NULL의 연산
- NULL 값과의 연산(+, -, *, / 등)은 NULL 값을 리턴
- NULL 값과의 비교연산(=, >, >=, <=)은 거짓(FALSE)을 리턴
- 특정 값보다 크다, 적다라고 표현할 수 없음

### 공백
오라클
- 공백 NULL로 인식 IS NULL, IS NOT NULL로 검색 가능
SQL Server
- 공백은 공백으로 인식 where조건 = '' 으로 검색 가능

### case when
- else값이 없는 경우 조건에 해당하지 않으면 null 값이 저장된다.
```sql
-- SEARCHED_CASE_EXPRESSION
SELECT LOC,
       CASE WHEN LOC = 'NEW YORK' THEN 'EAST'
       ELSE 'ETC'
       END AS AREA
FROM DEPT;

-- SIMPLE_CASE_EXPRESSION
SELECT LOC,
       CASE LOC WHEN 'NEW YORK' THEN 'EAST'
       ELSE 'ETC'
       END AS AREA
FROM DEPT;
```

### 집계함수
- NULL이 있는 경우 제외 후 연산 됨

### TOP() - WITH TIES
- 테이블에서 급여가 높은 2명을 내림차순으로 출력하는데 같은 급여를 받는 사원이 있으면 같이 출력
- SELECT TOP(2) WITH TIES ENAME, SAL FROM EMP ORDER BY SAL DESC;

### 집합 연산자
- EXCEPT
- UNION ALL
- UNION
- INTERSECT 
  - 교집합


### 계층 쿼리
- ORACLE
  - START WITH절: 계층 구조의 시작점을 지정하는 구문
    - START WITH 구문에 해당하는 행들은 조건과 상관없이 select 됨
  - ORDER SIBLINGS BY절: 형제 노드 사이에서 정렬을 지정하는 구문
  - 순방향전개: 부모 노드로부터 자식 노드 방향으로 전개하는 것
  - 루트노드의 LEVEL 값은 1
  - PRIOR: CONNECT BY절에 사용되며, 현재 읽은 칼럼을 지정한다, select절이나 where절에도 사용 가능
    - PRIOR 자식 = 부모 형태를 사용하면 계층구조에서 부모 데이터에서 자식 데이터(부모 -> 자식) 방향으로 전개하는 순방향 전개를 한다.
    - 그리고 PRIOR 부모 = 자식 형태를 출사용하면 반대로 자식 데이터에서 부모 데이터(자식 -> 부모) 방향으로 전개하는 역방향 전개를 한다.)
