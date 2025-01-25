import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GifLoader extends StatefulWidget {
  final String assetPath;

  const GifLoader({super.key, required this.assetPath});

  @override
  _GifLoaderState createState() => _GifLoaderState();
}

class _GifLoaderState extends State<GifLoader> {
  late Future<ByteData> _loadGifFuture;

  @override
  void initState() {
    super.initState();
    _loadGifFuture = rootBundle.load(widget.assetPath);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ByteData>(
      future: _loadGifFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error loading GIF'));
        } else {
          return Image.memory(snapshot.data!.buffer.asUint8List());
        }
      },
    );
  }
}
