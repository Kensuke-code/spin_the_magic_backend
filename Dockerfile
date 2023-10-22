# ベースイメージ
FROM ruby:3.2.2-alpine

WORKDIR /app 

COPY Gemfile Gemfile.lock ./

ENV RUNTIME_PACKAGES="nodejs git postgresql-dev build-base" \
    LANG=C.UTF-8 \
    TZ=Asia/Tokyo
  

# 必要なパッケージのインストール
RUN apk update && \
  apk upgrade && \
  apk add --no-cache ${RUNTIME_PACKAGES} && \
  bundle install -j4
RUN apk del build-base

# アプリケーションコードのコピー
COPY . .

# サーバの起動
CMD ["rails", "server", "-b", "0.0.0.0"]