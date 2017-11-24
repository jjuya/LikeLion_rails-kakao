## Week 3: 
- day 5 :
1. [카카오톡 챗봇](https://github.com/jjuya/LikeLion_rails-kakao)
    1) [플러스친구 관리자 센터](https://center-pf.kakao.com)
        * 플러스 친구만들기
        * 스마트채팅 : API형
            - 앱 URL : C9 프로젝트 주소 입력
            - 저장
            - 시작하기
    2) [카카오톡 플러스친구 API](https://github.com/plusfriend/auto_reply)
    3) C9 프로젝트 생성(rails)
        * kakao controller 생성
        ```bash
        rails g controller kakao keyboard message
        ```
        
            - view는 사용 안함 : 'render json:keyboard' 으로 사용
                
            ```ruby
            # app\controllers\kakao_controller.rb
            def keyboard
            keyboard = {
                          :type => "buttons",
                          :buttons => ["선택 1", "선택 2", "선택 3"]
                        }
                        
            render json:keyboard
            end
            ```
    4)