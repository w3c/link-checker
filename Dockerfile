FROM ubuntu

# Install dependencies required for link-checker distribution installation
RUN apt-get update && apt-get install -y \
    cpanminus \
    make \
    build-essential \
    libssl-dev \
  && rm -rf /var/lib/apt/lists/*

# Add link-checker user folder
ENV HOME /home/checklink
RUN useradd --create-home --home-dir $HOME checklink \
  && chown -R checklink:checklink $HOME

COPY . /tmp/checklink

RUN cd /tmp/checklink \
  && cpanm --installdeps . \
  && cpanm LWP::Protocol::https \
  && perl Makefile.PL \
  && make \
  && make test \
  && make install

# Clean temporary dist directory
RUN rm -rf /tmp/checklink

WORKDIR $HOME
USER checklink
