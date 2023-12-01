class Answer < ApplicationRecord
    belongs_to :user
    belongs_to :question
    has_many :choices
end
