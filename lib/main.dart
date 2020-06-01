import "package:flutter/material.dart";
import 'package:bitcoin_tracker/price_screen.dart';

void main(){
  runApp(
    MaterialApp(
      theme: ThemeData.dark(),
      home: PriceScreen(),
    )
  );
}