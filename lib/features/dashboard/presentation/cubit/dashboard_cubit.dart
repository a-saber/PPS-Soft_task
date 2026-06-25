import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/enums.dart';
import '../../../tickets/data/repo/ticket_repository.dart';
import 'dashboard_state.dart';

/// Dashboard has no data layer of its own — it's a *view* over the
/// `tickets` feature's data, so it simply depends on [TicketRepository].
/// This avoids duplicating ticket storage logic in two places.
class DashboardCubit extends Cubit<DashboardState> {
  final TicketRepository ticketRepository;

  DashboardCubit({required this.ticketRepository}) : super(const DashboardState());

  Future<void> loadSummary() async {
    emit(state.copyWith(status: DashboardStatus.loading));
    try {
      final tickets = await ticketRepository.getAllTickets();
      final open = tickets.where((t) => t.status == TicketStatus.open).length;
      final inProgress =
          tickets.where((t) => t.status == TicketStatus.inProgress).length;
      final closed = tickets.where((t) => t.status == TicketStatus.closed).length;

      emit(state.copyWith(
        status: DashboardStatus.loaded,
        total: tickets.length,
        open: open,
        inProgress: inProgress,
        closed: closed,
      ));
    } catch (e) {
      emit(state.copyWith(status: DashboardStatus.error, errorMessage: e.toString()));
    }
  }
}
