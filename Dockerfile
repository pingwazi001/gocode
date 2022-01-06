# 构建编译文件
FROM golang:1.17 as builder
# 拷贝项目文件到镜像中
COPY . /app
# 设置命令工作目录
WORKDIR /app
# 执行命令编译项目文件
RUN go mod tidy && make build

# 构建运行时文件
FROM alpine:3.13
# 添加作者
LABEL author=pingwazi
# 设置工作目录
WORKDIR /app
# 从上一阶段中拷贝可执行文件
COPY --from=builder /app/bin/app /app/bin/app
# 声明暴露的端口
EXPOSE 9000/tcp
# 调整动态链接地址
RUN mkdir /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2
# 启动服务
ENTRYPOINT [ "/app/bin/app" ]