FROM ruby:2.4.2

RUN apt-get -y install imagemagick libmagickcore-dev libmagickwand-dev git
ADD etc/policy.xml /etc/ImageMagick/policy.xml

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6
RUN echo "deb http://repo.mongodb.org/apt/debian jessie/mongodb-org/3.4 main" |  tee /etc/apt/sources.list.d/mongodb-org-3.4.list

RUN apt-get update && apt-get install -y mongodb-org
RUN systemctl enable mongod

RUN mkdir -p /shirasagi
WORKDIR /shirasagi
ADD shirasagi/Gemfile /shirasagi/Gemfile
ADD shirasagi/Gemfile.lock /shirasagi/Gemfile.lock
RUN bundle install -j10 --without development test

ADD shirasagi /shirasagi

RUN cp -n config/samples/mongoid.yml config/
RUN cp -n config/samples/secrets.yml config/
RUN cp -n config/samples/unicorn.rb config/

# サンプルや管理者ユーザーはdocker-composeのビルド後に以下を実行する
# docker-compose run web rake ss:create_site data='{ name: "自治体サンプル", host: "demo", domains: "localhost:3000" }'
# docker-compose run web rake db:seed site=demo name=demo
# docker-compose run web rake ss:create_site data='{ name: "企業サンプル", host: "company", domains: "localhost:3000" }'
# docker-compose run web rake db:seed site=company name=company
# docker-compose run web rake ss:create_site data='{ name: "子育て支援サンプル", host: "childcare", domains: "localhost:3000" }'
# docker-compose run web rake db:seed site=childcare name=childcare
# docker-compose run web rake ss:create_site data='{ name: "オープンデータサンプル", host: "opendata", domains: "localhost:3000" }'
# docker-compose run web rake db:seed site=opendata name=opendata
# docker-compose run web rake ss:create_site data='{ name: "LPサンプル", host: "lp", domains: "localhost:3000" }'
# docker-compose run web rake db:seed site=lp name=lp
# docker-compose run web rake ss:create_user data='{ name: "システム管理者", email: "sys@example.jp", password: "pass" }'
