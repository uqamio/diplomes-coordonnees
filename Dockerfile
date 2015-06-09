# Node.js app Docker file
FROM debian

MAINTAINER Gabriel Com "com.gabriel@uqam.ca"

RUN apt-get update  &&  apt-get install -y \
    curl \
    python \
    build-essential \
    git \
    nano \
    libaio1 \
    ruby-full

#installation de node
RUN curl -sL https://deb.nodesource.com/setup_0.12 | bash - &&\
    apt-get install -y nodejs

ENV NODE_ENV='development'
ENV PORT=2015
ENV REPERTOIRE_PUBLIC='./public'
ENV EMETTEUR='http://fondation-uqam.dahriel.io'
ENV PROJET_USAGER_CALLBACK_URL='http://fondation-uqam.dahriel.io/authentification'
ENV SAMLISE=false

ADD . /usr/www
WORKDIR /usr/www

#installer strong-oracle
RUN mv instantclient /opt/instantclient
ENV OCI_HOME=/opt/instantclient
ENV OCI_LIB_DIR=$OCI_HOME
ENV OCI_INCLUDE_DIR=$OCI_HOME/sdk/include
ENV NLS_LANG='.UTF8'

RUN cd $OCI_LIB_DIR &&\
    ln -s libclntsh.so.12.1 libclntsh.so &&\
    ln -s libocci.so.12.1 libocci.so &&\
    echo $OCI_HOME | tee -a /etc/ld.so.conf.d/oracle_instant_client.conf &&\
    ldconfig

#Exécuter des commande de configuration et d'installation
RUN git config --global url."https://".insteadOf git:// &&\
    npm install npm -g &&\
    npm install forever -g &&\
    npm install -g grunt-cli &&\
    npm install -g coffee-script &&\
    npm install -g bower

RUN cd /usr/www &&\
 npm install &&\
  bower install --allow-root &&\
  su -c "gem install sass" &&\
  grunt deploy

EXPOSE 2015

CMD forever -c node dist/app.js