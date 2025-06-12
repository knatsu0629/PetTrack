class Public::HomesController < ApplicationController
    skip_before_action :configure_authentication, only: [:top, :about] 
  
    def top
    end

    def about
    end
end