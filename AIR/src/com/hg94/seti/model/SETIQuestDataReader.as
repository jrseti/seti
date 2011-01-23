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

			var observation:Observation;
			
			var tauCeti:Target = new Target("Tau Ceti");
			tauCeti.setSETICoordinates(1.734467472, 15.93748);
			var tauCetiObservation:Observation = new Observation(new Date(2010, 11, 6, 2, 32));
			
			observation = tauCetiObservation;
			
			observation.addWaterfallTile(new WaterfallTile(1419.979734, 1419.980001, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan-0009/chan-0009-0-1419.979734-1419.980001.png"));
			observation.addWaterfallTile(new WaterfallTile(1419.980001, 1419.980267, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan-0009/chan-0009-1-1419.980001-1419.980267.png"));
			observation.addWaterfallTile(new WaterfallTile(1419.980267, 1419.980534, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan-0009/chan-0009-2-1419.980267-1419.980534.png"));
			observation.addWaterfallTile(new WaterfallTile(1419.980534, 1419.980801, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan-0009/chan-0009-3-1419.980534-1419.980801.png"));
			observation.addWaterfallTile(new WaterfallTile(1419.980801, 1419.981067, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan-0009/chan-0009-4-1419.980801-1419.981067.png"));
			observation.addWaterfallTile(new WaterfallTile(1419.981067, 1419.981334, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan-0009/chan-0009-5-1419.981067-1419.981334.png"));
			observation.addWaterfallTile(new WaterfallTile(1419.981334, 1419.981600, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan-0009/chan-0009-6-1419.981334-1419.981600.png"));
			observation.addWaterfallTile(new WaterfallTile(1419.981600, 1419.981867, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan-0009/chan-0009-7-1419.981600-1419.981867.png"));
			observation.addWaterfallTile(new WaterfallTile(1419.981867, 1419.982134, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan-0008/chan-0008-0-1419.981867-1419.982134.png"));
			observation.addWaterfallTile(new WaterfallTile(1419.982134, 1419.982401, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan-0008/chan-0008-1-1419.982134-1419.982401.png"));
			observation.addWaterfallTile(new WaterfallTile(1419.982401, 1419.982667, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan-0008/chan-0008-2-1419.982401-1419.982667.png"));
			observation.addWaterfallTile(new WaterfallTile(1419.982667, 1419.982934, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan-0008/chan-0008-3-1419.982667-1419.982934.png"));
			observation.addWaterfallTile(new WaterfallTile(1419.982934, 1419.983201, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan-0008/chan-0008-4-1419.982934-1419.983201.png"));
			observation.addWaterfallTile(new WaterfallTile(1419.983201, 1419.983467, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan-0008/chan-0008-5-1419.983201-1419.983467.png"));
			observation.addWaterfallTile(new WaterfallTile(1419.983467, 1419.983734, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan-0008/chan-0008-6-1419.983467-1419.983734.png"));
			observation.addWaterfallTile(new WaterfallTile(1419.983734, 1419.984000, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan-0008/chan-0008-7-1419.983734-1419.984000.png"));
			observation.addWaterfallTile(new WaterfallTile(1419.984001, 1419.984267, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan-0007/chan-0007-0-1419.984001-1419.984267.png"));
			observation.addWaterfallTile(new WaterfallTile(1419.984267, 1419.984534, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan-0007/chan-0007-1-1419.984267-1419.984534.png"));
			observation.addWaterfallTile(new WaterfallTile(1419.984534, 1419.984801, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan-0007/chan-0007-2-1419.984534-1419.984801.png"));
			observation.addWaterfallTile(new WaterfallTile(1419.984801, 1419.985067, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan-0007/chan-0007-3-1419.984801-1419.985067.png"));
			observation.addWaterfallTile(new WaterfallTile(1419.985067, 1419.985334, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan-0007/chan-0007-4-1419.985067-1419.985334.png"));
			observation.addWaterfallTile(new WaterfallTile(1419.985334, 1419.985600, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan-0007/chan-0007-5-1419.985334-1419.985600.png"));
			observation.addWaterfallTile(new WaterfallTile(1419.985600, 1419.985867, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan-0007/chan-0007-6-1419.985600-1419.985867.png"));
			observation.addWaterfallTile(new WaterfallTile(1419.985867, 1419.986134, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan-0007/chan-0007-7-1419.985867-1419.986134.png"));
			observation.addWaterfallTile(new WaterfallTile(1419.986134, 1419.986401, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan-0006/chan-0006-0-1419.986134-1419.986401.png"));
			observation.addWaterfallTile(new WaterfallTile(1419.986401, 1419.986667, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan-0006/chan-0006-1-1419.986401-1419.986667.png"));
			observation.addWaterfallTile(new WaterfallTile(1419.986667, 1419.986934, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan-0006/chan-0006-2-1419.986667-1419.986934.png"));
			observation.addWaterfallTile(new WaterfallTile(1419.986934, 1419.987201, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan-0006/chan-0006-3-1419.986934-1419.987201.png"));
			observation.addWaterfallTile(new WaterfallTile(1419.987201, 1419.987467, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan-0006/chan-0006-4-1419.987201-1419.987467.png"));
			observation.addWaterfallTile(new WaterfallTile(1419.987467, 1419.987734, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan-0006/chan-0006-5-1419.987467-1419.987734.png"));
			observation.addWaterfallTile(new WaterfallTile(1419.987734, 1419.988000, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan-0006/chan-0006-6-1419.987734-1419.988000.png"));
			observation.addWaterfallTile(new WaterfallTile(1419.988000, 1419.988267, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan-0006/chan-0006-7-1419.988000-1419.988267.png"));
			observation.addWaterfallTile(new WaterfallTile(1419.988267, 1419.988534, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan-0005/chan-0005-0-1419.988267-1419.988534.png"));
			observation.addWaterfallTile(new WaterfallTile(1419.988534, 1419.988801, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan-0005/chan-0005-1-1419.988534-1419.988801.png"));
			observation.addWaterfallTile(new WaterfallTile(1419.988801, 1419.989067, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan-0005/chan-0005-2-1419.988801-1419.989067.png"));
			observation.addWaterfallTile(new WaterfallTile(1419.989067, 1419.989334, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan-0005/chan-0005-3-1419.989067-1419.989334.png"));
			observation.addWaterfallTile(new WaterfallTile(1419.989334, 1419.989600, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan-0005/chan-0005-4-1419.989334-1419.989600.png"));
			observation.addWaterfallTile(new WaterfallTile(1419.989600, 1419.989867, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan-0005/chan-0005-5-1419.989600-1419.989867.png"));
			observation.addWaterfallTile(new WaterfallTile(1419.989867, 1419.990134, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan-0005/chan-0005-6-1419.989867-1419.990134.png"));
			observation.addWaterfallTile(new WaterfallTile(1419.990134, 1419.990400, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan-0005/chan-0005-7-1419.990134-1419.990400.png"));
			observation.addWaterfallTile(new WaterfallTile(1419.990401, 1419.990667, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan-0004/chan-0004-0-1419.990401-1419.990667.png"));
			observation.addWaterfallTile(new WaterfallTile(1419.990667, 1419.990934, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan-0004/chan-0004-1-1419.990667-1419.990934.png"));
			observation.addWaterfallTile(new WaterfallTile(1419.990934, 1419.991201, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan-0004/chan-0004-2-1419.990934-1419.991201.png"));
			observation.addWaterfallTile(new WaterfallTile(1419.991201, 1419.991467, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan-0004/chan-0004-3-1419.991201-1419.991467.png"));
			observation.addWaterfallTile(new WaterfallTile(1419.991467, 1419.991734, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan-0004/chan-0004-4-1419.991467-1419.991734.png"));
			observation.addWaterfallTile(new WaterfallTile(1419.991734, 1419.992000, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan-0004/chan-0004-5-1419.991734-1419.992000.png"));
			observation.addWaterfallTile(new WaterfallTile(1419.992000, 1419.992267, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan-0004/chan-0004-6-1419.992000-1419.992267.png"));
			observation.addWaterfallTile(new WaterfallTile(1419.992267, 1419.992534, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan-0004/chan-0004-7-1419.992267-1419.992534.png"));
			observation.addWaterfallTile(new WaterfallTile(1419.992534, 1419.992801, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan-0003/chan-0003-0-1419.992534-1419.992801.png"));
			observation.addWaterfallTile(new WaterfallTile(1419.992801, 1419.993067, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan-0003/chan-0003-1-1419.992801-1419.993067.png"));
			observation.addWaterfallTile(new WaterfallTile(1419.993067, 1419.993334, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan-0003/chan-0003-2-1419.993067-1419.993334.png"));
			observation.addWaterfallTile(new WaterfallTile(1419.993334, 1419.993600, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan-0003/chan-0003-3-1419.993334-1419.993600.png"));
			observation.addWaterfallTile(new WaterfallTile(1419.993600, 1419.993867, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan-0003/chan-0003-4-1419.993600-1419.993867.png"));
			observation.addWaterfallTile(new WaterfallTile(1419.993867, 1419.994134, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan-0003/chan-0003-5-1419.993867-1419.994134.png"));
			observation.addWaterfallTile(new WaterfallTile(1419.994134, 1419.994400, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan-0003/chan-0003-6-1419.994134-1419.994400.png"));
			observation.addWaterfallTile(new WaterfallTile(1419.994400, 1419.994667, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan-0003/chan-0003-7-1419.994400-1419.994667.png"));
			observation.addWaterfallTile(new WaterfallTile(1419.994667, 1419.994934, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan-0002/chan-0002-0-1419.994667-1419.994934.png"));
			observation.addWaterfallTile(new WaterfallTile(1419.994934, 1419.995201, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan-0002/chan-0002-1-1419.994934-1419.995201.png"));
			observation.addWaterfallTile(new WaterfallTile(1419.995201, 1419.995467, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan-0002/chan-0002-2-1419.995201-1419.995467.png"));
			observation.addWaterfallTile(new WaterfallTile(1419.995467, 1419.995734, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan-0002/chan-0002-3-1419.995467-1419.995734.png"));
			observation.addWaterfallTile(new WaterfallTile(1419.995734, 1419.996000, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan-0002/chan-0002-4-1419.995734-1419.996000.png"));
			observation.addWaterfallTile(new WaterfallTile(1419.996000, 1419.996267, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan-0002/chan-0002-5-1419.996000-1419.996267.png"));
			observation.addWaterfallTile(new WaterfallTile(1419.996267, 1419.996534, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan-0002/chan-0002-6-1419.996267-1419.996534.png"));
			observation.addWaterfallTile(new WaterfallTile(1419.996534, 1419.996800, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan-0002/chan-0002-7-1419.996534-1419.996800.png"));
			observation.addWaterfallTile(new WaterfallTile(1419.996801, 1419.997067, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan-0001/chan-0001-0-1419.996801-1419.997067.png"));
			observation.addWaterfallTile(new WaterfallTile(1419.997067, 1419.997334, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan-0001/chan-0001-1-1419.997067-1419.997334.png"));
			observation.addWaterfallTile(new WaterfallTile(1419.997334, 1419.997600, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan-0001/chan-0001-2-1419.997334-1419.997600.png"));
			observation.addWaterfallTile(new WaterfallTile(1419.997600, 1419.997867, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan-0001/chan-0001-3-1419.997600-1419.997867.png"));
			observation.addWaterfallTile(new WaterfallTile(1419.997867, 1419.998134, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan-0001/chan-0001-4-1419.997867-1419.998134.png"));
			observation.addWaterfallTile(new WaterfallTile(1419.998134, 1419.998400, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan-0001/chan-0001-5-1419.998134-1419.998400.png"));
			observation.addWaterfallTile(new WaterfallTile(1419.998400, 1419.998667, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan-0001/chan-0001-6-1419.998400-1419.998667.png"));
			observation.addWaterfallTile(new WaterfallTile(1419.998667, 1419.998934, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan-0001/chan-0001-7-1419.998667-1419.998934.png"));
			observation.addWaterfallTile(new WaterfallTile(1419.998934, 1419.999201, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan+0000/chan+0000-0-1419.998934-1419.999201.png"));
			observation.addWaterfallTile(new WaterfallTile(1419.999201, 1419.999467, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan+0000/chan+0000-1-1419.999201-1419.999467.png"));
			observation.addWaterfallTile(new WaterfallTile(1419.999467, 1419.999734, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan+0000/chan+0000-2-1419.999467-1419.999734.png"));
			observation.addWaterfallTile(new WaterfallTile(1419.999734, 1420.000000, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan+0000/chan+0000-3-1419.999734-1420.000000.png"));
			observation.addWaterfallTile(new WaterfallTile(1420.000000, 1420.000267, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan+0000/chan+0000-4-1420.000000-1420.000267.png"));
			observation.addWaterfallTile(new WaterfallTile(1420.000267, 1420.000534, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan+0000/chan+0000-5-1420.000267-1420.000534.png"));
			observation.addWaterfallTile(new WaterfallTile(1420.000534, 1420.000800, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan+0000/chan+0000-6-1420.000534-1420.000800.png"));
			observation.addWaterfallTile(new WaterfallTile(1420.000800, 1420.001067, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan+0000/chan+0000-7-1420.000800-1420.001067.png"));
			observation.addWaterfallTile(new WaterfallTile(1420.001067, 1420.001334, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan+0001/chan+0001-0-1420.001067-1420.001334.png"));
			observation.addWaterfallTile(new WaterfallTile(1420.001334, 1420.001600, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan+0001/chan+0001-1-1420.001334-1420.001600.png"));
			observation.addWaterfallTile(new WaterfallTile(1420.001600, 1420.001867, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan+0001/chan+0001-2-1420.001600-1420.001867.png"));
			observation.addWaterfallTile(new WaterfallTile(1420.001867, 1420.002134, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan+0001/chan+0001-3-1420.001867-1420.002134.png"));
			observation.addWaterfallTile(new WaterfallTile(1420.002134, 1420.002400, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan+0001/chan+0001-4-1420.002134-1420.002400.png"));
			observation.addWaterfallTile(new WaterfallTile(1420.002400, 1420.002667, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan+0001/chan+0001-5-1420.002400-1420.002667.png"));
			observation.addWaterfallTile(new WaterfallTile(1420.002667, 1420.002934, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan+0001/chan+0001-6-1420.002667-1420.002934.png"));
			observation.addWaterfallTile(new WaterfallTile(1420.002934, 1420.003200, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan+0001/chan+0001-7-1420.002934-1420.003200.png"));
			observation.addWaterfallTile(new WaterfallTile(1420.003201, 1420.003467, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan+0002/chan+0002-0-1420.003201-1420.003467.png"));
			observation.addWaterfallTile(new WaterfallTile(1420.003467, 1420.003734, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan+0002/chan+0002-1-1420.003467-1420.003734.png"));
			observation.addWaterfallTile(new WaterfallTile(1420.003734, 1420.004000, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan+0002/chan+0002-2-1420.003734-1420.004000.png"));
			observation.addWaterfallTile(new WaterfallTile(1420.004000, 1420.004267, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan+0002/chan+0002-3-1420.004000-1420.004267.png"));
			observation.addWaterfallTile(new WaterfallTile(1420.004267, 1420.004534, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan+0002/chan+0002-4-1420.004267-1420.004534.png"));
			observation.addWaterfallTile(new WaterfallTile(1420.004534, 1420.004800, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan+0002/chan+0002-5-1420.004534-1420.004800.png"));
			observation.addWaterfallTile(new WaterfallTile(1420.004800, 1420.005067, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan+0002/chan+0002-6-1420.004800-1420.005067.png"));
			observation.addWaterfallTile(new WaterfallTile(1420.005067, 1420.005334, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan+0002/chan+0002-7-1420.005067-1420.005334.png"));
			observation.addWaterfallTile(new WaterfallTile(1420.005334, 1420.005600, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan+0003/chan+0003-0-1420.005334-1420.005600.png"));
			observation.addWaterfallTile(new WaterfallTile(1420.005600, 1420.005867, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan+0003/chan+0003-1-1420.005600-1420.005867.png"));
			observation.addWaterfallTile(new WaterfallTile(1420.005867, 1420.006134, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan+0003/chan+0003-2-1420.005867-1420.006134.png"));
			observation.addWaterfallTile(new WaterfallTile(1420.006134, 1420.006400, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan+0003/chan+0003-3-1420.006134-1420.006400.png"));
			observation.addWaterfallTile(new WaterfallTile(1420.006400, 1420.006667, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan+0003/chan+0003-4-1420.006400-1420.006667.png"));
			observation.addWaterfallTile(new WaterfallTile(1420.006667, 1420.006934, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan+0003/chan+0003-5-1420.006667-1420.006934.png"));
			observation.addWaterfallTile(new WaterfallTile(1420.006934, 1420.007200, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan+0003/chan+0003-6-1420.006934-1420.007200.png"));
			observation.addWaterfallTile(new WaterfallTile(1420.007200, 1420.007467, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan+0003/chan+0003-7-1420.007200-1420.007467.png"));
			observation.addWaterfallTile(new WaterfallTile(1420.007467, 1420.007734, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan+0004/chan+0004-0-1420.007467-1420.007734.png"));
			observation.addWaterfallTile(new WaterfallTile(1420.007734, 1420.008000, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan+0004/chan+0004-1-1420.007734-1420.008000.png"));
			observation.addWaterfallTile(new WaterfallTile(1420.008000, 1420.008267, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan+0004/chan+0004-2-1420.008000-1420.008267.png"));
			observation.addWaterfallTile(new WaterfallTile(1420.008267, 1420.008534, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan+0004/chan+0004-3-1420.008267-1420.008534.png"));
			observation.addWaterfallTile(new WaterfallTile(1420.008534, 1420.008800, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan+0004/chan+0004-4-1420.008534-1420.008800.png"));
			observation.addWaterfallTile(new WaterfallTile(1420.008800, 1420.009067, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan+0004/chan+0004-5-1420.008800-1420.009067.png"));
			observation.addWaterfallTile(new WaterfallTile(1420.009067, 1420.009334, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan+0004/chan+0004-6-1420.009067-1420.009334.png"));
			observation.addWaterfallTile(new WaterfallTile(1420.009334, 1420.009600, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan+0004/chan+0004-7-1420.009334-1420.009600.png"));
			observation.addWaterfallTile(new WaterfallTile(1420.009600, 1420.009867, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan+0005/chan+0005-0-1420.009600-1420.009867.png"));
			observation.addWaterfallTile(new WaterfallTile(1420.009867, 1420.010134, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan+0005/chan+0005-1-1420.009867-1420.010134.png"));
			observation.addWaterfallTile(new WaterfallTile(1420.010134, 1420.010400, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan+0005/chan+0005-2-1420.010134-1420.010400.png"));
			observation.addWaterfallTile(new WaterfallTile(1420.010400, 1420.010667, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan+0005/chan+0005-3-1420.010400-1420.010667.png"));
			observation.addWaterfallTile(new WaterfallTile(1420.010667, 1420.010934, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan+0005/chan+0005-4-1420.010667-1420.010934.png"));
			observation.addWaterfallTile(new WaterfallTile(1420.010934, 1420.011200, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan+0005/chan+0005-5-1420.010934-1420.011200.png"));
			observation.addWaterfallTile(new WaterfallTile(1420.011200, 1420.011467, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan+0005/chan+0005-6-1420.011200-1420.011467.png"));
			observation.addWaterfallTile(new WaterfallTile(1420.011467, 1420.011734, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan+0005/chan+0005-7-1420.011467-1420.011734.png"));
			observation.addWaterfallTile(new WaterfallTile(1420.011734, 1420.012000, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan+0006/chan+0006-0-1420.011734-1420.012000.png"));
			observation.addWaterfallTile(new WaterfallTile(1420.012000, 1420.012267, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan+0006/chan+0006-1-1420.012000-1420.012267.png"));
			observation.addWaterfallTile(new WaterfallTile(1420.012267, 1420.012534, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan+0006/chan+0006-2-1420.012267-1420.012534.png"));
			observation.addWaterfallTile(new WaterfallTile(1420.012534, 1420.012800, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan+0006/chan+0006-3-1420.012534-1420.012800.png"));
			observation.addWaterfallTile(new WaterfallTile(1420.012800, 1420.013067, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan+0006/chan+0006-4-1420.012800-1420.013067.png"));
			observation.addWaterfallTile(new WaterfallTile(1420.013067, 1420.013334, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan+0006/chan+0006-5-1420.013067-1420.013334.png"));
			observation.addWaterfallTile(new WaterfallTile(1420.013334, 1420.013600, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan+0006/chan+0006-6-1420.013334-1420.013600.png"));
			observation.addWaterfallTile(new WaterfallTile(1420.013600, 1420.013867, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan+0006/chan+0006-7-1420.013600-1420.013867.png"));
			observation.addWaterfallTile(new WaterfallTile(1420.013867, 1420.014134, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan+0007/chan+0007-0-1420.013867-1420.014134.png"));
			observation.addWaterfallTile(new WaterfallTile(1420.014134, 1420.014400, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan+0007/chan+0007-1-1420.014134-1420.014400.png"));
			observation.addWaterfallTile(new WaterfallTile(1420.014400, 1420.014667, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan+0007/chan+0007-2-1420.014400-1420.014667.png"));
			observation.addWaterfallTile(new WaterfallTile(1420.014667, 1420.014934, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan+0007/chan+0007-3-1420.014667-1420.014934.png"));
			observation.addWaterfallTile(new WaterfallTile(1420.014934, 1420.015200, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan+0007/chan+0007-4-1420.014934-1420.015200.png"));
			observation.addWaterfallTile(new WaterfallTile(1420.015200, 1420.015467, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan+0007/chan+0007-5-1420.015200-1420.015467.png"));
			observation.addWaterfallTile(new WaterfallTile(1420.015467, 1420.015734, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan+0007/chan+0007-6-1420.015467-1420.015734.png"));
			observation.addWaterfallTile(new WaterfallTile(1420.015734, 1420.016000, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan+0007/chan+0007-7-1420.015734-1420.016000.png"));
			observation.addWaterfallTile(new WaterfallTile(1420.016000, 1420.016267, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan+0008/chan+0008-0-1420.016000-1420.016267.png"));
			observation.addWaterfallTile(new WaterfallTile(1420.016267, 1420.016534, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan+0008/chan+0008-1-1420.016267-1420.016534.png"));
			observation.addWaterfallTile(new WaterfallTile(1420.016534, 1420.016800, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan+0008/chan+0008-2-1420.016534-1420.016800.png"));
			observation.addWaterfallTile(new WaterfallTile(1420.016800, 1420.017067, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan+0008/chan+0008-3-1420.016800-1420.017067.png"));
			observation.addWaterfallTile(new WaterfallTile(1420.017067, 1420.017334, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan+0008/chan+0008-4-1420.017067-1420.017334.png"));
			observation.addWaterfallTile(new WaterfallTile(1420.017334, 1420.017600, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan+0008/chan+0008-5-1420.017334-1420.017600.png"));
			observation.addWaterfallTile(new WaterfallTile(1420.017600, 1420.017867, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan+0008/chan+0008-6-1420.017600-1420.017867.png"));
			observation.addWaterfallTile(new WaterfallTile(1420.017867, 1420.018134, "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan+0008/chan+0008-7-1420.017867-1420.018134.png"));

			

			
			tauCeti.defaultObservation = tauCetiObservation;
			targetSet.addTarget(tauCeti);
			
			var epsilonEridani:Target = new Target("Epsilon Eridani");
			epsilonEridani.setSETICoordinates(3.5488456,9.45826);
			var epsilonEridaniObservation:Observation = new Observation(new Date(2010, 11, 6, 4, 4));
			epsilonEridani.defaultObservation = epsilonEridaniObservation;
			targetSet.addTarget(epsilonEridani);
			
			
			var gliese581:Target = new Target("Giese 581");
			gliese581.setSETICoordinates(15.324118,7.72228028);
			var gliese581Observation:Observation = new Observation(new Date(2010, 11, 5, 13, 56));
			gliese581.defaultObservation = gliese581Observation;
			targetSet.addTarget(gliese581);
			
			return targetSet;
		}
		
	}
}