import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  final Map post;

  const DetailScreen({super.key, required this.post});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool loaded = false;

  @override
  Widget build(BuildContext context) {
    final post = widget.post;

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Thumbnail
                Hero(
                  tag: post['id'],
                  child: Image.network(
                    post['media_thumb_url'],
                  ),
                ),

                // Full image (fade in)
               AnimatedOpacity(
                  opacity: loaded ? 1 : 0,
                  duration: const Duration(seconds: 1), // slower so you can SEE it
                    child: Image.network(
                    post['media_mobile_url'],
                    loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
        // image finished loading
                  Future.delayed(const Duration(seconds: 1), () {
                     if (!loaded) {
                          setState(() {
                           loaded = true;
            });
          }
        });
      }
      return child;
    },
  ),
),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(12),
            child: ElevatedButton(
              onPressed: () {
                debugPrint(
                    "Downloading RAW: ${post['media_raw_url']}");
              },
              child: const Text("Download High-Res"),
            ),
          ),
        ],
      ),
    );
  }
}