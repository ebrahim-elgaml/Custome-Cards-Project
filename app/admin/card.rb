ActiveAdmin.register Card do


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
  permit_params :added_by, :added_by_id, :type, :type_id, :taken_by, :taken_by_id, :card_number, :is_taken
  
  filter :added_by
  filter :type
  filter :taken_by
  filter :card_number
  filter :is_taken
  filter :created_at, as: :date_time_range
  filter :taken_at, as: :date_time_range
  #filter :created_at, as: :time_range

end
