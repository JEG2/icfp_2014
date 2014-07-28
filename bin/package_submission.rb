#!/usr/bin/env ruby

require 'fileutils'

if File.exists?('submission')
  FileUtils.rm_rf 'submission'
end

FileUtils.cp_r '.', '../submission'

FileUtils.mkdir 'submission'

FileUtils.mv '../submission', './submission/code'
FileUtils.mv './submission/code/maps', './submission/maps'

FileUtils.mkdir 'submission/solution'

ARGV.each do |arg|
  # puts "#{arg}"
  FileUtils.cp "#{arg}", "submission/solution/#{File.basename(arg)}"
end
