package com.hg94.seti.model {
	
	
	/** Gets all the data about the targets that the application needs
	 */
	
	public class SETIQuestDataReader {

		

		// Public methods
		
		
		/** Gets the TargetSet
		 *  Fakes the SETIQuest data as a hard-coded set of stuff. In theory it reads from index files or an API.
		 */
		
		public function getTargetSet():TargetSet {
			var targetSet:TargetSet = new TargetSet();

			
			var tauCeti:Target = new Target("Tau Ceti");
			tauCeti.setSETICoordinates(1.734467472, 15.93748);
			targetSet.addTarget(tauCeti);
			
			var epsilonEridani:Target = new Target("Epsilon Eridani");
			epsilonEridani.setSETICoordinates(3.5488456,9.45826);
			targetSet.addTarget(epsilonEridani);
			
			
			var gliese581:Target = new Target("Giese 581");
			gliese581.setSETICoordinates(15.324118,7.72228028);
			targetSet.addTarget(gliese581);
			
			return targetSet;
		}
		
	}
}