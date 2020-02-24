
import 'dart:async';

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
  skyui.Image image = null;
  double x = 50.0;
  double y = 50.0;
  @override
  bool hitTestSelf(sky.Offset position) => true;

  @override
  void performLayout() {
    size = constraints.biggest;
  }

  @override
  void handleEvent(sky.PointerEvent event, sky.BoxHitTestEntry entry) {}

  loadImage() async {
    if (image == null) {
      image = await ImageLoader.load("assets/sample.jpeg");
      this.markNeedsPaint();
    }
  }
  void paint(sky.PaintingContext context, sky.Offset offset) {
    loadImage();
    sky.Paint paint = new sky.Paint()..color = new sky.Color.fromARGB(0xff, 0xff, 0xff, 0xff);
    sky.Offset point = new sky.Offset(x, y);
    if (image == null) {
      sky.Rect rect = new sky.Rect.fromLTWH(x, y, 50.0, 50.0);
      context.canvas.drawRect(rect, paint);
    } else {
      context.canvas.drawImageRect(
        image, 
        sky.Rect.fromLTWH(0.0,0.0, image.width.toDouble(), image.height.toDouble()),
        sky.Rect.fromLTWH(50.0,50.0, 50.0,50.0), paint);
    }
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

