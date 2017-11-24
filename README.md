## Week 3: 
- day 5 :
0. https://github.com/och8808/kakao_bot_sample

1. [카카오톡 챗봇](https://github.com/jjuya/LikeLion_rails-kakao)
    1) [플러스친구 관리자 센터](https://center-pf.kakao.com)

        * 플러스 친구만들기
        * 스마트채팅 : API형
            - 앱 URL : C9 프로젝트 주소 입력
            - 저장
            - 시작하기
    2) [카카오톡 플러스친구 API](https://github.com/plusfriend/auto_reply)
    3)  기본

     - C9 프로젝트 생성(rails)

     *  kakao controller 생성

        ```bash
        rails g controller kakao keyboard message
        ```

     *  view는 사용 안함 : 'render json:keyboard' 으로 사용

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

     *  message

        ```ruby
        # routes.rb
        post '/message' => 'kakao#message
        ```

        ```ruby
        # app\controllers\application_controller.rb
        class ApplicationController < ActionController::Base
          # Prevent CSRF attacks by raising an exception.
          # For APIs, you may want to use :null_session instead.
          # protect_from_forgery with: :exception
        end
        ```

        ```ruby
        # app\controllers\kakao_controller.rb
        def keyboard
          keyboard = {
            :type => "text"
            }

          render json: keyboard
        end

        def message
          user_msg = params[:content]

          result = {
            "message" => {
              "text" => "user_msg"
              }
            }
          
          render json: result
        end
        ```

    * 응용1 : 메아리

      ```ruby
      # app\controllers\kakao_controller.rb
      def keyboard
        keyboard = {
          :type => "text"
          }

        render json: keyboard
      end

      def message
        user_msg = params[:content]

        result = {
          "message" => {
            "text" => "user_msg"
            }
          }
        
        render json: result
      end
      ```

    * 응용 2 : 로또, 메뉴, 고양이

      ```ruby
      # app\controllers\kakao_controller.rb
      def keyboard
        keyboard = {
          :type => "buttons",
          :buttons => ["로또", "메뉴", "고양이"]
          }

        render json: keyboard
      end

      def message
        require 'rest-client'
        require 'nokogiri'

        user_msg = params[:content] # 사용자의 메세지를 받아온다

        if user_msg == "로또"
          msg = {
            :text => [*1..45].sample(6).to_s
            }
        elsif user_msg == "메뉴"
          menu = ["김밥", "햄버거", "샐러드"]
          msg = {
            :text => menu.sample
            }
        elsif user_msg == "고양이"
          cat = RestClient.get 'http://thecatapi.com/api/images/get?format=xml&results_per_page=1&type=jpg'
          doc = Nokogiri::XML(cat)
          cat_url = doc.xpath("//url").text

          msg = {
            :text => "나만 없어 고양이", 
            :photo => {
              :url => cat_url,
              :width => 640,
              :height => 480
              }
            }
        end

        basic_keyboard = {
          :type => "buttons",
          :buttons => ["로또", "메뉴", "고양이"]
          }

        basic_msg = {
          :message => msg,
          :keyboard => basic_keyboard
          }

        render json: basic_msg
      end
      ```

    4) 배포 : heroku
      ```ruby
      # Gemfile

      # 변경전
      #gem 'sqlite3'
      # 변경후
      gem 'sqlite3', :group => :development
      gem 'pg', :group => :production
      gem 'rails_12factor', :group => :production
      ```

      ```ruby
      # /config/database.yml

      # 변경전
      # production:
      #   <<: *default
      #   database: db/production.sqlite3

      # 변경후  
      production:
        <<: *default
        adapter: postgresql
        encoding: unicode
      ```

      ```bash
      git init
      git add .
      git commit -m "kakao_bot"

      heroku login
      heroku create

      git push heroku master​
      ```