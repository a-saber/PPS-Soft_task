


import '../../../../core/models/ticket_history_model.dart';
import '../../../../core/models/ticket_model.dart';

abstract class TicketLocalDataSource {
  Future<List<TicketModel>> getAllTickets();
  Future<TicketModel?> getTicketById(int id);
  Future<int> insertTicket(TicketModel ticket);
  Future<void> updateTicket(TicketModel ticket);
  Future<void> deleteTicket(int id);

  Future<List<TicketHistoryModel>> getHistory(int ticketId);
  Future<void> insertHistory(TicketHistoryModel history);
}