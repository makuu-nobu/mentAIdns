class SampleQuestion < ApplicationRecord
    def self.random_question
        offset(rand(count)).first
        #render json: { question_text: question&.text }     
    end
end
