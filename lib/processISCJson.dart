import 'dart:convert';
import 'dart:io';

import 'package:conduit/conduit.dart';

import 'model/project.dart';

Future<void> process({
  required ManagedContext context,
  String projectFilePath = "",
  String assignmentFilePath = "",
}) async {
  if (projectFilePath.isNotEmpty) {
    final file = File(projectFilePath);
    // print(await file.readAsString(encoding: ascii));

    await processProjectsFile(
      context: context,
      file: file,
    );
  }

  // if (assignmentFilePath.isNotEmpty) {
  //   var fileId = await uploadFile(
  //     path: assignmentFilePath,
  //   );

  //   await processAssignmentsFile(
  //     fileId: fileId,
  //   );
  // }
}

Future<List<dynamic>> rowsFromFile({required File file}) async {
  final fileContents = await file.readAsString();

  final json = jsonDecode(fileContents);

  return json["actions"][0]["returnValue"]["factMap"]["T!T"]["rows"]
      as List<dynamic>;
}

Future<void> processFile({
  required File file,
  required void Function(List<dynamic>) process,
}) async {
  final List<dynamic> rows = await rowsFromFile(file: file);

  try {
    for (var r in rows) {
      final record = r["dataCells"];
      process(record as List<dynamic>);
    }
  } on Exception catch (e) {
    print(e);
  }
}

Future<void> processProjectsFile({
  required ManagedContext context,
  required File file,
}) async {
  await processFile(
      file: file,
      process: (r) async {
        final Project p = Project.fromJsonDataCells(r);
        await Query<Project>(context, values: p).insert();

        // final Opportunity o = Opportunity.fromJsonDataCells(r);
        // await Query<Opportunity>(context, values: o).insert();

        //   Talent t = Talent.fromJsonDataCells(r);
        //   await processEntity(t.talentid, t.toJson(), talentCollectionId);

        //   cea.Account a = cea.Account.fromJsonDataCells(r);
        //   await processEntity(a.accountid, a.toJson(), accountsCollectionId);

        //   Geo g = Geo.fromJsonDataCells(r);
        //   await processEntity(g.geoname, g.toJson(), geoCollectionId);

        //   Market m = Market.fromJsonDataCells(r);
        //   await processEntity(m.marketname, m.toJson(), marketCollectionId);

        //   Squad s = Squad.fromJsonDataCells(r);
        //   await processEntity(s.squadname, s.toJson(), squadCollectionId);
      });
}
