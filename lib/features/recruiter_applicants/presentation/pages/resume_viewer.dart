import 'package:cv_frontend/core/constants/appcolors.dart';
import 'package:cv_frontend/global/common_widget/app_bar.dart';
import 'package:cv_frontend/global/common_widget/loading_widget.dart';
import 'package:cv_frontend/global/common_widget/pop_up_msg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class PdfViewerScreen extends StatefulWidget {
  final String url;

  const PdfViewerScreen({Key? key, required this.url}) : super(key: key);

  @override
  State<PdfViewerScreen> createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  int? _totalPages;
  int _currentPage = 0;
  bool _isReady = false;
  late PDFViewController _pdfViewController;
  String? _filePath;

  @override
  void initState() {
    super.initState();
    _loadPdfFromUrl();
  }

  Future<void> _loadPdfFromUrl() async {
    try {
      final tempDir = await getTemporaryDirectory();
      final filePath = '${tempDir.path}/resume.pdf';

      await Dio().download(widget.url, filePath);

      setState(() {
        _filePath = filePath;
        _isReady = true;
      });
    } catch (e) {
      showSnackBar(context: context, message: "Failed to load PDF: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GeneralAppBar(
        titleText: "See Resume",
      ),
      body: SafeArea(
        
        child: Stack(
          children: [
            if (_filePath != null)
              PDFView(
              
                filePath: _filePath,
                autoSpacing: true,
                enableSwipe: true,
                swipeHorizontal: false,
                pageSnap: true,
                onRender: (pages) {
                  setState(() {
                    _totalPages = pages;
                  });
                },
                onViewCreated: (PDFViewController pdfViewController) {
                  _pdfViewController = pdfViewController;
                },
                onPageChanged: (page, total) {
                  setState(() {
                    _currentPage = page ?? 0;
                  });
                },
                onError: (error) {
                  // Handle PDF loading error
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Failed to load PDF: $error")),
                  );
                },
              ),
            if (!_isReady)
              const Center(
                child: LoadingWidget(),
              ),
          ],
        ),
      ),
      bottomNavigationBar: _isReady
          ? BottomAppBar(
              color: whiteColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Page ${_currentPage + 1} of $_totalPages"),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.chevron_left),
                          onPressed: _currentPage > 0
                              ? () {
                                  _pdfViewController.setPage(_currentPage - 1);
                                }
                              : null,
                        ),
                        IconButton(
                          icon: const Icon(Icons.chevron_right),
                          onPressed: _currentPage < (_totalPages ?? 0) - 1
                              ? () {
                                  _pdfViewController.setPage(_currentPage + 1);
                                }
                              : null,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          : null,
    );
  }
}
