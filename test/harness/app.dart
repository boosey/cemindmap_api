import 'package:cemindmap_api/cemindmap_api.dart';
import 'package:conduit_test/conduit_test.dart';

export 'package:cemindmap_api/cemindmap_api.dart';
export 'package:conduit/conduit.dart';
export 'package:conduit_test/conduit_test.dart';
export 'package:test/test.dart';

/// A testing harness for cemindmap_api.
///
/// A harness for testing an conduit application. Example test file:
///
///         void main() {
///           Harness harness = Harness()..install();
///
///           test("GET /path returns 200", () async {
///             final response = await harness.agent.get("/path");
///             expectResponse(response, 200);
///           });
///         }
///
class Harness extends TestHarness<CemindmapApiChannel>
    with TestHarnessORMMixin {
  @override
  ManagedContext? get context => channel?.context;

  @override
  Future onSetUp() async {
    await resetData();
  }

  @override
  Future onTearDown() async {}

  @override
  Future seed() async {
    // restore any static data. called by resetData.
  }
}
