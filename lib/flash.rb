require 'json'

class Flash
  attr_reader :now

  def initialize(req)
    cookie = req.cookies['something']

    @now = cookie ? JSON.parse(cookie) : {}
    @flash = {}
  end

  def [](key)
    @now[key.to_s] || @flash[key.to_s]
  end

  def []=(key, value)
    @flash[key.to_s] = value
  end

  def store_flash(res)
    cookie = { path: '/' , value: @flash.to_json }
    res.set_cookie('something', cookie)
  end

end
