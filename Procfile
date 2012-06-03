web: bundle exec rails server -p $PORT
worker: env QUEUES=jobs VERBOSE=1 bundle exec rake resque:work
