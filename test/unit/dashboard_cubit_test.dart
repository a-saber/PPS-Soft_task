import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:pps_soft_task/core/utils/enums.dart';
import 'package:pps_soft_task/features/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:pps_soft_task/features/dashboard/presentation/cubit/dashboard_state.dart';
import 'package:pps_soft_task/features/tickets/data/models/ticket_model.dart';
import 'package:pps_soft_task/features/tickets/data/repo/ticket_repository.dart';

class MockTicketRepository extends Mock implements TicketRepository {}

TicketModel _ticket(int id, TicketStatus status) => TicketModel(
      id: id,
      ticketNumber: 'TCK-$id',
      subject: 'Subject $id',
      description: 'desc',
      priority: TicketPriority.low,
      category: TicketCategory.general,
      status: status,
      createdAt: DateTime(2026, 1, id),
      updatedAt: DateTime(2026, 1, id),
    );

void main() {
  late MockTicketRepository repository;

  setUp(() {
    repository = MockTicketRepository();
  });

  group('DashboardCubit', () {
    blocTest<DashboardCubit, DashboardState>(
      'emits [loading, loaded] with correct counts on success',
      build: () => DashboardCubit(ticketRepository: repository),
      setUp: () {
        when(() => repository.getAllTickets()).thenAnswer((_) async => [
              _ticket(1, TicketStatus.open),
              _ticket(2, TicketStatus.open),
              _ticket(3, TicketStatus.inProgress),
              _ticket(4, TicketStatus.closed),
            ]);
      },
      act: (cubit) => cubit.loadSummary(),
      expect: () => [
        const DashboardState(status: DashboardStatus.loading),
        const DashboardState(
          status: DashboardStatus.loaded,
          total: 4,
          open: 2,
          inProgress: 1,
          closed: 1,
        ),
      ],
    );

    blocTest<DashboardCubit, DashboardState>(
      'emits [loading, error] when repository throws',
      build: () => DashboardCubit(ticketRepository: repository),
      setUp: () {
        when(() => repository.getAllTickets()).thenThrow(Exception('db error'));
      },
      act: (cubit) => cubit.loadSummary(),
      expect: () => [
        const DashboardState(status: DashboardStatus.loading),
        isA<DashboardState>().having((s) => s.status, 'status', DashboardStatus.error),
      ],
    );
  });
}
