class Answer < ActiveRecord::Base
  attr_accessible :body
  validates_presence_of :body
  belongs_to :question
  belongs_to :user
end
