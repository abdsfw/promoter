class InventorySp {
  int? id;
  // num? totalPrice;
  // num? totalExpenses;
  DateTime? date;

  InventorySp({
    this.id,
    // this.totalPrice,
    // this.totalExpenses,
    this.date,
  });

  factory InventorySp.fromJson(Map<String, dynamic> json) {
    return InventorySp(
      id: json['id'] as int?,
      // totalPrice: json['total_price'] as num?,
      // totalExpenses: json['total_expenses'] as num?,
      date: json['date'] == null
          ? null
          : DateTime.parse(json['date'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        // 'total_price': totalPrice,
        // 'total_expenses': totalExpenses,
        'date': date?.toIso8601String(),
      };
}
