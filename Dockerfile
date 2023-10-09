FROM openjdk:8
ADD target/demo-workshop-2.1.2.jar ttrend-app.jar
ENTRYPOINT ["java","-jar","ttrend-app.jar"]