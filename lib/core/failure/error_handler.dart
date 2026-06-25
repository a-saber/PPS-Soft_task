import 'package:sqflite/sqflite.dart';

import 'failure_model.dart';

class ErrorHandler {
  static FailureModel handle(Object error) {
    if (error is DatabaseException) {
      return _handleDatabaseError(error);
    }

    if (error is FormatException) {
      return FailureModel('Invalid data format');
    }

    return FailureModel('Something went wrong, please try again');
  }


  static FailureModel _handleDatabaseError(DatabaseException error) {
    final message = error.toString();

    if (message.contains('UNIQUE constraint failed')) {
      return FailureModel('This data already exists');
    }

    if (message.contains('no such table')) {
      return FailureModel('Database table not found');
    }

    if (message.contains('database is locked')) {
      return FailureModel('Database is busy, try again');
    }

    return FailureModel('Database error occurred');
  }
}