import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/product.dart';
import '../viewmodels/product_viewmodel.dart';
import '../widgets/toast_widget.dart';

class ProductScreen extends StatefulWidget {
  final Product product;

  const ProductScreen({super.key, required this.product});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductViewModel>().setSelectedProduct(widget.product);
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.name),
        backgroundColor: const Color(0xFFFCEAE5),
        foregroundColor: const Color(0xFF5C4438),
      ),
      body: Consumer<ProductViewModel>(
        builder: (context, viewModel, child) {
          return Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Images (Carrousel)
                    SizedBox(
                      height: 400,
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: widget.product.images.length,
                        onPageChanged: (index) {
                          viewModel
                              .setSelectedImage(widget.product.images[index]);
                        },
                        itemBuilder: (context, index) {
                          return Container(
                            width: double.infinity,
                            color: Colors.grey[100],
                            child: widget.product.images.isNotEmpty
                                ? CachedNetworkImage(
                                    imageUrl: widget.product.images[index],
                                    fit: BoxFit.contain,
                                    placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error, size: 50),
                                  )
                                : const Icon(Icons.image, size: 100),
                          );
                        },
                      ),
                    ),

                    // Image Indicators
                    if (widget.product.images.length > 1)
                      Container(
                        height: 60,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.product.images.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                // Change the selected image and update PageView position
                                viewModel.setSelectedImage(
                                    widget.product.images[index]);
                                _pageController.jumpToPage(
                                    index); // Update the PageView to the clicked image
                              },
                              child: Container(
                                width: 60,
                                height: 60,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: viewModel.selectedImage ==
                                            widget.product.images[index]
                                        ? const Color(0xFF8B3A2E)
                                        : Colors.grey,
                                    width: 2,
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: CachedNetworkImage(
                                    imageUrl: widget.product.images[index],
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) =>
                                        const CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                    // Product Details
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Store Info
                          Row(
                            children: [
                              const Icon(Icons.store,
                                  size: 16, color: Colors.grey),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  widget.product.shopName,
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 16,
                                  ),
                                ),
                              ),

                              // Rating
                              Row(
                                children: [
                                  const Icon(Icons.star,
                                      size: 16, color: Colors.amber),
                                  const SizedBox(width: 4),
                                  Text(
                                    widget.product.rating.toStringAsFixed(1),
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  widget.product.shopCategory,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  widget.product.name,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  viewModel.toggleFavorite(widget.product.id);
                                },
                                icon: Icon(
                                  viewModel.isFavorite(widget.product.id)
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: viewModel.isFavorite(widget.product.id)
                                      ? Colors.red
                                      : Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),

                          Row(
                            children: [
                              // Price
                              Expanded(
                                child: Text(
                                  'R\$ ${widget.product.price.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF8B3A2E),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 24),

                          // Description
                          const Text(
                            'Descrição:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            widget.product.description,
                            style: const TextStyle(
                              fontSize: 16,
                              height: 1.5,
                            ),
                          ),

                          const SizedBox(height: 16),

                          // Size Selection
                          const Text(
                            'Tamanho:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: widget.product.availableSizes.map((size) {
                              final isSelected = viewModel
                                      .getSelectedSize(widget.product.id) ==
                                  size;
                              return GestureDetector(
                                onTap: () {
                                  viewModel.setSelectedSize(
                                      widget.product.id, size);
                                },
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: isSelected
                                          ? const Color(0xFF8B3A2E)
                                          : Colors.grey,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                    color: isSelected
                                        ? const Color(0xFF8B3A2E)
                                            .withOpacity(0.1)
                                        : Colors.white,
                                  ),
                                  child: Center(
                                    child: Text(
                                      size,
                                      style: TextStyle(
                                        color: isSelected
                                            ? const Color(0xFF8B3A2E)
                                            : Colors.black,
                                        fontWeight: isSelected
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 100), // Space for fixed button
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Fixed Add to Cart Button
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      viewModel.addToCartWithSelectedSize(widget.product);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8B3A2E),
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Adicionar ao Carrinho',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),

              // Toast Widget
              if (viewModel.showToast)
                ToastWidget(message: viewModel.toastMessage),
            ],
          );
        },
      ),
    );
  }
}
