import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:pps_soft_task/core/utils/enums.dart';
import 'package:pps_soft_task/features/tickets/data/datasources/ticket_local_datasource.dart';
import 'package:pps_soft_task/features/tickets/data/models/ticket_history_model.dart';
import 'package:pps_soft_task/features/tickets/data/models/ticket_model.dart';
import 'package:pps_soft_task/features/tickets/data/repo/ticket_repository_impl.dart';

/// Test double for [TicketLocalDataSource] backed by a real, in-memory
/// SQflite database (via `sqflite_common_ffi`) instead of a platform
/// channel. This lets us test the *real* SQL + repository orchestration
/// logic (not a mock pretending to be a database) without needing a
/// device/emulator — proving the offline persistence actually round-trips.
class FfiTicketLocalDataSource implements TicketLocalDataSource {
  late final Database db;

  Future<void> open() async {
    db = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
    await db.execute('''
      CREATE TABLE tickets (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        ticketNumber TEXT NOT NULL,
        subject TEXT NOT NULL,
        description TEXT NOT NULL,
        priority TEXT NOT NULL,
        category TEXT NOT NULL,
        status TEXT NOT NULL,
        createdAt TEXT NOT NULL,
        updatedAt TEXT NOT NULL
      )
    ''');
    await db.execute('''
      CREATE TABLE ticket_history (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        ticketId INTEGER NOT NULL,
        message TEXT NOT NULL,
        createdAt TEXT NOT NULL
      )
    ''');
  }

  @override
  Future<List<TicketModel>> getAllTickets() async {
    final rows = await db.query('tickets', orderBy: 'createdAt DESC');
    return rows.map(TicketModel.fromMap).toList();
  }

  @override
  Future<TicketModel?> getTicketById(int id) async {
    final rows = await db.query('tickets', where: 'id = ?', whereArgs: [id]);
    if (rows.isEmpty) return null;
    return TicketModel.fromMap(rows.first);
  }

  @override
  Future<int> insertTicket(TicketModel ticket) => db.insert('tickets', ticket.toMap());

  @override
  Future<void> updateTicket(TicketModel ticket) async {
    await db.update('tickets', ticket.toMap(), where: 'id = ?', whereArgs: [ticket.id]);
  }

  @override
  Future<void> deleteTicket(int id) async {
    await db.delete('ticket_history', where: 'ticketId = ?', whereArgs: [id]);
    await db.delete('tickets', where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<List<TicketHistoryModel>> getHistory(int ticketId) async {
    final rows = await db.query('ticket_history', where: 'ticketId = ?', whereArgs: [ticketId]);
    return rows.map(TicketHistoryModel.fromMap).toList();
  }

  @override
  Future<void> insertHistory(TicketHistoryModel history) =>
      db.insert('ticket_history', history.toMap());
}

void main() {
  sqfliteFfiInit();

  late FfiTicketLocalDataSource dataSource;
  late TicketRepositoryImpl repository;

  setUp(() async {
    dataSource = FfiTicketLocalDataSource();
    await dataSource.open();
    repository = TicketRepositoryImpl(localDataSource: dataSource);
  });

  group('TicketRepositoryImpl + real SQflite (ffi)', () {
    test('createTicket persists with status Open and an auto-generated ticket number', () async {
      final ticket = await repository.createTicket(
        subject: 'Cannot login',
        description: 'Password reset link is broken',
        priority: TicketPriority.high,
        category: TicketCategory.technical,
      );

      expect(ticket.id, isNotNull);
      expect(ticket.status, TicketStatus.open);
      expect(ticket.ticketNumber, startsWith('TCK-'));

      final all = await repository.getAllTickets();
      expect(all.length, 1);
    });

    test('changeStatus updates the ticket and writes a history entry', () async {
      final ticket = await repository.createTicket(
        subject: 'Invoice missing',
        description: 'Need last month invoice',
        priority: TicketPriority.medium,
        category: TicketCategory.billing,
      );

      await repository.changeStatus(ticket, TicketStatus.inProgress);

      final updated = await repository.getTicketById(ticket.id!);
      expect(updated!.status, TicketStatus.inProgress);

      final history = await repository.getHistory(ticket.id!);
      // one entry for creation + one for the status change
      expect(history.length, 2);
    });

    test('deleteTicket removes the ticket and its history', () async {
      final ticket = await repository.createTicket(
        subject: 'Test delete',
        description: 'Should disappear',
        priority: TicketPriority.low,
        category: TicketCategory.general,
      );

      await repository.deleteTicket(ticket.id!);

      final all = await repository.getAllTickets();
      expect(all, isEmpty);

      final history = await repository.getHistory(ticket.id!);
      expect(history, isEmpty);
    });

    test('data persists across repository instances using the same db (offline-first)', () async {
      await repository.createTicket(
        subject: 'Persisted ticket',
        description: 'Should survive a new repository instance',
        priority: TicketPriority.low,
        category: TicketCategory.general,
      );

      final secondRepository = TicketRepositoryImpl(localDataSource: dataSource);
      final all = await secondRepository.getAllTickets();

      expect(all.length, 1);
      expect(all.first.subject, 'Persisted ticket');
    });
  });
}
