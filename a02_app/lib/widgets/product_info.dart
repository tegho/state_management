import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:datamodels/datamodels.dart';

import '/business/state_manager.dart';

class ProductInfo extends StatefulWidget {
  final ProductModel product;

  const ProductInfo({super.key, required this.product});

  @override
  State<ProductInfo> createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  int imageIndex = -1;

  void _prevImage() {
    setState(() {
      imageIndex--;
      if (imageIndex < 0) {
        imageIndex = widget.product.images.length - 1;
      }
    });
  }

  void _nextImage() {
    setState(() {
      imageIndex++;
      if (imageIndex >= widget.product.images.length) {
        imageIndex = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String titleShort = (widget.product.title.length > 20)
        ? '${widget.product.title.substring(0, 17)}...'
        : widget.product.title;

    if ((widget.product.images.isNotEmpty) && (imageIndex < 0)) {
      imageIndex = 0;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(titleShort),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 4),
                height: MediaQuery.of(context).size.height / 3,
                child: (imageIndex < 0)
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
                              frameBuilder: (context, child, frame,
                                  wasSynchronouslyLoaded) {
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
                                        onTap: _prevImage,
                                        child: Container(
                                            color: Colors.transparent,
                                            alignment: Alignment.centerLeft,
                                            child: const Icon(
                                                Icons.keyboard_arrow_left)),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: GestureDetector(
                                        onTap: _nextImage,
                                        child: Container(
                                            color: Colors.transparent,
                                            alignment: Alignment.centerRight,
                                            child: const Icon(
                                                Icons.keyboard_arrow_right)),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: List<Widget>.generate(
                                          widget.product.images.length,
                                          (index) {
                                        return (index == imageIndex)
                                            ? const Padding(
                                                padding: EdgeInsets.only(
                                                    left: 4, right: 4),
                                                child: Icon(Icons.circle,
                                                    size: 12),
                                              )
                                            : const Padding(
                                                padding: EdgeInsets.only(
                                                    left: 4, right: 4),
                                                child: Icon(
                                                    Icons.circle_outlined,
                                                    size: 6),
                                              );
                                      }),
                                    )),
                              ),
                            ],
                          ),
                        ],
                      ),
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.product.title,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold))),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Text(widget.product.description,
                      style: const TextStyle(fontSize: 14))),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Brand: ${widget.product.brand}',
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold))),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Category: ${widget.product.category}',
                      style: const TextStyle(fontSize: 14))),
              Container(
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 18),
                alignment: Alignment.centerRight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(2),
                        child: Text('Price: ${widget.product.price}',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold))),
                    SizedBox(
                      width: 90,
                      child: ElevatedButton(
                        child: Row(
                          children: const [
                            Icon(Icons.add_shopping_cart),
                            Text('Add'),
                          ],
                        ),
                        onPressed: () {
                          final StateManager stateManager =
                              context.read<StateManager>();
                          stateManager.cart.addToCart(product: widget.product);
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
