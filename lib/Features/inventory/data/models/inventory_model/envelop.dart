class Envelop {
  int? id;
  String? number;
  var cash;
  var spExpenses;

  Envelop({this.id, this.number, this.cash, this.spExpenses});

  factory Envelop.fromJson(Map<String, dynamic> json) => Envelop(
        id: json['id'] as int?,
        number: json['number'] as String?,
        cash: json['cash'],
        spExpenses: json['sp_expenses'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'number': number,
        'cash': cash,
        'sp_expenses': spExpenses,
      };
}
