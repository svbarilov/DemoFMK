require 'bundler'
# require_relative "page_actions"

Bundler.require(:default)

DEFAULT_DEVICE = 'iPad Air'
DEFAULT_TIMEOUT = 3600


def caps
  { caps:       { deviceName: (ENV['DEVICE'] || DEFAULT_DEVICE),
                  platformName: 'iOS',
                  platformVersion: (ENV['SDK'] || '8.1'),
                  orientation: 'portrait',
                  newCommandTimeout: '36000',
                  browserName: 'Safari'
                  }}
end

def launch_driver
  Appium::Driver.new(caps)
  Appium.promote_appium_methods(App)
  Appium.promote_appium_methods(PageActions)

  i = 0
  app_driver = nil
  until app_driver != nil || i < 5
    begin
      app_driver = start_driver
    rescue
      `killall node >/dev/null 2>&1`
      p "Appium server doesn`t respond, restarting..."
      sleep 10
      i+=1
    end
  end

  start_driver
end


World { App.new }




After do |scenario|
  if scenario.failed?
    screenshots_dir = File.join(File.dirname(__FILE__), "..", ".." , "screenshots")
    time_stamp = Time.now.strftime("%Y-%m-%d_at_%H.%M.%S").to_s
    screenshot_name = "#{time_stamp}_failure_#{scenario.name.gsub(/[^\w`~!@#\$%&\(\)_\-\+=\[\]\{\};:',]/, '-')}.png"
    screenshot_file = File.join(screenshots_dir, screenshot_name)
    driver.save_screenshot(screenshot_file)
    embed("screenshots/#{screenshot_name}", 'image/png')
  end

  driver.quit
end
