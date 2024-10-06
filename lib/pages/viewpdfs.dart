// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
class viewpdfs extends StatefulWidget {
  final String? url;
  
  const viewpdfs(this.url, {super.key,});

  @override
  State<viewpdfs> createState() => _viewpdfsState();
}
class _viewpdfsState extends State<viewpdfs> {
  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: SfPdfViewer.network(widget.url!)
          ));
    
  }
}