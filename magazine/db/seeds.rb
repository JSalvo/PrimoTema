# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


article = Article.create(
	{
		title: Forgery(:lorem_ipsum).words(3),
		creation_date: '2016/12/06'
	})

article.images << Image.all.first

2.times.each do |i|
	par = Paragraph.create({body: Forgery(:lorem_ipsum).words(96)})
	par.article = article
	par.save
end
