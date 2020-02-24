import 'dart:async';
import 'dart:typed_data';

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
  MyRenderBox(){
     loadImage();
  }
  skyui.Image img = null;
  @override
  bool hitTestSelf(sky.Offset position) => true;

  @override
  void performLayout() {
    size = constraints.biggest;
  }

  @override
  void handleEvent(sky.PointerEvent event, sky.BoxHitTestEntry entry) {}

  loadImage() async {
    if (img == null) {
      img = await ImageLoader.load("assets/sample.jpeg");
      this.markNeedsPaint();
    }
  }
  @override
  void paint(sky.PaintingContext context, sky.Offset offset) {
    if(img == null) {
      return;
    }
    context.canvas.translate(50.0, 50.0);
    context.canvas.scale(8.0, 8.0);
    paintWithImage(context, offset);
  }

  void paintWithImage(sky.PaintingContext context, sky.Offset offset) {
    sky.Paint paint = new sky.Paint();
    skyui.VertexMode vertexMode = skyui.VertexMode.triangleFan;
    List<skyui.Offset> verticesSrc = [
      new skyui.Offset(0.0, 0.0),
      new skyui.Offset(10.0, 50.0),
      new skyui.Offset(50.0, 60.0),
      new skyui.Offset(40.0, 10.0)
    ];
    List<skyui.Offset> textureCoordinates = [
      new skyui.Offset(0.0, 0.0),
      new skyui.Offset(0.0, 1.0 * img.height),
      new skyui.Offset(1.0 * img.width, 1.0 * img.height),
      new skyui.Offset(1.0 * img.width, 0.0)
    ];
    List<sky.Color> colors = [
      const sky.Color.fromARGB(0xaa, 0x00, 0x00, 0xff),
      const sky.Color.fromARGB(0xaa, 0x00, 0x00, 0xff),
      const sky.Color.fromARGB(0xaa, 0x00, 0x00, 0xff),
      const sky.Color.fromARGB(0xaa, 0x00, 0x00, 0xff)
    ];

    skyui.TileMode tmx = skyui.TileMode.clamp;
    skyui.TileMode tmy = skyui.TileMode.clamp;
    Float64List matrix4 = new sky.Matrix4.identity().storage;
    skyui.ImageShader imgShader = new skyui.ImageShader(img, tmx, tmy, matrix4);
    paint.shader = imgShader;
    List<int> indicies = [0, 1, 2, 3];
    // Linear/Radial/SweepGradient and ImageShader not supported yet
    // https://github.com/flutter/engine/blob/master/lib/web_ui/lib/src/engine/bitmap_canvas.dart
    skyui.Vertices vertices = new skyui.Vertices(
        vertexMode, verticesSrc,
        textureCoordinates: textureCoordinates,
        colors: colors,
        indices: indicies
        );
    context.canvas.drawVertices(vertices, skyui.BlendMode.color, paint);
  }
}


class ImageLoader {
  static sky.AssetBundle getAssetBundle() => (sky.rootBundle != null)
      ? sky.rootBundle
      : new sky.NetworkAssetBundle(new Uri.directory(Uri.base.origin));

  static Future<skyui.Image> load(String url) async {
    sky.ImageStream stream = new sky.AssetImage(url, bundle: getAssetBundle()).resolve(sky.ImageConfiguration.empty);
    Completer<skyui.Image> completer = new Completer<skyui.Image>();
    
    sky.ImageStreamListener lis;
    void listener(sky.ImageInfo frame, bool synchronousCall) {
      final skyui.Image image = frame.image;
      completer.complete(image);
      stream.removeListener(lis);
    }
    lis = sky.ImageStreamListener(listener);
    stream.addListener(lis);
    return completer.future;
  }
}

