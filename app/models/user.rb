class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates_presence_of :first_name , :message => "first_name can't be empty"
  validates_presence_of :last_name , :message => "last_name can't be empty"
  #validates_numericality_of :phone_number
  validates :phone_number, numericality: { only_integer: true }, :allow_blank => true
  has_one :employee, :dependent => :destroy
  has_one :client, :dependent => :destroy
  has_many :inserted_cards, class_name: 'Card', :foreign_key => "added_by_id"
  has_many :taken_cards, class_name: 'Card', :foreign_key => "taken_by_id"
  after_create :set_employee_or_client, :default_values
  def default_values
    self.is_employee ||= false
  end
  def set_employee_or_client
  	if self.is_employee
  		Employee.create(user_id: self.id)
  	else
  		Client.create(user_id: self.id)
  	end
  end

  def type
    if self.is_employee
      Employee.find_by_user_id(self.id)
    else
      Client.find_by_user_id(self.id)
    end
  end
  
  def type_show
    if self.is_employee
      "Employee"
    else
      "Client"
    end
  end

  
  def cards
    if self.is_employee
      self.inserted_cards
    else
      self.taken_cards
    end
  end

  def to_s
    "#{first_name} #{last_name}"
    
  end
  
end
