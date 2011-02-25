package com.hg94.seti.view
{
	import com.hg94.seti.controller.GetAssignmentRequest;
	import com.hg94.seti.controller.PostPatternMarkRequest;
	import com.hg94.seti.model.Model;
	import com.hg94.seti.view.AssignmentStarfield;
	
	import components.MainSkin;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.system.Capabilities;
	
	import mx.binding.utils.BindingUtils;
	import mx.events.FlexEvent;
	import mx.graphics.BitmapFillMode;
	import mx.graphics.BitmapScaleMode;
	import mx.rpc.events.ResultEvent;
	
	import skinnablecomponents.CategoryButton;
	
	import spark.components.Button;
	import spark.components.Group;
	import spark.events.ElementExistenceEvent;
	
	public class SETIQuestExplorer extends Group
	{
		private static var DEBUG_AIR_URL_ROOT:String = "http://localhost.seti.hg94.com:3000";
		
		private static var PUBLIC_AIR_URL_ROOT:String = "http://heroku.seti.hg94.com";
		
		public var mainSkin:MainSkin;

		private var assignmentStarfield:AssignmentStarfield;
		
		private var waterfallDataVisualization:WaterfallDataVisualization;
		
		[Bindable] public var model:Model;
		
		protected var _api_url_root:String;

		public function SETIQuestExplorer()
		{
			
			// Determine what URL to use for the server
			
			if (Capabilities.playerType == "ActiveX" || Capabilities.playerType == "PlugIn") {
				this._api_url_root = "";
			} else if (Capabilities.isDebugger) {
				this._api_url_root = SETIQuestExplorer.DEBUG_AIR_URL_ROOT;
			} else {
				this._api_url_root = SETIQuestExplorer.PUBLIC_AIR_URL_ROOT; 
			}
			trace("URL Root set to " + this._api_url_root);
			
			this.percentHeight = 100;
			this.percentWidth = 100;
			this.model = new Model();
			this.model.splashMessage = "[[" + Capabilities.playerType + "|" + Capabilities.isDebugger + "]]";
			this.addEventListener(FlexEvent.CREATION_COMPLETE, this.creationCompleteHandler);
			super();
		}

		private function creationCompleteHandler(event:FlexEvent):void {
			this.mainSkin.galaxyImage.fillMode = BitmapFillMode.SCALE;
			this.mainSkin.galaxyImage.scaleMode = BitmapScaleMode.STRETCH;
			this.mainSkin.galaxyImage.percentHeight = 100;
			this.mainSkin.galaxyImage.percentWidth = 100;
			
			this.mainSkin.addEventListener(ElementExistenceEvent.ELEMENT_ADD, this.elementAddHandler);
			
		}
		
		private function elementAddHandler(event:ElementExistenceEvent):void {
			trace(event.element);
			if (event.element["id"]) {
				switch (event.element["id"]) {
					case "skipAssignmentButton":
						this.mainSkin.skipAssignmentButton.addEventListener(MouseEvent.CLICK, this.skipAssignmentButtonClickHandler);
						break;
					case "assignmentStarfieldPlaceholder":
						if (!this.assignmentStarfield) {
							this.assignmentStarfield = new AssignmentStarfield(this.mainSkin.assignmentStarfieldPlaceholder, this.model);
							this.assignmentStarfield.addEventListener("READY", this.starfieldReadyHandler);
						}
						break;
					case "dataVizTileListPlaceholder":
						if (!this.waterfallDataVisualization) {
							this.waterfallDataVisualization = new WaterfallDataVisualization(this.mainSkin.dataVizTileListPlaceholder, this.model);
						}
						break;
					case "assignmentZoomInButton":
						Button(event.element).addEventListener(MouseEvent.CLICK, this.zoomInButtonHandler);
						break;
					case "assignmentZoomOutButton":
						Button(event.element).addEventListener(MouseEvent.CLICK, this.zoomOutButtonHandler);
						break;
					/*case "iSeeAPatternButton":
						Button(event.element).addEventListener(MouseEvent.CLICK, this.iSeeAPatternButtonHandler);
						break;
					*/
				}
			}
			if (event.element is CategoryButton) {
				CategoryButton(event.element).addEventListener(MouseEvent.CLICK, this.categoryButtonHandler);
			}
		}
		
		private function categoryButtonHandler(event:MouseEvent):void {
			var postPatternMarkRequest:PostPatternMarkRequest = new PostPatternMarkRequest(this._api_url_root);
			postPatternMarkRequest.postPatternMark(this.model.currentAssignment, this.model.currentMHzMidpoint);
		}
		
		private function zoomInButtonHandler(event:MouseEvent):void {
			this.assignmentStarfield.zoomIn();
		}
		
		private function zoomOutButtonHandler(event:MouseEvent):void {
			this.assignmentStarfield.zoomOut();
		}
		
		private function starfieldReadyHandler(event:Event):void {
			this.getAssignment();
		}
		
		private function skipAssignmentButtonClickHandler(event:MouseEvent):void {
			this.getAssignment();
		}
		
		protected function getAssignment():void 
		{
			trace("So now the url root is " + this._api_url_root);
			var getAssignmentRequest:GetAssignmentRequest = new GetAssignmentRequest(this._api_url_root);
			getAssignmentRequest.addEventListener(ResultEvent.RESULT, this.getAssignmentResultHandler);
			getAssignmentRequest.getAssignment();
		}
		
		private function getAssignmentResultHandler(event:ResultEvent):void 
		{
			event.currentTarget.removeEventListener(event.type, getAssignmentResultHandler);
			this.model.currentAssignment = (event.currentTarget as GetAssignmentRequest).assignment;
			//this.waterfallDataVisualization.showObservationRange();
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