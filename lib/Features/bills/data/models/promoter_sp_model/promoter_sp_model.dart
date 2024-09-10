import 'school.dart';

class PromoterSpModel {
  int? id;
  String? name;
  School? school;

  PromoterSpModel({this.id, this.name, this.school});

  factory PromoterSpModel.fromJson(Map<String, dynamic> json) {
    return PromoterSpModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      school: json['school'] == null
          ? null
          : School.fromJson(json['school'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'school': school?.toJson(),
      };
}
