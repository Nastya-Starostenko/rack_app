# frozen_string_literal: true

class UnknownFormat
  def initialize(app)
    @app = app
  end

  def call(env)
    status, headers, body = @app.call(env)

    unknown_formats(env['QUERY_STRING']).any? ? [unknown_status, headers, unknown_body] : [status, headers, body]
  end

  private

  def unknown_formats(query_string = nil)
    query_string.sub('format=', '').split(App::DELIMITER).reject { |a| App::VALID_FORMATS.keys.include?(a) }
  end

  def unknown_status
    422
  end

  def unknown_body
    ["Unknown time format [#{unknown_formats.join(', ')}]\n"]
  end
end
