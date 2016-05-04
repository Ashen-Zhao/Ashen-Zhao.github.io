---
layout: post
title: "iOS 上传图片方法总结"
date: 2015-12-28 17:51:57 +0800
comments: true
tags: [iOS 上传, 上传图片, iOS上传图片,啊神]
keywords: 上传图片, iOS上传, 上传图片iOS, iOS如何上传图片,啊神
description:  iOS如何上传图片,啊神
categories: i|OS
---
###开题：
iOS 开发中难免会遇到上传图片，一般情况下有两种方式：

1.自己动手写（利用NSURLMutableRequest等系统类）

2.使用第三方（如AFNetworking)

据我所经历的，如果你不是大神，还是用第三方吧，自己写的话会很麻烦，需要拼接一些请求头，请求体等，就算弄好了也是废了很多时间了；当然，费时间并不是我不推荐自己动手写，因为在我现在接手的项目中，就是使用的自己写的，上传中会出现丢图等各种问题，特别在网络不好的情况下；

面对这样的上传图片，我的Boss 交给我了一个课题，就是改善上传图片的网络底层库；看在我不是大神的份上，我就选择了AFNetwoking；
<!--more-->
  So,对于自己动手实现的方法，在这里我就不多写了；接下来主要是AFNetwoking实现方法：至于如何导入第三方，我不多说，你是直接拉进也行，使用cocoapods也行；
###进入正题：
以下是上传图片的方法：
<pre>
<code>
+(void)uploadImageWithUrl:(NSString *)strUrl dataParams:(NSMutableDictionary *)dataParams imageParams:(NSMutableDictionary *) imageParams Success:(void(^)(NSDictionary* resultDic)) success Failed:(void(^)(NSError *error))fail {

 NSArray *keys = [imageParams allKeys];

 UIImage * image = [imageParams objectForKey:[keys firstObject]];

  AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//对SSL做处理，防止上传失败
AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    securityPolicy.allowInvalidCertificates = YES;
    securityPolicy.validatesDomainName = NO;
    manager.securityPolicy = securityPolicy;
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 120;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    [manager POST:strUrl parameters:dataParams constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:UIImageJPEGRepresentation(image, 0.5) name:[keys firstObject] fileName:[NSString stringWithFormat:@"%@.jpeg",[keys firstObject]] mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (fail) {
            fail(error);
        }
    }];
}
</code></pre> 
接下来是如何调用：
<pre><code>
-(void)uploadImageAction {

NSString *url = @"https://github.com/Ashen-Zhao";
    NSMutableDictionary *dpp =[@{@"token":@"zhaoshenshenazhao"} mutableCopy];
    NSMutableDictionary *pimgs= [@{@"file":[UIImage imageNamed:@"a.jpg"]} mutableCopy];
 [NetworkEngine uploadImageWithUrl:url dataParams:dpp imageParams:pimgs Success:^(NSDictionary* resultDic) {
        NSLog(@"%@", resultDic);
    } Failed:^(NSError *error) {
     }];
}
</code></pre>
参数说明：

- strUrl：上传图片的服务器地- - dataParams：数据参数（如token等）
- imageParams：图片参数（字典中的object一定要是UIImage类型；当然我写的是这样，你也可以修改为其他）
- Success：上传成功后的Block回调（resultDic是服务器返回的结果）
- Failed：上传失败后的Block回调（error是错误结果）

  以上就是AFNetworking上传图片的方法， 分享给大家一起学习，你也可以自己改造这个方法，如果你发现更好的方法，请留言给我或者发邮件给我<zhaoashen@gmail.com>；