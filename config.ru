# frozen_string_literal: true

require_relative 'middleware/not_found'
require_relative 'middleware/unknown_format'

require_relative 'app'

use NotFound
use UnknownFormat
use AppLogger, logdev: File.expand_path('log/app.log', __dir__)
run App.new
