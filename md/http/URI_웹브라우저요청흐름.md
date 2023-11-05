# URI 웹 브라우저 요청흐름

### 1. URI(Uniform Resource Identifier)
> -  Locator, name 또는 둘 다 추가로 분류될 수 있다.
>   - resource를 식별한다. 주민번호처럼?
>   - URL(Resource Locator) : 리소스의 위치
>   - URN(Resource Name) : 리소스의 이름
>   - 장유라가 어디에 있다.... ?
> 
> - URL 우리가 적는 http://www.naver.com:8080/~
> - 이름 부여.. 사실 거의 찾을 수 없음.. 거의 URL만 사용
> 
> 
> - Uniform : 리소스 식별하는 통일된 방식
> - Resource : 자원, URI로 식별할 수 있는 모든 것(제한 없음)
> - Identifier : 다른 항목과 구분하는데 필요한 정보 / 주민번호?
> 
> 
> - URL - Locator : 리소스가 있는 위치를 지정, 리소스가 여기에 있을거야!
> - URN - NAME : 리소스에 이름을 부여
> - 위치는 변할 수 있지만, 이름은 변하지 않는다.
> - urn:isbn:8960777331(어떤 책의 isbn URN)
> - URN 이름만으로 실제 리소스를 찾을 수 있는 방법이 보편화 되어있지 않음
> - 앞으로 URI를 URL과 같은 의미로 이야기!
> 
> 
>> URL 분석
>>> https://www.google.com/search?q=hello&hl=ko  
>>> 리소스에 대한 결과를 돌려줌
>>
>> URL 전체 문법
>>> - scheme://[userinfo@]host[:port][/path][?query][#fragment] 
>>> - https://www.google.com:443/search?q=hello&hl=ko
>>>
>> - secheme : 주로 프로토콜 사용
>>   - 프로토콜 : 어떤 방식으로 자원에 접근할 것인가 하는 약속 규칙
>>     - 예)http, https, ftp 등등
>>   - http는 80포트, https는 443포트를 주로 사용, 포트는 생략 가능
>>   - https는 http에 보안 추가(HTTP Secure)
>> - userinfo : URL의 사용자 정보를 포함해서 인증해야 할 때 사용
>>   - 거의 사용하지 않음
>> - host : 호스트명
>>   - 도메인명이나 IP 주소를 직접 입력
>> - port 
>>    - 접속 포트
>>    - 일반적으로 생략, 생략시 http는 80 https는 443
>> - path
>>   - 리소스가 있는 경로(path)
>>   - 계층적 구조로 설계
>>     - /home/file1.jpg
>>     - /members
>>     - /members/100, /items/iphone12
>> - query
>>   - key=value형태
>>   - ?로 시작, &로 추가 가능 ?keyA=valueA&keyB=valueB
>>   - query parameter, query string 등으로 불림, 웹서버에 제공하는 파라미터, 문자 형태
>>   - 숫자를 적어도 다 문자로 넘어감
>> - fragment
>>   - 잘 사용하진 않음
>>   - html 내부 북마크 등에서 사용
>>   - 서버로 전송되는 정보는 아님


### 2. 웹 브라우저 요청 흐름
> - https://www.google.com/search?q=hello&hello&hl=ko 요청
> - DNS 조회 (IP:200.200.200.2)
> - IP, PORT 정보 찾아냄
> - HTTP 요청 메시지 생성
>   - GET /serach?q=hello&hello&hl=ko HTTP/1.1  
>       HOST:www.google.com
> 
> 1. 웹 브라우저가 HTTP 메시지를 생성
> 2. SOCKET 라이브러리를 통해 OS에 tcpip 계층 전달 
>    1. TCP/IP 정보를 통해 씬 씬엑 엑 해서 서버와 연결!
>    2. 데이터를 전달
> 3. TCP/IP에서 내 데이터에 한번 패킷을 씌움 패킷 정보가 인터넷으로 흘러감
>    1. 웹브라우저가 만든 HTTP메시지를 패킷에 포함시킴
> 4. 수많은 인터넷 노드를 통해서 200.200.200.2번으로 전달
> 5. 요청패킷이 도착하면 서버에서 TCP/IP 패킷을 다 까서 버린 후 http메시지를 보고 해석 함
> 6. 웹서버에서 HTTP 응답 메시지를 만들어 냄
> 7. 서버도 응답 패킷을 만들고 그 위에 TCP/IP 패킷을 씌움
> 8. 클라이언트에 도착!
> 9. TCP/IP 위에 올라온 html메시지 확인
> 10. html 데이터를 까서 웹 브라우저가 html을 렌더링 하고 클라이언트가 볼 수 있음!

