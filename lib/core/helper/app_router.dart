import 'package:flutter/material.dart';

import '../../features/dashboard/presentation/views/dashboard_screen.dart';
import '../../features/tickets/data/models/ticket_model.dart';
import '../../features/tickets/presentation/views/create_ticket_screen.dart';
import '../../features/tickets/presentation/views/ticket_detail_screen.dart';
import '../../features/tickets/presentation/views/ticket_list_screen.dart';

/// Single place that knows route *names*. Screens never hardcode string
/// route paths, and navigation logic doesn't leak into widgets.
class AppRoutes {
  AppRoutes._();

  static const String dashboard = '/';
  static const String ticketList = '/tickets';
  static const String createTicket = '/tickets/create';
  static const String ticketDetail = '/tickets/detail';
}

class AppRouter {
  AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.dashboard:
        return MaterialPageRoute(builder: (_) => const DashboardScreen());
      case AppRoutes.ticketList:
        return MaterialPageRoute(builder: (_) => const TicketListScreen());
      case AppRoutes.createTicket:
        return MaterialPageRoute(builder: (_) => const CreateTicketScreen());
      case AppRoutes.ticketDetail:
        final ticket = settings.arguments as TicketModel;
        return MaterialPageRoute(builder: (_) => TicketDetailScreen(ticket: ticket));
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(body: Center(child: Text('Route not found'))),
        );
    }
  }
}
