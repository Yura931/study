### CREATE TABLE
```sql
-- create 시 함께 제약 조건 지정
CREATE TABLE PRODUCT
(
    PROD_ID VARCHAR2(10) NOT NULL,
    PROD_NM VARCHAR2(100) NOT NULL,
    REG_DT DATE NOT NULL,
    REGR_NO NUMBER(10) NULL,
    CONSTRAINT PRODUCT_PK PRIMARY KEY (PROD_ID)
);

-- create 후 alter문을 통해 제약 조건 추가
CREATE TABLE PRODUCT2
(
    PROD_ID VARCHAR2(10) NOT NULL,
    PROD_NM VARCHAR2(100) NOT NULL,
    REG_DT DATE NOT NULL,
    REGR_NO NUMBER(10) NULL
);
ALTER TABLE PRODUCT2 ADD CONSTRAINT PRODUCT_PK2 PRIMARY KEY (PROD_ID);
```

### 테이블 컬럼에 대한 정의 변경
- 오라클
  - ALTER TABLE 테이블명 MODIFY 컬럼이름 데이터유형 NOTNULL/NULL
  - ALTER TABLE COL_ADD_TBL MODIFY COL_NAME VARCHAR2(20); NULL생략시 기본값 NULL
- SQL Server - SQL Server의 경우 컬럼을 여러개 한번에 변경하지 못한다.  
  - ALTER TABLE 테이블명 ALTER 컬럼이름 데이터유형 NOTNULL/NULL
  - ALTER TABLE COL_ADD_TBL ALTER COL_NAME BIGINT (NULL)

### null
- 모르는 값
- NULL과의 모든 비교(IS NULL 제외)는 알 수 없음(Unknown)을 반환

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

### 제약 조건의 종류
- PRIMARY KEY(기본키): 중복 불가능, NULL 불가능
- UNIQUE KEY(고유키): 중복 불가능, NULL 가능
- NOT NULL: 명시적으로 NULL 입력을 방지
- CHECK: 테이블 만들 때 설정 가능 컬럼의 속성에 대한 제약 가능 무결성 유지
- FOREIGN KEY: 외래키로 테이블당 여러 개 생성이 가능

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

### 데이터 삭제
- 모든 작업들은 트랜잭션 로그를 남길 수 있음 LOG DB에 쌓아두다 어느정도 차게 되면 실제 DB에 동기화 작업
- DROP, TRUNCATE, DELETE 모두 삭제 작업, 이 중 DELETE만 로그를 남길 수 있다.
- DROP
  - DDL
  - ROLLBACK 불가능
  - AUTO COMMIT
  - 용량 모두 반환
  - 테이블의 정의 자체를 완전히 삭제함
- TRUNCATE
  - DDL(일부 DML 성격 가짐)
  - ROLLBACK 불가능
  - AUTO COMMIT
  - 테이블 최초 생성 시 용량만 남기고, 모두 반환함.
  - 테이블을 최초 생성된 초기상태로 만듦
- DELETE
  - DML
  - COMMIT 이전 ROLLBACK 가능
  - 사용자 COMMIT
  - 용량 반환 하지 않음
  - 데이터만 삭제

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

### 집계함수
- NULL이 있는 경우 제외 후 연산 됨

### TOP() - WITH TIES
- 테이블에서 급여가 높은 2명을 내림차순으로 출력하는데 같은 급여를 받는 사원이 있으면 같이 출력
- SELECT TOP(2) WITH TIES ENAME, SAL FROM EMP ORDER BY SAL DESC;

### 집합 연산자


### 계층 쿼리
- ORACLE
  - START WITH절: 계층 구조의 시작점을 지정하는 구문
    - START WITH 구문에 해당하는 행들은 조건과 상관없이 select 됨
  - ORDER SIBLINGS BY절: 형제 노드 사이에서 정렬을 지정하는 구문
  - 순방향전개: 부모 노드로부터 자식 노드 방향으로 전개하는 것
  - 루트노드의 LEVEL 값은 1
  - PRIOR: CONNECT BY절에 사용되며, 현재 읽은 칼럼을 지정한다.
    - PRIOR 자식 = 부모 형태를 사용하면 계층구조에서 부모 데이터에서 자식 데이터(부모 -> 자식) 방향으로 전개하는 순방향 전개를 한다.
    - 그리고 PRIOR 부모 = 자식 형태ㅡㄹ 사용하면 반대로 자식 데이터에서 부모 데이터(자식 -> 부모) 방향으로 전개하는 역방향 전개를 한다.)
