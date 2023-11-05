# 메뉴얼 검색

### welcome page
> - static/index.html을 올려두면 Welcome page 기능을 제공
> - [참고링크] https://docs.spring.io/spring-boot/docs/2.7.16/reference/html/web.html#web.reactive
> [![2023-10-06-182701.png](https://i.postimg.cc/hGQZZhc8/2023-10-06-1827 01.png)](https://postimg.cc/Z9ZLCb90)


### 템플릿엔진
> - 컨트롤러에서 리턴 값으로 문자를 반환하면 viewResolver가 화면을 찾아서 처리
>   - 스프링부트 템플릿엔진 기본 viewName 매핑
>   - resources:templates/ + {ViewName} + .html
> - [참고]`spring-boot-devtools`라이브러리를 추가하면, `html`파일을 컴파일만 해주면 서버 재시작 없이 View 파일 변경 가능
> - intellij 컴파일 방법 : 메뉴 build -> Recompile