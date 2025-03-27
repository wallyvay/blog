---
layout: post
title: "终于解决：wordpress分享到微信朋友圈缩略图"
date: 2025-03-27
categories: [讲点正事儿]
---

Title: 终于解决：Wordpress分享到微信朋友圈缩略图
Date: 2016-12-16 13:03:49
URL: /wordpress-weixin-thumbnail/
Tags: wordpress , 微信 , 朋友圈 , 特色图片 , 缩略图

![](http://img.weimao.me/2019-05-21-023042.jpg)
微信在2017-3-29发布的《JSSDK自定义分享接口的策略调整》中，对于未接入微信JSSDK或已接入但JSSDK调用失败的网页，被用户分享时，分享卡片将统一使用默认缩略图和标题简介，不允许自定义。

我的那个配置缩略图的方法不能用了，好气啊，微信这种封闭心态真是令人心寒，先有互联网再有微信，但微信不去优化所有的页面抓取体验，而是非要别人接SDK来实现自己的数据诉求矩阵，好气啊真是。

---------------------以下方法已无效--------------------------

我们不用微信的JS接口，那个看起来就好麻烦，不适合我这种代码盲。理念很简单，微信的规则是**自动爬取页面的第一张大图**，大到什么地步呢，说是300px以上，不过我习惯性的设置成750px以上，因为750px是iPhone6的宽，是我用于手机图片的最低标准。那么只需要做一件事情，在**header.php**的**&lt;body&gt;**标签里的第一行里插入一个符合标准的图，并将这个图隐藏起来。假设这个时候你插入的是一个普通url的话，那么每一个页面分享出去都是一样的图，就不够精致。我们使用wordpress的参数，插入文章的『特色图片』，就可以把每篇文章的特色图片作为缩略图分享出去了！**我这个主题coherent的首页图片函数**



&lt;?php header_image(); ?&gt;



**特色图片的函数：**



&lt;?php$large_image_url = wp_get_attachment_image_src( get_post_thumbnail_id($post-&gt;ID), 'large');echo $large_image_url[0];?&gt;



**插入代码**



&lt;!--微信分享缩略图--&gt;
    &lt;div style='margin:0 auto;width:0px;height:0px;overflow:hidden;'&gt;
    &lt;img src="&lt;?php$large_image_url =wp_get_attachment_image_src(get_post_thumbnail_id($post-&gt;ID), 'large');echo $large_image_url[0];?&gt;" width='750'&gt;
    &lt;/div&gt;
&lt;!--微信分享缩略图end--&gt;