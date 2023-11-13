# SQL 문장종류

---

### 데이터 조작어(DML: Data Manipulation Language)
- **SELECT**: 데이터베이스에 들어 있는 데이터를 조회하거나 검색하기 위한 명령어를 말하는 것으로 RETRIEVE라고도 한다.
- **INSERT, UPDATE, DELETE**: 
  - 데이터베이스의 테이블에 들어 있는 데이터에 변형을 가하는 종류의 명령어들을 말한다. 예를 들어 데이터를 테이블에 새로운 행을 집어넣거나, 원하지 않는 데이터를 삭제하거나 수정하는 것들의 명령어들을 DML이라고 부른다.
  - 비절차적 데이터 조작어는 사용자가 무슨 데이터를 원하는 지만을 명세

### 데이터 정의어(DDL: Data Definition Language)
- **CREATE, ALTER, DROP, RENAME**: 테이블과 같은 데이터 구조를 정의하는데 사용되는 명령어들로 그러한 구조를 생성하거나 변경하거나 삭제하거나 이름을 바꾸는 데이터 구조와 관련된 명령어

### 데이터 제어어(DCL: Data Control Language)
- **GRANT, REVOKE**: 데이터베이스에 접근하고 객체들을 사용하도록 권한을 주고 회수하는 명령어

### 트랜잭션 제어어(TCL: Transaction Control Language)
- **COMMIT, ROLLBACK**: 논리적인 작업의 단위를 묶어서 DML에 의해 조작된 결과를 작업단위(트랜잭션) 별로 제어하는 명령어를 말한다.


> ### 절차적 데이터 조작어 PL/SQL(오라클), T-SQL(SQL Server)
> - 절차적 데이터 조작어는 어떻게 데이터를 접근해야 하는지 명세
