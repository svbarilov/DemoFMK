class HomeScreen < PageActions

  # element :sign_in, css: "span.text"



  def get_home
     driver.get "http://www.prosper.com/"
  end


  def loan_amount
     find_element(:id, "loan-amount")
  end


  def loan_purpose
     find_element(:id, "listing-category-id")
  end


  def credit_score
    find_element(:id, "credit_quality_id")
  end


  def check_your_rate
    find_element(:class, "button")
  end


end