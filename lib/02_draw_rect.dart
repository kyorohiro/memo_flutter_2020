import 'package:flutter/material.dart' as sky;
import 'package:flutter/widgets.dart' as sky;
import 'package:flutter/painting.dart' as sky;
import 'package:flutter/rendering.dart' as sky;

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
    sky.Paint p = new sky.Paint();
    p.color = new sky.Color.fromARGB(0xff, 0x55, 0x55, 0x55);
    sky.Rect r = new sky.Rect.fromLTWH(50.0, 100.0, 150.0, 25.0);
    context.canvas.drawRect(r, p);
  }
}