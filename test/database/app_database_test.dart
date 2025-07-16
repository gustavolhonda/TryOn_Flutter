import 'package:flutter_test/flutter_test.dart';
import 'package:floor/floor.dart';
import 'package:atividade_avaliativa_2/models/cart_item.dart';
import 'package:atividade_avaliativa_2/database/cart_dao.dart';
import 'package:atividade_avaliativa_2/database/database.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void initSqflite() {
  databaseFactory = databaseFactoryFfi;
}

void main() {
  late AppDatabase db;
  late CartDao cartDao;

  setUp(() async {
    initSqflite(); // Inicializa o banco de dados FFI para testes

    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'test.db');

    // Criação do banco de dados
    db = await $FloorAppDatabase.databaseBuilder(path).build();
    cartDao = db.cartDao;

    // Limpar dados antes de cada teste
    await cartDao.deleteAllCartItems();
  });

  tearDown(() async {
    // Ensure all pending stream events are processed before closing the DB
    // This can help avoid "Bad state: Cannot add new events after calling close"
    // if the stream emits right before tearDown is called.
    await Future.microtask(() {});
    await db.close(); // Fechar o banco após o teste
  });

  test('testEmpty', () async {
    // Teste se a lista de itens do carrinho está vazia
    final cartItems = await cartDao.getAllCartItems();
    expect(cartItems, isEmpty);
  });

  test('testInsertAndSelect', () async {
    final cartItem1 = CartItem(
      productId: 1,
      name: 'Produto 1',
      price: 99.99,
      shopName: 'Loja 1',
      shopCategory: 'Categoria 1',
      description: 'Descrição 1',
      rating: 4.5,
      size: 'M',
      imageUrl: 'url1',
      quantity: 1,
    );

    final cartItem2 = CartItem(
      productId: 2,
      name: 'Produto 2',
      price: 149.99,
      shopName: 'Loja 2',
      shopCategory: 'Categoria 2',
      description: 'Descrição 2',
      rating: 4.0,
      size: 'G',
      imageUrl: 'url2',
      quantity: 2,
    );

    // Inserir os itens no banco
    await cartDao.insertCartItem(cartItem1);
    await cartDao.insertCartItem(cartItem2);

    // Obter os itens e fazer a asserção
    final cartItems = await cartDao.getAllCartItems();
    expect(cartItems.length, 2); // Espera-se 2 itens
    expect(cartItems[0].name, 'Produto 1');
    expect(cartItems[1].name, 'Produto 2');
  });

  test('testDelete', () async {
    final cartItemToInsert = CartItem(
      productId: 1,
      name: 'Produto 1',
      price: 99.99,
      shopName: 'Loja 1',
      shopCategory: 'Categoria 1',
      description: 'Descrição 1',
      rating: 4.5,
      size: 'M',
      imageUrl: 'url1',
      quantity: 1,
    );

    // Inserir item no banco
    await cartDao.insertCartItem(cartItemToInsert);

    // Retrieve the item from the database to get its generated ID
    final cartItemsAfterInsert = await cartDao.getAllCartItems();
    expect(cartItemsAfterInsert.length, 1); // Ensure it was inserted

    final insertedCartItem = cartItemsAfterInsert.first; // Get the item with its ID

    // Deletar o item usando the object with the generated ID
    await cartDao.deleteCartItem(insertedCartItem);

    // Verificar se o item foi deletado
    final cartItemsAfterDelete = await cartDao.getAllCartItems();
    expect(cartItemsAfterDelete, isEmpty); // Espera-se que a lista esteja vazia após a exclusão
  });

  test('testInsertAndSelectStream', () async {
    final cartItem1 = CartItem(
      productId: 1,
      name: 'Produto 1',
      price: 99.99,
      shopName: 'Loja 1',
      shopCategory: 'Categoria 1',
      description: 'Descrição 1',
      rating: 4.5,
      size: 'M',
      imageUrl: 'url1',
      quantity: 1,
    );

    final cartItem2 = CartItem(
      productId: 2,
      name: 'Produto 2',
      price: 149.99,
      shopName: 'Loja 2',
      shopCategory: 'Categoria 2',
      description: 'Descrição 2',
      rating: 4.0,
      size: 'G',
      imageUrl: 'url2',
      quantity: 2,
    );

    // Use expectLater to define the expected sequence of emissions
    expectLater(
      cartDao.watchAllCartItems(),
      emitsInOrder([
        // 1. Initial emission: empty list (from setUp's deleteAllCartItems)
        isEmpty,
        // 2. After inserting cartItem1 and cartItem2: list with 2 items
        [
          predicate((item) => item is CartItem && item.productId == cartItem1.productId),
          predicate((item) => item is CartItem && item.productId == cartItem2.productId),
        ],
        // You could add more expectations here for subsequent operations (e.g., deletion)
      ]),
    );

    // Now perform the insertions
    await cartDao.insertCartItem(cartItem1);
    await cartDao.insertCartItem(cartItem2);

    // Give time for the stream to process and emit the updates
    // This is often crucial with database streams as changes might not be immediate
    await Future.delayed(Duration.zero); // Or a small delay if needed
  });
}