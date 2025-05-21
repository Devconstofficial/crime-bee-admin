class MonthlyStatsModel {
  final String? id;
  final String? type;
  final List<Record>? records;
  final Map<String, double>? top3Crimes;
  final int? previousCount;
  final int? currentCount;
  final int? increase;
  final double? increasePercentage;

  MonthlyStatsModel({
    this.id,
    this.type,
    this.records,
    this.top3Crimes,
    this.previousCount,
    this.currentCount,
    this.increase,
    this.increasePercentage,
  });

  factory MonthlyStatsModel.fromJson(Map<String, dynamic> json) {
    return MonthlyStatsModel(
      id: json['_id'],
      type: json['type'],
      records: (json['records'] as List?)
          ?.map((e) => Record.fromJson(e))
          .toList(),
      top3Crimes: json['top3Crimes'] != null
          ? Map<String, double>.from(json['top3Crimes'])
          : null,
      previousCount: json['previousCount'],
      currentCount: json['currentCount'],
      increase: json['increase'],
      increasePercentage: json['increasePercentage']?.toDouble(),
    );
  }
}

class Record {
  final int? year;
  final int? monthNumber;
  final int? crimeCount;

  Record({
    this.year,
    this.monthNumber,
    this.crimeCount,
  });

  factory Record.fromJson(Map<String, dynamic> json) {
    return Record(
      year: json['year'],
      monthNumber: json['month_number'],
      crimeCount: json['crime_count'],
    );
  }
}
