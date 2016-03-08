# lib/tasks/sample_data.rake
namespace :db do
  desc 'Drop, create, migrate, seed and populate sample data'
  #task prepare: [:drop, :create, :migrate, :seed, :populate_sample_data] do
  task prepare: [:migrate, :seed, :populate_sample_data] do  
	puts 'Ready to go!'
  end

  desc 'Populates the database with sample data'
  task populate_sample_data: :environment do
	1.upto(10) do |i|
		Laboratory.create(:title=>"Lab #{i}", :user_id=>"1")
		puts 'Lab created!'
	end

	1.upto(3) do |i|
		Gateway.create(:gateway_hash=>"GW #{i}", :synched=>"0", :password => "test")
		puts 'Gateway created!'
	end
	
	1.upto(3) do |i|
		Thing.create(:gateway_id=>"1", :thing_type=>"temperature")
		puts 'Things created!'
	end

	laboratory = Laboratory.find(params[:id])
	thing = Thing.find(params[:id])
	laboratory.things << things
  end
end

