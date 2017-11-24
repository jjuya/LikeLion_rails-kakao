class KakaoController < ApplicationController
  
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
    require 'faker'
    
    user_msg = params[:content] # 사용자의 메세지를 받아온다
    
    if user_msg == "로또"
      msg = {
        :text => [*1..45].sample(6).to_s
      }
    elsif user_msg == "메뉴"
      menu = ["김밥", "햄버거", "샐러드"]
      msg = {
        :text => Faker::Food.dish
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
end
