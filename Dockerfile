FROM ruby:3.3.4-slim-bookworm

RUN useradd -u 1000 developper \
  && apt-get update -qq && apt-get install -qq --no-install-recommends \
    curl awscli unzip wget git vim

RUN wget https://github.com/aws/aws-sam-cli/releases/latest/download/aws-sam-cli-linux-x86_64.zip
RUN unzip aws-sam-cli-linux-x86_64.zip -d sam-installation
RUN ./sam-installation/install
RUN rm -rf aws-sam-cli-linux-x86_64.zip ./sam-installation

RUN gem install bundler -v 2.5.11

RUN chown -R developper:developper /usr/local/bundle
COPY --chown=developper:developper . /home/developper/app
WORKDIR /home/developper/app
RUN chown -R developper:developper /home/developper/app
USER developper
