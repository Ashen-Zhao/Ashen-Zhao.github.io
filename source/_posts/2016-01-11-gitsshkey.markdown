---
layout: post
title: "GitHub 的简明教程之配置ssh key"
date: 2016-01-11 17:22:46 +0800
comments: true
keywords: github使用, ssh key, git
categories: Github
---
#Git & GitHub极简介
git 是分布式的代码管理工具，远程的代码管理是基于ssh的，所以要使用远程的git则需要ssh的配置  
github 开源代码库以及版本控制系统
#GitHub的配置

## 1.检查是否已经存在ssh 密钥  
输入 ls -al ~/.ssh 命令  查看是否存在`id_rsa.pub` 和 `id_rsa` 文件  

![附图1](/images/isHassshkey.png)  
如果存在，则执行第 3 步， 否则执行第 2 步
  
## 2.生成新的ssh 密钥  
输入 ssh-keygen -t rsa -C “emailname@gmail.com”  回车，会让你输入密码，直接输入三个空格，不要密码即可    
最后得到了两个文件：id_rsa和id_rsa.pub
## 3.将ssh key添加到GitHub中  
打开[github](https://github.com) 添加 SSH Key 页面

![附图2](/images/goaddsshkey.png)  ![附图2](/images/addsshkey.png)  
这要添加的是`id_rsa.pub`里面的公钥;  
进入ssh. 目录下，输入 cat id_rsa.pub 即可在窗口中看到公钥，将公钥从 ssh-key 一直复制到邮箱地址（包含邮箱），然后粘贴到github 添加ssh key 的key 输入框中，title则随意输入，然后点击Add 即可；  

>##相关文章  
###[GitHub 的简明教程之配置ssh key](http://www.devashen.xyz/blog/2016/01/12/githubused/)   