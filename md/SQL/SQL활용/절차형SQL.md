# 절차형 SQL

---

### CURSOR(DB의 연결포인트, 연결점) 순서
- CURSOR OPEN(CURSOR순서 : 선언 -> OPEN -> FETCH -> CLOSE)
- SQL 커서는 Oracle 서버에서 할당한 전용 메모리 영역에 대한 포인터
- 질의의 결과로 얻어진 여러 행이 저장된 메모리상의 위치
- 커서는 SELECT 문의 집합을 처리하는데 사용

```sql
CURSOR 커서명[(매개변수1, 매개변수2, ...)]
IS
SELECT 문장;

-- CURSOR를 OPEN한다.

OPEN 커서명[(매개변수1, 매개변수2, ...)];

-- FETCH는 실제 테이블에서 데이터를 읽어온다.

LOOP
   FETCH 커서명 INTO 변수1, 변수2, ...
   EXIT WHEN 커서명%NOTFOUND
END LOOP;

-- *사용이 완료된 CURSOR는 반드시 CLOSE 해주어야 한다.

CLOSE 커서명;
```

