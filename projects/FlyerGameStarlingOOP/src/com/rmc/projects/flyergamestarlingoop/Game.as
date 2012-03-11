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
package com.rmc.projects.flyergamestarlingoop {
	
	// --------------------------------------
	// Imports
	// --------------------------------------
	
	import com.rmc.projects.flyergamestarlingoop.movieclips.Biplane;
	import com.rmc.projects.flyergamestarlingoop.movieclips.Blimp;
	import com.rmc.projects.flyergamestarlingoop.movieclips.Flyer;
	
	import flash.text.Font;
	
	import flashx.textLayout.formats.TextAlign;
	
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.extensions.ParticleSystem;
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
		/**
		 *  
		 */		
		private var _isPaused_boolean : Boolean;
		public function get isPaused () 					: Boolean 	{ return _isPaused_boolean; }
		public function set isPaused (aValue : Boolean) 	: void 		{ _isPaused_boolean = aValue; }
		
		// PUBLIC CONST
		/**
		 *  DIMENSIONS: 
		 */	
		public static const Y_FOR_VICTORY : uint = 30;
		
		/**
		 *  DIMENSIONS: 
		 */	
		public static const WIDTH : uint = 800;
		
		/**
		 *  DIMENSIONS: 
		 */	
		public static const HEIGHT : uint = 600;
		
		
		
			
		
		// PRIVATE
		/**
		 *	TEXTFIELD :  
		 */		
		private var _score_textfield : TextField
		
		/**
		 *	TEXTFIELD :  
		 */		
		private var _instructions_textfield:TextField;
		
		/**
		 *	MOVIECLIP :  
		 */		
		private var _backgroundMC : MovieClip;
		
		/**
		 *	MOVIECLIP :  
		 */		
		public var flyer : Flyer;
		
		/**
		 *	MOVIECLIP :  
		 */		
		private var _blimp1MC : Blimp;
		
		/**
		 *	MOVIECLIP :  
		 */		
		private var _blimp2MC : Blimp;
		
		/**
		 *	MOVIECLIP :  
		 */		
		private var _biplane1MC : Biplane;
		
		/**
		 *	MOVIECLIP :  
		 */		
		private var _biplane2MC : Biplane;
		
		/**
		 *	PARTICLE SYSTEM :  
		 */		
		private var _particleSystem1:ParticleSystem;
		
		/**
		 *	PARTICLE SYSTEM :  
		 */		
		private var _particleSystem2:ParticleSystem;
		
		
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
		/**
		 * SETUP : This creates the whole Game layout.
		 * 
		 * 	RESTART: I do quite a bit of work to allow for 'restarting the game'. It works well. Press Spacebar during gameplay.
		 * 			**Removing listeners and objects from the stage
		 * 			**Ensuring there are no duplicate objects (visuals, listeners, etc...)
		 * 
		 * 	UPDATE: While my technique is good and educational, I now thing it would be easer
		 * 			to simply tell Startup.as to remove and reattach the whole game. (maybe or would listeners still exist). TBD...
		 * 
		 */	
		public function doSetup () : void
		{
			
			//SETUP - WE BREAK THIS UP TO MATCH OTHER VERSIONS OF THIS GAME I CREATED
			// http://www.rivellomultimediaconsulting.com/flyergame-for-html5/
			_isPaused_boolean = false;
			Starling.current.start();
			_doSetupStage();
			_doSetupSprites();
			_doApplyEffects();
			_doSetupGameLoop();
			_doStartGameplay();
		}
		
		//	PRIVATE
		/**
		 * SETUP : 
		 * 
		 */	
		private function _doSetupStage () : void
		{
			
			// FONT
			var myriadProFont: Font = new AssetManager.MyriadProFont();
			
			// SCORE
			var width_int 		: int 		= 300; 
			var height_int 		: int 		= 80; 
			var text_str		: String 	= ""; 
			var fontName_str 	: String 	= myriadProFont.fontName;	//"Verdana" = DEFAULT
			var fontSize_num	: Number  	= 40;			//DEFAULT
			var color_uint		: uint 		= 0;			//DEFAULT
			var isBold_boolean	: Boolean   = false; 		//DEFAULT
			_score_textfield = new TextField (	width_int, height_int, text_str, fontName_str, 
				fontSize_num, color_uint, isBold_boolean); //add to stage later ('above' the z of the background)
			_score_textfield.hAlign = TextAlign.LEFT;
			_score_textfield.x = 120;
			_score_textfield.y = 10;
			
			
			//INSTRUCTIONS
			_instructions_textfield = new TextField (270, 80, "", myriadProFont.fontName, 14);
			_instructions_textfield.hAlign = TextAlign.LEFT;
			_instructions_textfield.vAlign = "top";
			_instructions_textfield.x = 510;
			_instructions_textfield.y = 15;
			_instructions_textfield.text = "Use the arrow keys to move. Reach the top to win. Hit an enemy to lose. Use spacebar anytime to restart."
			
			// EVENTS
			if (stage.hasEventListener(KeyboardEvent.KEY_DOWN)) {
				stage.removeEventListeners(KeyboardEvent.KEY_DOWN);
			}
			if (stage.hasEventListener(KeyboardEvent.KEY_UP)) {
				stage.removeEventListeners(KeyboardEvent.KEY_UP);
			}
			
			// SCORE
			_setScore(0);
		}
		
		/**
		 * SETUP : 
		 * 
		 */	
		private function _doSetupSprites () : void
		{
			
			//REMOVE LISTENERS (IF WE ARE RESTARTING)
			if (flyer && flyer.hasEventListener(Event.ENTER_FRAME) ) {
				flyer.removeEventListeners(Event.ENTER_FRAME);
			}
			
			if (_blimp1MC && _blimp1MC.hasEventListener(Event.ENTER_FRAME) ) {
				_blimp1MC.removeEventListeners(Event.ENTER_FRAME);
			}
			
			if (_blimp2MC && _blimp2MC.hasEventListener(Event.ENTER_FRAME) ) {
				_blimp2MC.removeEventListeners(Event.ENTER_FRAME);
			}
			
			if (_biplane1MC && _biplane1MC.hasEventListener(Event.ENTER_FRAME) ) {
				_biplane1MC.removeEventListeners(Event.ENTER_FRAME);
			}
			
			if (_biplane2MC && _biplane2MC.hasEventListener(Event.ENTER_FRAME) ) {
				_biplane2MC.removeEventListeners(Event.ENTER_FRAME);
			}
			
			//REMOVE ANY CURRENT CHILDREN
			removeChildren(0, -1, true);
			Starling.current.juggler.purge()
			
			//	CREATE BACKGROUND
			_backgroundMC = AssetManager.getNewStarlingMovieClipFromClass (AssetManager.BackgroundMC, MovieClip, -2);
			_backgroundMC.x = 0;
			_backgroundMC.y = 0;
			addChild(_backgroundMC);

			
			//	CREATE BLIMPS
			_blimp1MC = AssetManager.getNewStarlingMovieClipFromClass (AssetManager.BlimpMC, Blimp );
			_blimp1MC.x = 650;
			_blimp1MC.y = 120;
			_blimp1MC.speed = 5;
			addChild(_blimp1MC);
			
			_blimp2MC = AssetManager.getNewStarlingMovieClipFromClass (AssetManager.BlimpMC, Blimp );
			_blimp2MC.x = 700;
			_blimp2MC.y = 350;
			_blimp2MC.scaleX = -1;
			_blimp2MC.speed = -7;
			addChild(_blimp2MC);
			
			//	CREATE BIPLANES
			_biplane1MC = AssetManager.getNewStarlingMovieClipFromClass (AssetManager.BiplaneMC,  Biplane );
			_biplane1MC.x = 200;
			_biplane1MC.y = 210;
			_biplane1MC.speed = 2;
			addChild(_biplane1MC);
			
			_biplane2MC = AssetManager.getNewStarlingMovieClipFromClass (AssetManager.BiplaneMC,  Biplane );
			_biplane2MC.x = 550;
			_biplane2MC.y = 420;
			_biplane2MC.speed = -10
			_biplane2MC.scaleX = -1;
			addChild(_biplane2MC);
			
			//	CREATE FLYER
			flyer = AssetManager.getNewStarlingMovieClipFromClass (AssetManager.FlyerMC,  Flyer );
			flyer.x = 250;
			flyer.y = 525;
			addChild(flyer);
			
			//ADD TEXTFIELDS ON TOP
			addChild(_instructions_textfield);
			addChild(_score_textfield);
			
		}
		
		/**
		 * SETUP : 
		 * 
		 */	
		private function _doApplyEffects () : void
		{
			//_biplane1MC.filters = [] is NOT supported by Starling as it is in native Flash. 
			
			//However Particles are possible...
			//ADD BENEATH THE BIPLANE
			if (_particleSystem1) {
				_particleSystem1.removeFromParent(true)
			}
			if (_particleSystem2) {
				_particleSystem2.removeFromParent(true)
			}
			_particleSystem1 = AssetManager.createExhaustCloudParticleSystem (_biplane1MC, -Math.PI/2);
			addChildAt(_particleSystem1, getChildIndex(_biplane1MC));
			
			//ADD BENEATH THE BIPLANE
			_particleSystem2 = AssetManager.createExhaustCloudParticleSystem (_biplane2MC, Math.PI/2);
			addChildAt(_particleSystem2, getChildIndex(_biplane1MC));
			
			
		}	
		
		/**
		 * SETUP : 
		 * 
		 */	
		private function _doSetupGameLoop () : void
		{

		}
		
		
		/**
		 * SETUP : 
		 * 
		 */	
		private function _doStartGameplay () : void
		{
			//Starling.current.start()  IS AUTOMATICALLY CALLED BY THE API INTERNALS
			//TO STOP RENDERING -- Starling.current.stop();
			
		}
		
		
		////////////////////////////////////////////////////
		//	SCORE BOARD
		////////////////////////////////////////////////////
		/**
		 * SCORE : 
		 * 
		 */	
		private function _setScore (aScore_uint : int) : void
		{
			//
			_score_textfield.text = "Score: " + aScore_uint;
			
		}
		
		////////////////////////////////////////////////////
		//	GAME OVER STUFF
		////////////////////////////////////////////////////
		
		/**
		 * GAME END : Victory
		 * 
		 * Show 'You Win' and clean up the screen
		 * 
		 */	
		public function youWin() : void {
			
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
		public function youLose() : void {
			
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
			_isPaused_boolean = true;
			Starling.current.stop();
			Starling.juggler.remove(_particleSystem1);
			Starling.juggler.remove(_particleSystem2);
			
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
			doSetup();
			
		}
		
		
		
		
	}
}
