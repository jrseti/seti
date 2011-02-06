package com.hg94.seti.skinnablecomponents
{
	/* For guidance on writing an ActionScript Skinnable Component please refer to the Flex documentation: 
	www.adobe.com/go/actionscriptskinnablecomponents */
	
	import spark.components.Button;
	import spark.components.supportClasses.SkinnableComponent;
	
	
	/* A component must identify the view states that its skin supports. 
	Use the [SkinState] metadata tag to define the view states in the component class. 
	[SkinState("normal")] */
	
	public class StarfieldSkinnableComponent extends SkinnableComponent
	{
		[SkinPart(required="true")]
		public var zoomInButton:Button;
		[SkinPart(required="true")]
		public var zoomOutButton:Button;
		
		public function StarfieldSkinnableComponent()
		{
			//TODO: implement function
			super();
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