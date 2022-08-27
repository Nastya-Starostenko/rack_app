# frozen_string_literal: true

class NotFound
  def initialize(app)
    @app = app
  end

  def call(env)
    status, headers, body = @app.call(env)

    right_uri?(env) ? [status, headers, body] : [not_found_status, headers, not_found_body]
  end

  private

  def right_uri?(env)
    env['REQUEST_METHOD'] == 'GET' && env['REQUEST_PATH'] == '/time'
  end

  def not_found_status
    404
  end

  def not_found_body
    ["No route match\n"]
  end
end
