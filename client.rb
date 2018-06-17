# -*- coding: utf-8 -*-
require 'net/http'
require 'uri'
require 'json'

module MikuBullet
  class Client
    def initialize token
      @token = token
    end

    def create_push(body:, title: nil, url: nil, device_iden: nil)
      begin
        uri = URI.parse('https://api.pushbullet.com/v2/pushes')
        https = Net::HTTP.new(uri.host, uri.port)
        https.use_ssl = true
        req = Net::HTTP::Post.new(uri.request_uri)
        req['Content-Type'] = 'application/json'
        req['Access-Token'] = @token
        type = if url.nil?
                 'note'
               else
                 'link'
               end
        payload = {
          'type' => type,
          'title' => title,
          'body' => body,
          'url' => url,
          'device_iden' => device_iden
        }
        req.body = payload.to_json
        res = https.request(req)
        JSON.parse(res.body)
      rescue => error
        p error
      end
    end
  end
end
