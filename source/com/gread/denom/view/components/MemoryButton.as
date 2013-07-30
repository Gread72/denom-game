package com.gread.denom.view.components {
	/*
	MemoryButton Class
	mediator / graphic for Memory Button component
	*/
	
	import com.gread.HelperUtil;
	import com.gread.flash.graphics.BoxGraphic;
	import com.greensock.*;
	import com.greensock.easing.*;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.GlowFilter;
	import flash.media.Sound;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import org.osflash.signals.Signal;
	
	public class MemoryButton extends MovieClip{
		
		private var _soundPath:String = "";
		private var _id:String;
		private var _animating = false;
		private var _thisMC:Sprite;
		private var _sound:Sound;
		private var _color:uint;
		private var graphicRec:BoxGraphic;
		public var selectedEnd:Signal;
		
		/* 
		constructor code
		@param - color : uint - color for component	
		*/
		public function MemoryButton(color:uint = 0x3366FF) {
			_color = color;
			selectedEnd = new Signal();
			init();
		}
		
		/* initialize function */
		private function init():void{
			graphicRec = new BoxGraphic(this, 180/2, 158/2, 180, 158, 1, _color);
			graphicRec.ellipseWidth = graphicRec.ellipseHeight = 50;
			graphicRec.lineColor = 0xFFFFFF;
			graphicRec.lineThickness = 2;
			graphicRec.create();
		}
		
		/*
		function selected()
		play animation and sound when selected by either game state
		*/
		public function selected():void{
			_thisMC = Sprite(graphicRec.element);
			_animating = true;
			
			_thisMC.filters = [new GlowFilter(0x91e600,1,10,10,2,1,false)];
			
			if(_sound){
				_sound.play();
			}
			
			TweenLite.to(_thisMC, .3, {x:_thisMC.x - 3, y:_thisMC.y - 5, scaleX:1.1, scaleY:1.1, onComplete:function(){
				onSelectedEnd();
			}});
		}
		
		/*
		function onSelectedEnd()
		handler for animation and sound when selected by either game state
		*/
		private function onSelectedEnd():void{
			_thisMC.filters = [];
			TweenLite.to(_thisMC, .5, {x:_thisMC.x + 3, y:_thisMC.y + 5, scaleX:1, scaleY:1, onComplete:function(){
				_animating = false;
				//dispatchEvent(new Event("SELECTED_END",true));
				selectedEnd.dispatch();
			}});	
		}
		
		/*
		function id()
		getter for id
		*/
		public function get id():String{
			return _id;
		}
		
		/*
		function id()
		setter for id
		*/
		public function set id(value:String):void{
			_id = value;
		}
		
		/*
		function animating()
		getter for animating
		*/
		public function get animating(){
			return _animating;
		}
		
		/*
		function soundPath()
		getter for soundPath
		*/
		public function get soundPath():String{
			return _soundPath;
		}
		
		/*
		function soundPath()
		setter for soundPath
		*/
		public function set soundPath(value:String):void{
			_soundPath = value;
			
			_sound = new Sound();
			_sound.load(new URLRequest(_soundPath));
			
		}


	}
	
}
