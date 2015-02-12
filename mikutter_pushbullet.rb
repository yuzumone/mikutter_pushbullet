# -*- coding: utf-8 -*-

require 'washbullet'

Plugin.create(:mikutter_pushbullet) do

  client = Washbullet::Client.new(UserConfig[:pushbullet_token])

  on_mention do |service, msg|
    msg.each do |m|
      if Time.now - m.message[:created] < 10 and
        m.retweet? == false
        title = "Mentioned by " + m.user.to_s
        client.push_note(UserConfig[:pushbullet_device], title, m)
      end
    end
  end

  on_favorite do |service, user, msg|
    title = "Favorite by " + user.to_s
    client.push_note(UserConfig[:pushbullet_device], title, msg)
  end

  on_retweet do |msg|
    msg.each do |m|
      if Time.now - m.message[:created] < 10
        m.retweet_source_d.next { |s|
          if s.user.to_s == Service.primary.user.to_s
            title = "ReTweeted by " + m.user.to_s
            client.push_note(UserConfig[:pushbullet_device], title, s)
          end
        }
      end
    end
  end
  
  settings "Pushbullet" do
    input("AccessToken", :pushbullet_token)
    input("DeviceID", :pushbullet_device)
  end
  
end
