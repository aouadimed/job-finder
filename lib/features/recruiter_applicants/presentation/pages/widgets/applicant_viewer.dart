import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class ApplicantViewerCard extends StatefulWidget {
  final String name;
  final String? jobTitle;
  final String profileImageUrl;
  final String? resumeUrl;
  final String motivationLetter;
  final VoidCallback? onSeeDetailsPressed;
  final VoidCallback onMessageSent;
  final bool hasProfile;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  const ApplicantViewerCard({
    Key? key,
    required this.name,
    this.jobTitle,
    required this.profileImageUrl,
    this.resumeUrl,
    required this.motivationLetter,
    required this.onMessageSent,
    this.onSeeDetailsPressed,
    this.hasProfile = true,
    required this.onAccept,
    required this.onReject,
  }) : super(key: key);

  @override
  State<ApplicantViewerCard> createState() => _ApplicantViewerCardState();
}

class _ApplicantViewerCardState extends State<ApplicantViewerCard> {
  int? _totalPages;
  int _currentPage = 0;
  bool _isReady = false;
  bool _showMotivationLetter = false;
  PDFViewController? _pdfViewController;
  String? _filePath;
  static final Map<String, String> _pdfCache = {};

  @override
  void initState() {
    super.initState();
    if (widget.resumeUrl != null) {
      _loadPdfFromUrl();
    } else {
      setState(() {
        _isReady = true;
      });
    }
  }

  Future<void> _loadPdfFromUrl() async {
    if (widget.resumeUrl == null) return;

    try {
      // Check cache first
      if (_pdfCache.containsKey(widget.resumeUrl)) {
        _filePath = _pdfCache[widget.resumeUrl];
      } else {
        // Download and cache
        final tempDir = await getTemporaryDirectory();
        final fileName = widget.resumeUrl!.split('/').last;
        final filePath = '${tempDir.path}/$fileName';

        final file = File(filePath);
        if (!file.existsSync()) {
          await Dio().download(widget.resumeUrl!, filePath);
        }

        _pdfCache[widget.resumeUrl!] = filePath;
        _filePath = filePath;
      }

      setState(() {
        _isReady = true;
      });
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to load PDF: $e")),
      );
    }
  }

  void _navigateToPage(int page) {
    if (_pdfViewController != null && page >= 0 && page < (_totalPages ?? 0)) {
      _pdfViewController!.setPage(page);
      setState(() {
        _currentPage = page;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.all(16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (!widget.hasProfile) ...[
              _isReady && _filePath != null
                  ? AspectRatio(
                      aspectRatio: 1,
                      child: Stack(
                        children: [
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
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Failed to load PDF: $error")),
                              );
                            },
                          ),
                          if (_showMotivationLetter)
                            Center(
                              child: Container(
                                padding: const EdgeInsets.all(8.0),
                                color: Colors.black.withOpacity(0.7),
                                child: Text(
                                  widget.motivationLetter,
                                  style: const TextStyle(color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                        ],
                      ),
                    )
                  : const AspectRatio(
                      aspectRatio: 3 / 2,
                      child: Center(child: CircularProgressIndicator()),
                    ),
            ] else
              const Center(
                child: Text(
                  "Profile",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
              ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => _navigateToPage(_currentPage - 1),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward),
                  onPressed: () => _navigateToPage(_currentPage + 1),
                ),
                IconButton(
                  icon: const Icon(Icons.note),
                  onPressed: () {
                    setState(() {
                      _showMotivationLetter = !_showMotivationLetter;
                    });
                  },
                ),
              ],
            ),
            const Divider(),
            Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(widget.profileImageUrl),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      if (widget.jobTitle != null)
                        Text(
                          widget.jobTitle!,
                          style: const TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
