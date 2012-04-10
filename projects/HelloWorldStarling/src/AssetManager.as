package 
{
	public class AssetManager
	{
		
		// --------------------------------------
		//  EMBED: Image
		// --------------------------------------
		/**
		 * EMBED: 	Image
		 */		
		[Embed(source = '../assets_compiletime/images/RMC_Logo_v1.jpg')] 
		public static var RMC_LOGO:Class;
		
		// --------------------------------------
		//  EMBED: from Swf
		// --------------------------------------
		/**
		 * EMBED: 	One MovieClip From The Library Linked As 'BoyAndDogRunning'
		 */		
		[Embed(source = '../assets_compiletime/fla/HelloWorldStarling_Assets_v1.swf', symbol = "BoyAndDogRunning")] 
		public static var BoyAndDogRunning:Class;
		

		

	}
}
