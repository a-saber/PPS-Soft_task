import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:pps_soft_task/core/translations/app_localizations.dart';
import 'package:pps_soft_task/features/tickets/data/repo/ticket_repository.dart';
import 'package:pps_soft_task/features/tickets/presentation/cubit/ticket_form/ticket_form_cubit.dart';
import 'package:pps_soft_task/features/tickets/presentation/views/create_ticket_screen.dart';

class MockTicketRepository extends Mock implements TicketRepository {}

void main() {
  late MockTicketRepository repository;

  setUp(() {
    repository = MockTicketRepository();
  });

  Widget buildSubject() {
    return MaterialApp(
      locale: const Locale('en'),
      localizationsDelegates: const [AppLocalizations.delegate],
      supportedLocales: const [Locale('en'), Locale('ar')],
      home: BlocProvider<TicketFormCubit>(
        create: (_) => TicketFormCubit(ticketRepository: repository),
        child: const CreateTicketScreen(),
      ),
    );
  }

  testWidgets('shows required-field errors when submitting an empty form', (tester) async {
    await tester.pumpWidget(buildSubject());

    await tester.tap(find.text('Save'));
    await tester.pump();

    expect(find.text('Subject is required'), findsOneWidget);
    expect(find.text('Description is required'), findsOneWidget);
    verifyNever(() => repository.createTicket(
          subject: any(named: 'subject'),
          description: any(named: 'description'),
          priority: any(named: 'priority'),
          category: any(named: 'category'),
        ));
  });
}
