package com.hg94.seti.view
{
	import com.hg94.core.SessionIDManager;
	import com.hg94.seti.controller.GetAssignmentRequest;
	import com.hg94.seti.controller.PostPatternMarkRequest;
	import com.hg94.seti.model.Model;
	import com.hg94.seti.view.AssignmentStarfield;
	
	import components.MainSkin;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.system.Capabilities;
	import flash.utils.Timer;
	
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
		
		public var sessionIDManager:SessionIDManager;

		private var assignmentStarfield:AssignmentStarfield;
		
		private var waterfallDataVisualization:WaterfallDataVisualization;
		
		[Bindable] public var model:Model;
		
		
		/** Get the root to use for the API URL, also used for authentication.
		 * 	Static method so it can be called e.g. from an AndroidView.
		 */
		
		public static function get api_url_root():String {
			if (Capabilities.playerType == "ActiveX" || Capabilities.playerType == "PlugIn") {
				return "";
			} else if (Capabilities.isDebugger) {
				return SETIQuestExplorer.DEBUG_AIR_URL_ROOT;
			} else {
				return SETIQuestExplorer.PUBLIC_AIR_URL_ROOT; 
			}
			
		}
		
		

		public function SETIQuestExplorer()
		{
			this.percentHeight = 100;
			this.percentWidth = 100;
			this.model = new Model();
			this.model.splashMessage = "Pre-Release Version";
			super();
		}
		
		protected override function createChildren():void {
			this.mainSkin = new MainSkin();
			this.mainSkin.percentHeight = 100;
			this.mainSkin.percentWidth = 100;
			this.mainSkin.model = this.model;
			/*
			if (this.initialState) {
				this.mainSkin.currentState = this.initialState;
			}
			*/
			this.mainSkin.currentState = "Splash_Loading";
			var timer:Timer = new Timer(2000, 1);
			timer.addEventListener(TimerEvent.TIMER, this.splashLoadingTimerHandler);
			timer.start();
			//this.mainSkin.addEventListener(Event.EXIT_FRAME, this.mainSkinEnterFrameHandlerSplashLoading);
			this.mainSkin.addEventListener(ElementExistenceEvent.ELEMENT_ADD, this.elementAddHandler);
			this.addElement(this.mainSkin);
			super.createChildren();
		}
		
		private function splashLoadingTimerHandler(event:Event):void {
			trace("Timer");
			event.target.removeEventListener(event.type, this.splashLoadingTimerHandler);
			//this.mainSkin.removeEventListener(event.type, this.mainSkinEnterFrameHandlerSplashLoading);
			this.mainSkin.currentState = "Assignment";
			//this.mainSkin.addEventListener(Event.ENTER_FRAME, this.mainSkinEnterFrameHandlerAssignment);
		}
		
		/**
		 * Not fired right now. But it would be handy to leave the Splash up until the user is ready
		 */
		
		private function mainSkinEnterFrameHandlerAssignment(event:Event):void {
			this.mainSkin.removeEventListener(event.type, this.mainSkinEnterFrameHandlerAssignment);
			this.mainSkin.currentState = "Splash_WithButton";
		}
		
		private function elementAddHandler(event:ElementExistenceEvent):void {
			trace(event.element);
			if (event.element["id"]) {
				switch (event.element["id"]) {
					case "galaxyImage":
						this.mainSkin.galaxyImage.fillMode = BitmapFillMode.SCALE;
						this.mainSkin.galaxyImage.scaleMode = BitmapScaleMode.STRETCH;
						this.mainSkin.galaxyImage.percentHeight = 100;
						this.mainSkin.galaxyImage.percentWidth = 100;
						break;
					case "skipAssignmentButton":
						this.mainSkin.skipAssignmentButton.addEventListener(MouseEvent.CLICK, this.skipAssignmentButtonClickHandler);
						break;
					case "assignmentStarfieldPlaceholder":
						if (!this.assignmentStarfield) {
							this.assignmentStarfield = new AssignmentStarfield(this.mainSkin.assignmentStarfieldPlaceholder, this.model);
							this.assignmentStarfield.addEventListener("FREEZE_STARTING", this.starfieldFreezeStartingHandler);
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
				}
			}
			if (event.element is CategoryButton) {
				CategoryButton(event.element).addEventListener(MouseEvent.CLICK, this.categoryButtonHandler);
			}
		}
		
		private function starfieldFreezeStartingHandler(event:Event):void {
			trace("");
			//this.mainSkin.currentState = "Splash_Loading";
		}
		
		private function starfieldReadyHandler(event:Event):void {
			trace("");
			//this.mainSkin.currentState = "Assignment";
			this.getAssignment();
		}
		
		private function categoryButtonHandler(event:MouseEvent):void {
			var postPatternMarkRequest:PostPatternMarkRequest = new PostPatternMarkRequest(SETIQuestExplorer.api_url_root);
			postPatternMarkRequest.postPatternMark(this.model.currentAssignment, this.model.currentMHzMidpoint);
		}
		
		private function zoomInButtonHandler(event:MouseEvent):void {
			this.assignmentStarfield.zoomIn();
		}
		
		private function zoomOutButtonHandler(event:MouseEvent):void {
			this.assignmentStarfield.zoomOut();
		}
		
		private function skipAssignmentButtonClickHandler(event:MouseEvent):void {
			this.getAssignment();
		}
		
		protected function getAssignment():void 
		{
			var getAssignmentRequest:GetAssignmentRequest = new GetAssignmentRequest(SETIQuestExplorer.api_url_root);
			getAssignmentRequest.addEventListener(ResultEvent.RESULT, this.getAssignmentResultHandler);
			getAssignmentRequest.getAssignment();
		}
		
		private function getAssignmentResultHandler(event:ResultEvent):void 
		{
			event.currentTarget.removeEventListener(event.type, getAssignmentResultHandler);
			this.model.currentAssignment = (event.currentTarget as GetAssignmentRequest).assignment;
		}
	}
}