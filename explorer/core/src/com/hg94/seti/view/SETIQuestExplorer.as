package com.hg94.seti.view
{
	import com.hg94.seti.model.Model;
	import com.hg94.seti.view.AssignmentStarfield;
	
	import components.MainSkin;
	
	import flash.events.MouseEvent;
	
	import mx.binding.utils.BindingUtils;
	import mx.events.FlexEvent;
	
	import spark.components.Group;
	
	public class SETIQuestExplorer extends Group
	{
		
		public var mainSkin:MainSkin;

		private var assignmentStarfield:AssignmentStarfield;
		
		private var waterfallDataVisualization:WaterfallDataVisualization;
		
		[Bindable] protected var model:Model;

		public function SETIQuestExplorer()
		{
			this.model = new Model();
			this.addEventListener(FlexEvent.CREATION_COMPLETE, this.creationCompleteHandler);
			super();
		}

		private function creationCompleteHandler(event:FlexEvent):void {
			this.assignmentStarfield = new AssignmentStarfield(this.mainSkin.assignmentStarfieldPlaceholder, this.model);
			this.waterfallDataVisualization = new WaterfallDataVisualization(this.mainSkin.dataVizTileListPlaceholder);
			this.mainSkin.viewDataButton.addEventListener(MouseEvent.CLICK, this.viewDataButtonClickHandler);
		}
		
		private function viewDataButtonClickHandler(event:MouseEvent):void {
			this.waterfallDataVisualization.target = this.assignmentStarfield.target; 
		}
		
		protected override function createChildren():void {
			this.mainSkin = new MainSkin();
			this.mainSkin.model = this.model;
			this.addElement(this.mainSkin);
			super.createChildren();
		}
	}
}