import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main(){
  Future.delayed(new Duration(seconds: 1)).then((value) {
    SystemChrome.setEnabledSystemUIOverlays([]);
  });
  runApp(Directionality(textDirection: TextDirection.ltr, child: Center(child: Text("xx"),)));
}
