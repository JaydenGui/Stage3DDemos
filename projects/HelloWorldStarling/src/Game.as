/**
 * Copyright (C) 2005-2012 by Rivello Multimedia Consulting (RMC).                    
 * code [at] RivelloMultimediaConsulting [dot] com                                                  
 *                                                                      
 * Permission is hereby granted, free of charge, to any person obtaining
 * a copy of this software and associated documentation files (the      
 * "Software"), to deal in the Software without restriction, including  
 * without limitation the rights to use, copy, modify, merge, publish,  
 * distribute, sublicense, and#or sell copies of the Software, and to   
 * permit persons to whom the Software is furnished to do so, subject to
 * the following conditions:                                            
 *                                                                      
 * The above copyright notice and this permission notice shall be       
 * included in all copies or substantial portions of the Software.      
 *                                                                      
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,      
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF   
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
 * IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR    
 * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
 * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 * OTHER DEALINGS IN THE SOFTWARE.                                      
 */
//Marks the right margin of code *******************************************************************
package {
	
	// --------------------------------------
	// Imports
	// --------------------------------------
	import flash.display.Bitmap;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	import textureAtlas.DynamicAtlas;
	
	// --------------------------------------
	// Class
	// --------------------------------------
	/**
	 * <p>The <code>Game</code> class.</p>
	 * 
	 */
	public class Game extends Sprite{
		
		// --------------------------------------
		// Properties
		// --------------------------------------
		// PUBLIC GETTER/SETTERS
		
		// PUBLIC CONST
		
		// PRIVATE
		
		// --------------------------------------
		// Constructor
		// --------------------------------------
		/**
		 * This is the constructor.
		 * 
		 */
		public function Game(){
			
			// SUPER
			super();
			
			// EVENTS
			addEventListener(Event.ADDED_TO_STAGE, _onAddedToStage);
			
			
		}
		
		
		// --------------------------------------
		// Events
		// --------------------------------------
		/**
		 * Handles the Event: <code>Event.ADDED_TO_STAGE</code>.
		 * 
		 * @param aEvent <code>Event</code> The incoming aEvent payload.
		 *  
		 * @return void
		 * 
		 */	
		private function _onAddedToStage (aEvent : Event) : void
		{
			// Method 1 - Quad
			_doRender_Quad();
			
			// Method 2 - Image
			_doRender_Image();
			
			// Method 3 - SWF Symbol
			_doRender_FromEmbeddedSWFSymbol();
			
			// Method 1 - Text
			_doRender_Text();
		}
			
		
		// --------------------------------------
		// Methods
		// --------------------------------------
		/**
		 * RENDER: Quad
		 * 
		 */		
		private function _doRender_Quad () : void
		{
			
			// CREATE OBJECT
			var quad : Quad = new Quad(650, 400, 0xf7f7fff);
			
			//	POSITION
			quad.x = 75;
			quad.y = 170;
			
			// ADD TO STAGE
			addChild(quad);
			
			
		}
		
		
		
		/**
		 * RENDER: Image
		 * 
		 */	
		private function _doRender_Image () : void
		{
			
			// CREATE OBJECT
			var rmcLOGO_bitmap	: Bitmap 	= new AssetManager.RMC_LOGO();
			var rmcLOGO_texture	: Texture 	= Texture.fromBitmap(rmcLOGO_bitmap);
			var rmcLOGO_image	: Image 	= new Image(rmcLOGO_texture);
			
			//	POSITION
			rmcLOGO_image.x = 100;
			rmcLOGO_image.y = 225;
			
			// ADD TO STAGE
			addChild(rmcLOGO_image);
			
			
		}
		
		
		/**
		 * Render: Dynamic Atlas From Source: An Embedded MovieClip Symbol From SWF
		 * 
		 * This is totally awesome. Now I can keep my graphics as vectors. 
		 * 
		 */	
		private function _doRender_FromEmbeddedSWFSymbol () : void
		{
			
			try {
				
				// 1. Setup Properties
				var assets_vector_class:Vector.<Class> = new Vector.<Class> ();
				
				//
				assets_vector_class.push (AssetManager.BoyAndDogRunning); 	//WARNING - MUST HAVE 2+ 
																			//FRAMES TO AVOID ERRORS
				
				//
				var scaleFactor_num:Number 			= 1;		//DEFAULT
				var margin_uint:int					= 0;		//DEFAULT
				var preserveColor_boolean:Boolean 	= true;		//DEFAULT
				var checkBounds_boolean:Boolean 	= false;	//DEFAULT
				
				// 2. Create Atlas From VectorClass
				var myTextureAtlas : TextureAtlas = DynamicAtlas.fromClassVector (	
					assets_vector_class, 
					scaleFactor_num,
					margin_uint,
					preserveColor_boolean, 
					checkBounds_boolean
				);
				
				//3. POSITION
				var myBoyAndDogRunning : MovieClip = new MovieClip ( myTextureAtlas.getTextures() , 60);
				myBoyAndDogRunning.x = 425 
				myBoyAndDogRunning.y = 350;
				
				
				//4. ADD TO STAGE
				addChild(myBoyAndDogRunning);
				Starling.juggler.add(myBoyAndDogRunning);
				
				
				
			} catch (e:Error) {
				
				trace ("ERROR");
				trace (	"There was an error in the creation of the texture Atlas. ");
				trace (	"Please check if the dimensions of your clip exceeded the maximun ");
				trace (	"allowed texture size.");
				trace ("[[ " + e.message + " ]]");
				
			}
			
		}
		
		
		/**
		 * Render: Text
		 * 
		 */	
		private function _doRender_Text () : void
		{
			
			// 1. CREATE OBJECT
			var textField1 : TextField = new TextField (100, 100, "Quad", "Verdana", 20, 0x000000, true);
			
			//	POSITION
			textField1.x = 360;
			textField1.y = 90;
			
			// ADD TO STAGE
			addChild(textField1);
			
			
			
			// 2. CREATE OBJECT
			var textField2 : TextField = new TextField (100, 100, "Image", "Verdana", 20, 0x000000, true);
			
			//	POSITION
			textField2.x = 200;
			textField2.y = 150;
			
			// ADD TO STAGE
			addChild(textField2);
			
			
			
			// 3. CREATE OBJECT
			var textField3 : TextField = new TextField (100, 100, "Vector", "Verdana", 20, 0x000000, true);
			
			//	POSITION
			textField3.x = 510;
			textField3.y = 260;
			
			// ADD TO STAGE
			addChild(textField3);
			
		}
		
		
		
	}
}
