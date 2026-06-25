

import 'package:dartz/dartz.dart';
import 'package:pps_soft_task/core/failure/failure_model.dart';

import '../../../../core/local_db/enums.dart';
import '../../../../core/models/ticket_history_model.dart';
import '../../../../core/models/ticket_model.dart';

abstract class TicketRepository {
  Future<Either<FailureModel, List<TicketModel>>> getAllTickets();

  Future<Either<FailureModel, TicketModel?>> getTicketById(int id);

  Future<Either<FailureModel, TicketModel>> createTicket({
    required String subject,
    required String description,
    required TicketPriority priority,
    required TicketCategory category,
  });

  Future<Either<FailureModel, Unit>> updateTicketFields(
    TicketModel ticket, {
    String? subject,
    String? description,
    TicketPriority? priority,
  });

  Future<Either<FailureModel, Unit>> changeStatus(TicketModel ticket, TicketStatus newStatus);

  Future<Either<FailureModel, Unit>> deleteTicket(int id);

  Future<Either<FailureModel, List<TicketHistoryModel>>> getHistory(int ticketId);

  /// Bonus feature: exports all tickets to a JSON file and returns its path.
  Future<Either<FailureModel, String>> exportTicketsToJson();
}
