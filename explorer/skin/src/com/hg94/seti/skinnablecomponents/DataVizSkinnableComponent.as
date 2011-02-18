package com.hg94.seti.skinnablecomponents
{
	/* For guidance on writing an ActionScript Skinnable Component please refer to the Flex documentation: 
	www.adobe.com/go/actionscriptskinnablecomponents */
	
	import components.ControlBarSkin;
	
	import mx.binding.utils.BindingUtils;
	import mx.events.FlexEvent;
	
	import spark.components.RichText;
	import spark.components.supportClasses.SkinnableComponent;
	
	
	/* A component must identify the view states that its skin supports. 
	Use the [SkinState] metadata tag to define the view states in the component class. 
	[SkinState("normal")] */
	
	public class DataVizSkinnableComponent extends SkinnableComponent
	{
		[SkinPart(required="false")]
		public var controlBar:ControlBarSkinnableComponent;
		
		[SkinPart(required="true")]
		public var starNameText:RichText;
		
		[SkinPart(required="true")]
		public var targetDescriptionField:RichText;
		[SkinPart(required="true")]
		public var observationDateField:RichText;
		[SkinPart(required="true")]
		public var observationFrequencyField:RichText;
		[SkinPart(required="true")]
		public var observationCoordinatesField:RichText;
		
		
		public var targetName:String;
		public var targetDescription:String;
		public var observationDate:String;
		public var observationFrequency:String;
		public var observationCoordinates:String;
				
		public function DataVizSkinnableComponent()
		{
			//TODO: implement function
			super();
			this.addEventListener(FlexEvent.CREATION_COMPLETE, this.creationCompleteHandler);
		}
		
		private function creationCompleteHandler(event:FlexEvent):void {
			BindingUtils.bindProperty(this.starNameText, "text", this, "targetName");
			BindingUtils.bindProperty(this.targetDescriptionField, "text", this, "targetDescription");
			BindingUtils.bindProperty(this.observationDateField, "text", this, "observationDate");
			//BindingUtils.bindProperty(this.observationFrequencyField, "text", this, "observationFrequency");
			BindingUtils.bindProperty(this.observationCoordinatesField, "text", this, "observationCoordinates");
			
			
		} 
		
		/* Implement the getCurrentSkinState() method to set the view state of the skin class. */
		override protected function getCurrentSkinState():String
		{
			return super.getCurrentSkinState();
		} 
		
		/* Implement the partAdded() method to attach event handlers to a skin part, 
		configure a skin part, or perform other actions when a skin part is added. */	
		override protected function partAdded(partName:String, instance:Object) : void
		{
			super.partAdded(partName, instance);
		}
		
		/* Implement the partRemoved() method to remove the even handlers added in partAdded() */
		override protected function partRemoved(partName:String, instance:Object) : void
		{
			super.partRemoved(partName, instance);
		}
		
	}
}