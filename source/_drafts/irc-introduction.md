title: IRC 简介
date: 2015-07-20 10:41:23
tags: irc
---

IRC 是与 HTTP 一样的用户层协议，底层都使用 TCP 协议
常见 IRC 服务器的是 freenode: chat.freenode.net
irc.mozilla.org 6667/6697/8443

# 常用命令
/join #CHANNEL 加入某个频道，如果频道不存在则会创建新频道
/msg NICKNAME MESSAGE 开小窗和某人私聊
/nick NEW_NICKNAME 换昵称
/part #CHANNEL 离开某个频道
/quit 退出IRC
/whois NICKNAME 查看某个详细信息


# freenode
如果某个频道 mode 为 +r，则只有注册了用户名之后才能进入，否则会被转到其它频道，例如 #python 频道，如果没有注册就会跳转到 #python-unregistered。如果 mode 为 +q $~a 则未注册用户不能在里面发言

注册用户名： /msg NickServ register PASSWORD EMAIL
不显示邮箱： /msg NickServ set hidemail on 新注册用户默认就是不公开邮箱的
新加一个备用名：
/nick NEW_NICKNAME
/msg NickServ identify NICKNAME PASSWORD
/msg NickServ group 将 NEW_NICKNAME 加入备用名

隐藏IP：到 #freenode 频道发消息请求获得 cloak，比如在这个频道里发消息：I want to have my unaffiliated cloak，正常情况下立即有管理员帮你设置 unaffiliated cloak
