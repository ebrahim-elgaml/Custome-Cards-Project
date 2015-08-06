class CardsController < ApplicationController
  before_action :authenticate_user!
  def index
    if(params[:user_id])
      user = User.find(params[:user_id])
      @cards = user.cards
    else
      @cards = current_user.cards
    end
  end
  def create
    notices = []
  	if current_user.is_employee
  		if Type.exists?(value: params[:value])
        type = Type.find_by(value: params[:value])
      else
        flash[:notice] = "Cards value not available"
        redirect_to root_path and return
      end
      cards = params[:cards].split(' ')
  		line = 1
  		cards.each do |c|
  			unless c.blank?
  				added_card = Card.new(number: c, added_by_id: current_user.id, type_id: type.id)
  				unless added_card.save
  					notices << "Card #{added_card.errors.full_messages.first} in Card (#{c})"
  				end
  				line += 1
  			end
  		end
      unless notices.count == cards.count
        notices << "The other cards added succefully"
      end
  		redirect_to root_path, notice: notices
  	else
      found = false
      Type.all.each do|t|
        param = params["#{t.id}"]
        unless param.blank?
          if Card.where(type_id: t.id, is_taken: false).count >= param.to_i
            found = true
            Card.where(type_id: t.id, is_taken: false).limit(param.to_i).update_all(is_taken:true)
          else
            notices << "No available cards for value #{t.value}"
          end
        end
      end
      if found
        notices << "The other cards has been taken succefully"
      end
  		redirect_to root_path, notice: notices
  	end
  end


end
