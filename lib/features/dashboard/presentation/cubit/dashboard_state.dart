import 'package:equatable/equatable.dart';

enum DashboardStatus { initial, loading, loaded, error }

class DashboardState extends Equatable {
  final DashboardStatus status;
  final int total;
  final int open;
  final int inProgress;
  final int closed;
  final String? errorMessage;

  const DashboardState({
    this.status = DashboardStatus.initial,
    this.total = 0,
    this.open = 0,
    this.inProgress = 0,
    this.closed = 0,
    this.errorMessage,
  });

  DashboardState copyWith({
    DashboardStatus? status,
    int? total,
    int? open,
    int? inProgress,
    int? closed,
    String? errorMessage,
  }) {
    return DashboardState(
      status: status ?? this.status,
      total: total ?? this.total,
      open: open ?? this.open,
      inProgress: inProgress ?? this.inProgress,
      closed: closed ?? this.closed,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, total, open, inProgress, closed, errorMessage];
}
