import 'package:bid_online_app_v2/constants.dart';

class Helper {
  String formatCurrency(double amount) {
    final currencyFormat = regexCurrency;
    return currencyFormat.format(amount);
  }

  DateTime calculateRemainDayTime(DateTime startDay, DateTime endDay) {
    DateTime now = DateTime.now();
    if (now.isAfter(endDay)) {
      return endDay;
    } else if (now.isBefore(startDay)) {
      return endDay;
    } else {
      return endDay.isAfter(now) ? endDay : now;
    }
  }

  String capitalizeVietnamese(String input) {
    List<String> words = input.split(' ');
    for (int i = 0; i < words.length; i++) {
      String word = words[i];
      if (word.isNotEmpty) {
        String firstChar = word[0].toUpperCase();
        String rest = word.substring(1);
        words[i] = '$firstChar$rest';
      }
    }
    return words.join(' ');
  }
}
