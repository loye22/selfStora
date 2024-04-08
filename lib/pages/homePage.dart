import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';



class homePage extends StatefulWidget {
  static const routeName = '/homePage';

  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Syncfusion Flutter PDF Viewer'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.bookmark,
              color: Colors.white,
              semanticLabel: 'Bookmark',
            ),
            onPressed: () {
              _pdfViewerKey.currentState?.openBookmarkView();
            },
          ),
        ],
      ),
      body: Center(child: Column(
        children: [
          Text("homePagexxxx"),
          /*Container(
            width: 500,
            height: 500,
            child: SfPdfViewer.network(

              'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf',
              key: _pdfViewerKey,
            ),
          ),*/
        ],
      ),),
    );
  }
}
