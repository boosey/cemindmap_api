import 'package:cemindmap_api/cemindmap_api.dart';
import 'package:cemindmap_api/processISCJson.dart';

import '../model/project.dart';

class LoadController extends Controller {
  LoadController(this.context);

  final ManagedContext context;

  @override
  FutureOr<RequestOrResponse?> handle(Request request) async {
    final loadType = request.path.variables["loadtype"];
    if (loadType == "projects") {
      await process(
          context: context, projectFilePath: "public/projects-5-30.json");
      return Response.ok('Loaded $loadType');
    }
    if (loadType == "assignments") {
      // process(context: context, projectFilePath: "public/projects-5-30.json");
      return Response.ok('Loaded $loadType');
    }
    if (loadType == "deleteall") {
      final q = Query<Project>(context);
      q.canModifyAllInstances = true;
      final count = await q.delete();

      return Response.ok('$count');
    }

    throw Response.notFound();
  }
}
