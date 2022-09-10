import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

LinearGradient bgAppBare= const LinearGradient(
colors: [Colors.amber,Color.fromRGBO(196, 137, 26,1)],
begin: Alignment.bottomLeft,
end: Alignment.topRight,
);
LinearGradient taskColor= const LinearGradient(
  colors: [Colors.amber,Color.fromRGBO(218, 162, 15,1),Color.fromRGBO(196, 137, 26,1)],
  begin: Alignment.bottomLeft,
  end: Alignment.topRight,
);
LinearGradient bgList= LinearGradient(
  colors: [Color.fromRGBO(2, 45, 115,1),Color.fromRGBO(2, 30, 77,1),Color.fromRGBO(1, 26, 66,1)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);
Color? mainColor =Color.fromRGBO(218, 162, 15,1);