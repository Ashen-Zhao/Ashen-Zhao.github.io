---
layout: post
title: "集成友盟分享中遇到的奇怪的错误"
date: 2017-02-14 13:35:47 +0800
comments: true
keywords: cocoapods警告,`$(inherited)`,友盟编译错误,Undefined symbols for architecture arm64
categories: i|OS
---


###开发中遇到的一些看似不起眼的警告，往往却是问题的所在！
----
这不，这次我就遇到了这个坑，为了提醒自己不要轻易忽略警告，以此文章记录一下，埋坑的艰辛。   

我是在集成友盟分享SDK的时候，使用`cocoapods`导入的友盟分享组件，在命令行敲下pod install只会，安装也完成了，就是出现以下一些警告，我大概浏览了一下，看不出所以然，就没管, 继续在集成。

<i>[!] The `ULife [Debug]` target overrides the `OTHER_LDFLAGS` build setting defined in `Pods/Target Support Files/Pods-ULife/Pods-ULife.debug.xcconfig'. This can lead to problems with the CocoaPods installation
    - Use the `$(inherited)` flag, or
    - Remove the build settings from the target.

[!] The `ULife [Release]` target overrides the `OTHER_LDFLAGS` build setting defined in `Pods/Target Support Files/Pods-ULife/Pods-ULife.release.xcconfig'. This can lead to problems with the CocoaPods installation
    - Use the `$(inherited)` flag, or
    - Remove the build settings from the target.  
</i>
<!--more-->
直到我开始使用友盟的一些类库时，使用也是没有问题的，可当我编译时，却出现了以下错误信息：  

<i>Undefined symbols for architecture arm64:
  "_OBJC_CLASS_$_UMSocialManager", referenced from:
      objc-class-ref in AppDelegate.o
ld: symbol(s) not found for architecture arm64
clang: error: linker command failed with exit code 1 (use -v to see invocation) </i>  

咋一看，还以为是不支持64位呢，可是官方明明写着支持64位的，也就没有去怀疑官方，就开始各种清理缓存，重复编译，各种谷歌，百度，可终究没有可行的办法。去友盟问客服，沟通成本太高，每次掉线，重新连接又是一个新人，也未能解决。   

实在没有办法了，我又重新pod update一下，这次发现依然是上面提到的警告信息，这次我没有忽略，而是仔细的看了下，大概知道了，产生此警告的原因是项目 Target 中的一些设置，CocoaPods 也做了默认的设置，如果两个设置结果不一致，就会造成问题。 

警告中，提示要想使用cocoapods中的设置，需要在项目中定义`PODS_ROOT` 和 `Other Linker Flags`的地方，把他们的值用`$(inherited)`替换掉。   

大致解决办法知道了， 开始在`Build Settings`中的PODS_ROOT` 和 `Other Linker Flags`处进行修改，添加一项`$(inherited)`，Other Linker Flags`我这里没有替换掉，而是添加一项，怕我本来的项也是有用的，就没有替换。  

最后修改后，我再次编译，竟然通过了，我喜极而泣的写下了这篇文章来记录下这次忽略警告的教训经历。  

---
注：在我在网上搜索时，有说，点击项目文件 project.xcodeproj，右键`显示包内容`，用文本编辑器打开`project.pbxproj`，删除`OTHER_LDFLAGS`的地方，保存，回到 Xcode，编译也能通过。这种删除内容的解决办法，我一般不轻易使用的，所以我没有去证实这种做法，若有兴趣，你可以尝试下，不过做好备份哦~~

