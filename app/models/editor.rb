class Editor
    include ActiveModel::Model
    
    def self.editText(user_id)
        recent_answers = Answer.where(user_id: user_id).last(5)
        results = []
        
        recent_answers.each_with_index do |answer, index|
            question = Question.find_by(id: answer.question_id)

            # 対応する選択肢を取得
            choice = Choice.find_by(id: answer.choice_id)

            # 直感的な変換
            intuitive_answer = if answer.choice.answer_time <= 1
                                    '直感で回答'
                                else
                                    ''
                                end

            # 思考的な変換
            thoughtful_answer = if answer.choice.answer_time > 1
                                    '思考して回答'
                                else
                                    ''
                                end
            puts "Question Text: #{question&.question_text}"  # nilの可能性に対処
            puts "Result Answer: #{choice&.result_answer}"     # nilの可能性に対処
            puts "Intuitive Answer: #{intuitive_answer}"
            puts "Thoughtful Answer: #{thoughtful_answer}"
            puts '---'
            results.push("問#{index + 1}=>質問文:#{question&.question_text}、回答:#{choice&.result_answer}、回答の傾向:#{intuitive_answer + thoughtful_answer}")
        end

        return results
    end

end