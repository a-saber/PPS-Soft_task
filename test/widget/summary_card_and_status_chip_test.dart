import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:pps_soft_task/core/shared_components/status_chip.dart';
import 'package:pps_soft_task/core/translations/app_localizations.dart';
import 'package:pps_soft_task/core/utils/enums.dart';
import 'package:pps_soft_task/features/dashboard/presentation/widgets/summary_card.dart';

Widget _wrap(Widget child) {
  return MaterialApp(
    locale: const Locale('en'),
    localizationsDelegates: const [AppLocalizations.delegate],
    supportedLocales: const [Locale('en'), Locale('ar')],
    home: Scaffold(body: child),
  );
}

void main() {
  testWidgets('SummaryCard displays label and value', (tester) async {
    await tester.pumpWidget(
      _wrap(
        SummaryCard(
          label: 'Total Tickets',
          value: 12,
          color: Colors.blue,
          icon: Icons.confirmation_number_outlined,
        ),
      ),
    );

    expect(find.text('12'), findsOneWidget);
    expect(find.text('Total Tickets'), findsOneWidget);
  });

  testWidgets('SummaryCard triggers onTap callback', (tester) async {
    var tapped = false;
    await tester.pumpWidget(
      _wrap(
        SummaryCard(
          label: 'Open',
          value: 3,
          color: Colors.purple,
          icon: Icons.lock_open,
          onTap: () => tapped = true,
        ),
      ),
    );

    await tester.tap(find.byType(SummaryCard));
    await tester.pump();

    expect(tapped, isTrue);
  });

  testWidgets('StatusChip shows the correct English label per status', (tester) async {
    await tester.pumpWidget(_wrap(const StatusChip(status: TicketStatus.inProgress)));
    expect(find.text('In Progress'), findsOneWidget);
  });
}
