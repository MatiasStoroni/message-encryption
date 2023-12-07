namespace :custom do
  desc "Drop, create, and migrate the database"
  task db_reset: :environment do
    Rake::Task["db:drop:_unsafe"].invoke
    Rake::Task["db:create"].invoke
    Rake::Task["db:migrate"].invoke
  end
end

#para ejecutar
#bundle exec rake custom:db_reset