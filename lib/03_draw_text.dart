import 'package:flutter/material.dart' as sky;
import 'package:flutter/widgets.dart' as sky;
import 'package:flutter/painting.dart' as sky;
import 'package:flutter/rendering.dart' as sky;
import 'dart:ui' as skyui;
Future<Null> main() {
  sky.runApp(new sky.Directionality(textDirection: sky.TextDirection.ltr, child: new Body()));
}


class Body2 extends sky.StatelessWidget{
  @override
  sky.Widget build(sky.BuildContext context) {
    return sky.Center(child: sky.Text("HelloWorld"));
  }
}


class Body extends sky.SingleChildRenderObjectWidget {
  @override
  sky.RenderObject createRenderObject(sky.BuildContext context) {
    return MyRenderBox();
  }
  
}

class MyRenderBox extends sky.RenderBox {
  @override
  bool hitTestSelf(sky.Offset position) => true;

  @override
  void performLayout() {
    size = constraints.biggest;
  }

  @override
  void handleEvent(sky.PointerEvent event, sky.BoxHitTestEntry entry) {}

  void paint(sky.PaintingContext context, sky.Offset offset) {
    sky.Color textColor = const sky.Color.fromARGB(0xaa, 0xff, 0xaa, 0xaa);
    sky.TextStyle textStyle = new sky.TextStyle(
        fontFamily: "Aclonica",
        fontSize: 50.0,
        fontWeight: sky.FontWeight.w500,
        color: textColor);
    sky.TextSpan testStyledSpan = new sky.TextSpan(
        text:"Hello Text!! こんにちは!!",
        style:textStyle);
    sky.TextPainter textPainter = new sky.TextPainter(text:
    testStyledSpan,textDirection: sky.TextDirection.ltr);

    textPainter.layout(minWidth: 200.0, maxWidth: 200.0);
    textPainter.paint(context.canvas, new skyui.Offset(100.0, 100.0));
  }
}