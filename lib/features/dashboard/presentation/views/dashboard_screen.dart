import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helper/app_router.dart';
import '../../../../core/shared_components/loading_widget.dart';
import '../../../../core/translations/app_localizations.dart';
import '../../../settings/presentation/cubit/locale_cubit.dart';
import '../../../settings/presentation/cubit/theme_cubit.dart';
import '../cubit/dashboard_cubit.dart';
import '../cubit/dashboard_state.dart';
import '../widgets/summary_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    context.read<DashboardCubit>().loadSummary();
  }

  Future<void> _refresh() => context.read<DashboardCubit>().loadSummary();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr('dashboard')),
        actions: [
          IconButton(
            tooltip: 'AR / EN',
            onPressed: () => context.read<LocaleCubit>().toggleLocale(),
            icon: const Icon(Icons.translate),
          ),
          Builder(
            builder: (context) {
              final isDark = context.watch<ThemeCubit>().state.isDark;
              return IconButton(
                tooltip: context.tr('dark_mode'),
                onPressed: () => context.read<ThemeCubit>().toggleTheme(),
                icon: Icon(isDark ? Icons.dark_mode : Icons.light_mode),
              );
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: BlocBuilder<DashboardCubit, DashboardState>(
          builder: (context, state) {
            if (state.status == DashboardStatus.loading && state.total == 0) {
              return const LoadingWidget();
            }

            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1,
                  children: [
                    SummaryCard(
                      label: context.tr('total_tickets'),
                      value: state.total,
                      color: Theme.of(context).colorScheme.primary,
                      icon: Icons.confirmation_number_outlined,
                      onTap: () => Navigator.pushNamed(context, AppRoutes.ticketList),
                    ),
                    SummaryCard(
                      label: context.tr('open_tickets'),
                      value: state.open,
                      color: Colors.purple,
                      icon: Icons.lock_open,
                      onTap: () => Navigator.pushNamed(context, AppRoutes.ticketList),
                    ),
                    SummaryCard(
                      label: context.tr('in_progress_tickets'),
                      value: state.inProgress,
                      color: Colors.orange,
                      icon: Icons.timelapse,
                      onTap: () => Navigator.pushNamed(context, AppRoutes.ticketList),
                    ),
                    SummaryCard(
                      label: context.tr('closed_tickets'),
                      value: state.closed,
                      color: Colors.green,
                      icon: Icons.check_circle_outline,
                      onTap: () => Navigator.pushNamed(context, AppRoutes.ticketList),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: () => Navigator.pushNamed(context, AppRoutes.ticketList),
                  icon: const Icon(Icons.list_alt),
                  label: Text(context.tr('view_all')),
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, AppRoutes.createTicket);
          if (context.mounted) _refresh();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
