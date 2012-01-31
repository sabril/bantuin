ActiveAdmin.register AdminUser do
  menu :parent => "System Settings"
  
  index do
    column :email do |user|
        link_to user.email, admin_admin_user_path(user)
    end
    column :current_sign_in_at
  end
  
  form :partial => "admin_user_form"
  
  collection_action :new_password
  
  collection_action :update_password, :method => :put do
    admin_user = current_admin_user
    if admin_user.update_attributes(params[:admin_user])
      sign_in admin_user, :bypass => true
      redirect_to root_path, :notice => "Password updated"
    else
      render :action => "new_password"
    end
  end
  
  controller do
    after_filter :add_updated_by, :only => [:create, :update]
    def add_updated_by
      @admin_user.update_attributes(:updated_by => current_admin_user.email)
    end
  end
end

ActiveAdmin.register_page "Update My Password" do
  menu :parent => "System Settings"
  content do
    render  :partial => "admin/admin_users/new_password"
  end  
end

