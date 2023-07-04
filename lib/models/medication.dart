class Medication {
  Medication(
      {this.name,
      this.medType,
      this.unit,
      this.quantity,
      this.medicalCondition,
      this.frequency,
      this.startDate,
      this.endDate,
      this.time,
      this.minimumSupply,
      this.currentSupply});

  String? name;
  String? medType;
  String? unit;
  String? quantity;
  String? medicalCondition;
  String? frequency;
  String? startDate;
  String? endDate;
  String? currentSupply;
  String? minimumSupply;
  String? time;

  factory Medication.fromMap(
    Map<dynamic, dynamic> value,
  ) {
    return Medication(
      name: value['name'],
      medType: value['medType'],
      unit: value['unit'],
      quantity: value['quantity'],
      medicalCondition: value['medicalCondition'],
      frequency: value['frequency'],
      startDate: value['startDate'],
      endDate: value['endDate'],
      currentSupply: value['currentSupply'],
      minimumSupply: value['minimumSupply'],
      time: value['time'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'medType': medType,
      'unit': unit,
      'quantity': quantity,
      'medicalCondition': medicalCondition,
      'frequency': frequency,
      'startDate': startDate,
      'endDate': endDate,
      'currentSupply': currentSupply,
      'minimumSupply': minimumSupply,
      'time': time,
    };
  }
}
