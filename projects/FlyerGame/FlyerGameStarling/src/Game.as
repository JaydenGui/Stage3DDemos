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
	import flash.events.KeyboardEvent;
	
	import flashx.textLayout.accessibility.TextAccImpl;
	
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	
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
		/**
		 *	TEXTFIELD :  
		 */		
		private var _score_textfield : TextField
		
		/**
		 *	MOVIECLIP :  
		 */		
		private var _backgroundMC : MovieClip;
		
		/**
		 *	MOVIECLIP :  
		 */		
		private var _flyerMC : MovieClip;
		
		/**
		 *	MOVIECLIP :  
		 */		
		private var _blimp1MC : MovieClip;
		
		/**
		 *	MOVIECLIP :  
		 */		
		private var _blimp2MC : MovieClip;
		
		/**
		 *	MOVIECLIP :  
		 */		
		private var _biplane1MC : MovieClip;
		
		/**
		 *	MOVIECLIP :  
		 */		
		private var _biplane2MC : MovieClip;
		
		
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
			
			// VARIABLES
			
			// PROPERTIES
			
			// METHODS
			
			
			
		}
		
		// --------------------------------------
		// Methods
		// --------------------------------------
		//	PUBLIC
		
		
		//	PRIVATE
		/**
		 * SETUP : 
		 * 
		 */	
		private function _doSetup () : void
		{
			//SETUP - WE BREAK THIS UP TO MATCH OTHER VERSIONS OF THIS GAME I CREATED
			// http://www.rivellomultimediaconsulting.com/flyergame-for-html5/
			_doSetupStage();
			_doSetupSprites();
			_doApplyEffects();
			_doSetupGameLoop();
			_doStartGameplay();
		}
		
		/**
		 * SETUP : 
		 * 
		 */	
		private function _doSetupStage () : void
		{
			// SCORE
			var width_int 		: int 		= 300; 
			var height_int 		: int 		= 200; 
			var text_str		: String 	= ""; 
			var fontName_str 	: String 	= "Verdana";	//DEFAULT
			var fontSize_num	: Number  	= 12;			//DEFAULT
			var color_uint		: uint 		= 0;			//DEFAULT
			var isBold_boolean	: Boolean   = false; 		//DEFAULT
			_score_textfield = new TextField (	width_int, height_int, text_str, fontName_str, 
												fontSize_num, color_uint, isBold_boolean);
			addChild(_score_textfield);
			
			trace (stage);
			// EVENTS
			//stage.addEventListener(KeyboardEvent.KEY_DOWN,  _onKeyboardKeyDown)
			//stage.addEventListener(KeyboardEvent.KEY_UP, 	_onKeyboardKeyUp)
		}
		
		/**
		 * SETUP : 
		 * 
		 */	
		private function _doSetupSprites () : void
		{
			
			//	CREATE BACKGROUND
			_backgroundMC = AssetManager.getNewStarlingMovieClipFromClass (AssetManager.BackgroundMC);
			_backgroundMC.x = 0;
			_backgroundMC.y = 0;
			addChild(_backgroundMC);
			
			//	CREATE FLYER
			_flyerMC = AssetManager.getNewStarlingMovieClipFromClass (AssetManager.FlyerMC);
			_flyerMC.x = 250;
			_flyerMC.y = 525;
			addChild(_flyerMC);
			
			//	CREATE BLIMPS
			_blimp1MC = AssetManager.getNewStarlingMovieClipFromClass (AssetManager.BlimpMC);
			_blimp1MC.x = 650;
			_blimp1MC.y = 120;
			addChild(_blimp1MC);
			
			_blimp2MC = AssetManager.getNewStarlingMovieClipFromClass (AssetManager.BlimpMC);
			_blimp2MC.x = 300;
			_blimp2MC.y = 350;
			_blimp2MC.scaleX = -1;
			addChild(_blimp2MC);
			
			//	CREATE BIPLANES
			_biplane1MC = AssetManager.getNewStarlingMovieClipFromClass (AssetManager.BiplaneMC);
			_biplane1MC.x = 200;
			_biplane1MC.y = 210;
			addChild(_biplane1MC);
			
			_biplane1MC = AssetManager.getNewStarlingMovieClipFromClass (AssetManager.BiplaneMC);
			_biplane1MC.x = 550;
			_biplane1MC.y = 420;
			_biplane1MC.scaleX = -1;
			addChild(_biplane1MC);
			
		}
		
		/**
		 * SETUP : 
		 * 
		 */	
		private function _doApplyEffects () : void
		{
			//
			
		}
		
		/**
		 * SETUP : 
		 * 
		 */	
		private function _doSetupGameLoop () : void
		{
			//
			
		}
		
		
		/**
		 * SETUP : 
		 * 
		 */	
		private function _doStartGameplay () : void
		{
			//
			
		}
		
		
		/**
		 * SETUP : 
		 * 
		 */	
		private function _setScore (aScore_uint : uint) : void
		{
			//
			_score_textfield.text = "Score: " + aScore_uint;
			
		}
		
		/**
		 * GAME END : Victory
		 * 
		 * Show 'You Win' and clean up the screen
		 * 
		 */	
		private function _youWin() : void {
			
			//MESSAGE
			trace("You Won the Game!");
			
			//SET SCORE
			_setScore (100);
			
			//PLAY SOUND
			AssetManager.PlayWinGameSound();
			
			//END GAME, STOP LISTENING TO EVENTS
			_doEndGameCleanUp();
			
		}
		
		/**
		 * GAME END : Loss
		 * 
		 * Show 'You Lose' and clean up the screen
		 * 
		 */	
		private function _youLose() : void {
			
			//MESSAGE
			trace("You Lost the Game!");
			
			//SET SCORE
			_setScore (-100);
			
			//PLAY SOUND
			AssetManager.PlayLoseGameSound();
			
			//END GAME
			_doEndGameCleanUp();
		}
		
		
		
		/**
		 * GAME END
		 * 
		 * Clean up the screen
		 * 
		 */	
		private function _doEndGameCleanUp() : void {
			
			//END GAME
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, _onKeyboardKeyDown)
			stage.removeEventListener(KeyboardEvent.KEY_UP, _onKeyboardKeyUp)
			//_biplane1MC.removeEventListener	(Event.ENTER_FRAME, moveRight);
			//_biplane2MC.removeEventListener	(Event.ENTER_FRAME, moveRight);
			//_blimp1MC.removeEventListener	(Event.ENTER_FRAME, moveLeft);
			//_blimp2MC.removeEventListener	(Event.ENTER_FRAME, moveLeft);
		}
		
		
		// --------------------------------------
		// EVENTS
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
			//	SETUP
			_doSetup();
			
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
			
			//REACT TO 4 ARROW KEYS
			/*
			if (event.keyCode == Keyboard.UP) {
			flyer_mc.y = flyer_mc.y - 30;
			playMoveFlyerSound();
			} else if (event.keyCode == Keyboard.DOWN) {
			flyer_mc.y = flyer_mc.y + 30;
			playMoveFlyerSound();
			} else if (event.keyCode == Keyboard.LEFT) {
			flyer_mc.x = flyer_mc.x - 30;
			playMoveFlyerSound();
			} else if (event.keyCode == Keyboard.RIGHT) {
			flyer_mc.x = flyer_mc.x + 30;
			playMoveFlyerSound();
			}
			
			//WIN WHEN YOU REACH THE TOP OF SCREEN
			if (flyer_mc.y < 30) {
			youWin();
			}
			
			//ANIMATE A LITTLE
			flyer_mc.gotoAndStop(1);
			*/
		};
		
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
			
			//ANIMATE A LITTLE
			//flyer_mc.gotoAndStop(2);
		};
		
		
		
		
	}
}
