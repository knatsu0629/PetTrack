# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.find_or_create_by!(email: "admin@example.com") do |admin|
  admin.password = "password"
  admin.password_confirmation = "password"
end

LostPet.create!([
  {
    user_id: 1,
    title: 'チワワのココちゃんがいなくなりました',
    name: 'ココ',
    animal_type: 'チワワ',
    gender: 1, 
    feature: 'ピンクの首輪をしています',
    description: '人見知りですが、食べ物には目がありません。見つけた方はコメントでお知らせください。よろしくお願いします。',
    missing_date: '2025-05-10',
    last_seen_location: '代々木公園',
    address: '東京都渋谷区代々木神園町２−１',
    status: 0 
  },  
  {
    user_id: 4,
    title: '茶トラのネコを探しています',
    name: 'タマ',
    animal_type: '猫',
    gender: 0, 
    feature: 'しっぽが長い',
    description: '普段は家の中にいますが、怖がりで外では鳴いている可能性があります。見かけた方はコメントでご連絡お願いします。',
    missing_date: '2025-05-15',
    last_seen_location: '大濠公園',
    address: '福岡県福岡市中央区大濠公園1-2',
    status: 0
  },
  {
     user_id: 5,
    title: '迷子の柴犬を探しています',
    name: 'ポチ',
    animal_type: '犬',
    gender: 0,
    feature: '赤い首輪',
    description: '人懐っこく、赤い首輪をつけています。体重は約10kgで、柴犬特有の立ち耳と巻き尾が特徴です。人懐っこくて名前を呼ぶと反応します。見かけた方はコメントでお知らせください。よろしくお願いします。',
    missing_date: '2025-05-16',
    last_seen_location: '大阪城公園',
    address: '大阪府大阪市中央区大阪城１−１',
    status: 0
  }
])