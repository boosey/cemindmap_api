import 'package:cemindmap_api/cemindmap_api.dart';
import 'package:cemindmap_api/processISCJson.dart';

import '../model/assignment.dart';
import '../model/project.dart';

class LoadController extends Controller {
  LoadController(this.context);

  final ManagedContext context;

  @override
  FutureOr<RequestOrResponse?> handle(Request request) async {
    final loadType = request.path.variables["loadtype"];
    if (loadType == "projects") {
      await process(
          context: context, projectFilePath: "public/projects-7-21.json");
      return Response.ok('Loaded $loadType');
    }
    if (loadType == "assignments") {
      await process(
          context: context, assignmentFilePath: "public/assignments-7-21.json");
      return Response.ok('Loaded $loadType');
    }
    if (loadType == "deleteall") {
      final pq = Query<Project>(context);
      pq.canModifyAllInstances = true;
      await pq.delete();

      final aq = Query<Assignment>(context);
      aq.canModifyAllInstances = true;
      await aq.delete();

      return Response.ok('Deleted All Records');
    }

    throw Response.notFound();
  }
}
