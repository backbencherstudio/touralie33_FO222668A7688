import 'package:flutter/material.dart';

class PdfDetailsScreen extends StatefulWidget {
  const PdfDetailsScreen({super.key});

  @override
  State<PdfDetailsScreen> createState() => _PdfDetailsScreenState();
}

class _PdfDetailsScreenState extends State<PdfDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
      ),
      body: Center(child: Text('Pdf Details')),
    );
  }
}
