// Copyright 2018 LiuCheng. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.
// 钱学超 2020-04-26 修改

import 'package:flutter/material.dart';

/// 自动缩放大小的文本框
class FlutterAutoText extends StatefulWidget {
  /// 要显示的文字
  final String text;

  ///指定text的父容器的宽度
  ///必须制定宽度
  final double width;

  ///最小的字体大小
  ///默认最小是6
  final double minTextSize;

  /// 字体的样式
  final TextStyle textStyle;

  /// 构造函数
  FlutterAutoText({Key key, @required String text, @required this.width, TextStyle textStyle, double minTextSize})
      : minTextSize = minTextSize ?? 6,
        text = text ?? '',
        textStyle = textStyle ?? TextStyle(fontSize: 14),
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return AutoTextState();
  }
}

/// 创建控件的一个状态
class AutoTextState extends State<FlutterAutoText> with TickerProviderStateMixin {
  final GlobalKey _autoTextKey = GlobalKey();

  // 计算过后的字体大小
  double _fontSize = 0;

  // 动画控制器
  AnimationController _controller;

  // 绘制文本的主要工具
  TextPainter _textPainter;

  didUpdateWidget(FlutterAutoText oldWidget) {
    super.didUpdateWidget(oldWidget);

    _textPainter.text = TextSpan(
      text: widget.text,
      style: widget.textStyle,
    );
    _textPainter.layout();

    _fontSize = widget.textStyle.fontSize;
    _controller.notifyListeners();
    _controller.reset();
    _controller.forward();
  }

  @override
  void initState() {
    super.initState();

    _textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      text: TextSpan(
        text: widget.text,
        style: widget.textStyle,
      ),
    );
    _textPainter.layout();

    _fontSize = widget.textStyle.fontSize;
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 100))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          //当前没有缩放前的text宽度
          var textWidth = _textPainter.width;
          var fontSize = widget.textStyle.fontSize;
          /**
           * only text width largger than Container Width can do while
           */
          if (textWidth > widget.width) {
            while (textWidth > widget.width && fontSize > widget.minTextSize) {
              fontSize -= 0.2;
              _textPainter.text = TextSpan(
                text: widget.text,
                style: widget.textStyle.copyWith(fontSize: fontSize),
              );
              _textPainter.layout();
              textWidth = _textPainter.width;
            }
            setState(() {
              _fontSize = fontSize;
            });
          }
        }
      });
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    /// 缩放文本大小的动画
    return ScaleTransition(
        scale: CurvedAnimation(
          parent: _controller,
          curve: Interval(0.0, 1.0, curve: Curves.easeOut),
        ),
        child: Text(widget.text, key: _autoTextKey, style: widget.textStyle.copyWith(fontSize: _fontSize)));
  }
}
