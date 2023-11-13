-- 단일행 문자형 함수

select LOWER('ABCDE') from dual; -- 결과 abcde
select UPPER('abcde') from dual; -- 결과 ABCDE
select INITCAP('abcde') from dual; -- 결과 Abcde
select ASCII('a') from dual; -- 결과 97
select CHR(10) from dual;   -- 결과 줄바꿈
select CONCAT('가', '나') from dual; -- 결과 가나
select SUBSTR('ABCDEFGHIJKLMNOPQRSTUVWXYZ', 1, 5) from dual; -- 결과 ABCDE
select SUBSTR('ABCDEFGHIJKLMNOPQRSTUVWXYZ', 20) from dual; -- 결과 TUVWXYZ

-- INSTR('비교할대상', '비교하고자하는 값', 비교를 시작할 위치, 검색된 결과의 순번
-- 주어진 문자열이나 컬럼에서 특정 글자의 위치를 찾아주는 함수
select 'A-B-C-D', INSTR('A-B-C-D', '-', 1, 2) "INSTR" FROM DUAL;    -- 4 첫번째 인자 문자열에서 세번째 인자 문자에서 시작해서 네번째 인자에 갬색되는 두 번째 인자 문자의 위치 출력
SELECT REPLACE('ABCDE', 'ABC', 'A') FROM DUAL;   -- 첫번째 인자 문자열에서 두번째 인자 문자열을 찾아 세번째 인자 문자열로 변경 후 반환 ADE
select LENGTH('AABBCCDD') from dual; -- 결과 8

SELECT LPAD('20', '5', 'X'),    -- XXX20
       RPAD('20', '5', 'X')     -- 20XXX
FROM DUAL;

SELECT LTRIM(' ORACLE') AS DEFAULT_EX, -- DEFAULT 왼쪽 공백 삭제
       LTRIM('0000ORACLE', '0000') AS CHAR_EX -- 시작 부분에서 '0000' 제거
FROM DUAL; -- 결과 왼쪽공백삭제

SELECT RTRIM ('ORACLE ') AS DEFAULT_EX,         -- DEFAULT 오른쪽 공백 삭제
       RTRIM ('ORACLE0000', '0000') AS CHAR_EX  -- 끝 부분에서 '0000' 제거
FROM DUAL;

SELECT TRIM(' ORACLE ') AS DEFAULT_EX                      -- Default
     , TRIM(' '  FROM  '   ORACLE   ') AS CHAR_EX          -- ' ' 제거
     , TRIM(LEADING '0' FROM '000ORACLE') AS LEADING_EX    -- 시작 부분에서 '0' 제거
     , TRIM(TRAILING '0' FROM 'ORACLE000') AS TRAILING_EX  -- 끝 부분에서 '0' 제거
     , TRIM(BOTH '1' FROM '111ORACLE111') AS BOTH_EX       -- 양쪽에서 '1' 제거
FROM DUAL;

-- 단일행 숫자형 함수

-- 절대값 출력
SELECT ABS(-234) FROM DUAL; -- 234

-- 음수, 0, 양수 구분, 음수는 -1, 0은 0, 양수는 1로 결과를 반환
SELECT SIGN(-20) AS 음수,   -- -1
       SIGN(0) AS 영,       -- 0
       SIGN(20) AS 양수     -- 1
FROM DUAL;

-- 숫자1 나누기 숫자2 후 나머지 값 반환
SELECT MOD(100, 15) FROM DUAL;  -- 10

-- 숫자를 소수점 두 번째 인자 자리에서 반올림하여 리턴한다 두번째 인자가 생략되면 디폴트값은 0
SELECT ROUND(6.2277899) FROM DUAL; -- 6
SELECT ROUND(6.7777899, 3) FROM DUAL;  -- 6.778

-- 숫자를 소수점 두 번째 인자 자리에서 내림하여 리턴한다 두번째 인자가 생략되면 디폴트값은 0
SELECT TRUNC(6.777) FROM DUAL; -- 6
SELECT TRUNC(6.777, 1) FROM DUAL; -- 6.7

-- 숫자보다 작거나 같은 최대 정수를 리턴, 두 번째 인자를 받지 않음, 내림
SELECT FLOOR(6.2) FROM DUAL; -- 6
SELECT FLOOR(6.7) FROM DUAL; -- 6

-- 숫자보다 크거나 같은 최소 정수를 리턴, 두 번째 인자를 받지 않음, 올림
SELECT CEIL(6.2) FROM DUAL; -- 6
SELECT CEIL(6.7) FROM DUAL; -- 7

-- ASCII 코드 번호를 문자나 숫자로 바꾸어 줌
SELECT CHR(91) FROM DUAL; -- [

-- 숫자의 삼각함수 값을 리턴
SELECT SIN(1.4),
       COS(1.4),
       TAN(1.4)
FROM DUAL;

-- 숫자의 지수, 거듭 제곱, 제곱근, 자연 로그 값을 리턴
SELECT EXP(2),
       POWER(13, 14),
       SQRT(3),
       LOG(10, 10),
       LN(10)
FROM DUAL;

-- 날짜형 함수 DATE 타입의 값을 연산

-- 시스템에 저장된 현재 날짜를 반환
SELECT SYSDATE,
       SYSDATE + 1,
       SYSDATE + 1/24,
       SYSDATE + 1/24/60,
       SYSDATE + 1/24/(60/10)
FROM DUAL;

-- 날짜와 날짜 사이의 개월 수를 계산 (첫번째인자 - 두번째인자)
SELECT MONTHS_BETWEEN(TO_DATE('2023-11-13'), TO_DATE('2023-7-13')) AS MONTHS_BETWEEN FROM DUAL; -- 4

-- 날짜에 월을 빼거나 더하는 함수
SELECT ADD_MONTHS(TO_DATE('2023-11-13'), 3) FROM DUAL; -- 2024-02-13
SELECT ADD_MONTHS(TO_DATE('2023-11-13'), -3) FROM DUAL; -- 2023-08-13

-- 첫번째 인자 기준 지정된 요일의 돌아오는 날짜가 언제인지 계산하는 함수, NEXT_DAY(날짜, '요일' or 숫자) 숫자는 1(일) ~ 7(토)
SELECT NEXT_DAY(TO_DATE('2023-11-13'), 1) FROM DUAL; -- 2023-11-19

-- 월의 마지막 날짜를 계산해서 출력하는 함수
SELECT LAST_DAY(TO_DATE('2023-11-01')) FROM DUAL; -- 2023-11-30

-- 날짜 유형의 데이터로부터 날짜 정보를 분리하여 새로운 컬럼의 형태로 추출
select TO_DATE('2023-11-13 07:40:00', 'YYYY-MM-DD HH24:MI:SS') AS systimestamp,
       extract (year from systimestamp) as year,
       extract (month from systimestamp) as month,
       extract (day from systimestamp) as day,
       extract (hour from systimestamp) as hour,
       extract (minute from systimestamp) as minute,
       extract (second from systimestamp) as second
from dual;

select TO_DATE('2023-11-13 07:37:00', 'YYYY-MM-DD HH24:MI:SS') from dual;

/*
    형변환(TO_NUMBER, TO_CHAR, TO_DATE)
    오라클에서 형변환은 임시적(자동) 형변환, 명시적(수동) 형변환 두 가지로 나눌 수 있다.

    NUMBER 10 -> (TO_CHAR) -> CHAR 10 -> (TO_NUMBER) NUMBER 10
    CHAR '21/01/01' -> (TO_DATE) -> DATE 21/01/01

    날짜를 표현하는 방법

    - 연대
    CC - 연대를 1부터 시작해 해당 날짜가 속한 연대를 나타냄

    - 연도
    YYYY - 연도를 4자리로 표현
    RRRR - 2000년 이후에 Y2K 버그로 인해 등장한 날짜 표기법으로 연도 4자리 표기법
    YY - 연도의 끝의 2자리만 표시
    RR - 연도의 끝의 2자리만 표시
    YEAR - 연도의 영문 이름 전체를 표시

    - 월
    MM - 월을 숫자 2자리로 표현
    MON - 유닉스용 오라클에서 월을 뜻하는 영어 3글자로 표시
        윈도우용 오라클일 경우는 MONTH와 동일
    MONTH - 월을 뜻하는 이름 전체를 표시

    - 일
    DD - 일을 숫자 2자리로 표시
    DAY - 요일에 해당하는 명칭을 표시하는데 유닉스용 오라클에서는 영문으로, 윈도우용 오라클에서는 한글로 표시
    DDTH - 몇 번째 날인지를 표시

    -- 시간
    HH24 - 하루를 24시간으로 표시
    HH - 하루를 12시간으로 표시
    MI - 분 표시
    SS - 초 표시
*/

-- 날짜를 문자로 형변환
SELECT TO_CHAR(SYSDATE, 'CC RRRRMMDD HH:MI:SS') FROM DUAL;

-- 문자 포맷 변경
SELECT TO_CHAR(1234, '99999'),  -- 1234
       TO_CHAR(1234, '099999'), -- 001234
       TO_CHAR(1234, '$9999'),  -- $1234
       TO_CHAR(123.4, '999.99'), -- 123.40
       TO_CHAR(12345, '99,999')  -- 12,345
FROM DUAL;


-- 문자형 날짜를 날짜형으로 변경
SELECT TO_DATE('2023-11-13') - TO_DATE('2023-11-01') FROM DUAL;

-- 숫자형 문자를 숫자로 변경
SELECT TO_NUMBER('5') FROM DUAL;
SELECT TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) FROM DUAL;

-- 입력받은 문자열을 다른 문자셋으로 변경 12C 이상에서는 권장하지 않음
SELECT CONVERT('TITLE', 'KO16MSWIN949', 'AL16UTF16') FROM DUAL;
SELECT CONVERT('TITLE', 'UTF8') FROM DUAL;
SELECT CONVERT('Ä Ê Í Õ Ø A B C D E ', 'US7ASCII', 'WE8ISO8859P1') FROM DUAL;



