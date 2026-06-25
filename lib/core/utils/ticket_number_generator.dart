/// Generates human friendly, unique-enough ticket numbers e.g. TCK-240621-1830
/// Using a timestamp avoids needing the DB to know the "next id" up front,
/// and keeps the model free to build before it's persisted.
class TicketNumberGenerator {
  TicketNumberGenerator._();

  static String generate() {
    final now = DateTime.now();
    final datePart =
        '${now.year.toString().substring(2)}${_two(now.month)}${_two(now.day)}';
    final timePart = '${_two(now.hour)}${_two(now.minute)}${_two(now.second)}';
    return 'TCK-$datePart-$timePart';
  }

  static String _two(int value) => value.toString().padLeft(2, '0');
}
