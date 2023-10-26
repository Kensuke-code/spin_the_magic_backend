# ベースイメージ
FROM ruby:3.2.2-alpine

ARG RUNTIME_PACKAGES="nodejs tzdata postgresql-dev postgresql git gcompat" \
    DEV_PACKAGES="build-base curl-dev"
ENV LANG=C.UTF-8 \
    TZ=Asia/Tokyo

WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN apk update && \
  apk upgrade && \
  apk add --no-cache ${RUNTIME_PACKAGES} && \
  apk add --virtual build-dependencies --no-cache ${DEV_PACKAGES} && \
  bundle install -j4
RUN apk del build-base

# アプリケーションコードのコピー
COPY . .

# サーバの起動
# 127.0.0.1を0.0.0.0にバインドしている
CMD ["rails", "server", "-b", "0.0.0.0"]