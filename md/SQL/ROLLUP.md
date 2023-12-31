# ROLLUP

```sql
컬럼의 순서가 수행 결과에 영향을 미침 
오른쪽부터 하나씩 없어짐
GROUP BY ROLLUP(col1, col2, col3)
    
    group by 결과1: col1, col2, col3
    group by 결과2: col1, col2
    group by 결과3: col1
    group by 결과4: () -> 전체합계
    
GROUP BY ROLLUP(col1, (col2, col3))
    
    group by 결과1: col1, (col2, col3)
    group by 결과2: col1
    group by 결과3: () -> 전체합계
    
GROUP BY col1, ROLLUP((col2, col3))
    
    group by 결과1: col1, (col2, col3)
    group by 결과2: col1
```

# GROUPPING 함수
ROLLUP, CUBE, GROUPING SETS 함수랑 함께 쓰이며,
GROUP BY에서 쓰인 소계 함수 결과 CASE에서 빠진 컬럼에 대해 1을 반환한다.

### CUBE
```sql
컬럼의 순서가 수행결과에 영향을 미치지 않음
GROUP BY CUBE(col1, col2)
    
    group by 결과 1: col1, col2
    group by 결과 2: col1
    group by 결과 3: col2
    group by 결과 4: () -> 전체합계
    
GROUP BY CUBE(col1)
    
    group by 결과1: col1
    group by 결과2: () -> 전체합계    
```

### GROUPING SETS
```sql
- 원하는 컬럼만 지정해서 소계를 구함
- UNION ALL과 결과가 동일함
    
GROUP BY GROUPING SETS(col1, col2)
    
    group by 결과1: col1
    group by 결과2: col2
    
GROUP BY GROUPING SETS((col1, col2), col2, ())
    
    group by 결과1:(col1, col2)
    group by 결과2: col2
    group by 결과3: ()
```
