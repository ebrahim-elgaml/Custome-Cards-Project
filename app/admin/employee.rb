ActiveAdmin.register Employee do


  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end

  permit_params :user, :user_id
  index do
    selectable_column
    id_column
    column :user
    column :total_inserted_cards do |u|
      u.user.inserted_cards.count
    end
    column :created_at
    actions
  end


end
