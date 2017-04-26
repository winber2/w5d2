require 'erb'

class ShowExceptions
  attr_reader :app

  def initialize(app)
    @app = app
  end

  def call(env)
    req = Rack::Request.new(env)
    res = Rack::Response.new


    render_exception(env)
    file = File.open('lib/template/rescue.html.erb', 'r')
    lines = file.read

    res.write(lines)
    res.finish
  end

  private

  def render_exception(env)
    log_file = File.open('lib/template/rescue.html.erb', 'a')
    begin
      app.call(env)
    rescue
      log = caller
      log_file.write(log)
    end
    log_file.close

  end

end
