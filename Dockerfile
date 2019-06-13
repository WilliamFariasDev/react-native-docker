FROM openjdk:8

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get update && apt-get -y install nodejs unzip
# ENV VARIABLES
ENV ANDROID_HOME="/usr/local/android-sdk"

WORKDIR ${ANDROID_HOME}

# GRADLE
RUN  mkdir /opt/gradle

# ADD PATH TO BASHRC
RUN export PATH=$PATH:$ANDROID_HOME/emulator\
    && export PATH=$PATH:$ANDROID_HOME/tools\
    && export PATH=$PATH:$ANDROID_HOME/tools/bin\
    && export PATH=$PATH:/opt/gradle/bin\
    && echo PATH=$PATH:$ANDROID_HOME/platform-tools>>/etc/bash.bashrc
RUN npm install -g yarn && yarn global add react-native-cli create-react-native-app
# VOLUMES
VOLUME ["/app","/root/.gradle"]
# CHANGE WORKDIR
WORKDIR /app
# REAT NATIVE PORT
EXPOSE 8081
# DEFAULT REACT NATIVE COMMAND
CMD react-native
