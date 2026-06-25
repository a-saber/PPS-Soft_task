import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:pps_soft_task/core/translation/translation_keys.dart';

enum TicketStatus { open, inProgress, closed }

enum TicketPriority { low, medium, high }

enum TicketCategory { technical, billing, general }

extension TicketStatusX on TicketStatus {
  String get dbValue => name;

  static TicketStatus fromDb(String value) {
    return TicketStatus.values.firstWhere(
          (e) => e.name == value,
      orElse: () => TicketStatus.open,
    );
  }

  String label() {
    switch (this) {
      case TicketStatus.open:
        return TranslationsKeys.open.tr;
      case TicketStatus.inProgress:
        return TranslationsKeys.inProgress.tr;
      case TicketStatus.closed:
        return TranslationsKeys.closed.tr;
    }
  }
}

extension TicketPriorityX on TicketPriority {
  String get dbValue => name;

  static TicketPriority fromDb(String value) {
    return TicketPriority.values.firstWhere(
          (e) => e.name == value,
      orElse: () => TicketPriority.medium,
    );
  }

  String label() {
    switch (this) {
      case TicketPriority.low:
        return TranslationsKeys.low.tr;
      case TicketPriority.medium:
        return TranslationsKeys.medium.tr;
      case TicketPriority.high:
        return TranslationsKeys.high.tr;
    }
  }
}

extension TicketCategoryX on TicketCategory {
  String get dbValue => name;

  static TicketCategory fromDb(String value) {
    return TicketCategory.values.firstWhere(
          (e) => e.name == value,
      orElse: () => TicketCategory.general,
    );
  }

  String label() {
    switch (this) {
      case TicketCategory.technical:
        return TranslationsKeys.technical.tr;
      case TicketCategory.billing:
        return TranslationsKeys.billing.tr;
      case TicketCategory.general:
        return TranslationsKeys.general.tr;
    }
  }
}

enum SortOrder { newestFirst, oldestFirst }

extension SortOrderX on SortOrder {
  String label() {
    switch (this) {
      case SortOrder.newestFirst:
        return TranslationsKeys.newestFirst.tr;
      case SortOrder.oldestFirst:
        return TranslationsKeys.oldestFirst.tr;
    }
  }
}
