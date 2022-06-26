// ignore_for_file: avoid_positional_boolean_parameters

import 'package:cemindmap_api/cemindmap_api.dart';

const oppIdx = 1;
const accountIdx = 2;
const ownerIdIdx = 8;
const amountIdIdx = 9;
const closeDateIdIdx = 10;
const isOpportunityClosedIdx = 11;
const isOpportunityWonIdx = 12;
const opportunityStageIdx = 13;
const opportunityFiscalPeriodIdx = 14;
const opportunityFiscalYearIdx = 15;

const label = "label";
const value = "value";
const amountKey = "amount";

class Opportunity extends ManagedObject<_Opportunity> implements _Opportunity {
  Opportunity();

  Opportunity.fromJsonDataCells(List<dynamic> dataCells) {
    opportunityId = dataCells[oppIdx][value] as String;
    opportunityName = dataCells[oppIdx][label] as String;
    opportunityOwnerId = dataCells[ownerIdIdx][value] as String;

    accountId = dataCells[accountIdx][value] as String;

    final amountString = dataCells[amountIdIdx][label] as String;
    if (amountString.contains(".00")) {
      amount = (dataCells[amountIdIdx][value][amountKey] as int).toDouble();
    }
    if (amountString.contains(".") && !amountString.contains(".00")) {
      amount = dataCells[amountIdIdx][value][amountKey] as double;
    }

    closeDate = DateTime.parse(dataCells[closeDateIdIdx][value] as String);
    isOpportunityClosed = dataCells[isOpportunityClosedIdx][value] as bool;
    isOpportunityWon = dataCells[isOpportunityWonIdx][value] as bool;
    opportunityStage = dataCells[opportunityStageIdx][value] as String;
    opportunityFiscalPeriod =
        dataCells[opportunityFiscalPeriodIdx][value] as String;
    opportunityFiscalYear =
        (dataCells[opportunityFiscalYearIdx][value] as int).toString();
  }

  @override
  void willInsert() {
    createdAt = DateTime.now().toUtc();
  }
}

class _Opportunity {
  @primaryKey
  int? id;

  late String opportunityId;
  late String opportunityName;
  late String accountId;
  late String opportunityOwnerId;
  late double amount;
  late DateTime closeDate;
  late bool isOpportunityClosed;
  late bool isOpportunityWon;
  late String opportunityStage;
  late String opportunityFiscalPeriod;
  late String opportunityFiscalYear;

  DateTime? createdAt;
}
