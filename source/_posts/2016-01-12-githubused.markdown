---
layout: post
title: "GitHub 的简明教程之入门使用"
date: 2016-01-12 10:22:46 +0800
comments: true
keywords: github使用, ssh key, git
categories: Github
---
>##相关文章  
###[GitHub 的简明教程之配置ssh key](http://www.devashen.xyz/blog/2016/01/11/gitsshkey/)   

##本地创建Git仓库
####1、git init 初始化仓库
打开terminal 命令窗口，利用cd 命令，进入你需要初始化的目录，执行git init 命令；  
如出现以下类型输入，则成功初始化  
`Initialized empty Git repository in /Users/shou65/Desktop/myfirstgit/.git/`  
####2、git add . 添加到暂存区（保存项目索引，并生产快照）
这一步一般什么的都不会输出，但是却已经添加好了，不用多想，继续下一步
####3、git commit 提交仓库内容（提交项目索引）
`git commit -m 'fitst commit'`  

-m 之后的内容是对本次commit的描述  
#####4、git log (可忽略) 
查看提交的历史记录  

##本地Git仓库推送到Github
####1、首页github上需要创建个仓库,按下图一步一步走
***
进入github添加仓库界面
![new](/images/newGit.png)    
***
填写仓库相关内容
![addgithub](/images/gitfillcontent.png)  
***
仓库创建成功界面，记住图片中的地址
![url](/images/githubURL.png)  
####2、添加远程仓库，这时候图片中的地址，就有用了  
执行命令：`git remote add origin git@github.com:Ashen-Zhao/firstgithub.git`  

git remote add 远程库的名字 远程库的URL  
####3、推送到远程分支，git默认会创建一个master主分支 
`git push origin master`   

到这里，就完成了本地git仓库提交到github了，有没有小激动，速去github刷新页面，看看你的成果吧

##将github仓库，克隆到本地
####使用git clone 仓库地址 即可
`git clone git@github.com:Ashen-Zhao/firstgithub.git`