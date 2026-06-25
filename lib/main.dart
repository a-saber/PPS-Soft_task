import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/helper/app_router.dart';
import 'core/helper/injector.dart';
import 'core/theme/app_theme.dart';
import 'core/translations/app_localizations.dart';
import 'features/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'features/settings/presentation/cubit/locale_cubit.dart';
import 'features/settings/presentation/cubit/theme_cubit.dart';
import 'features/tickets/data/repo/ticket_repository.dart';
import 'features/tickets/presentation/cubit/ticket_list/ticket_list_cubit.dart';

void main() {
  runApp(const HelpDeskApp());
}

class HelpDeskApp extends StatelessWidget {
  const HelpDeskApp({super.key});

  @override
  Widget build(BuildContext context) {
    final TicketRepository ticketRepository = Injector.instance.ticketRepository;

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<TicketRepository>.value(value: ticketRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => ThemeCubit()),
          BlocProvider(create: (_) => LocaleCubit()),
          // Long-lived, app-level cubits. Screen-scoped cubits (form/detail)
          // are provided closer to where they're used instead.
          BlocProvider(create: (_) => DashboardCubit(ticketRepository: ticketRepository)),
          BlocProvider(create: (_) => TicketListCubit(ticketRepository: ticketRepository)),
        ],
        child: Builder(
          builder: (context) {
            final themeMode = context.watch<ThemeCubit>().state.themeMode;
            final locale = context.watch<LocaleCubit>().state.locale;

            return MaterialApp(
              title: 'Help Desk',
              debugShowCheckedModeBanner: false,
              themeMode: themeMode,
              theme: AppTheme.light,
              darkTheme: AppTheme.dark,
              locale: locale,
              supportedLocales: const [Locale('en'), Locale('ar')],
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              initialRoute: AppRoutes.dashboard,
              onGenerateRoute: AppRouter.onGenerateRoute,
            );
          },
        ),
      ),
    );
  }
}
