# ROW

---

### Row Chaining
- 정의
  - 하나의 Row를 하나의 블록에 저장할 수 없어서 여러 블록에 걸쳐서 저장하는 현상
- 특성
  - Initial Row Piece(행 조작)와 Row Pointer로 블록 내에 저장 됨
- 문제점 
  - Row의 정보를 검색하기 위해 하나 이상의 데이터 블록을 Scan해야 하기 때문에 성능이 감소됨
- 해결책
  - 블록의 크기를 크게 만든다.

### Row Migration
- 정의
  - Update로 인하여 늘어나는 공간을 저장할 공간이 없어서 다른 블록으로 Row를 옮기는 현상
- 특성
  - 기존 블록에는 Migration되는 데이터의 row header와 블록 주소값을 갖게 되고, 새로운 블록에는 Migration되는 데이터가 저장됨
- 문제점
  - Migration된 Row를 읽기 전에 기존 블록에서 헤더를 통해 Migration 된 Row를 읽기 때문에 성능이 감소됨
- 해결책
  - PCTFREE를 크게 설정
  - 객체를 Export하고 삭제한 후 import
  - 객체를 Migration하고 Truncate