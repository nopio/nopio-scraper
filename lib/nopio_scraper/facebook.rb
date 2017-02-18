require 'nopio_scraper/class_extensions'

module NopioScraper
  class Facebook
    REGISTRATION_INPUTS = %i(first_name last_name email password day month year sex)
    EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

    attr_accessor :email, :password, :logged_in

    def initialize(email, password)
      @email = email
      @password = password
    end

    def login
      browser.goto('https://www.facebook.com/')
      form = browser.form(id: 'login_form')

      return false unless form.exist?

      form.text_field(name: 'email').set(email)
      form.text_field(name: 'pass').set(password)
      form.input(value: 'Log In').click

      sleep(2)

      @logged_in = main_page?
    end

    def search(query)
      raise unless main_page?

      form = browser.form(action: '/search/web/direct_search.php')
      form.inputs.last.to_subtype.clear
      form.inputs.last.to_subtype.set(query)
      form.button(type: 'submit').click
    end

    def like_page(name)
      login unless logged_in

      search(name)
      browser.link(href: "/search/pages/?q=#{name}&ref=top_filter").click
      browser.button(class_name: 'PageLikeButton').click
    end

    def invite_friend(name)
      login unless logged_in

      search(name)
      browser.link(href: "/search/people/?q=#{name}&ref=top_filter").click
      browser.button(class_name: 'FriendRequestAdd').click
    end

    def create_account(**args)
      raise unless registration_params_valid?(args)

      browser.goto('https://www.facebook.com/')
      form = browser.form(id: 'reg')
      form.text_field(name: 'firstname').set(args[:first_name])
      form.text_field(name: 'lastname').set(args[:last_name])
      form.text_field(name: 'reg_email__').set(args[:email])
      form.text_field(name: 'reg_email_confirmation__').set(args[:email])
      form.text_field(name: 'reg_passwd__').set(args[:password])
      form.select_list(name: 'birthday_day').select(args[:day])
      form.select_list(name: 'birthday_month').select(args[:month])
      form.select_list(name: 'birthday_year').select(args[:year])
      form.radio(name: 'sex', value: sex(args[:sex])).set
      form.button(name: 'websubmit').click
    end

    def browser
      @_browser ||= Watir::Browser.new(:chrome)
    end

    private

    def sex(value)
      value.downcase.strip == 'male' ? '2' : '1'
    end

    def main_page?
      browser.element(id: 'userNavigationLabel').exist?
    end

    def registration_params_valid?(params)
      return false unless params.keys.uniq.sort == REGISTRATION_INPUTS.uniq.sort
      return false if params.values.map(&:blank?).include?(true)
      return false if EMAIL_REGEX.match(params[:email]).nil?

      true
    end
  end
end
