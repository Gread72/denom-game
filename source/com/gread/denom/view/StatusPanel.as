package com.gread.denom.view{
	/*
	GamePanel Class
	view mediator for Gamepanel = create instances for memory buttons, sounds, and graphics
	*/
	
	import com.gread.flash.graphics.BoxGraphic;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class StatusPanel extends Sprite{
		
		private var _statusTxt:TextField = new TextField();
		private var graphicRec:BoxGraphic;
		
		/* constructor code */
		public function StatusPanel(parent:DisplayObjectContainer){
			super();
			
			init();
			
			parent.addChild( this );
		}
		
		/* initialize function */
		private function init():void{
			createBackground();
			
			_statusTxt.width = 80;
			_statusTxt.height = 336;
			_statusTxt.wordWrap = true;
			_statusTxt.multiline = true;
			addChild(_statusTxt);
			_statusTxt.x = 5;
			_statusTxt.y = 10;
		}
		
		/*
		function setText
		@param - textValue : string - set text to status textbox
		Set text and format to Status textbox
		*/
		public function setText(textValue:String):void{
			_statusTxt.text = textValue;
			var textFormat:TextFormat = new TextFormat("Arial", 10, 0xFFFFFF);
			_statusTxt.setTextFormat(textFormat);
		}
		
		/*
		function createBackground()
		create background graphic
		*/
		private function createBackground():void{
			graphicRec = new BoxGraphic(this, 0, 0, 82, 336, 1, 0xCCCCCC);
			//graphicRec.ellipseWidth = graphicRec.ellipseHeight = 50;
			graphicRec.lineColor = 0xFFFFFF;
			graphicRec.lineThickness = 2;
			graphicRec.create();
		}
	}
}