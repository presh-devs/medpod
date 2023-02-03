import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'med.g.dart';

@HiveType(typeId: 0)
class Med extends HiveObject{
  @HiveField(0)
  late String name;

  @HiveField(1)
  late String medType;

  @HiveField(2)
  late String unit;

  @HiveField(3)
  late String quantity;

  @HiveField(4)
  late String medicalCondition;

  @HiveField(5)
  late String frequency;

  @HiveField(7)
  late String startDate;

  @HiveField(8)
  late String endDate;

  @HiveField(9)
  late String currentSupply;


  @HiveField(10)
  late String minimumSupply;

  @HiveField(11)
  late String time;
}