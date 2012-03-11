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
	import flash.text.Font;
	import flash.ui.Keyboard;
	
	import flashx.textLayout.formats.TextAlign;
	
	import starling.animation.Juggler;
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.extensions.ParticleDesignerPS;
	import starling.extensions.ParticleSystem;
	import starling.text.TextField;
	import starling.textures.Texture;
	
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
		
		/**
		 *	PARTICLE SYSTEM :  
		 */		
		private var _particleSystem1:ParticleSystem;
		
		/**
		 *	PARTICLE SYSTEM :  
		 */		
		private var _particleSystem2:ParticleSystem;
		
		/**
		 *	PARTICLE SYSTEM :  
		 */		
		private var _isPaused_boolean:Boolean;
		
		
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
			_isPaused_boolean = false;
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
			stage.addEventListener(KeyboardEvent.KEY_DOWN,  _onKeyboardKeyDown)
			stage.addEventListener(KeyboardEvent.KEY_UP, 	_onKeyboardKeyUp)
			
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
			if (_flyerMC && _flyerMC.hasEventListener(Event.ENTER_FRAME) ) {
				_flyerMC.removeEventListeners(Event.ENTER_FRAME);
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
			_backgroundMC = AssetManager.getNewStarlingMovieClipFromClass (AssetManager.BackgroundMC);
			_backgroundMC.x = 0;
			_backgroundMC.y = 0;
			addChild(_backgroundMC);

			
			//	CREATE BLIMPS
			_blimp1MC = AssetManager.getNewStarlingMovieClipFromClass (AssetManager.BlimpMC);
			_blimp1MC.x = 650;
			_blimp1MC.y = 120;
			addChild(_blimp1MC);
			
			_blimp2MC = AssetManager.getNewStarlingMovieClipFromClass (AssetManager.BlimpMC);
			_blimp2MC.x = 700;
			_blimp2MC.y = 350;
			_blimp2MC.scaleX = -1;
			addChild(_blimp2MC);
			
			//	CREATE BIPLANES
			_biplane1MC = AssetManager.getNewStarlingMovieClipFromClass (AssetManager.BiplaneMC);
			_biplane1MC.x = 200;
			_biplane1MC.y = 210;
			addChild(_biplane1MC);
			
			_biplane2MC = AssetManager.getNewStarlingMovieClipFromClass (AssetManager.BiplaneMC);
			_biplane2MC.x = 550;
			_biplane2MC.y = 420;
			_biplane2MC.scaleX = -1;
			addChild(_biplane2MC);
			
			//	CREATE FLYER
			_flyerMC = AssetManager.getNewStarlingMovieClipFromClass (AssetManager.FlyerMC);
			_flyerMC.x = 250;
			_flyerMC.y = 525;
			addChild(_flyerMC);
			
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
			//REQUIRED FOR AUTOMATICALLY ADVANCING ITS ANIMATION FRAMES
			//Starling.juggler.add(_flyerMC); [[ WE DON'T WANT IT TO '.play()' so don't use it ]]
			
			//REQUIRED FOR MOVING (X,Y) AROUND THE SCREEN [[ WE DO WANT THAT! ]]
			//	FYI, adding ENTER_FRAME, automatically adds to the Juggler
			//
			_blimp1MC.addEventListener(Event.ENTER_FRAME, 	_moveLeft);
			_blimp2MC.addEventListener(Event.ENTER_FRAME, 	_moveRight);
			_biplane1MC.addEventListener(Event.ENTER_FRAME, _moveRight);
			_biplane2MC.addEventListener(Event.ENTER_FRAME, _moveLeft);
			
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
			_isPaused_boolean = true;
			Starling.juggler.remove(_particleSystem1);
			Starling.juggler.remove(_particleSystem2);
			_blimp1MC.removeEventListeners		(Event.ENTER_FRAME);
			_blimp2MC.removeEventListeners		(Event.ENTER_FRAME);
			_biplane1MC.removeEventListeners	(Event.ENTER_FRAME);
			_biplane2MC.removeEventListeners	(Event.ENTER_FRAME); //NOTE: removeEventListener() [without the 's'] appears to do nothing
			
			
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
			if (!_isPaused_boolean) {
				
				if (aEvent.keyCode == Keyboard.UP) {
					_flyerMC.y = _flyerMC.y - 30;
					AssetManager.PlayMoveFlyerSound();
				} else if (aEvent.keyCode == Keyboard.DOWN) {
					_flyerMC.y = _flyerMC.y + 30;
					AssetManager.PlayMoveFlyerSound();
				} else if (aEvent.keyCode == Keyboard.LEFT) {
					_flyerMC.x = _flyerMC.x - 30;
					AssetManager.PlayMoveFlyerSound();
				} else if (aEvent.keyCode == Keyboard.RIGHT) {
					_flyerMC.x = _flyerMC.x + 30;
					AssetManager.PlayMoveFlyerSound();
				} 
				
				
				//WIN WHEN YOU REACH THE TOP OF SCREEN
				if (_flyerMC.y < 30) {
					_youWin();
				}
				
				//ANIMATE A LITTLE
				_flyerMC.currentFrame = 0;
				
			}
			
			//MUST WORK, EVEN AFTER THE GAME IS OVER
			if (aEvent.keyCode == Keyboard.SPACE) {
				_doSetup();
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
			
			//ANIMATE A LITTLE
			_flyerMC.currentFrame = 1;
		};
		
		
		////////////////////////////////////////////////////
		//	ENTER_FRAME CODE
		////////////////////////////////////////////////////
		/**
		 * Handles the Event: <code>Event.ENTER_FRAME</code>.
		 * 
		 * @param aEvent <code>Event</code> The incoming aEvent payload.
		 *  
		 * @return void
		 * 
		 */
		private function _moveRight (aEvent:Event) : void 
		{
			
			//REFERENCE TO ENEMY
			var enemy_mc:MovieClip = aEvent.target as MovieClip;
			
			//MOVE THE ENEMY FORWARD
			enemy_mc.x = enemy_mc.x + 10;
			
			//RESET POSITION IF OFFSCREEN
			if (enemy_mc.x > 800) {
				enemy_mc.x = -100;
			}
			
			//COLLISION DETECTION 'DID ENEMY HIT FLYER?'
			if (enemy_mc.getBounds(enemy_mc.parent).intersects(_flyerMC.getBounds(_flyerMC.parent)) ) {
				_youLose()
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
		private function _moveLeft (aEvent:Event) : void {	
			
			//REFERENCE TO ENEMY
			var enemy_mc:MovieClip = aEvent.target as MovieClip;
			
			//MOVE THE ENEMY FORWARD
			enemy_mc.x = enemy_mc.x - 7
			
			//RESET POSITION IF OFFSCREEN
			if (enemy_mc.x < -100) {
				enemy_mc.x = 800;
			}
			
			//COLLISION DETECTION 'DID ENEMY HIT FLYER?'
			if (enemy_mc.getBounds(enemy_mc.parent).intersects(_flyerMC.getBounds(_flyerMC.parent)) ) {
				_youLose()
			}
		};
		
		
		
		
		
	}
}
