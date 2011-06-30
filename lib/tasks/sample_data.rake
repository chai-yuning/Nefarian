namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do

    User.all(:limit => 6).each do |user|
      50.times do
        user.quests.create!(:quest_id => 1, :status => 1)
      end
    end
    
  end
end