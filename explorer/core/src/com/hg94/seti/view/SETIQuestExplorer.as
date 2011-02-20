package com.hg94.seti.view
{
	import components.MainSkin;
	import com.hg94.seti.view.AssignmentStarfield;
	
	import mx.events.FlexEvent;
	
	import spark.components.Group;
	
	public class SETIQuestExplorer extends Group
	{
		
		public var mainSkin:MainSkin;

		private var assignmentStarfield:AssignmentStarfield;

		public function SETIQuestExplorer()
		{
			this.addEventListener(FlexEvent.CREATION_COMPLETE, this.creationCompleteHandler);
			super();
		}

		private function creationCompleteHandler(event:FlexEvent):void {
			assignmentStarfield = new AssignmentStarfield(this.mainSkin.assignmentStarfieldPlaceholder);
		}
		
		protected override function createChildren():void {
			this.mainSkin = new MainSkin();
			this.addElement(this.mainSkin);
			super.createChildren();
		}
	}
}