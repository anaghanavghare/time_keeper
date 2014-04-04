class Project < ActiveRecord::Base
	attr_accessible :name, :doc_name, :timeframe, :user_id

  belongs_to :user

  accepts_nested_attributes_for :user

  validates_presence_of :name
end
