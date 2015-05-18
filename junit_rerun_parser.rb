require 'rubygems'
require 'nokogiri'

path = './junit_format'
rerun_path = path + '_rerun'
total_failed_on_first_run = 0
total_passed_on_rerun = 0

Dir.foreach(path) do |fname|
  next if fname == '.' or fname == '..'

  if File.file?("#{rerun_path}/#{fname}")
    puts "#{fname} was found in rerun folder"

    main_file = Nokogiri::XML(open("#{path}/#{fname}"))
    rerun_file = Nokogiri::XML(open("#{rerun_path}/#{fname}"))

    total_failed_on_first_run += main_file.child['failures'].to_i

    puts "Number of failures before rerun = " + main_file.child['failures'].to_s

    main_file.xpath("//failure").each do |main_node|

      rerun_file.xpath("//testcase").each do |rerun_node|

        if rerun_node['name'] == main_node.parent['name'] && rerun_node.xpath("./failure").to_s == ""
          temp = main_file.child['failures'].to_i
          temp -= 1
          total_passed_on_rerun += 1
          main_file.child['failures'] = temp.to_s
          puts "Scenario \"" + main_node['message'].gsub('failed ', '') + "\" was changed from failed to passed"
          main_node.remove
          break
        end

      end

    end

    puts "Number of failures after rerun = " + main_file.child['failures'].to_s

    File.open("#{path}/#{fname}", 'w') {|f| f.write("#{main_file}") }

  end

end

puts "Total number of failures before rerun = #{total_failed_on_first_run}"
puts "Total number of failures after rerun = #{total_failed_on_first_run - total_passed_on_rerun}"

raise "There still #{total_failed_on_first_run - total_passed_on_rerun} failed scenarios after rerun" if (total_failed_on_first_run - total_passed_on_rerun) > 0