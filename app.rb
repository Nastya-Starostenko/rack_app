# frozen_string_literal: true

class App
  VALID_FORMATS = { 'year' => '%Y',
                    'month' => '%m',
                    'day' => '%d',
                    'hour' => '%H',
                    'minute' => '%M',
                    'second' => '%S' }.freeze
  DELIMITER = '%2C'

  def call(env)
    puts self.class

    [status, headers, body(env)]
  end

  private

  def status
    200
  end

  def passed_formats(query_string)
    query_string.sub('format=', '').split(DELIMITER)
  end

  def headers
    { 'Content-Type' => 'text/plain' }
  end

  def body(env)
    formats = passed_formats(env['QUERY_STRING'])
    format_string = ''
    formats.each_with_index do |format, index|
      format_string += formats.count - 1 == index ? VALID_FORMATS[format] : "#{VALID_FORMATS[format]}-"
    end
    ["#{Time.now.strftime(format_string)}\n"]
  end
end
