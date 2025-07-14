import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../viewmodels/home_viewmodel.dart';
import '../viewmodels/product_viewmodel.dart';
import '../app/app.dart';
import '../widgets/loading_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeViewModel>().loadProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFCEAE5),
        foregroundColor: const Color(0xFF5C4438),
        title: const Text('TryOn'),
        leading: IconButton(
          icon: const Icon(Icons.account_circle),
          onPressed: () {
            // Profile functionality
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Search functionality
            },
          ),
        ],
      ),
      body: Consumer<HomeViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const LoadingDialog();
          }

          if (viewModel.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    viewModel.error!,
                    style: const TextStyle(fontSize: 16, color: Colors.red),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: viewModel.refreshProducts,
                    child: const Text('Tentar Novamente'),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              // Tab Bar
              Container(
                color: const Color(0xFFFCEAE5),
                child: TabBar(
                  controller: DefaultTabController.of(context),
                  tabs: viewModel.tabTitles
                      .map((title) => Tab(text: title))
                      .toList(),
                  labelColor: const Color(0xFF5C4438),
                  unselectedLabelColor: const Color(0xFF5C4438).withOpacity(0.6),
                  indicator: const UnderlineTabIndicator(
                    borderSide: BorderSide(color: Color(0xFF8B3A2E), width: 2),
                  ),
                ),
              ),
              
              // Product Grid
              Expanded(
                child: TabBarView(
                  controller: DefaultTabController.of(context),
                  children: viewModel.tabTitles.map((title) {
                    return RefreshIndicator(
                      onRefresh: () async {
                        await viewModel.loadProducts();
                      },
                      child: GridView.builder(
                        padding: const EdgeInsets.all(16),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.7,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                        itemCount: viewModel.products.length,
                        itemBuilder: (context, index) {
                          final product = viewModel.products[index];
                          return Card(
                            elevation: 4,
                            child: InkWell(
                              onTap: () {
                                context.read<ProductViewModel>().setSelectedProduct(product);
                                context.push(AppRouter.productRoute, extra: product);
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Product Image
                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.vertical(
                                          top: Radius.circular(8),
                                        ),
                                        color: Colors.grey[200],
                                      ),
                                      child: product.images.isNotEmpty
                                          ? CachedNetworkImage(
                                              imageUrl: product.images.first,
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) =>
                                                  const Center(
                                                child: CircularProgressIndicator(),
                                              ),
                                              errorWidget: (context, url, error) =>
                                                  const Icon(Icons.error),
                                            )
                                          : const Icon(Icons.image, size: 50),
                                    ),
                                  ),
                                  
                                  // Product Info
                                  Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            product.name,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            'R\$ ${product.price.toStringAsFixed(2)}',
                                            style: const TextStyle(
                                              color: Color(0xFF8B3A2E),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            product.shopName,
                                            style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: 12,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// Wrapper widget to provide TabController
class HomeScreenWrapper extends StatelessWidget {
  const HomeScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: const HomeScreen(),
    );
  }
} 