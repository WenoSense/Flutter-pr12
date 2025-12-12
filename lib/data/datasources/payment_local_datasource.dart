import 'package:sqflite/sqflite.dart';
import '../../domain/interfaces/payment_datasource.dart';
import '../../domain/models/payment.dart';
import '../database/app_database.dart';
import '../dto/payment_dto.dart';

class PaymentLocalDataSource implements PaymentDataSource {
  static const String tableName = 'payments';
  final AppDatabase _appDatabase;

  PaymentLocalDataSource({AppDatabase? appDatabase})
      : _appDatabase = appDatabase ?? AppDatabase.instance;

  Future<Database> get _database async => await _appDatabase.database;

  @override
  Future<List<Payment>> getAllPayments() async {
    final db = await _database;
    final maps = await db.query(tableName);
    
    return maps.map((map) => PaymentDTO.fromMap(map).toDomain()).toList();
  }

  @override
  Future<void> addPayment(Payment payment) async {
    final db = await _database;
    final dto = PaymentDTO.fromDomain(payment);
    
    await db.insert(
      tableName,
      dto.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> updatePayment(Payment payment) async {
    final db = await _database;
    final dto = PaymentDTO.fromDomain(payment);
    
    await db.update(
      tableName,
      dto.toMap(),
      where: 'id = ?',
      whereArgs: [payment.id],
    );
  }

  @override
  Future<void> deletePayment(String id) async {
    final db = await _database;
    
    await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
