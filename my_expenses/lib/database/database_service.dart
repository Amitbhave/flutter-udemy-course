import 'dart:async';
import 'package:myexpenses/models/transaction.dart' as Tx;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final transactionTable = "transactions";

class DatabaseService {
  static final DatabaseService instance = DatabaseService._();
  static Database _database;

  DatabaseService._();

  Future<Database> get database async {
    if (_database == null) {
      return await initDatabase();
    }
    return _database;
  }

  initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'transactions.db'),
      onCreate: (db, version) {
        db.execute(
          '''CREATE TABLE $transactionTable(
            id TEXT PRIMARY KEY,
            title TEXT,
            amount TEXT,
            date DATETIME)
          ''',
        );
      },
      version: 1,
    );
  }

  Future<List<Tx.Transaction>> getAllTransaction() async {
    Database db = await database;
    List<Map> transactions = await db.query(transactionTable);
    if (transactions.length > 0) {
      List<Tx.Transaction> userTransactions = [];
      transactions.forEach((element) {
        userTransactions.add(Tx.Transaction.fromMap(element));
      });
      return userTransactions;
    }
    return [];
  }

  Future<int> insertTransaction(Tx.Transaction tx) async {
    Database db = await database;
    int id = await db.insert(transactionTable, tx.toMap());
    return id;
  }

  Future<void> deleteTransaction(String id) async {
    Database db = await database;
    await db.delete(transactionTable,
        where: 'id = ?',
        whereArgs: [id]);
  }

}