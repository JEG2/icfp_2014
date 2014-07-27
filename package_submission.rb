#!/usr/bin/env ruby
require 'fileutils'
include FileUtils

if File.exists?('submission')
  FileUtils.rm_rf 'submission'
end

FileUtils.mkdir('submission')

FileUtils.cp_r './', '../submission'

FileUtils.mv '../submission', './submission/code'

FileUtils.mkdir('submission/solution')

ARGV.each do |arg|
  # puts "#{arg}"
  FileUtils.cp "#{arg}", "submission/solution/#{File.basename(arg)}"
end