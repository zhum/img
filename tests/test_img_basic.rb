require_relative 'test_helper'

require 'img'

describe Img do
  around do |test|
    Dir.chdir('testing') do
      Img::Img.init('schema.yml')
      test.call
    end
  end

  it 'loads config' do
    Img::Img.config.wont_be_nil
  end

  it 'will be skipped' do
    skip "test this later"
  end
end
