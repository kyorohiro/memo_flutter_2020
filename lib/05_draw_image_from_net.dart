
import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart' as sky;
import 'package:flutter/services.dart' as sky;
import 'package:flutter/widgets.dart' as sky;
import 'package:flutter/material.dart' as sky;
import 'package:flutter/painting.dart' as sky;
import 'dart:ui' as skyui;
import 'dart:io' as io;
import 'package:http/io_client.dart' as http_io;
import 'package:http/browser_client.dart' as http_browser;

import 'package:http/http.dart' as http;


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
      image = await ImageLoader.load("https://avatars0.githubusercontent.com/u/1310669");
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
  static Future<skyui.Image> load(String url) async {
    
    http.BaseClient client;
    if(kIsWeb) {
      client = http_browser.BrowserClient();
    }else{
      client = http_io.IOClient();
    }
    http.Response response = await client.get(Uri.parse(url));

    if (response.statusCode != 200) {
      throw {"message": "failed to load ${url}"};
    } else {
      Uint8List bytes = response.bodyBytes;
      Completer<skyui.Image> completer = new Completer();
      skyui.decodeImageFromList(bytes, (skyui.Image image) {
        completer.complete(image);
      });
      return completer.future;
    }
  }
}