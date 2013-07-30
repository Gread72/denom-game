package com.gread.denom.view{
	/*
	GamePanel Class
	view mediator for Gamepanel = create instances for memory buttons, sounds, and graphics
	*/
	
	import com.gread.denom.view.components.MemoryButton;
	import com.gread.flash.components.ButtonComponent;
	import com.gread.flash.graphics.BoxGraphic;
	import com.gread.flash.graphics.GraphicCreator;
	import com.greensock.*;
	import com.greensock.easing.*;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import org.osflash.signals.Signal;
	
	public class GamePanel extends Sprite{
		
		public var blueBtn:MemoryButton;
		public var redBtn:MemoryButton;
		public var greenBtn:MemoryButton;
		public var yellowBtn:MemoryButton;
		
		private var _startBtn:ButtonComponent;
		private var _titleTxt:TextField = new TextField();
		private var _blocker:BoxGraphic;
		
		public var startGame:Signal;
		
		public static var STAGE_WIDTH:Number = 550;
		public static var STAGE_HEIGHT:Number = 400;
		private static var START_BTN_POS_X:Number = (STAGE_WIDTH / 2 - 200 / 2) - 40;
		private static var START_BTN_POS_Y:Number = (STAGE_HEIGHT / 2 - 30 / 2) + 5;
		
		/* constructor code */
		public function GamePanel(parent:DisplayObjectContainer){
			super();
			
			init();
			
			parent.addChild( this );
		}
		
		/* initialize function */
		private function init():void{
			
			blueBtn = new MemoryButton(0x3366FF);
			this.addChild( blueBtn );
			blueBtn.x = -60;
			blueBtn.y = -40;
			blueBtn.id = "blue";
			blueBtn.soundPath = "assets/audio/toneA.mp3";
			blueBtn.useHandCursor = blueBtn.buttonMode = true;
			
			redBtn = new MemoryButton(0xFF3300);
			this.addChild( redBtn );
			redBtn.x = blueBtn.x + 228;
			redBtn.y = blueBtn.y;
			redBtn.id = "red";
			redBtn.soundPath = "assets/audio/toneB.mp3";
			redBtn.useHandCursor = redBtn.buttonMode = true;
			
			greenBtn = new MemoryButton(0x66CC33);
			this.addChild( greenBtn );
			greenBtn.x = -60;
			greenBtn.y = 182 - 40;
			greenBtn.id = "green";
			greenBtn.soundPath = "assets/audio/toneC.mp3";
			greenBtn.useHandCursor = greenBtn.buttonMode = true;
			
			yellowBtn = new MemoryButton(0xFFFF00);
			this.addChild( yellowBtn );
			yellowBtn.x = redBtn.x;
			yellowBtn.y = 182 - 40;
			yellowBtn.id = "yellow";
			yellowBtn.soundPath = "assets/audio/toneD.mp3";
			yellowBtn.useHandCursor = yellowBtn.buttonMode = true;
			
			_titleTxt.text = "Denom:Memory Pattern Game";
			_titleTxt.width = STAGE_WIDTH;
			var textFormat:TextFormat = new TextFormat("Arial", 22, 0xFFFFFF);
			_titleTxt.setTextFormat(textFormat);
			addChild(_titleTxt);
			_titleTxt.x = 30;
			_titleTxt.y = 0;
			
			_blocker = new BoxGraphic(this, 0, 0, STAGE_WIDTH, STAGE_HEIGHT, 0, 0xFFFFFF);
			_blocker.create();
			
			_startBtn = new ButtonComponent(this, 100, 100, 200, 30, "Start Game", new TextFormat("Times", 16));
			_startBtn.create();
			_startBtn.x = START_BTN_POS_X;
			_startBtn.y = START_BTN_POS_Y;
			_startBtn.clicked.add(onStartBtnClicked);
			
			startGame = new Signal();
		}
		
		/*
		function onStartBtnClicked()
		Handler for startBtn - to start game play
		*/
		private function onStartBtnClicked():void{
			_startBtn.x = -STAGE_WIDTH;
			_blocker.x = -STAGE_WIDTH;
			startGame.dispatch();
		}
		
		/*
		function resultsOfGame()
		@param - message : string - message to display on title textbox
		@param - isEndOfLevels : boolean - condition for last level
		end of current game play
		*/
		public function resultsOfGame(message:String, isEndOfLevels:Boolean = false):void{
			_titleTxt.text = message;
			_titleTxt.setTextFormat(new TextFormat("Arial", 22, 0xFFFFFF));
			
			if(!isEndOfLevels){
				_startBtn.text = "Start Next Game";
				_startBtn.x = START_BTN_POS_X;
				_startBtn.y = START_BTN_POS_Y;
			}else{
				_startBtn.text = "Restart Levels";
				_startBtn.x = START_BTN_POS_X;
				_startBtn.y = START_BTN_POS_Y;
			}
			
			_blocker.x = 0;
		}
		
	}
}