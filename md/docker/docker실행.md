# Docker 실행

---

#### $ docker run [OPTION] IMAGE[:TAG|@DIGEST][COMMAND][ARG...]

| 옵션 | 설명                                                                                                    |
|----|-------------------------------------------------------------------------------------------------------|
| -d | detached mode 흔히 말하는 백그라운드 모드                                                                         |
| -p | 호스트와 컨테이너의 포트를 연결(포워딩)                                                                                |
| -v | 호스트와 컨테이너의 디렉토리를 연결(마운트) </br> 볼륨 마운트 : 호스트 PC가 가지고 있는 디렉토리와 컨테이너가 가지고 있는 디렉토리를 연결 시킬 수 있는 공유 디렉터리 개념 |
|-e| 컨테이너 내에서 사용할 환경변수 설정                                                                                  |
|--name| 컨테이너 이름 설정(컨테이너 이름 중복 불가능)                                                                            |
|--rm| 프로세스 종료시 컨테이너 자동 제거                                                                                   |
|-it| -i(interactive)와 -t(TTY)를 동시에 사용한 것으로 터미널 입력을 위한 옵션                                                   |
|-link| 컨테이너 연결[컨테이너명:별칭]                                                                                     |

ex) $ docker run ubuntu:16.04

---

# 커맨드
- exec(execute) : 추가적으로 컨테이너에 어떤 커맨드를 전달하고자 할 때 사용

---

#### docker mariadb 
- docker exec -it mariadb /bin/bash
  - bash 쉘 실행
- mysql -uroot -p 명령어 실행 시 `bash: mysql: command not found` 에러 발생
  - mariadb 11 버전 이상인 경우 mariadb -u root -p 명령어로 실행