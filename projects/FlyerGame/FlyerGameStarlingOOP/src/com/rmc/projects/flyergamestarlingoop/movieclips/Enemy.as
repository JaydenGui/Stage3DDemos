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
	
	import starling.display.MovieClip;
	import starling.events.Event;
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
	public class Enemy extends Mover
	{
		
		// --------------------------------------
		// Properties
		// --------------------------------------
		// PUBLIC GETTER/SETTERS
		/**
		 *  
		 */		
		private var _speed_num : Number;
		public function get speed () 					: Number 	{ return _speed_num; }
		public function set speed (aValue : Number) 	: void 		{ 
			
			
			_speed_num = aValue; 
			
			//SET AN ENTERFRAME SPECIFIC TO ITS DIRECTION (JUST AS AN EXAMPLE)
			if (hasEventListener(Event.ENTER_FRAME) ) {
				removeEventListeners(Event.ENTER_FRAME);
			}
			if (_speed_num > 0) {
				//MOVE RIGHT
				addEventListener(Event.ENTER_FRAME, _onMoveRight);
			} else {
				//MOVE LEFT
				addEventListener(Event.ENTER_FRAME, _onMoveLeft);
			}
			
		}

		/**
		 *  WIDTH: Overwrite to include smoke trail for biplanes
		 * 		   This is usefull, but mainly educational (OOP principal of overriding)
		 */		
		protected function _getWidth () 					: uint 	{ return width; }
		
		// PUBLIC CONST
		
		// PRIVATE
		
		// --------------------------------------
		// Constructor
		// --------------------------------------
		/**
		 * This is the constructor.
		 * 
		 */
		public function Enemy(aTextures_vector_texture:Vector.<Texture>, aFramesPerSecond_num : Number=12)
		{
			//SUPER
			super(aTextures_vector_texture, aFramesPerSecond_num );
			
			// EVENTS
			
			// VARIABLES
			
			// PROPERTIES

			// METHODS
			
		}
		
		
		// --------------------------------------
		// Methods
		// --------------------------------------
		// PUBLIC
		
		// PRIVATE
		
		// --------------------------------------
		// Event Handlers
		// --------------------------------------
		/**
		 * Handles the Event: <code>Event.ENTER_FRAME</code>.
		 * 
		 * @param aEvent <code>Event</code> The incoming aEvent payload.
		 *  
		 * @return void
		 * 
		 */
		private function _onMoveRight (aEvent:Event) : void 
		{
			
			//REFERENCE TO ENEMY
			var enemy_mc:MovieClip = aEvent.target as MovieClip;
			
			//MOVE THE ENEMY FORWARD
			enemy_mc.x = enemy_mc.x + 10;
			
			//RESET POSITION IF OFFSCREEN
			if (enemy_mc.x > Game.WIDTH + _getWidth()) {
				enemy_mc.x = - _getWidth();
			}
			
			//COLLISION DETECTION 'DID ENEMY HIT FLYER?'
			if (enemy_mc.getBounds(enemy_mc.parent).intersects(_game.flyer.getBounds(_game.flyer.parent)) ) {
				_game.youLose()
			}
			
		}
		/**
		 * Handles the Event: <code>Event.ENTER_FRAME</code>.
		 * 
		 * @param aEvent <code>Event</code> The incoming aEvent payload.
		 *  
		 * @return void
		 * 
		 */
		private function _onMoveLeft (aEvent:Event) : void {	
			
			//REFERENCE TO ENEMY
			var enemy_mc:MovieClip = aEvent.target as MovieClip;
			
			//MOVE THE ENEMY FORWARD
			enemy_mc.x = enemy_mc.x - 7
			
			//RESET POSITION IF OFFSCREEN
			if (enemy_mc.x < - _getWidth()) {
				enemy_mc.x = Game.WIDTH + _getWidth();
			}
			
			//COLLISION DETECTION 'DID ENEMY HIT FLYER?'
			if (enemy_mc.getBounds(enemy_mc.parent).intersects(_game.flyer.getBounds(_game.flyer.parent)) ) {
				_game.youLose()
			}
		};
		
	}
}

