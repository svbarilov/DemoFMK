class GetRateScreen < PageActions

  element :email_field,     id: "email"
  element :password_field,  id: "password"
  element :signin_btn,      id: "signIn"


  # def email_field
  #   find_element(:id, "email")
  # end
  #
  # def password_field
  #   find_element(:id, "password")
  # end
  #
  # def signin_btn
  #   find_element(:id, "login-form-contBtn")
  # end
  #
  # def errors
  #   find_element(:id, "aerrors")
  # end


  def get_rates
    find_element(:css, "div.small-12.columns").find_element(:tag_name, "h1")
  end


  def errors
    find_element(css: "div.alert.alert-danger").find_element(:tag_name, "p")
  end
end