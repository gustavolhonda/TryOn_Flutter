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

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeViewModel>().loadProducts();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<HomeViewModel>(
        builder: (context, viewModel, child) {
          return Column(
            children: [
              // HEADER
              Container(
                height: 56,
                color: const Color(0xFFFCEAE5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.account_circle),
                      onPressed: () {
                        // Profile functionality
                      },
                      color: const Color(0xFF5C4438),
                    ),
                    const Expanded(
                      child: Text(
                        'TryOn',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF5C4438),
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        // Search functionality
                      },
                      color: const Color(0xFF5C4438),
                    ),
                  ],
                ),
              ),

              // TAB BAR
              Container(
                color: const Color(0xFFFCEAE5),
                child: TabBar(
                  controller: _tabController,
                  tabs: const [
                    Tab(text: 'Todos'),
                    Tab(text: 'Promoções'),
                    Tab(text: 'Lojas'),
                  ],
                  labelColor: const Color(0xFF8B3A2E),
                  unselectedLabelColor: const Color(0xFF5C4438),
                  indicator: UnderlineTabIndicator(
                    borderSide: const BorderSide(color: Color(0xFF8B3A2E), width: 3),
                    insets: const EdgeInsets.symmetric(horizontal: 45),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                  ),
                ),
              ),

              // CONTENT
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // HIGHLIGHTS SECTION
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Destaques',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              height: 120,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 3,
                                itemBuilder: (context, index) {
                                  return Container(
                                    width: 220,
                                    margin: EdgeInsets.only(
                                      right: index < 2 ? 12 : 0,
                                    ),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      elevation: 4,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: CachedNetworkImage(
                                          imageUrl: "https://satotrader.com.br/site/views/data/noticias/acoes-das-lojas-renner-lren3-comprar-ou-vender-image-1713213671.jpg",
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) => const Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                          errorWidget: (context, url, error) => const Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                      // PRODUCTS SECTION
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Produtos',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 12),
                            if (viewModel.isLoading)
                              const Center(child: CircularProgressIndicator())
                            else if (viewModel.error != null)
                              Center(
                                child: Column(
                                  children: [
                                    Text(
                                      viewModel.error!,
                                      style: const TextStyle(color: Colors.red),
                                    ),
                                    const SizedBox(height: 8),
                                    ElevatedButton(
                                      onPressed: viewModel.refreshProducts,
                                      child: const Text('Tentar Novamente'),
                                    ),
                                  ],
                                ),
                              )
                            else
                              SizedBox(
                                height: 280,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: viewModel.products.length,
                                  itemBuilder: (context, index) {
                                    final product = viewModel.products[index];
                                    return Container(
                                      width: 160,
                                      margin: EdgeInsets.only(
                                        right: index < viewModel.products.length - 1 ? 12 : 0,
                                      ),
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        elevation: 2,
                                        child: InkWell(
                                          onTap: () {
                                            context.read<ProductViewModel>().setSelectedProduct(product);
                                            context.push(AppRouter.productRoute, extra: product);
                                          },
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              // Product Image with Favorite Button
                                              SizedBox(
                                                height: 140,
                                                child: Stack(
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius: const BorderRadius.vertical(
                                                        top: Radius.circular(8),
                                                      ),
                                                      child: product.images.isNotEmpty
                                                          ? CachedNetworkImage(
                                                        imageUrl: product.images.first,
                                                        width: double.infinity,
                                                        height: 140,
                                                        fit: BoxFit.cover,
                                                        placeholder: (context, url) =>
                                                        const Center(child: CircularProgressIndicator()),
                                                        errorWidget: (context, url, error) =>
                                                        const Icon(Icons.error),
                                                      )
                                                          : Container(
                                                        color: Colors.grey[200],
                                                        child: const Icon(Icons.image, size: 50),
                                                      ),
                                                    ),
                                                    Positioned(
                                                      top: 8,
                                                      right: 8,
                                                      child: SizedBox(
                                                        width: 28,
                                                        height: 28,
                                                        child: IconButton(
                                                          padding: EdgeInsets.zero,
                                                          onPressed: () {
                                                            context.read<ProductViewModel>().toggleFavorite(product.id);
                                                          },
                                                          icon: Icon(
                                                            context.watch<ProductViewModel>().isFavorite(product.id)
                                                                ? Icons.favorite
                                                                : Icons.favorite_border,
                                                            color: const Color(0xFF8B3A2E),
                                                            size: 20,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              // Product Info
                                              Expanded(
                                                child: Container(
                                                  width: double.infinity,
                                                  color: const Color(0xFFFCEAE5),
                                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(
                                                        product.name,
                                                        style: const TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 14,
                                                        ),
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                      Text(
                                                        'R\$ ${product.price.toStringAsFixed(2)}',
                                                        style: const TextStyle(
                                                          color: Color(0xFF8B3A2E),
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 18,
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          SizedBox(
                                                            width: 20,
                                                            height: 20,
                                                            child: CachedNetworkImage(
                                                              imageUrl: "https://i0.wp.com/assets.b9.com.br/wp-content/uploads/2020/07/B.png?fit=554%2C673&ssl=1",
                                                              fit: BoxFit.cover,
                                                              placeholder: (context, url) =>
                                                              const Icon(Icons.store, size: 16),
                                                              errorWidget: (context, url, error) =>
                                                              const Icon(Icons.store, size: 16),
                                                            ),
                                                          ),
                                                          const SizedBox(width: 4),
                                                          Expanded(
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Text(
                                                                  product.shopName,
                                                                  style: const TextStyle(fontSize: 12),
                                                                  maxLines: 1,
                                                                  overflow: TextOverflow.ellipsis,
                                                                ),
                                                                const Text(
                                                                  'Categoria da loja',
                                                                  style: TextStyle(
                                                                    color: Colors.grey,
                                                                    fontSize: 8,
                                                                  ),
                                                                  maxLines: 1,
                                                                  overflow: TextOverflow.ellipsis,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )

                          ],
                        ),
                      ),

                      // STORES SECTION
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Lojas',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Column(
                              children: [
                                // First row
                                Row(
                                  children: [
                                    Expanded(child: _buildStoreCard(0)),
                                    const SizedBox(width: 16),
                                    Expanded(child: _buildStoreCard(1)),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                // Second row
                                Row(
                                  children: [
                                    Expanded(child: _buildStoreCard(2)),
                                    const SizedBox(width: 16),
                                    Expanded(child: _buildStoreCard(3)),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildStoreCard(int index) {
    final stores = [
      {'name': 'Street Wear', 'avatar': 'https://randomuser.me/api/portraits/men/1.jpg'},
      {'name': 'Street Wear', 'avatar': 'https://randomuser.me/api/portraits/men/1.jpg'},
      {'name': 'Street Wear', 'avatar': 'https://randomuser.me/api/portraits/men/1.jpg'},
      {'name': 'Street Wear', 'avatar': 'https://randomuser.me/api/portraits/men/1.jpg'},
    ];

    const bgUrl = "https://img.freepik.com/fotos-gratis/roupas-infantis_23-2148166232.jpg";

    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: const Color(0xFFFFF7F5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SizedBox(
                width: 40,
                height: 40,
                child: CachedNetworkImage(
                  imageUrl: stores[index]['avatar']!,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                  const Icon(Icons.person, size: 20),
                  errorWidget: (context, url, error) =>
                  const Icon(Icons.person, size: 20),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  stores[index]['name']!,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
                const Text(
                  'Categoria da loja',
                  style: TextStyle(
                    fontSize: 8,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
            child: SizedBox(
              width: 70,
              height: 80,
              child: CachedNetworkImage(
                imageUrl: bgUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                const Icon(Icons.image, size: 30),
                errorWidget: (context, url, error) =>
                const Icon(Icons.image, size: 30),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Wrapper widget to provide TabController
class HomeScreenWrapper extends StatelessWidget {
  const HomeScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeScreen();
  }
}