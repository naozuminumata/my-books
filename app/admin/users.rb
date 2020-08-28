ActiveAdmin.register User do
  permit_params :name, :email, :password_digest 
   ActionController::Base
end
