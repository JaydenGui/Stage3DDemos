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
package  com.rmc.projects.flyergamestarlingoop.movieclips
{
	
	// --------------------------------------
	// Imports
	// --------------------------------------
	import com.rmc.projects.flyergamestarlingoop.Game;
	
	import flash.geom.Point;
	import flash.ui.Keyboard;
	
	import starling.animation.Juggler;
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.textures.Texture;
	
	
	
	// --------------------------------------
	// Metadata
	// --------------------------------------
	
	
	// --------------------------------------
	// Class
	// --------------------------------------
	/**
	 * <p>The <code>ClassTemplate</code> class is ...</p>
	 * 
	 */
	public class Flyer extends Mover
	{
		
		// --------------------------------------
		// Properties
		// --------------------------------------
		// PUBLIC GETTER/SETTERS
		
		// PUBLIC CONST
		
		// PRIVATE
		/**
		 * TWEEN:  
		 */		
		private var _doMoveByTween:Tween;
		
		/**
		 * KEYS: Prevent holding down keys to move
		 */		
		private var _isKeyDown_boolean:Boolean;
		
		//	PRIVATE STATIC
		/**
		 * MOVEMENT
		 */		
		private static const PIXELS_PER_MOVEMENT : uint = 40;
		
		// --------------------------------------
		// Constructor
		// --------------------------------------
		
		/**
		 * This is the constructor.
		 * 
		 */
		public function Flyer(aTextures_vector_texture:Vector.<Texture>, aFramesPerSecond_num : Number=12)
		{
			//SUPER
			super(aTextures_vector_texture, aFramesPerSecond_num );
			
			// EVENTS
			addEventListener(Event.ADDED_TO_STAGE, _onAddedToStage);
			
			// VARIABLES
			
			// PROPERTIES
			_isKeyDown_boolean = false;
			
			// METHODS
			
		}
		
		
		// --------------------------------------
		// Methods
		// --------------------------------------
		// PUBLIC
		
		// PRIVATE
		/**
		 * Handles the Event: <code>Event.ADDED_TO_STAGE</code>.
		 * 
		 * @param aEvent <code>Event</code> The incoming aEvent payload.
		 *  
		 * @return void
		 * 
		 */
		private function _doMoveBy(aOffset_point : Point) : void 
		{
			//IDEALLY I WOULD CREATE THE TWEEN ONLY ONE TIME, BUT STARLING AUTO-DESTROYS THE TWEEN UPON COMPLETE
			//THIS IS INEFFCIENT, I POSTED ON THE FORUM. FOR NOW ITS OK.
			_doMoveByTween = new Tween (this, .2, Transitions.EASE_OUT);
			_doMoveByTween.moveTo(x + aOffset_point.x, y + aOffset_point.y);
			Starling.juggler.add(_doMoveByTween);
			
			//PLAY SOUND
			AssetManager.PlayMoveFlyerSound();
			
		}
		
		
		// --------------------------------------
		// Event Handlers
		// --------------------------------------
		/**
		 * Handles the Event: <code>Event.ADDED_TO_STAGE</code>.
		 * 
		 * @param aEvent <code>Event</code> The incoming aEvent payload.
		 *  
		 * @return void
		 * 
		 */
		private function _onAddedToStage(aEvent:Event) : void 
		{
			stage.addEventListener(KeyboardEvent.KEY_DOWN, _onKeyboardKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, _onKeyboardKeyUp);
			
		}
		
		/**
		 * Handles the Event: <code>KeyboardEvent.KEY_DOWN</code>.
		 * 
		 * @param aEvent <code>KeyboardEvent</code> The incoming aEvent payload.
		 *  
		 * @return void
		 * 
		 */
		private function _onKeyboardKeyDown(aEvent:KeyboardEvent) : void 
		{
			//REACT TO 4 ARROW KEYS (PREVENT HOLDING DOWN KEY)
			if (!_game.isPaused && _isKeyDown_boolean == false) {
				
				_isKeyDown_boolean = true;
				
				if (aEvent.keyCode == Keyboard.UP) {
					_doMoveBy (new Point (0, - PIXELS_PER_MOVEMENT));
				} else if (aEvent.keyCode == Keyboard.DOWN) {
					_doMoveBy (new Point (0, PIXELS_PER_MOVEMENT));
				} else if (aEvent.keyCode == Keyboard.LEFT) {
					_doMoveBy (new Point (-PIXELS_PER_MOVEMENT, 0));
				} else if (aEvent.keyCode == Keyboard.RIGHT) {
					_doMoveBy (new Point (PIXELS_PER_MOVEMENT, 0));
				} 
				
				
				//WIN WHEN YOU REACH THE TOP OF SCREEN
				if (y < Game.Y_FOR_VICTORY) {
					_game.youWin();
				}
				
				//ANIMATE A LITTLE
				currentFrame = 0;
				
			}
			
			//MUST WORK, EVEN AFTER THE GAME IS OVER
			if (aEvent.keyCode == Keyboard.SPACE) {
				_game.doSetup();
			}
		}
		
		
		/**
		 * Handles the Event: <code>KeyboardEvent.KEY_UP</code>.
		 * 
		 * @param aEvent <code>KeyboardEvent</code> The incoming aEvent payload.
		 *  
		 * @return void
		 * 
		 */
		private function _onKeyboardKeyUp(aEvent:KeyboardEvent) : void 
		{
			//PREVENT HOLDING KEY TO MOVE
			if (_isKeyDown_boolean == true) {
				_isKeyDown_boolean = false;
				//REACT TO 4 ARROW KEYS
				if (!_game.isPaused) {
					//ANIMATE A LITTLE
					currentFrame = 1;
				}
			}
		};
		
		
		
	}
}

