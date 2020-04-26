# flutterautotext

flutter 插件

根据宽度自动缩放字体
forked from LiuC520/flutterautotext
因为原文实验过，发现自动缩放的文本框会保存自己的文本大小，如果后台更新了文本，即便是新的文本很少，文本大小也不会恢复。
所以触发了didUpdateWidget方法，重新设置一次动画。
另外对于动画要求不高，所以把动画时间调成100毫秒，有需要的可以自行修改。


![flutter_custom_bottom_tab_bar](/screenshot.png)

### 属性：

*    <font color='VioletRed'>text</font>  ,    //String 要显示的文字  必须的
*   <font color='VioletRed'>width</font> , //doule 指定text的父容器的宽度，必须制定宽度
*   <font color='#DC143C'>minTextSize</font> , //double 最小的字体大小   默认最小是6
*   <font color='#DC143C'>textStyle</font> ,//TextStyle  textStyle文字样式，可以设置字体粗体啊，斜体啊啥的，功能更强大些

提示：
 <font color='#DC143C'>width</font> 这个是必须的属性，因为在build之前无法拿到宽度，必须指定宽度，才能根据宽度进行适配
 其实原理很简单，就是给一个动画，然后在动画结束拿到text的宽度是否大于给定的宽度，
 如果大于给定的宽度，做一个循环来缩小字体，然后重新判断字体的宽度，直到宽度小于等于给定的宽度为止。


# Example

1、首先在pubspec.yaml中添加依赖
```

dependencies:
  flutter:
    sdk: flutter
  flutterautotext:
    git: https://github.com/qianxuechao/flutterautotext
```


```
    import 'package:flutterautotext/flutterautotext.dart';



    FlutterAutoText(
        width: 50, //这个是必须的
        text: "我是钱学超Forked From刘成" ,
        textSize: 12,
    ),

```
