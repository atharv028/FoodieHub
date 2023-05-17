// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_db.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
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

  HistoryDao? _historyDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
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
            'CREATE TABLE IF NOT EXISTS `Cart` (`id` INTEGER, `name` TEXT, `price` INTEGER, `img` TEXT, `quantity` INTEGER, `isExist` INTEGER, `time` TEXT, `product` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `History` (`time` TEXT, `cart` TEXT, PRIMARY KEY (`time`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  CartDao get cartDao {
    return _cartDaoInstance ??= _$CartDao(database, changeListener);
  }

  @override
  HistoryDao get historyDao {
    return _historyDaoInstance ??= _$HistoryDao(database, changeListener);
  }
}

class _$CartDao extends CartDao {
  _$CartDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _cartInsertionAdapter = InsertionAdapter(
            database,
            'Cart',
            (Cart item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'price': item.price,
                  'img': item.img,
                  'quantity': item.quantity,
                  'isExist':
                      item.isExist == null ? null : (item.isExist! ? 1 : 0),
                  'time': item.time,
                  'product': _productConverter.encode(item.product)
                },
            changeListener),
        _cartDeletionAdapter = DeletionAdapter(
            database,
            'Cart',
            ['id'],
            (Cart item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'price': item.price,
                  'img': item.img,
                  'quantity': item.quantity,
                  'isExist':
                      item.isExist == null ? null : (item.isExist! ? 1 : 0),
                  'time': item.time,
                  'product': _productConverter.encode(item.product)
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Cart> _cartInsertionAdapter;

  final DeletionAdapter<Cart> _cartDeletionAdapter;

  @override
  Future<List<Cart>> getAllItems() async {
    return _queryAdapter.queryList('SELECT * FROM Cart',
        mapper: (Map<String, Object?> row) => Cart(
            id: row['id'] as int?,
            name: row['name'] as String?,
            price: row['price'] as int?,
            img: row['img'] as String?,
            quantity: row['quantity'] as int?,
            isExist:
                row['isExist'] == null ? null : (row['isExist'] as int) != 0,
            time: row['time'] as String?,
            product: _productConverter.decode(row['product'] as String?)));
  }

  @override
  Stream<Cart?> findCartItemById(int id) {
    return _queryAdapter.queryStream('SELECT * FROM Cart WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Cart(
            id: row['id'] as int?,
            name: row['name'] as String?,
            price: row['price'] as int?,
            img: row['img'] as String?,
            quantity: row['quantity'] as int?,
            isExist:
                row['isExist'] == null ? null : (row['isExist'] as int) != 0,
            time: row['time'] as String?,
            product: _productConverter.decode(row['product'] as String?)),
        arguments: [id],
        queryableName: 'Cart',
        isView: false);
  }

  @override
  Future<void> deleteAllCartItems() async {
    await _queryAdapter.queryNoReturn('DELETE FROM Cart');
  }

  @override
  Future<void> insertItem(Cart cart) async {
    await _cartInsertionAdapter.insert(cart, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteItem(Cart cart) async {
    await _cartDeletionAdapter.delete(cart);
  }
}

class _$HistoryDao extends HistoryDao {
  _$HistoryDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _historyInsertionAdapter = InsertionAdapter(
            database,
            'History',
            (History item) => <String, Object?>{
                  'time': item.time,
                  'cart': _cartConverter.encode(item.cart)
                }),
        _historyDeletionAdapter = DeletionAdapter(
            database,
            'History',
            ['time'],
            (History item) => <String, Object?>{
                  'time': item.time,
                  'cart': _cartConverter.encode(item.cart)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<History> _historyInsertionAdapter;

  final DeletionAdapter<History> _historyDeletionAdapter;

  @override
  Future<List<History>> getAllOrders() async {
    return _queryAdapter.queryList('SELECT * FROM history',
        mapper: (Map<String, Object?> row) => History(
            time: row['time'] as String?,
            cart: _cartConverter.decode(row['cart'] as String?)));
  }

  @override
  Future<void> deleteAllOrders() async {
    await _queryAdapter.queryNoReturn('DELETE FROM history');
  }

  @override
  Future<void> insertOrder(History historyItem) async {
    await _historyInsertionAdapter.insert(
        historyItem, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertAllOrders(List<History> historyItemList) async {
    await _historyInsertionAdapter.insertList(
        historyItemList, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteOrder(History cart) async {
    await _historyDeletionAdapter.delete(cart);
  }
}

// ignore_for_file: unused_element
final _productConverter = ProductConverter();
final _dateTimeConverter = DateTimeConverter();
final _cartConverter = CartConverter();
