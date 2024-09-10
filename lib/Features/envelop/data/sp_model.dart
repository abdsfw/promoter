class SellPoint {
  final int id;
  final String? name;
  final School? school;

  SellPoint({
    required this.id,
    required this.name,
    this.school,
  });

  factory SellPoint.fromJson(Map<String, dynamic> json) {
    return SellPoint(
      id: json['id'],
      name: json['name'],
      school: json['school'] != null ? School.fromJson(json['school']) : null,
    );
  }
}

class School {
  final int id;
  final String? nameAr;
  final String? nameEn;
  final String? region;
  final String? type;
  final String? createdAt;
  final String? updatedAt;

  School({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.region,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
  });

  factory School.fromJson(Map<String, dynamic> json) {
    return School(
      id: json['id'],
      nameAr: json['name_ar'],
      nameEn: json['name_en'],
      region: json['region'],
      type: json['type'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}

class Envelope {
  final int id;
  final String? number;
  final double? cash;
  final DateTime? date;
  final int? sellPointId;
  final int? spexpenses; 
  Envelope({
    required this.id,
    required this.number,
    required this.cash,
    required this.date,
    required this.sellPointId,
    required this.spexpenses
  });

  factory Envelope.fromJson(Map<String, dynamic> json) {
    return Envelope(
      id: json['id'],
      number: json['number'],
      spexpenses: json['sp_expenses'],
      cash: json['cash'].toDouble(),
      date: DateTime.parse(json['date']),
      sellPointId: json['sell_point_id'],
    );
  }
}
