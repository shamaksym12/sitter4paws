# Use an official Ruby runtime as a parent image
FROM ruby:2.7.7
# RUN printf "deb http://archive.debian.org/debian/ jessie main\ndeb-src http://archive.debian.org/debian/ jessie main\ndeb http://security.debian.org jessie/updates main\ndeb-src http://security.debian.org jessie/updates main" > /etc/apt/sources.list
RUN sed -i 's/stable\/updates/stable-security\/updates/' /etc/apt/sources.list
# RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN apt-get update -qq && apt-get install -y postgresql-client
# Set the working directory to /myapp
RUN mkdir /myapp
WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install
# Copy the current directory contents into the container at /myapp
COPY . /myapp
# Add a script to be executed every time the container starts.
# COPY entrypoint.sh /usr/bin/
# RUN chmod +x /usr/bin/entrypoint.sh
# ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000
# Start the main process. 
# CMD ["rails", "server", "-b", "0.0.0.0"]