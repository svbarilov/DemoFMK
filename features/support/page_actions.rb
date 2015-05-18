class PageActions

  App.register_page_object(self)

  def self.inherited(klass)
    App.register_page_object(klass)
  end

  def self.element(name, finder)
    define_method(name) do
      begin
        driver.find_element(finder)
      rescue => e
        raise e, "#{name} cannot be found using #{finder}"
      end
    end
  end

  def wait_for_element_displayed(timeout = 10, &block)
    wait_for(timeout){yield.displayed?}
  end

  def wait_for_element_enabled(timeout = 10, &block)
    wait_for(timeout){yield.enabled?}
  end

  def wait_for_element_exists(timeout = 10, &block)
    wait_for(timeout){yield}
  end

  def wait_for_element_not_exists(timeout = 10, &block)
    result = wait_for(timeout){element_exists?{yield}==false}
    if result == nil
      raise "Element still exists"
    end
  end


  def wait_for(timeout = 10, &block)
    @result=nil
    end_time = Time.now.to_i + timeout
    until Time.now.to_i > end_time
      begin
        @result = with_reduced_timeout{yield}
        return @result if @result
      rescue Selenium::WebDriver::Error::NoSuchElementError
        nil
      end
    end
    if @result == nil || @result == false
      raise "Timeout exceeded, block not succeeded"
    elsif @result == true
      return true
    end
  end


  def element_exists?(&block)
    with_reduced_timeout do
      begin
        result = yield
        return true if result
      rescue
        return false
      end
    end
  end

  private

  def with_reduced_timeout(&block)
    driver.manage.timeouts.implicit_wait = 1
    result = yield
    driver.manage.timeouts.implicit_wait = DEFAULT_TIMEOUT
    result
  end


end