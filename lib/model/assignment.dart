// ignore_for_file: avoid_positional_boolean_parameters

import 'package:cemindmap_api/cemindmap_api.dart';

const amountKey = "amount";
const label = "label";
const value = "value";

const assignmentIdx = 0;
const talentIdx = 1;
const projectIdx = 2;
const startDateIdx = 3;
const endDateIdx = 4;
const milestoneIdx = 5;
const scheduledDaysIdx = 6;
const scheduledHoursIdx = 7;

class Assignment extends ManagedObject<_Assignment> implements _Assignment {
  Assignment();

  Assignment.fromJsonDataCells(List<dynamic> dataCells) {
    assignmentId = dataCells[assignmentIdx][value] as String;
    assignmentName = dataCells[assignmentIdx][label] as String;
    talentId = dataCells[talentIdx][value] as String;
    talentName = dataCells[talentIdx][label] as String;
    projectId = dataCells[projectIdx][value] as String;
    projectName = dataCells[projectIdx][label] as String;
    startDate = DateTime.parse(dataCells[startDateIdx][value] as String);
    endDate = DateTime.parse(dataCells[endDateIdx][value] as String);
    milestone = dataCells[milestoneIdx][label] as String;

    final scheduledDaysString = dataCells[scheduledDaysIdx][label] as String;
    if (scheduledDaysString.contains(".00")) {
      scheduledDays = (dataCells[scheduledDaysIdx][value] as int).toDouble();
    } else if (scheduledDaysString.contains(".")) {
      scheduledDays = dataCells[scheduledDaysIdx][value] as double;
    } else {
      scheduledDays = 0;
    }

    final scheduledHoursString = dataCells[scheduledHoursIdx][label] as String;
    if (scheduledHoursString.contains(".00")) {
      scheduledHours = (dataCells[scheduledHoursIdx][value] as int).toDouble();
    } else if (scheduledHoursString.contains(".")) {
      scheduledHours = dataCells[scheduledHoursIdx][value] as double;
    } else {
      scheduledHours = 0;
    }
  }

  @override
  void willInsert() {
    createdAt = DateTime.now().toUtc();
  }
}

class _Assignment {
  @primaryKey
  int? id;

  @Column(indexed: true)
  late String assignmentId;
  late String assignmentName;
  late String talentId;
  late String talentName;
  late String projectId;
  late String projectName;
  late DateTime startDate;
  late DateTime endDate;
  late String milestone;
  late double scheduledDays;
  late double scheduledHours;

  DateTime? createdAt;
}
