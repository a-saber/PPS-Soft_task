import '../../features/tickets/data/datasources/ticket_local_datasource.dart';
import '../../features/tickets/data/repo/ticket_repository.dart';
import '../../features/tickets/data/repo/ticket_repository_impl.dart';

/// Minimal hand-rolled DI container. For a project this size, pulling in
/// get_it/injectable would add ceremony without real benefit — but the
/// *pattern* (depend on abstractions, wire concretes in one place) is the
/// same one a bigger app would use with a real DI framework.
class Injector {
  Injector._();
  static final Injector instance = Injector._();

  late final TicketLocalDataSource ticketLocalDataSource = TicketLocalDataSourceImpl();
  late final TicketRepository ticketRepository =
      TicketRepositoryImpl(localDataSource: ticketLocalDataSource);
}
