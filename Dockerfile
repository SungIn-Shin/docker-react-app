# Docker 운영환경
######## builder stage start ##########
# 다음 FROM 까지는 builder stage 라는 것을 명시해줌.
FROM node:alpine as builder

WORKDIR /usr/src/app

COPY package.json ./

# bash shell install
RUN apk update

RUN apk add -no-cache bash
# bash shell install - end
RUN npm install

COPY ./ ./

RUN npm run build

######## builder stage end ##########

######## Nginx 를 활용한 Run Stage start ##########
######## Nginx 를 활용한 Run Stage start ##########

######## Nginx 를 활용한 Run Stage end ##########
FROM nginx 

COPY --from=builder /usr/src/app/build /usr/share/nginx/html
######## Nginx 를 활용한 Run Stage end ##########
