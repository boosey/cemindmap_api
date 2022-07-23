import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cemindmap_api/model/assignment.dart';
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

  if (assignmentFilePath.isNotEmpty) {
    final file = File(assignmentFilePath);
    // print(await file.readAsString(encoding: ascii));

    await processAssignmentsFile(
      context: context,
      file: file,
    );
  }
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
        try {
          final Project p = Project.fromJsonDataCells(r);
          await Query<Project>(context, values: p).insert();
        } catch (e) {
          log("Error loading: ${e.toString()}");
        }
      });
}

Future<void> processAssignmentsFile({
  required ManagedContext context,
  required File file,
}) async {
  await processFile(
      file: file,
      process: (r) async {
        try {
          final Assignment a = Assignment.fromJsonDataCells(r);
          await Query<Assignment>(context, values: a).insert();
        } catch (e) {
          log("Error loading: ${e.toString()}");
        }
      });
}
