$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'minitest'
require 'minitest/spec'
require 'minitest/around/spec'
require 'minitest/autorun'
