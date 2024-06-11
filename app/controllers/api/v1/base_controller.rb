class Api::V1::BaseController < ApplicationController
  include Devise::Controllers::Helpers
  before_action :authenticate_user!
end
