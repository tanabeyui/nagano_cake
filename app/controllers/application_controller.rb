class ApplicationController < ActionController::Base
  before_action :authenticate_customer!, if: :customer_auth?
  before_action :authenticate_admin!, except: [:index]


  private

  def customer_auth?
    unless controller_name == 'items' || controller_name == 'homes'
      true
    end
  end
end
