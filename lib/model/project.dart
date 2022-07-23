// ignore_for_file: avoid_positional_boolean_parameters

import 'package:cemindmap_api/cemindmap_api.dart';

const amountKey = "amount";
const label = "label";
const value = "value";

const accountIdx = 2;
const amountIdx = 9;
const closeDateIdIdx = 10;
const endDateIdx = 6;
const geoNameIdx = 18;
const isCustomerRefererence = 20;
const isOpportunityClosedIdx = 11;
const isOpportunityWonIdx = 12;
const leaderIdIdx = 7;
const marketCodeIdx = 16;
const marketNameIdx = 21;
const notesIdx = 3;
const oppIdx = 1;
const opportunityFiscalPeriodIdx = 14;
const opportunityFiscalYearIdx = 15;
const opportunityStageIdx = 13;
const ownerIdIdx = 8;
const parentAccountCodeIdx = 17;
const projectIdx = 0;
const squadNameIdx = 19;
const stageIdx = 4;
const startDateIdx = 5;

class Project extends ManagedObject<_Project> implements _Project {
  Project();

  Project.fromJsonDataCells(List<dynamic> dataCells) {
    projectId = (dataCells[projectIdx][value] ?? "-") as String;
    projectName = dataCells[projectIdx][label] as String;
    opportunityId = dataCells[oppIdx][value] as String;
    opportunityName = dataCells[oppIdx][label] as String;
    opportunityOwnerId = dataCells[ownerIdIdx][value] as String;
    opportunityOwnerName = dataCells[ownerIdIdx][label] as String;
    projectLeaderId = (dataCells[leaderIdIdx][value] ?? "-") as String;
    projectLeaderName = dataCells[leaderIdIdx][label] as String;
    accountId = (dataCells[accountIdx][value] ?? "-") as String;
    accountName = dataCells[accountIdx][label] as String;
    notes = dataCells[notesIdx][label] as String;
    projectStage = dataCells[stageIdx][label] as String;
    startDate = DateTime.parse(
        (dataCells[startDateIdx][value] ?? "1/1/1900") as String);
    endDate =
        DateTime.parse((dataCells[endDateIdx][value] ?? "1/1/1900") as String);
    marketCode = dataCells[marketCodeIdx][value] as String;
    parentAccountCode = dataCells[parentAccountCodeIdx][value] as String;
    geo = dataCells[geoNameIdx][label] as String;
    geoMarketSquad = dataCells[squadNameIdx][label] as String;
    isExternalClientReference = dataCells[isCustomerRefererence][value] as bool;
    market = dataCells[marketNameIdx][label] as String;
    final amountString = (dataCells[amountIdx][label] ?? "0") as String;
    if (amountString.contains(".00")) {
      amount = (dataCells[amountIdx][value][amountKey] as int).toDouble();
    } else if (amountString.contains(".")) {
      amount = dataCells[amountIdx][value][amountKey] as double;
    } else {
      amount = 0.0;
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

class _Project {
  @primaryKey
  int? id;

  @Column(indexed: true)
  late String projectId;
  late String projectName;
  @Column(indexed: true)
  late String opportunityId;
  @Column(indexed: true)
  late String accountId;
  late String accountName;
  late String notes;
  @Column(indexed: true)
  late String projectStage;
  late DateTime startDate;
  late DateTime endDate;
  @Column(indexed: true)
  late String projectLeaderId;
  late String projectLeaderName;
  @Column(indexed: true)
  late String opportunityOwnerId;
  late String opportunityOwnerName;
  @Column(indexed: true)
  late String marketCode;
  @Column(indexed: true)
  late String parentAccountCode;
  @Column(indexed: true)
  late String geo;
  @Column(indexed: true)
  late String geoMarketSquad;
  late bool isExternalClientReference;
  @Column(indexed: true)
  late String market;
  late String opportunityName;
  late double amount;
  late DateTime closeDate;
  late bool isOpportunityClosed;
  late bool isOpportunityWon;
  @Column(indexed: true)
  late String opportunityStage;
  @Column(indexed: true)
  late String opportunityFiscalPeriod;
  @Column(indexed: true)
  late String opportunityFiscalYear;

  DateTime? createdAt;
}
