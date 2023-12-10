# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
User.create!(username:  "管理者",
    email: "admin@gmail.com",
    password:  "admin1111",
    password_confirmation: "admin1111",
    admin: true)

questions_sample = [
    "他人との関係において、自分の感情や考えをオープンに表現することができますか？",
    "新しい環境や経験に対して興奮することがありますか？",
    "ストレスが溜まった時、自分なりのストレス解消法はありますか？",
    "新しいアイデアやプロジェクトに取り組むことが好きですか？",
    "他人の期待に応えるために、自分の時間や意見を犠牲にすることがありますか？",
    "未来の計画や目標を立てることが好きですか？",
    "他人の感情や状況に敏感で、共感することがありますか？",
    "自分の弱点や不完全さを他人に見せることができますか?",
    "新しい人と出会うことが好きですか?",
    "失敗したとき、自分を責めることがありますか？",
    "他人の期待に応えるために、自分の本音を押し殺すことがありますか？",
    "計画的に物事を進めることが得意ですか？"
]
questions_sample.each do |sample|
    SampleQuestion.create!(text: sample)
end