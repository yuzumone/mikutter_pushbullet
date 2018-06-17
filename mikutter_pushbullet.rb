# -*- coding: utf-8 -*-

require_relative './client'

Plugin.create(:mikutter_pushbullet) do

  on_mention do |service, msg|
    msg.each do |m|
      if Time.now - m.created < 10 and !m.retweet?
        title = "Mentioned by #{m.user.idname}"
        notify title, m.description, m.perma_link.to_s
      end
    end
  end

  on_favorite do |service, user, msg|
    if !user.me?
      title = "Favorited by #{user.idname}"
      notify title, msg.description, msg.perma_link.to_s
    end
  end

  on_retweet do |msg|
    msg.each do |m|
      if Time.now - m.created < 10
        m.retweet_source_d.next { |s|
          if s.from_me?
            title = "ReTweeted by #{m.user.idname}"
            notify title, s.description, s.perma_link.to_s
          end
        }
      end
    end
  end

  def notify(title, body, url)
    client = MikuBullet::Client.new UserConfig[:pushbullet_token]
    client.create_push(
      title: title,
      body: body,
      url: url,
      device_iden: UserConfig[:pushbullet_device]
    )
  end
  
  settings "Pushbullet" do
    input("AccessToken", :pushbullet_token)
    input("DeviceID", :pushbullet_device)
  end
  
end
