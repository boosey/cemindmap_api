import 'dart:async';
import 'package:conduit/conduit.dart';   

class Migration3 extends Migration { 
  @override
  Future upgrade() async {
   		database.deleteColumn("_Project", "amount");
		database.deleteColumn("_Project", "closeDate");
		database.deleteColumn("_Project", "isOpportunityClosed");
		database.deleteColumn("_Project", "isOpportunityWon");
		database.deleteColumn("_Project", "opportunityStage");
		database.deleteColumn("_Project", "opportunityFiscalPeriod");
		database.deleteColumn("_Project", "opportunityFiscalYear");
  }
  
  @override
  Future downgrade() async {}
  
  @override
  Future seed() async {}
}
    