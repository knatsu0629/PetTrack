class Public::HomesController < ApplicationController
    skip_before_action :configure_authentication, only: [:top] 
  
    def top
    end
end