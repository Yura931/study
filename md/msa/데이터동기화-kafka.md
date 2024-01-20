# 데이터 동기화

---

## Apache Kafka
- Apache Software Foundation의 Scalar 언어로 된 오픈 소스 메시지 브로커 프로젝트
  - Open Source Message Broker Project
- 링크드인(Linked-in)에서 개발, 2011년 오픈 소스화
  - 2014년 11월 링크드인에서 Kafka를 개발하던 엔지니어들이 Kafka개발에 집중하기 위해 Confluent라는 회사 창립
- 실시간 데이터 피드를 관리하기 위해 통일된 높은 처리량, 낮은 지연 시간을 지닌 플랫폼 제공
- Apple, Netflix, Shopify, Yelp, Kakao, New York Times, Cisco, Ebay, Paypal, Hyperledger Fabric, Uber, Salesforce.com 등이 사용

> - 메시지 브로커 : 특정한 리소스에서 다른 쪽에 있는 리소스 또는 서비스 시스템으로 메시지를 전달 할 때 사용되는 서버
> - 전산 시스템에서의 메시지 : 일반적인 텍스트 형태의 메시지, 다양한 문서포맷, JSON, XML, Java가 사용하는 오브젝트 형태의 데이터들
> - 이런 데이터들을 보내는 쪽과 받는 쪽 두 개로 구분 시킨 후 원하는 쪽으로 안전하게 메시지를 전달시켜주는 역할을 하는 것이 메시지 서버(메시지 브로커)

---

### Kafka 데이터 처리 흐름
- MySQL, ORACLE, mongoDB, App, Monitoring, Email 등 다양한 데이터 포맷을 가진 시스템이 Kafka 하나만 상대 하도록 함
- Producer(메시지를 보내는 쪽) / Consumer(메시지를 받는 쪽) 분리
- 메시지를 여러 Consumer 에게 허용
- 높은 처리량을 위한 메시지 최적화
- Scale-out 가능
- Eco-system

### Kafka Broker
- 실행 된 Kafka 애플리케이션 서버
- 3대 이상의 Broker Cluster 구성 권장
  - 여러 개의 브로커들이 서로 밀접하게 연결이 되면서 한 곳에 저장되어 있었떤 어떤 메시지를 다른 쪽에 있는 메시지들도 같이 공유해 줌으로써 하나의 서버가 문제가 생겼을 때, 그걸 대신 할 수 있는 또 다른 브로커를 사용할 수 있음으로써 안전하게 메시지를 지속적으로 사용할 수 있음
  - 어플리케이션 서버의 상태, 문제가 생겼을 때 장애에 대한 체크, 장애에 대한 복구 이런 것들을 관리해주기 위해 코디네이터라는 시스템을 같이 연동해서 사용
  - 카프카에서 코디네이터로 아파치의 주키퍼 사용
- Zookeeper 연동
  - 역할 : 메타데이터 (Broker ID, Controller ID 등) 저장
  - Controller 정보 저장
- n개 Broker 중 1대는 Controller 기능 수행
  - Controller 역할
    - 각 Broker에게 담당 파티션 할당 수행
    - Broker 정상 동작 모니터링 관리

> - 메시지를 주고받을 때 저장되는 공간으로 써는 Kafka 브로커 사용
> - 브로커들을 중재, 컨트롤 해주는 역할 Zookeeper 시스템 사용 

### Kafka 서버 기동 - Windows
- `.\bin\windows\zookeeper-server-start.bat .\config\zookeeper.properties`
- `.\bin\windows\kafka-server-start.bat .\config\server.properties`

### Kafka Producer / Consumer
- Producer(메시지 생산)
  - `.\bin\windows\kafka-console-producer.bat --broker-list localhost:9092 --topic quickstart-events`
- Consumer(메시지 소비)
  - `.\bin\windows\kafka-console-consumer.bat --bootstrap-server localhost:9092 --topic quickstart-events --from-beginning`

### Kafka Connect
- Kafka Connect를 통해 Data를 Import/Export 가능
- 코드 없이 Configuration으로 데이터를 이동
- Standalone mode, Distribution mode 지원
  - RESTful API 통해 지원(Postman, URI)
  - Stream 또는 Batch 형태로 데이터 전송 가능
  - 커스텀 Connector를 통한 다양한 Plugin 제공 (File, S3, Hive, Mysql, etc ...)

#### Kafka Connect 설치
```text
  - curl -O http://packages.confluent.io/archive/5.5/confluent-community-5.5.2-2.12.tar.gz
  - curl -O http://packages.confluent.io/archive/6.1/confluent-community-6.1.0.tar.gz
  - tar xvf confluent-community-6.1.0.tar.gz
  - cd $KAFKA_CONNECT_HOME
  
  2024-01-20 기준 windows
  - confluent-7.3.1
  - confluentinc-kafka-connect-jdbc-10.6.3 
  사용
  
  
```
- Kafka Connect 설정 (기본으로 사용)
  - $KAFKA_HOME/config/connect-distributed.properties
- Kafka Connect 실행
  - ./bin/(windows)/connect-distributed ./etc/kafka/connect-distributed.properties
- Topic 목록 확인
  - ./bin/(windows)/kafka-topics.sh --bootstrap-server localhost:9092 --list

#### Kafka Source Connect 테스트
- Kafka Source Connect 추가(MariaDB)
- 데이터베이스 테이블에 데이터가 추가되면 자동으로 Source Connect에 의해서 컨슈머가 데이터를 받아 볼 수 있음
- 토픽의 데이터가 쌓이는 것을 확인해 볼 수 있다.

#### Kafka Sink Connect 테스트
- Kafka Sink Connect 추가(MariaDB)
```
echo '
{
  "name":"my-sink-connect",
    ...
}
' | curl -X POST -d @- http://localhost:8083/connectors --header "content-Type:application/json"
```
- 데이터가 업데이트 됨과 동시에 데이터를 Sink Connect하고 연결되어 있던 Table에 동일하게 업데이트 시켜주는 작업

-Kafka Producer를 이용해서 Kafka Topic에 데이터 직접 전송
  - Kafka-console-producer에서 데이터 전송 -> Topic에 추가 -> MariaDB에 추가