class Users::RegistrationsController < Devise::RegistrationsController
    def destroy
        super
    end
end
