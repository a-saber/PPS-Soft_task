import 'package:flutter_test/flutter_test.dart';
import 'package:pps_soft_task/core/utils/enums.dart';
import 'package:pps_soft_task/features/tickets/data/models/ticket_model.dart';
import 'package:pps_soft_task/features/tickets/presentation/cubit/ticket_list/ticket_list_state.dart';

TicketModel _ticket({
  required int id,
  required String subject,
  required TicketStatus status,
  required DateTime createdAt,
}) {
  return TicketModel(
    id: id,
    ticketNumber: 'TCK-$id',
    subject: subject,
    description: 'desc',
    priority: TicketPriority.medium,
    category: TicketCategory.general,
    status: status,
    createdAt: createdAt,
    updatedAt: createdAt,
  );
}

void main() {
  final tickets = [
    _ticket(
      id: 1,
      subject: 'Cannot login',
      status: TicketStatus.open,
      createdAt: DateTime(2026, 1, 1),
    ),
    _ticket(
      id: 2,
      subject: 'Billing question',
      status: TicketStatus.closed,
      createdAt: DateTime(2026, 1, 5),
    ),
    _ticket(
      id: 3,
      subject: 'Login slow',
      status: TicketStatus.inProgress,
      createdAt: DateTime(2026, 1, 3),
    ),
  ];

  group('TicketListState.visibleTickets', () {
    test('returns all tickets sorted newest first by default', () {
      final state = TicketListState(allTickets: tickets);
      final result = state.visibleTickets;

      expect(result.length, 3);
      expect(result.first.id, 2); // Jan 5 is newest
      expect(result.last.id, 1); // Jan 1 is oldest
    });

    test('filters by search query (case-insensitive, partial match)', () {
      final state = TicketListState(allTickets: tickets, searchQuery: 'login');
      final result = state.visibleTickets;

      expect(result.length, 2);
      expect(result.every((t) => t.subject.toLowerCase().contains('login')), isTrue);
    });

    test('filters by status', () {
      final state = TicketListState(allTickets: tickets, statusFilter: TicketStatus.closed);
      final result = state.visibleTickets;

      expect(result.length, 1);
      expect(result.first.id, 2);
    });

    test('sorts oldest first when requested', () {
      final state = TicketListState(allTickets: tickets, sortOrder: SortOrder.oldestFirst);
      final result = state.visibleTickets;

      expect(result.first.id, 1);
      expect(result.last.id, 2);
    });

    test('combines search and status filter', () {
      final state = TicketListState(
        allTickets: tickets,
        searchQuery: 'login',
        statusFilter: TicketStatus.inProgress,
      );
      final result = state.visibleTickets;

      expect(result.length, 1);
      expect(result.first.id, 3);
    });
  });
}
