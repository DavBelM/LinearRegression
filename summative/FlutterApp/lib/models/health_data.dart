class HealthData {
  final int age;
  final String sex;
  final double bmi;
  final int children;
  final String smoker;
  final String region;

  HealthData({
    required this.age,
    required this.sex,
    required this.bmi,
    required this.children,
    required this.smoker,
    required this.region,
  });

  Map<String, dynamic> toJson() {
    return {
      'age': age,
      'sex': sex,
      'bmi': bmi,
      'children': children,
      'smoker': smoker,
      'region': region,
    };
  }

  factory HealthData.fromJson(Map<String, dynamic> json) {
    return HealthData(
      age: json['age'],
      sex: json['sex'],
      bmi: json['bmi'],
      children: json['children'],
      smoker: json['smoker'],
      region: json['region'],
    );
  }
}