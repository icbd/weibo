require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest


  test "首页链接" do
    get root_path

    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", signup_path

    assert_select 'title', full_title('')
  end


  test 'full_title 帮助方法' do
    assert_equal full_title,  @base_title
    assert_equal full_title(''), @base_title
    assert_equal full_title('About'), "About | #{@base_title}"
  end

end
