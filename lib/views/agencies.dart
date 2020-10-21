import 'package:flutter/material.dart';
import 'sellingPoints.dart';

class SmopayeAgencies extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Smopaye Selling Points")),
      body: SellingPoints()
      );
  }
}