package com.hg94.seti.view
{
	import com.google.maps.MapEvent;
	import com.hg94.core.AuthenticationEvent;
	import com.hg94.core.IAuthenticationSystem;
	import com.hg94.core.IAuthenticationSystemComponent;
	import com.hg94.seti.controller.GetAssignmentAPICall;
	import com.hg94.seti.controller.GetUserAPICall;
	import com.hg94.seti.controller.PostPatternMarkAPICall;
	import com.hg94.seti.events.GetUserAPICallCompleteEvent;
	import com.hg94.seti.model.Model;
	import com.hg94.seti.view.AssignmentStarfield;
	
	import components.MainSkin;
	
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	import flash.utils.Timer;
	
	import mx.binding.utils.BindingUtils;
	import mx.binding.utils.ChangeWatcher;
	import mx.events.FlexEvent;
	import mx.events.PropertyChangeEvent;
	import mx.graphics.BitmapFillMode;
	import mx.graphics.BitmapScaleMode;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import skinnablecomponents.CategoryButton;
	
	import spark.components.Button;
	import spark.components.Group;
	import spark.events.ElementExistenceEvent;
	
	public class SETIQuestExplorer extends Group implements IAuthenticationSystemComponent {
		
		
		
		// Static Variable Declarations
		
		
		private static var DEBUG_AIR_URL_ROOT:String = "http://localhost.seti.hg94.com:3000";
		
		private static var PUBLIC_AIR_URL_ROOT:String = "http://live.seti.hg94.com";
		
		private static var PATTERN_CATEGORY_CODES:Array = ["local", "diagonal", "squiggle", "pulse", "broadband", "modulation", "radar", "unknown"]
		
		
		
		// Public Variable Declarations
		
		
		public var mainSkin:MainSkin;
		
		public var authenticationSystem:IAuthenticationSystem;
		
		[Bindable] public var model:Model;

		
		
		// Private Variable Declarations
		
		
		private var assignmentStarfield:AssignmentStarfield;
		
		private var waterfallDataVisualization:WaterfallDataVisualization;
		

		
		// Getters and Setters
		
		
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
		

		
		// Sequence Methods
		
		
		/** Step 1: Initialize some variables
		 */
		
		public function SETIQuestExplorer() {
			this.percentHeight = 100;
			this.percentWidth = 100;
			this.model = new Model();
			super();
		}
		

		/** Step 2: Actually set up the skin
		 */
		
		protected override function createChildren():void {
			
			
			// We have one child, basically, which is the skin
			// TODO: Could we be a skinnablecontainer and do this.skin = ? (Catalyst wouldn't get it, but maybe Flex would)
			
			this.mainSkin = new MainSkin();
			this.mainSkin.percentHeight = 100;
			this.mainSkin.percentWidth = 100;
			this.mainSkin.model = this.model;
			this.mainSkin.currentState = "Splash_Loading";
			this.mainSkin.addEventListener(ElementExistenceEvent.ELEMENT_ADD, this.elementAddHandler);
			
			
			// Add the handler which will start the first API call
			//this.addEventListener(Event.ADDED_TO_STAGE, this.addedToStageHandler);
			//this.addEventListener(FlexEvent.CREATION_COMPLETE, this.addedToStageHandler);
			
			
			// Listen for error messages. This will only work after mainSkin is set up.
			ChangeWatcher.watch(this.model, "errorMessage", this.errorMessageChangeHandler)
			
			// Add the skin, so the splash screen will start to draw
			this.addElement(this.mainSkin);
			
			// Do the right thing
			super.createChildren();
		}
		
		
		/** Step 3: (Not really a step, but...) Handle all errors!
		 */
		
		private function errorMessageChangeHandler(event:PropertyChangeEvent):void {
			this.mainSkin.currentState = "Error_NoConnection";
		}
		
		
		/** Step 4: Gets info about the current user. Mostly this is just a way of confirming we are logged in, and if not, then we will request authentication
		 * 	This should be called on addedToStage (AIR) or creationComplete (browser)
		 */
		
		public function start():void {
			var getUserAPICall:GetUserAPICall = new GetUserAPICall(SETIQuestExplorer.api_url_root, this.authenticationSystem, this.model);
			getUserAPICall.addEventListener(GetUserAPICallCompleteEvent.GET_USER_API_CALL_COMPLETE, this.getUserAPICallCompleteHandler);
			getUserAPICall.execute();
		}
		
		
		/** Step 5: Based on whether the user is logged in and their role, do the right thing.
		 */
		
		private function getUserAPICallCompleteHandler(event:GetUserAPICallCompleteEvent):void {
			if (event.isLoggedIn) {
				if (this.model.user.role == "admin" || this.model.user.role == "explorer") {  
					this.startTimer();
				} else {
					this.mainSkin.currentState = "Login_Thanks";
				}
			} else {
				this.mainSkin.currentState = "LogIn";
			}
		}
		
		
		/** Step 6: User has clicked "Login"
		 */
		
		private function loginButtonClickHandler(event:MouseEvent):void {
			this.authenticateUser();
		}
		
		
		/** Step 7: Authenticate the user. In AIR, this will throw a StageWebView up in front of the main screen.
		 */
		
		protected function authenticateUser():void {
			this.authenticationSystem.addEventListener(AuthenticationEvent.AUTHENTICATION_COMPLETE, this.authenticationCompleteHandler);
			this.authenticationSystem.addEventListener(ErrorEvent.ERROR, this.authenticationSystemErrorHandler);
			this.authenticationSystem.authenticate(SETIQuestExplorer.api_url_root);
		}
		
		
		/** Step 8: Handle authentication errors
		 */
		
		private function authenticationSystemErrorHandler(event:ErrorEvent):void {
			event.target.removeEventListener(AuthenticationEvent.AUTHENTICATION_COMPLETE, this.authenticationCompleteHandler);
			event.target.removeEventListener(ErrorEvent.ERROR, this.authenticationSystemErrorHandler);
			this.model.errorMessage = event.text;
		}
		
		
		/** Step 9: Authentication successful. Start over to get the user information.
		 */
		
		private function authenticationCompleteHandler(event:AuthenticationEvent):void {
			event.target.removeEventListener(AuthenticationEvent.AUTHENTICATION_COMPLETE, this.authenticationCompleteHandler);
			event.target.removeEventListener(ErrorEvent.ERROR, this.authenticationSystemErrorHandler);
			this.mainSkin.currentState = "Splash_Loading";
			this.start();
		}		
		
		
		/** Step 8: Start the timer, after which we will go to the Assignment screen.
		 * 	Yes, we are *always* showing the splash screen for two stupid seconds.
		 * 	I don't know of any other way to confirm the splash screen is completely visible before going to assignment screen
		 * 	which starts the Google Maps freeze.
		 */
		
		protected function startTimer():void {
			
			// Set up a timer. This allows the splash screen to completely show itself before we start initializing the map
			
			var timer:Timer = new Timer(2000, 1);
			timer.addEventListener(TimerEvent.TIMER, this.timerHandler);
			timer.start();
		}
		
		
		
		/** Step 3: Timer that was set when we first showed the splash screen is now complete.
		 * 	Next step is to show the Assignment state, so the map starts initializing
		 */
		
		private function timerHandler(event:Event):void {
			event.target.removeEventListener(event.type, this.timerHandler);
			
			
			// If for some reason we had an error when the timer was going, then we should stay at the error state
			
			if (this.mainSkin.currentState != "Error_NoConnection") {
				this.mainSkin.currentState = "Assignment";
			}
		}
		
		
		/** Step 4 (not really, because this happens every time something is added to the skin)
		 * 	Most importantly for now, the assignmentStarfield is added
		 * 	This starts the lengthy initialization of Google Maps
		 * 	We're listening for Map Ready event
		 */
		
		private function elementAddHandler(event:ElementExistenceEvent):void {
			trace(event.element);
			if (event.element["id"]) {
				switch (event.element["id"]) {
					case "assignmentStarfieldPlaceholder":
						if (!this.assignmentStarfield) {
							this.assignmentStarfield = new AssignmentStarfield(this.mainSkin.assignmentStarfieldPlaceholder, this.model);
							this.assignmentStarfield.addEventListener(MapEvent.MAP_READY, this.mapReadyHandler);
						}
						break;
					case "assignmentZoomInButton":
						Button(event.element).addEventListener(MouseEvent.CLICK, this.zoomInButtonHandler);
						break;
					case "assignmentZoomOutButton":
						Button(event.element).addEventListener(MouseEvent.CLICK, this.zoomOutButtonHandler);
						break;
					case "dataVizTileListPlaceholder":
						if (!this.waterfallDataVisualization) {
							this.waterfallDataVisualization = new WaterfallDataVisualization(this.mainSkin.dataVizTileListPlaceholder, this.model);
						}
						break;
					case "galaxyImage":
						this.mainSkin.galaxyImage.fillMode = BitmapFillMode.SCALE;
						this.mainSkin.galaxyImage.scaleMode = BitmapScaleMode.STRETCH;
						this.mainSkin.galaxyImage.percentHeight = 100;
						this.mainSkin.galaxyImage.percentWidth = 100;
						break;
					case "loginButton":
						this.mainSkin.loginButton.addEventListener(MouseEvent.CLICK, this.loginButtonClickHandler);
						break; //foo
					case "skipAssignmentButton":
						this.mainSkin.skipAssignmentButton.addEventListener(MouseEvent.CLICK, this.skipAssignmentButtonClickHandler);
						break;
				}
			}
			if (event.element is CategoryButton) {
				CategoryButton(event.element).addEventListener(MouseEvent.CLICK, this.categoryButtonHandler);
			}
		}


		/** Step 5: The Map is done initializing.
		 */
		
		private function mapReadyHandler(event:Event):void {
			this.getAssignment();
		}


		
		/** Now we are actually getting the assignment.
		 */
		
		protected function getAssignment():void  {
			var getAssignmentAPICall:GetAssignmentAPICall = new GetAssignmentAPICall(SETIQuestExplorer.api_url_root, this.authenticationSystem, this.model);
			getAssignmentAPICall.execute();
		}
		
		
		
		// UI Control Handlers
		
		
		/** Post the pattern mark that the person found.
		 *  Note that we are providing no real feedback to the user on their post.
		 */
		
		private function categoryButtonHandler(event:MouseEvent):void {
			var buttonID:String = event.currentTarget.id;
			if (buttonID.substr(0, 15) == "categoryButton_") {
				var categoryName:String = buttonID.substr(15);
				if (SETIQuestExplorer.PATTERN_CATEGORY_CODES.indexOf(categoryName) > 0) {
					var postPatternMarkAPICall:PostPatternMarkAPICall = new PostPatternMarkAPICall(SETIQuestExplorer.api_url_root, this.authenticationSystem, this.model);
					postPatternMarkAPICall.assignment = this.model.currentAssignment;
					postPatternMarkAPICall.mhz = this.model.currentMHzMidpoint;
					postPatternMarkAPICall.category = categoryName;
					postPatternMarkAPICall.execute();
				}
			}
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
		
		
		
		// Public methods
		
		
		/** Return the rectangle of the entire skin, for AIR authentication.
		 */
		
		public function getWebViewRegion():Rectangle {
			return this.getBounds(this.stage);
		}
	}
}