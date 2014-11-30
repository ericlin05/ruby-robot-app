require 'fileutils'

task default: %w[test]

desc "Running unit test cases"
task :test do
    sh %{ ruby -I . test/unit/all_tests.rb }
end
