class CardsController < ApplicationController
  before_action :authenticate_user!
  def index
    if(params[:user_id])
      user = User.find(params[:user_id])
      @cards = user.cards.order(created_at: :desc)
    else
      if current_user.is_employee
        @cards = current_user.cards.order(created_at: :desc)
      else
        @cards = current_user.cards.order(taken_at: :desc).group(:taken_at, :type_id, :id).count.to_a
      end
    end
  end

  def show
    redirect_to action: :edit, id: params[:id]
  end
  # def uploadFile
  #   if Type.exists?(params[:type])
  #     type = Type.find(params[:type])
  #   else
  #     flash[:notice] = "Cards value not available"
  #     redirect_to root_path and return
  #   end
  #   file = params[:upload][:datafile].open
  #   notices = []
  #   inserted = false
  #   i = 0
  #   #file.each_line do |f|
  #    # if i < 50
  #      notices << file
  #    #   i += 1
  #    # else
  #    #   break
  #    # end
  #     #notices << file.each_line.count
  #    # unless f.blank?
  #    #   added_card = Card.new(card_number: f, added_by_id: current_user.id, type_id: type.id)
  #    #   unless added_card.save
  #     #    notices << "Card #{added_card.errors.full_messages.first} in Card (#{f})"
  #      # else
  #      #   inserted = true
  #      # end
  #     #end
  #   #end
  #   if notices.any?
  #     if inserted
  #       notices << "Other cards has been added succefully"
  #     end
  #   else
  #     notices << "cards has been added succefully"
  #   end
  #   redirect_to root_path, notice: notices
  # end

  def create
    
    notices = []
  	if current_user.is_employee
  		if Type.exists?(value: params[:value])
        type = Type.find_by(value: params[:value])
      else
        flash[:notice] = "Cards value not available"
        redirect_to root_path and return
      end
      inserted = false
      cards = params[:cards].split(' ')
  		cards.each do |c|
  			unless c.blank?
  				added_card = Card.new(card_number: c, added_by_id: current_user.id, type_id: type.id)
  				if added_card.save
  					inserted = true
  				else
            notices << "Card #{added_card.errors.full_messages.first} in Card (#{c})"
          end
  			end
  		end
      if notices.any?
        if inserted
          notices << "Other cards has been added succefully"
        end
      else
        notices << "cards has been added succefully"
      end
      #if notices.count > 0 and notices.count != cards.count
      #  notices << "Other cards has been added succefully"
      #elsif notices.count == 0
      #  notices << "cards has been added succefully"
      #end
      #unless notices.count == cards.count
      #  notices << "cards has been added succefully"
      #end
  		redirect_to root_path, notice: notices
  	else
      if Type.exists?(params[:value])
        number = params[:number]
        t = Type.find(params[:value])
        if Card.where(type_id: t.id, is_taken: false).count >= number.to_i
          Card.where(type_id: t.id, is_taken: false).limit(number.to_i).update_all(is_taken: true, taken_by_id: current_user.id, taken_at: Time.current)
          redirect_to cards_path, notice: "Cards has been taken succefully"
        else
          redirect_to root_path, notice: "No available cards for value"
        end
      else
        redirect_to root_path, "NO Value"
      end
  	end
  end

  def edit
    if Card.exists?(params[:id])
      @card = Card.find(params[:id])
      unless @card.added_by == current_user
        redirect_to root_path, notice: "No permission"
      end
    else
      redirect_to root_path, notice: "No card available"
    end 
  end

  def update
    @card = Card.find(params[:id])
    if @card.update(card_params)
      redirect_to cards_path, notice: "updated succefully"
    else
      flash[:notice] = @card.errors.full_messages.first
      render 'edit'
    end
  end

  def destroy
    if Card.exists?(params[:id])
      card = Card.find(params[:id])
      if card.added_by == current_user
        card.destroy
        redirect_to cards_path, notice: " Deleted succefully "
      else
        redirect_to root_path, notice: "No permission"
      end
    else
      redirect_to root_path, notice: "No card available"
    end
  end

  private
    def card_params
      params.require(:card).permit(:card_number, :type_id)
    end



end
