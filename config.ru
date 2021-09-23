require_relative 'src/main'

use Rack::Reloader
use Rack::Static, urls: ['/assets'], root: 'public'
use Rack::Session::Cookie, key: 'rack.session', path: '/', secret: 'change_me'
run Main
