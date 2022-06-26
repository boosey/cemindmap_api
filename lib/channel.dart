import 'package:cemindmap_api/cemindmap_api.dart';
import 'package:cemindmap_api/controllers/load_controller.dart';
import 'package:cemindmap_api/model/project.dart';

/// This type initializes an application.
///
/// Override methods in this class to set up routes and initialize services like
/// database connections. See http://conduit.io/docs/http/channel/.
class CemindmapApiChannel extends ApplicationChannel {
  late ManagedContext context;

  /// Initialize services in this method.
  ///
  /// Implement this method to initialize services, read values from [options]
  /// and any other initialization required before constructing [entryPoint].
  ///
  /// This method is invoked prior to [entryPoint] being accessed.
  @override
  Future prepare() async {
    logger.onRecord.listen(
        (rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));

    final config = CemindmapApiConfiguration(options!.configurationFilePath!);
    context = contextWithConnectionInfo(config.database!);
  }

  /// Construct the request channel.
  ///
  /// Return an instance of some [Controller] that will be the initial receiver
  /// of all [Request]s.
  ///
  /// This method is invoked after [prepare].
  @override
  Controller get entryPoint {
    final router = Router();

    router
        .route("/project/[:id]")
        .link(() => ManagedObjectController<Project>(context));

    router
        .route('/load/:loadtype(projects|assignments|deleteall)')
        .link(() => LoadController(context));

    return router;
  }

  /*
   * Helper methods
   */

  ManagedContext contextWithConnectionInfo(
      DatabaseConfiguration connectionInfo) {
    final dataModel = ManagedDataModel.fromCurrentMirrorSystem();
    final psc = PostgreSQLPersistentStore(
        connectionInfo.username,
        connectionInfo.password,
        connectionInfo.host,
        connectionInfo.port,
        connectionInfo.databaseName);

    return ManagedContext(dataModel, psc);
  }
}

/// An instance of this class reads values from a configuration
/// file specific to this application.
///
/// Configuration files must have key-value for the properties in this class.
/// For more documentation on configuration files, see https://conduit.io/docs/configure/ and
/// https://pub.dartlang.org/packages/safe_config.
class CemindmapApiConfiguration extends Configuration {
  CemindmapApiConfiguration(String fileName) : super.fromFile(File(fileName));

  DatabaseConfiguration? database;
}
