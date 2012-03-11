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
package  
{
	
	// --------------------------------------
	// Imports
	// --------------------------------------
	import com.rmc.projects.flyergamestarlingoop.movieclips.Enemy;
	import com.rmc.projects.flyergamestarlingoop.movieclips.Flyer;
	
	import flash.display.Sprite;
	
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.extensions.ParticleDesignerPS;
	import starling.extensions.ParticleSystem;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	import textureAtlas.DynamicAtlas;
	
	// --------------------------------------
	// Class
	// --------------------------------------
	/**
	 * <p>The <code>AssetManager</code> class is designed to embed assets and provide access.</p>
	 * 
	 */
	public class AssetManager
	{
		
		// --------------------------------------
		// Properties
		// --------------------------------------
		
		// PUBLIC
		
		// *******************
		//  Visual
		// *******************
		/**
		 * EMBED: 
		 */		
		[Embed(source = '../assets_compiletime/fla/FlyerGameStarlingOOP_Assets_v1.swf', symbol = "BackgroundMC")] 
		public static var BackgroundMC:Class;
		
		/**
		 * EMBED: 
		 */		
		[Embed(source = '../assets_compiletime/fla/FlyerGameStarlingOOP_Assets_v1.swf', symbol = "FlyerMC")] 
		public static var FlyerMC:Class;
		
		/**
		 * EMBED: 
		 */		
		[Embed(source = '../assets_compiletime/fla/FlyerGameStarlingOOP_Assets_v1.swf', symbol = "BlimpMC")] 
		public static var BlimpMC:Class;
		
		/**
		 * EMBED: 
		 */		
		[Embed(source = '../assets_compiletime/fla/FlyerGameStarlingOOP_Assets_v1.swf', symbol = "BiplaneMC")] 
		public static var BiplaneMC:Class;
		
		
		
		
		// *******************
		//  Particles - Created with http://onebyonedesign.com/flash/particleeditor/
		// *******************
		/**
		 * EMBED: The data for the particle system. Complex settings for the #, direction, color, etc... of the particles 
		 */	
		[Embed(source="../assets_compiletime/data/particle.pex", mimeType="application/octet-stream")]
		private static const ParticleDataFile:Class;
		
		/**
		 * EMBED: 
		 */		
		[Embed(source = '../assets_compiletime/fla/FlyerGameStarlingOOP_Assets_v1.swf', symbol = "CloudMC")] 
		public static var CloudMC:Class;
		
		
		// *******************
		//  Audio
		// *******************
		
		/**
		 * EMBED: 
		 */		
		[Embed(source = '../assets_compiletime/fla/FlyerGameStarlingOOP_Assets_v1.swf', symbol = "WinGameSound")] 
		public static var WinGameSound:Class;
		
		/**
		 * EMBED: 
		 */		
		[Embed(source = '../assets_compiletime/fla/FlyerGameStarlingOOP_Assets_v1.swf', symbol = "LoseGameSound")] 
		public static var LoseGameSound:Class;
		
		/**
		 * EMBED: 
		 */		
		[Embed(source = '../assets_compiletime/fla/FlyerGameStarlingOOP_Assets_v1.swf', symbol = "MoveFlyerSound")] 
		public static var MoveFlyerSound:Class;
		
		// *******************
		//  Fonts
		// *******************
		
		/**
		 * EMBED: 
		 */		
		[Embed(source = '../assets_compiletime/fla/FlyerGameStarlingOOP_Assets_v1.swf', symbol = "MyriadProFont")] 
		public static var MyriadProFont:Class;
		
		
		
		// --------------------------------------
		// Methods
		// --------------------------------------
		// PUBLIC STATIC
		/**
		 * Create a MovieClip using the fantastic DynamicTextureAtlasGenerator from VECTOR Source
		 *  
		 * @param aClass source that has been linked from embedded swf
		 * 
		 * @return the created clip
		 * 
		 */
		public static function getNewStarlingMovieClipFromClass (aSourceClass : Class, aDestinationClass : Class, aMargin_uint : uint = 0) : *
		{
			
			//	WE RECREATE A TEXTATLAS FOR *EVERY* CALL (OF THE SAME OBJECT TOO). THIS IS INEFFICIENT. BUT ITS OK FOR NOW.
			var destinationInstance : *;
			try {
				
				// 1. Setup Properties
				var assets_vector_class:Vector.<Class> = new Vector.<Class> ();
				
				//
				assets_vector_class.push (aSourceClass); 	//WARNING - MUST HAVE 2+ 
				//FRAMES TO AVOID ERRORS
				
				//
				var scaleFactor_num:Number 			= 1;			//DEFAULT
				var margin_uint:int					= aMargin_uint;	//0 == DEFAULT
				var preserveColor_boolean:Boolean 	= true;			//DEFAULT
				var checkBounds_boolean:Boolean 	= false;		//DEFAULT
				
				// 2. Create Atlas From VectorClass
				var myTextureAtlas : TextureAtlas = DynamicAtlas.fromClassVector (	
					assets_vector_class, 
					scaleFactor_num,
					margin_uint,
					preserveColor_boolean, 
					checkBounds_boolean);
				
				// 3. Create MovieClip From Atlas
				var framesPerSecond_uint:int		= 12;		//DEFAULT
				destinationInstance = new aDestinationClass ( myTextureAtlas.getTextures(), framesPerSecond_uint);
				
				
			} catch (e:Error) {
				
				trace ("ERROR");
				trace (	"There was an error in the creation of the texture Atlas. ");
				trace (	"Please check if the dimensions of your clip exceeded the maximun ");
				trace (	"allowed texture size.");
				trace ("[[ " + e.message + " ]]");
				
			}
			
			
			return destinationInstance;
			
		}
		
		
		/**
		 * Create a texture (for use in particle systems)
		 *  
		 * @param aClass source that has been linked from embedded swf
		 * @param aFrameNumber_uint
		 * 
		 * @return texture
		 * 
		 */
		public static function getNewTextureFromClass (aClass : Class, aFrameNumber_uint : uint) : Texture
		{
			
			//	WE RECREATE A TEXTATLAS FOR *EVERY* CALL (OF THE SAME OBJECT TOO). THIS IS INEFFICIENT. BUT ITS OK FOR NOW.
			var texture : Texture;
			try {
				
				// 1. Setup Properties
				var assets_vector_class:Vector.<Class> = new Vector.<Class> ();
				
				//
				assets_vector_class.push (aClass); 	//WARNING - MUST HAVE 2+ 
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
					checkBounds_boolean);
				
				// 3. Create MovieClip From Atlas
				var framesPerSecond_uint:int		= 12;		//DEFAULT
				texture = myTextureAtlas.getTextures()[aFrameNumber_uint]
				
				
				
			} catch (e:Error) {
				
				trace ("ERROR");
				trace (	"There was an error in the creation of the texture Atlas. ");
				trace (	"Please check if the dimensions of your clip exceeded the maximun ");
				trace (	"allowed texture size.");
				trace ("[[ " + e.message + " ]]");
				
			}
			
			
			return texture;
			
		}

		
		
		/**
		 *
		 * 	Create a one-cloude particle system 
		 * 
		 * @param aX_num
		 * @param aY_num
		 * @param aRotation_num
		 * @return 
		 * 
		 */		
		public static function createExhaustCloudParticleSystem (aHost_movieclip : MovieClip, aRotation_num : Number) : ParticleSystem
		{
			//WE ARE CREATING AN ENTIRE SYSTEM FOR EACH PARTICLE, THIS IS INEFFICIENT, THAT IS OK FOR NOW
			
			
			var particleSystem : ParticleSystem;
			
			//	PROPERTIES
			var texture				: Texture 	= AssetManager.getNewTextureFromClass (AssetManager.CloudMC, 1);		
			var particleDataFile	:XML 		= XML(new ParticleDataFile());
			particleSystem				 		= new ParticleDesignerPS(particleDataFile, texture);
			particleSystem.rotation = aRotation_num;

			//	EVENTS
			particleSystem.addEventListener(Event.COMPLETE, function (aEvent : Event): void 
			{
				//NOT SURE IF THIS WORKS, BUT I SEE MEMORY IS NOT *OBVIOUSLY* LEAKING
				//WHEN I HAD MANY EMITTERS. FOR NOW I JUST HAVE A FEW, PERMANENT EMITTERS
				particleSystem.removeFromParent(true);
			});
			
			//	EVENTS
			particleSystem.addEventListener(Event.ENTER_FRAME, function (aEvent : Event): void 
			{
				//	POSITION BEHIND THE TAIL OF THE PLANE
				particleSystem.x = aHost_movieclip.x + 10*Math.sin(aRotation_num);
				particleSystem.y = aHost_movieclip.y + aHost_movieclip.height/2;
			});
			
			//	START
			Starling.juggler.add(particleSystem);
			particleSystem.start();
			
			
			//
			return particleSystem;
			
		}
		
		
		/**
		 * Play Sound
		 *  
		 */
		private static function _PlaySound (aSoundClass : Class) : void
		{
			//WE RE-CREATE THE SOUND BEFORE EVERY PLAY - THIS IS NOT VERY EFFICIENT. THAT'S OK FOR NOW.
			var sound:* = new aSoundClass();
			sound.play();
		}
		
		/**
		 * Play Sound
		 *  
		 */
		public static function PlayWinGameSound () : void
		{
			AssetManager._PlaySound (WinGameSound);
		}
		
		/**
		 * Play Sound
		 *  
		 */
		public static function PlayLoseGameSound () : void
		{
			AssetManager._PlaySound (LoseGameSound);
		}
		
		/**
		 * Play Sound
		 *  
		 */
		public static function PlayMoveFlyerSound () : void
		{
			AssetManager._PlaySound (MoveFlyerSound);
		}
		
	}
}
