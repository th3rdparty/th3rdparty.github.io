FROM alpine/bundle:2.4.2

ENV LC_ALL=C.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8

ENV EMAIL=th3rdpartyorg@protonmail.com
ENV GITHUB_ID=th3rdparty

RUN git config --global user.email "${EMAIL}" \
    && git config --global user.name "${GITHUB_ID}"
RUN groupadd -r -g 1000 ${GITHUB_ID} \
    && useradd -r -u 1000 -g 1000 ${GITHUB_ID} \
    && mkdir /home/${GITHUB_ID} \
    && chown -R ${GITHUB_ID}:${GITHUB_ID} /home/${GITHUB_ID}

RUN apt-get update \
    && apt-get install -y \
       vim

ADD Gemfile .

RUN bundle install

CMD bundle exec jekyll serve --host 0.0.0.0
