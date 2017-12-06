require 'test_helper'

class PoliteControllerTest < ActionDispatch::IntegrationTest
  test "should get salute" do
    get polite_salute_url
    assert_response :success
  end

end
