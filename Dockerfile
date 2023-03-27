FROM ubuntu:20.04
#added the ENV debian frontend to resolve the error that stops the build- showing error- debconf: unable to initialize frontend: Dialog 
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get -y update \
# install required tools
&& apt-get install dialog apt-utils -y && apt-get install maven git -y
#returning the DEBIAN_FRONTEND to its default value
ENV DEBIAN_FRONTEND=newt
#copy the entire project
RUN git clone https://github.com/barais/TPDockerSampleApp
WORKDIR /TPDockerSampleApp
RUN mvn install:install-file -Dfile=./lib/opencv-3410.jar \
    -DgroupId=org.opencv  -DartifactId=opencv -Dversion=3.4.10 -Dpackaging=jar
#compile the opencv project 
RUN  mvn package   
#test the built and compiled project, run the application
CMD ["java", "-Djava.library.path=lib/ubuntuupperthan18/", "-jar", "target/fatjar-0.0.1-SNAPSHOT.jar"]
EXPOSE 8080
