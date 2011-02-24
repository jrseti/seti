package com.hg94.seti.view
{
	import com.hg94.seti.controller.GetAssignmentRequest;
	import com.hg94.seti.model.Model;
	import com.hg94.seti.view.AssignmentStarfield;
	
	import components.MainSkin;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.binding.utils.BindingUtils;
	import mx.events.FlexEvent;
	import mx.graphics.BitmapFillMode;
	import mx.graphics.BitmapScaleMode;
	import mx.rpc.events.ResultEvent;
	
	import spark.components.Group;
	import spark.events.ElementExistenceEvent;
	
	public class SETIQuestExplorer extends Group
	{
		
		public var mainSkin:MainSkin;

		private var assignmentStarfield:AssignmentStarfield;
		
		private var waterfallDataVisualization:WaterfallDataVisualization;
		
		[Bindable] protected var model:Model;
		
		public var api_url_root:String = "";

		public function SETIQuestExplorer()
		{
			this.percentHeight = 100;
			this.percentWidth = 100;
			this.model = new Model();
			this.addEventListener(FlexEvent.CREATION_COMPLETE, this.creationCompleteHandler);
			super();
		}

		private function creationCompleteHandler(event:FlexEvent):void {
			this.assignmentStarfield = new AssignmentStarfield(this.mainSkin.assignmentStarfieldPlaceholder, this.model);
			this.assignmentStarfield.addEventListener("READY", this.starfieldReadyHandler);
			this.waterfallDataVisualization = new WaterfallDataVisualization(this.mainSkin.dataVizTileListPlaceholder, this.model);
			//this.mainSkin.viewDataButton.addEventListener(MouseEvent.CLICK, this.viewDataButtonClickHandler);
			
			this.mainSkin.addEventListener(ElementExistenceEvent.ELEMENT_ADD, this.elementAddHandler);
			
			this.mainSkin.galaxyImage.fillMode = BitmapFillMode.SCALE;
			this.mainSkin.galaxyImage.scaleMode = BitmapScaleMode.STRETCH;
			this.mainSkin.galaxyImage.percentHeight = 100;
			this.mainSkin.galaxyImage.percentWidth = 100;
		}
		
		private function elementAddHandler(event:ElementExistenceEvent):void {
			trace(event.element);
			if (event.element["id"] && event.element["id"] == "skipAssignmentButton") {
				this.mainSkin.skipAssignmentButton.addEventListener(MouseEvent.CLICK, this.skipAssignmentButtonClickHandler);
				trace("Added event handler");
			}

		}
		
		private function starfieldReadyHandler(event:Event):void {
			this.getAssignment();
		}
		
		private function skipAssignmentButtonClickHandler(event:MouseEvent):void {
			this.getAssignment();
		}
		
		protected function getAssignment():void 
		{
			var getAssignmentRequest:GetAssignmentRequest = new GetAssignmentRequest(this.api_url_root);
			getAssignmentRequest.addEventListener(ResultEvent.RESULT, this.getAssignmentResultHandler);
			getAssignmentRequest.getAssignment();
		}
		
		private function getAssignmentResultHandler(event:ResultEvent):void 
		{
			event.currentTarget.removeEventListener(event.type, getAssignmentResultHandler);
			this.model.currentAssignment = (event.currentTarget as GetAssignmentRequest).assignment;
			this.assignmentStarfield.showTarget();
			this.waterfallDataVisualization.showObservationRange();
		}
		
		/*
		private function viewDataButtonClickHandler(event:MouseEvent):void {
			this.waterfallDataVisualization.target = this.assignmentStarfield.target; 
		}
		*/
		
		protected override function createChildren():void {
			this.mainSkin = new MainSkin();
			this.mainSkin.percentHeight = 100;
			this.mainSkin.percentWidth = 100;
			this.mainSkin.model = this.model;
			this.addElement(this.mainSkin);
			
			//scaleMode="stretch" fillMode="scale" height="100%" width="100%"
			
			super.createChildren();
		}
	}
}