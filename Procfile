web: bin/rails server -p $PORT -e $RAILS_ENV
worker: bundle exec sidekiq -C ./config/sidekiq.yml -v
release: bash ./release_tasks.sh
