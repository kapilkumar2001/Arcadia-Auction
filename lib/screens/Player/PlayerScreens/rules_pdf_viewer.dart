import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class RulesPdfViewer extends StatefulWidget {
  static const routeName = '/rules-pdf-viewer';

  @override
  _RulesPdfViewerState createState() => _RulesPdfViewerState();
}

class _RulesPdfViewerState extends State<RulesPdfViewer> {
  PdfViewerController? _pdfViewerController;
  @override
  void initState() {
    _pdfViewerController = PdfViewerController();
    _pdfViewerController!.jumpToPage(1);
    super.initState();
  }

  PdfTextSearchResult? _searchResult;

  @override
  Widget build(BuildContext context) {
    String pdfUrl = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text('Schedule'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () async {
              _searchResult = await _pdfViewerController?.searchText(
                'the',
                searchOption: TextSearchOption.caseSensitive,
              );
            },
          ),
          Visibility(
            visible: _searchResult?.hasResult ?? false,
            child: IconButton(
              icon: Icon(
                Icons.clear,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  _searchResult!.clear();
                });
              },
            ),
          ),
          Visibility(
            visible: _searchResult?.hasResult ?? false,
            child: IconButton(
              icon: Icon(
                Icons.keyboard_arrow_up,
                color: Colors.white,
              ),
              onPressed: () {
                _searchResult?.previousInstance();
              },
            ),
          ),
          Visibility(
            visible: _searchResult?.hasResult ?? false,
            child: IconButton(
              icon: Icon(
                Icons.keyboard_arrow_down,
                color: Colors.white,
              ),
              onPressed: () {
                _searchResult?.nextInstance();
              },
            ),
          ),
        ],
      ),
      body: Container(
        // child: SfPdfViewer.network(
        //   pdfUrl,
        //   initialZoomLevel: 2,
        // ),
        child: SfPdfViewer.asset('assets/docs/RuleBook.pdf'),
      ),
    );
  }
}
