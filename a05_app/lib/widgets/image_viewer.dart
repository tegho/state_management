import 'package:flutter/material.dart';

import 'package:datamodels/datamodels.dart';

class ImageViewer extends StatefulWidget {
  final ProductModel product;

  const ImageViewer({super.key, required this.product});

  @override
  State<ImageViewer> createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  int imageIndex = -1;

  void _prevImage() {
    setState(() {
      imageIndex =
          (imageIndex < 1) ? widget.product.images.length - 1 : imageIndex - 1;
    });
  }

  void _nextImage() {
    setState(() {
      imageIndex =
          (imageIndex >= widget.product.images.length - 1) ? 0 : imageIndex + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    if ((widget.product.images.isNotEmpty) && (imageIndex < 0)) {
      imageIndex = 0;
    }

    return (imageIndex < 0)
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.image_outlined, size: 100),
                Text('NO PREVIEW'),
              ],
            ),
          )
        : Stack(
            children: [
              Center(
                child: Image.network(
                  widget.product.images[imageIndex],
                  fit: BoxFit.contain,
                  frameBuilder:
                      (context, child, frame, wasSynchronouslyLoaded) {
                    if (frame == null) {
                      return const CircularProgressIndicator();
                    }
                    return child;
                  },
                ),
              ),
              Column(
                children: [
                  Expanded(
                    flex: 8,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {
                              _prevImage();
                            },
                            child: Container(
                                color: Colors.transparent,
                                alignment: Alignment.centerLeft,
                                child: const Icon(Icons.keyboard_arrow_left)),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: GestureDetector(
                            onTap: () {
                              _nextImage();
                            },
                            child: Container(
                                color: Colors.transparent,
                                alignment: Alignment.centerRight,
                                child: const Icon(Icons.keyboard_arrow_right)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                        color: Colors.black12,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List<Widget>.generate(
                              widget.product.images.length, (index) {
                            return (index == imageIndex)
                                ? const Padding(
                                    padding: EdgeInsets.only(left: 4, right: 4),
                                    child: Icon(Icons.circle, size: 12),
                                  )
                                : const Padding(
                                    padding: EdgeInsets.only(left: 4, right: 4),
                                    child: Icon(Icons.circle_outlined, size: 6),
                                  );
                          }),
                        )),
                  ),
                ],
              ),
            ],
          );
  }
}
