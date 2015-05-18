class HomeScreen < PageActions

  # element :sign_in, css: "span.text"

  def get_home
    driver.get "http://www.distilnetworks.com/"
  end

  def expand_menu
    find_element(:css,"a.hamburger")
  end

  def sign_in
    find_element(:id, "menu-item-39").find_element(:tag_name, "a")
  end

end