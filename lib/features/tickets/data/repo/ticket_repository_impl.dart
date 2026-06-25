import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pps_soft_task/core/failure/error_handler.dart';

import '../../../../core/failure/failure_model.dart';
import '../../../../core/helper/ticket_number_generator.dart';
import '../../../../core/local_db/enums.dart';
import '../../../../core/models/ticket_history_model.dart';
import '../../../../core/models/ticket_model.dart';
import '../data_sources/ticket_local_data_source.dart';
import 'ticket_repository.dart';

class TicketRepositoryImpl implements TicketRepository {
  final TicketLocalDataSource localDataSource;

  TicketRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<FailureModel, List<TicketModel>>> getAllTickets() async {
    try {
      return right(await localDataSource.getAllTickets());
    } catch (e) {
      return left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<FailureModel, TicketModel?>> getTicketById(int id) async {
    try {
      return right(await localDataSource.getTicketById(id));
    } catch (e) {
      return left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<FailureModel, TicketModel>> createTicket({
    required String subject,
    required String description,
    required TicketPriority priority,
    required TicketCategory category,
  }) async {
    try {
      final now = DateTime.now();
      final ticket = TicketModel(
        ticketNumber: TicketNumberGenerator.generate(),
        subject: subject.trim(),
        description: description.trim(),
        priority: priority,
        category: category,
        status: TicketStatus.open,
        createdAt: now,
        updatedAt: now,
      );

      final id = await localDataSource.insertTicket(ticket);
      final saved = ticket._withId(id);

      await localDataSource.insertHistory(
        TicketHistoryModel(
          ticketId: id,
          message: 'Ticket created with status Open',
          createdAt: now,
        ),
      );

      return right(saved);
    } catch (e) {
      return left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<FailureModel, Unit>> updateTicketFields(
    TicketModel ticket, {
    String? subject,
    String? description,
    TicketPriority? priority,
  }) async {
    try {
      final changes = <String>[];
      if (subject != null && subject.trim() != ticket.subject) {
        changes.add('Subject updated');
      }
      if (description != null && description.trim() != ticket.description) {
        changes.add('Description updated');
      }
      if (priority != null && priority != ticket.priority) {
        changes.add('Priority changed to ${priority.name}');
      }

      final updated = ticket.copyWith(
        subject: subject,
        description: description,
        priority: priority,
        updatedAt: DateTime.now(),
      );

      await localDataSource.updateTicket(updated);

      for (final change in changes) {
        await localDataSource.insertHistory(
          TicketHistoryModel(
            ticketId: ticket.id!,
            message: change,
            createdAt: DateTime.now(),
          ),
        );
      }

      return right(unit);
    } catch (e) {
      return left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<FailureModel, Unit>> changeStatus(
    TicketModel ticket,
    TicketStatus newStatus,
  ) async {
    try {
      if (ticket.status == newStatus) return right(unit);

      final updated = ticket.copyWith(
        status: newStatus,
        updatedAt: DateTime.now(),
      );
      await localDataSource.updateTicket(updated);

      await localDataSource.insertHistory(
        TicketHistoryModel(
          ticketId: ticket.id!,
          message:
              'Status changed from ${ticket.status.name} to ${newStatus.name}',
          createdAt: DateTime.now(),
        ),
      );
      return right(unit);
    } catch (e) {
      return left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<FailureModel, Unit>> deleteTicket(int id) async {
    try {
      localDataSource.deleteTicket(id);
      return right(unit);
    } catch (e) {
      return left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<FailureModel, List<TicketHistoryModel>>> getHistory(
    int ticketId,
  ) async {
    try {
      final history = await localDataSource.getHistory(ticketId);
      return right(history);
    } catch (e) {
      return left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<FailureModel, String>> exportTicketsToJson() async {
    try {
      final tickets = await localDataSource.getAllTickets();
      final jsonList = tickets.map((t) => t.toJson()).toList();
      final jsonString = const JsonEncoder.withIndent('  ').convert(jsonList);

      final dir = await getApplicationDocumentsDirectory();
      final fileName =
          'tickets_export_${DateTime.now().millisecondsSinceEpoch}.json';
      final file = File('${dir.path}/$fileName');
      await file.writeAsString(jsonString);

      return right(file.path);
    } catch (e) {
      return left(ErrorHandler.handle(e));
    }
  }
}

extension on TicketModel {
  TicketModel _withId(int id) => TicketModel(
    id: id,
    ticketNumber: ticketNumber,
    subject: subject,
    description: description,
    priority: priority,
    category: category,
    status: status,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
}
