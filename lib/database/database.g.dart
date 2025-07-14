// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  CartDao? _cartDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `cart_items` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `productId` INTEGER NOT NULL, `name` TEXT NOT NULL, `price` REAL NOT NULL, `shopName` TEXT NOT NULL, `shopCategory` TEXT NOT NULL, `description` TEXT NOT NULL, `rating` REAL NOT NULL, `size` TEXT NOT NULL, `imageUrl` TEXT NOT NULL, `quantity` INTEGER NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  CartDao get cartDao {
    return _cartDaoInstance ??= _$CartDao(database, changeListener);
  }
}

class _$CartDao extends CartDao {
  _$CartDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _cartItemInsertionAdapter = InsertionAdapter(
            database,
            'cart_items',
            (CartItem item) => <String, Object?>{
                  'id': item.id,
                  'productId': item.productId,
                  'name': item.name,
                  'price': item.price,
                  'shopName': item.shopName,
                  'shopCategory': item.shopCategory,
                  'description': item.description,
                  'rating': item.rating,
                  'size': item.size,
                  'imageUrl': item.imageUrl,
                  'quantity': item.quantity
                },
            changeListener),
        _cartItemUpdateAdapter = UpdateAdapter(
            database,
            'cart_items',
            ['id'],
            (CartItem item) => <String, Object?>{
                  'id': item.id,
                  'productId': item.productId,
                  'name': item.name,
                  'price': item.price,
                  'shopName': item.shopName,
                  'shopCategory': item.shopCategory,
                  'description': item.description,
                  'rating': item.rating,
                  'size': item.size,
                  'imageUrl': item.imageUrl,
                  'quantity': item.quantity
                },
            changeListener),
        _cartItemDeletionAdapter = DeletionAdapter(
            database,
            'cart_items',
            ['id'],
            (CartItem item) => <String, Object?>{
                  'id': item.id,
                  'productId': item.productId,
                  'name': item.name,
                  'price': item.price,
                  'shopName': item.shopName,
                  'shopCategory': item.shopCategory,
                  'description': item.description,
                  'rating': item.rating,
                  'size': item.size,
                  'imageUrl': item.imageUrl,
                  'quantity': item.quantity
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<CartItem> _cartItemInsertionAdapter;

  final UpdateAdapter<CartItem> _cartItemUpdateAdapter;

  final DeletionAdapter<CartItem> _cartItemDeletionAdapter;

  @override
  Stream<List<CartItem>> watchAllCartItems() {
    return _queryAdapter.queryListStream('SELECT * FROM cart_items',
        mapper: (Map<String, Object?> row) => CartItem(
            id: row['id'] as int?,
            productId: row['productId'] as int,
            name: row['name'] as String,
            price: row['price'] as double,
            shopName: row['shopName'] as String,
            shopCategory: row['shopCategory'] as String,
            description: row['description'] as String,
            rating: row['rating'] as double,
            size: row['size'] as String,
            imageUrl: row['imageUrl'] as String,
            quantity: row['quantity'] as int),
        queryableName: 'cart_items',
        isView: false);
  }

  @override
  Future<List<CartItem>> getAllCartItems() async {
    return _queryAdapter.queryList('SELECT * FROM cart_items',
        mapper: (Map<String, Object?> row) => CartItem(
            id: row['id'] as int?,
            productId: row['productId'] as int,
            name: row['name'] as String,
            price: row['price'] as double,
            shopName: row['shopName'] as String,
            shopCategory: row['shopCategory'] as String,
            description: row['description'] as String,
            rating: row['rating'] as double,
            size: row['size'] as String,
            imageUrl: row['imageUrl'] as String,
            quantity: row['quantity'] as int));
  }

  @override
  Future<CartItem?> getCartItem(
    int productId,
    String size,
  ) async {
    return _queryAdapter.query(
        'SELECT * FROM cart_items WHERE productId = ?1 AND size = ?2',
        mapper: (Map<String, Object?> row) => CartItem(
            id: row['id'] as int?,
            productId: row['productId'] as int,
            name: row['name'] as String,
            price: row['price'] as double,
            shopName: row['shopName'] as String,
            shopCategory: row['shopCategory'] as String,
            description: row['description'] as String,
            rating: row['rating'] as double,
            size: row['size'] as String,
            imageUrl: row['imageUrl'] as String,
            quantity: row['quantity'] as int),
        arguments: [productId, size]);
  }

  @override
  Future<void> deleteAllCartItems() async {
    await _queryAdapter.queryNoReturn('DELETE FROM cart_items');
  }

  @override
  Future<void> insertCartItem(CartItem cartItem) async {
    await _cartItemInsertionAdapter.insert(cartItem, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateCartItem(CartItem cartItem) async {
    await _cartItemUpdateAdapter.update(cartItem, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteCartItem(CartItem cartItem) async {
    await _cartItemDeletionAdapter.delete(cartItem);
  }
}
