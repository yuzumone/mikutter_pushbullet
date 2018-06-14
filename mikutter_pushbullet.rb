# -*- coding: utf-8 -*-

require 'washbullet'

Plugin.create(:mikutter_pushbullet) do

  client = Washbullet::Client.new(UserConfig[:pushbullet_token])

  on_mention do |service, msg|
    msg.each do |m|
      if Time.now - m.message[:created] < 10 and m.retweet? == false
        title = "Mentioned by " + m.user.idname
        client.push_note(
          receiver: :device,
          identifier: UserConfig[:pushbullet_device],
          params: {
            title: title,
            body: m.description
          }
        )
      end
    end
  end

  on_favorite do |service, user, msg|
    if !user.me?
      title = "Favorite by " + user.idname
      client.push_note(
        receiver: :device,
        identifier: UserConfig[:pushbullet_device],
        params: {
          title: title,
          body: msg.description
        }
      )
    end
  end

  on_retweet do |msg|
    msg.each do |m|
      if Time.now - m.message[:created] < 10
        m.retweet_source_d.next { |s|
          if s.from_me?
            title = "ReTweeted by " + m.user.idname
            client.push_note(
              receiver: :device,
              identifier: UserConfig[:pushbullet_device],
              params: {
                title: title,
                body: s.description
              }
            )
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
