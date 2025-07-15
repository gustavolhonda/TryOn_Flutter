import 'package:flutter/material.dart';
import '../generated/l10n.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../viewmodels/orders_viewmodel.dart';
import '../models/cart_item.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).ordersTitle),
        backgroundColor: const Color(0xFFFCEAE5),
        foregroundColor: const Color(0xFF5C4438),
      ),
      body: Consumer<OrdersViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.cartItems.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.shopping_cart_outlined,
                    size: 64,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    S.of(context).cartEmpty,
                    style: const TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            );
          }
          // Retornar apenas o ListView, sem Expanded, pois é o único widget do body
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Renderiza cada item do carrinho
              ...viewModel.cartItems.map((item) => _buildCartItem(context, item, viewModel)).toList(),
              const SizedBox(height: 16),
              // Bloco de resumo (total, botões etc.)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        S.of(context).totalItems(viewModel.totalItems),
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        'R\$ ${viewModel.totalPrice.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF8B3A2E),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            _showClearCartDialog(context, viewModel);
                          },
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Color(0xFF8B3A2E)),
                          ),
                          child: Text(
                            S.of(context).clearCart,
                            style: const TextStyle(color: Color(0xFF8B3A2E)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // Finalizar pedido
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(S.of(context).orderSuccess),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF8B3A2E),
                            foregroundColor: Colors.white,
                          ),
                          child: Text(S.of(context).finishOrder),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCartItem(BuildContext context, CartItem item, OrdersViewModel viewModel) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Product Image
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey[200],
              ),
              child: item.imageUrl.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: item.imageUrl,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const CircularProgressIndicator(),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    )
                  : const Icon(Icons.image, size: 40),
            ),
            const SizedBox(width: 16),
            
            // Product Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Tamanho: ${item.size}',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'R\$ ${item.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Color(0xFF8B3A2E),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            
            // Quantity Controls
            Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () => viewModel.decrementQuantity(item),
                      icon: const Icon(Icons.remove),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                    ),
                    Container(
                      width: 40,
                      height: 32,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        item.quantity.toString(),
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    IconButton(
                      onPressed: () => viewModel.incrementQuantity(item),
                      icon: const Icon(Icons.add),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () => viewModel.removeFromCart(item),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                  ),
                  child: const Text('Remover'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showClearCartDialog(BuildContext context, OrdersViewModel viewModel) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(S.of(context).clearCart),
        content: Text(S.of(context).clearCartConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(S.of(context).cancel),
          ),
          TextButton(
            onPressed: () {
              viewModel.clearCart();
              Navigator.of(context).pop();
            },
            child: Text(S.of(context).clear),
          ),
        ],
      ),
    );
  }
} 