#!/bin/bash
#定义变量
API_NAME="devops-demo"
API_VERSION="0.0.1-SNAPSHOT"
API_PORT=58080
#IMAGE_NAME="harry/$API_NAME:$BUILD_NUMBER"
#如果下面需要将镜像推送到镜像仓库，那么此处的镜像名称需要带上镜像仓库地址
IMAGE_NAME="harbor.harry.com:8015/harry/$API_NAME:$BUILD_NUMBER"
CONTAINER_NAME=$API_NAME-$API_VERSION
#进入target目录复制Dockerfile文件
cd $WORKSPACE/$API_NAME/target/docker
#cp classes/Dockerfile .
#构建docker镜像
docker build -t $IMAGE_NAME .
#登录Harbor镜像仓库（此处的仓库地址需要与上面IMAGE_NAME的仓库地址保持一致否则推送denied）
docker login -u admin -p Harbor12345 harbor.harry.com:8015
#推送docker镜像到Harbor镜像仓库
docker push $IMAGE_NAME
#删除docker容器
cid=$(docker ps -a -q -f NAME="$CONTAINER_NAME")
#cid=$(docker ps | grep "$CONTAINER_NAME" | awk '{print $1}')
if [ "$cid" != "" ]; then
   docker rm -f $cid
fi
#启动docker容器
docker run -d -p $API_PORT:8080 --name $CONTAINER_NAME $IMAGE_NAME
#删除Dockerfile文件
rm -f Dockerfile
