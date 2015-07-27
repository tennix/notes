title: 强大好用的 IRC 客户端 WeeChat
date: 2015-07-22 00:13:00
tags: [irc, weechat]
---

WeeChat 是轻量级可扩展的 IRC 客户端，一个轻量级的核心+可选插件。几乎所有东西都是插件，甚至包括 IRC 协议，插件和脚本可以随时动态加载或卸载

## 特性
+ 256色
+ 鼠标
+ 状态条可自定义
+ 6种脚本语言
+ 水平/垂直分屏
+ 动态过滤消息
+ 递增式查找消息
+ FIFO 管道
+ 拼写检查
+ 脚本管理器
+ 远程接口，可以利用图形界面的客户端连接上 WeeChat
+ 不下线升级


http://kmacphail.blogspot.com/2011/09/using-weechat-with-freenode-basics.html

/server add freenode chat.freenode.net/8001
/set irc.server.freenode.nicks "NICKNAME1,NICKNAME2"
/set irc.server.freenode.username "USERNAME"
/set irc.server.freenode.realname "REALNAME"
/connect freenode
/set irc.server.freenode.autoconnect on
/msg nickserv identify PASSWORD
/set irc.server.freenode.command "/msg nickserv identify PASSWORD"
/join #CHANNEL
/set irc.server.freenode.autojoin "#CHANNEL1,#CHANNEL2"
/buffer +1       switch to previous buffer
/buffer -1       switch to next buffer
/buffer 2        switch to the second buffer
/buffer #CHANNEL
/message SOME_USER SOME_MESSAGE
/close
/disconnect SERVER

设置在退出 WeeChat 后或输入 /save 命令后会自动保存，配置保存在 $HOME/.weechat 目录下

清除某个配置：/set irc.server.freenode.nicks null

过滤 join/part/quit 消息
智能过滤 join/part/quit 消息，最近讲过话的人的 join/part/quit 消息保留
/set irc.look.smart_filter on
/filter add irc_smart * irc_smart_filter *   添加 filter 名字为 irc_smart
全局过滤
/filter add joinquit * irc_join,irc_part,irc_quit *  添加 filter 名字为 joinquit
删除添加的过虑器
/filter del joinquit    删除 joinquit 过滤器

过滤后只是隐藏了部分消息，关闭过滤器后又可以看到这些消息，通过 Alt+= 可以开关过滤器

设置输入区域大小
/set weechat.bar.input.size 0   动态调整大小
/set weechat.bar.input.size_max 3 设置最多3行

分割窗口后让所有窗口共用一个输入框
/bar add rootinput root bottom 1 0 [buffer_name]+[input_prompt]+(away),[input_search],[input_paste],input_text
/bar del input 删除默认输入框
要取消一个输入框的设定
/bar del rootinput

搜索聊天记录
/input search_text 或者直接按快捷键 Ctrl+r

安装脚本
/script search url
/script install buffers.pl
/script remove buffers.pl
/script upgrade
