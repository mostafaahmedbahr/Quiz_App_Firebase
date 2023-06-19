import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

class PDFViewerCachedFromUrl extends StatelessWidget {
    PDFViewerCachedFromUrl({Key? key, required this.url ,required this.name , required this.onPressed}) : super(key: key);

  final String url;
  final String name;
  void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:   Text(name),
        actions: [
          IconButton(
              onPressed: onPressed,
              icon: Icon(Icons.download),
          ),
        ],
      ),
      body: const PDF().cachedFromUrl(
        url,
        placeholder: (double progress) => Center(child: Text('$progress %')),
        errorWidget: (dynamic error) => Center(child: Text(error.toString())),
      ),
    );
  }
}