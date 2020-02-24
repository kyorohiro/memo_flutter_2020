import 'package:flutter/rendering.dart' as sky;
import 'package:flutter/services.dart' as sky;
import 'package:flutter/widgets.dart' as sky;
import 'package:flutter/material.dart' as sky;
import 'package:flutter/painting.dart' as sky;
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

  @override
  void paint(sky.PaintingContext context, sky.Offset offset) {
    sky.Paint paint = new sky.Paint();
    skyui.VertexMode vertexMode = skyui.VertexMode.triangles;
    List<skyui.Offset> verticesSrc = [
      new skyui.Offset(50.0, 50.0),
      new skyui.Offset(100.0, 400.0),
      new skyui.Offset(350.0, 300.0)
    ];
    List<skyui.Offset> textureCoordinates = [];
    List<sky.Color> colors = [
      const sky.Color.fromARGB(0xaa, 0xff, 0x00, 0x00),
      const sky.Color.fromARGB(0xaa, 0x00, 0xff, 0x00),
      const sky.Color.fromARGB(0xaa, 0x00, 0x00, 0xff)
    ];
    List<int> indicies = [0, 1, 2];
    skyui.Vertices vertices = new skyui.Vertices(vertexMode, verticesSrc,colors: colors, indices: indicies);
    context.canvas.drawVertices(vertices, skyui.BlendMode.color, paint);
  }
}