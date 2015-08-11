ActiveAdmin.register User do


  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end

  menu priority: 1
  
  permit_params :email, :password, :password_confirmation, :first_name, :last_name, :phone_number, :is_employee
  
  index do
    selectable_column
    id_column
    column :email
    column :first_name
    column :last_name
    column :phone_number
    column :is_employee
    column :created_at
    actions
  end

  filter :employee
  filter :client
  filter :email
  filter :first_name
  filter :last_name
  filter :phone_number
  filter :is_employee
  filter :inserted_cards
  filter :taken_cards
  filter :created_at

  form do |f|
    f.inputs "User Details" do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :first_name
      f.input :last_name
      f.input :phone_number
      f.input :is_employee
    end
    f.actions
  end

  show do
    attributes_table do
      row :first_name
      row :last_name
      row :email
      row :phone_number
      row :is_employee
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

  #show do
  #  panel "User" do
  #    table_for user do
  #      column :email
  #      column :first_name
  #      column :last_name
  #      column :phone_number
  #      column :is_employee
  #      column :created_at
  #    end
  #  end
    #active_admin_comments
  #end

end
