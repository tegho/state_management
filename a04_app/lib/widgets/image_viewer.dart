import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:datamodels/datamodels.dart';

class ImageViewer extends HookWidget {
  final ProductModel product;

  const ImageViewer({super.key, required this.product});

  void _prevImage(ValueNotifier<int> imageIndex) {
    imageIndex.value = (imageIndex.value < 1)
        ? product.images.length - 1
        : imageIndex.value - 1;
  }

  void _nextImage(ValueNotifier<int> imageIndex) {
    imageIndex.value = (imageIndex.value >= product.images.length - 1)
        ? 0
        : imageIndex.value + 1;
  }

  @override
  Widget build(BuildContext context) {
    final imageIndex = useState(-1);

    if ((product.images.isNotEmpty) && (imageIndex.value < 0)) {
      imageIndex.value = 0;
    }

    return (imageIndex.value < 0)
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
                  product.images[imageIndex.value],
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
                              _prevImage(imageIndex);
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
                              _nextImage(imageIndex);
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
                          children: List<Widget>.generate(product.images.length,
                              (index) {
                            return (index == imageIndex.value)
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
