// ignore_for_file: avoid_positional_boolean_parameters

import 'package:cemindmap_api/cemindmap_api.dart';

const projectIdx = 0;
const oppIdx = 1;
const accountIdx = 2;
const notesIdx = 3;
const stageIdx = 4;
const startDateIdx = 5;
const endDateIdx = 6;
const leaderIdIdx = 7;
const ownerIdIdx = 8;
const amountIdIdx = 9;
const closeDateIdIdx = 10;
const isOpportunityClosedIdx = 11;
const isOpportunityWonIdx = 12;
const opportunityStageIdx = 13;
const opportunityFiscalPeriodIdx = 14;
const opportunityFiscalYearIdx = 15;
const marketCodeIdx = 16;
const parentAccountCodeIdx = 17;
const geoNameIdx = 18;
const squadNameIdx = 19;
const isCustomerRefererence = 20;
const marketNameIdx = 21;

const label = "label";
const value = "value";
const amountKey = "amount";

class Project extends ManagedObject<_Project> implements _Project {
  Project();

  Project.fromJsonDataCells(List<dynamic> dataCells) {
    projectId = dataCells[projectIdx][value] as String;
    projectName = dataCells[projectIdx][label] as String;
    opportunityId = dataCells[oppIdx][value] as String;
    accountId = dataCells[accountIdx][value] as String;
    notes = dataCells[notesIdx][label] as String;
    stage = dataCells[stageIdx][label] as String;
    startDate = DateTime.parse(dataCells[startDateIdx][value] as String);
    endDate = DateTime.parse(dataCells[endDateIdx][value] as String);
    projectLeaderId = dataCells[leaderIdIdx][value] as String;
    opportunityOwnerId = dataCells[leaderIdIdx][value] as String;

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
    marketCode = dataCells[marketCodeIdx][value] as String;
    parentAccountCode = dataCells[parentAccountCodeIdx][value] as String;
    geo = dataCells[geoNameIdx][label] as String;
    geoMarketSquad = dataCells[squadNameIdx][label] as String;
    isExternalClientReference = dataCells[isCustomerRefererence][value] as bool;
    market = dataCells[marketNameIdx][label] as String;
  }

  @override
  void willInsert() {
    createdAt = DateTime.now().toUtc();
  }
}

class _Project {
  @primaryKey
  int? id;

  late String projectId;
  @Column(indexed: true)
  late String projectName;
  late String opportunityId;
  late String accountId;
  late String notes;
  late String stage;
  late DateTime startDate;
  late DateTime endDate;
  late String projectLeaderId;
  late String opportunityOwnerId;
  late double amount;
  late DateTime closeDate;
  late bool isOpportunityClosed;
  late bool isOpportunityWon;
  late String opportunityStage;
  late String opportunityFiscalPeriod;
  late String opportunityFiscalYear;
  late String marketCode;
  late String parentAccountCode;
  late String geo;
  late String geoMarketSquad;
  late bool isExternalClientReference;
  late String market;

  DateTime? createdAt;
}
