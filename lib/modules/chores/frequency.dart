enum Frequency {
  doesNotRepeat,
  daily,
  weekly,
  monthly,
  quarterly,
  yearly;

  String get friendlyName {
    switch (this) {
      case Frequency.doesNotRepeat:
        return 'Does not repeat';
      case Frequency.daily:
        return 'daily';
      case Frequency.weekly:
        return 'weekly';
      case Frequency.monthly:
        return 'monthly';
      case Frequency.quarterly:
        return 'quarterly';
      case Frequency.yearly:
        return 'yearly';
    }
  }

  int get id {
    switch (this) {
      case Frequency.doesNotRepeat:
        return 0;
      case Frequency.daily:
        return 1;
      case Frequency.weekly:
        return 2;
      case Frequency.monthly:
        return 3;
      case Frequency.quarterly:
        return 4;
      case Frequency.yearly:
        return 5;
    }
  }

  static Frequency fromId(int? id) {
    switch (id) {
      case null:
        return Frequency.doesNotRepeat;
      case 0:
        return Frequency.doesNotRepeat;
      case 1:
        return Frequency.daily;
      case 2:
        return Frequency.weekly;
      case 3:
        return Frequency.monthly;
      case 4:
        return Frequency.quarterly;
      case 5:
        return Frequency.yearly;
      default:
        throw Exception('Invalid frequency id: $id');
    }
  }
}
