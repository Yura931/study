-- 66
-- 3, 4

with 고객(aid, aname, age) AS (
    select '001', '고객1', 10 from dual
    union all
    select '002', '고객2', 10 from dual
    union all
    select '003', '고객3', 10 from dual
    union all
    select '004', '고객4', 10 from dual
),
     추천컨텐츠(aid, cid, cdate) AS (
         select '001', 'C001', '2023-11-13' from dual
         union all
         select '001', 'C002', '2023-11-13' from dual
         union all
         select '001', 'C003', '2023-11-13' from dual
         union all
         select '002', 'C004', '2023-11-13' from dual
         union all
         select '003', 'C004', '2023-11-13' from dual
     ),
     컨텐츠(cid, cname) AS (
         select 'C001', '컨텐츠1' from dual
         union all
         select 'C002', '컨텐츠2' from dual
         union all
         select 'C003', '컨텐츠3' from dual
         union all
         select 'C004', '컨텐츠4' from dual
     ),
     비선호컨텐츠(aid, cid, idate) AS (
         select '001', 'C001', '2023-11-13' from dual
     )
SELECT a.*, b.*, c.*
FROM 고객 a INNER JOIN 추천컨텐츠 b
ON (a.aid = b.aid) INNER JOIN 컨텐츠 c
ON (b.cid = c.cid)
WHERE a.aid = '001'
  AND b.cdate = TO_CHAR('2023-11-13', 'YYYY-MM-DD')
  AND NOT EXISTS (
        SELECT x.cid
        FROM 비선호컨텐츠 x
        WHERE x.aid = b.aid
          and x.cid = b.cid
);