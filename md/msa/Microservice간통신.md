# Microservice간 통신

---

- Synchronous HTTP communication
  - 동기방식, 하나의 클라이언트 요청이 들어오면 해당 요청이 다 끝날 때 까지 다른 작업을 할 수 없음
- Asynchronous communication over AMQP
  - ex) Spring Cloud Bus : AMQP 프로토콜을 이용해서 각 마이크로 서비스 간의 비동기 방식으로 통신
    - Spring Configuration 정보값을 각각의 마이크로 서비스가 순차적으로 데이터를 동기하는 것이 아니라 일단 연결되어 있는 모든 마이크로 서비스들한테 변경된 사항을 전달
---

## Feign Web Service Client
- FeignClient -> HTTP Client
  - REST Call을 추상화 한 Spring Cloud Netflix 라이브러리
- 사용방법
  - 호출하려는 HTTP Endpoint에 대한 Interface를 생성
  - @FeignClient 선언
- Load balanced 지원