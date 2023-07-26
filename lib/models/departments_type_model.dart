import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class DepartmentTypes {
  final List<Departments> departments;
  const DepartmentTypes({
    required this.departments,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'department': departments.map((x) => x.toMap()).toList(),
    };
  }

  factory DepartmentTypes.fromMap(Map<String, dynamic> map) {
    return DepartmentTypes(
      departments: List<Departments>.from(
        (map['department'] as List).map<Departments>(
          (x) => Departments.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory DepartmentTypes.fromJson(String source) =>
      DepartmentTypes.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Departments {
  final String departmentName;
  Departments({
    required this.departmentName,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'departmentName': departmentName,
    };
  }

  factory Departments.fromMap(Map<String, dynamic> map) {
    return Departments(
      departmentName: map['departmentName'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Departments.fromJson(String source) =>
      Departments.fromMap(json.decode(source) as Map<String, dynamic>);
}
