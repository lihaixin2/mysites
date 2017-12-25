##用法：

	docker run -d --restart=always \
	           --name=shadowsocksr.server \
			   -p 613488:61348 -p  613488:61348/udp \
			   -e PASSWORD=pwd lihaixin/shadowsocksr

	docker run -d --restart=always --name=shadowsocksr.local \
			   -p 1080:1080 \
			   -e PASSWORD=pwd lihaixin/shadowsocksr.local
