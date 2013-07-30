package com.gread.denom.controller{
	/*
	GameManager Class
	manager logic for game series played
	*/
	
	import com.gread.denom.view.components.MemoryButton;
	
	public class GameManager{
		
		private var _memoryButtons:Vector.<MemoryButton> = new Vector.<MemoryButton>();
		private var _selectionOrder:Vector.<MemoryButton> = new Vector.<MemoryButton>();
		private var _currentOrderIteration:Number = 0;
		private var _randomSelectNum:Number = 4;
		
		static public var STATE_RUN_ORDER:String = "runOrder";
		static public var STATE_PLAYER_MIMICS_ORDER:String = "playerMimicsOrder";
		
		private var _state:String = STATE_RUN_ORDER;
		
		/* constructor function */
		public function GameManager(){
		}
		
		/*
		function memoryButtons()
		getter for memoryButtons vector array
		*/
		public function get memoryButtons():Vector.<MemoryButton>
		{
			return _memoryButtons;
		}
		
		/*
		function memoryButtons()
		setter for memoryButtons vector array
		*/
		public function set memoryButtons(value:Vector.<MemoryButton>):void
		{
			_memoryButtons = value;
		}
		
		/*
		function runSelectionSeries()
		Create pattern series for game
		*/
		public function runSelectionSeries():void{
			
			_selectionOrder = new Vector.<MemoryButton>();
			
			for(var i:Number = 0; i < _randomSelectNum; i++){
				var randNumb:Number = Math.round(Math.random() * 3);
				//trace(randNumb);
				_selectionOrder.push(_memoryButtons[randNumb]);
			}
			
//			for each(var item:MemoryButton in _selectionOrder){
//				trace(item.id);
//			}
		}
		
		/*
		function startGame()
		start game - reset iteration order, game state and play first select which will trigger the "played" series
		*/
		public function startGame():void{
			_currentOrderIteration = 0;
			_state = STATE_RUN_ORDER;
			playMem();
		}
		
		/*
		function playMem()
		play current series memory button animation otherwise change state - to allow player to recreate pattern
		*/
		public function playMem():void{
			if(_currentOrderIteration < _randomSelectNum){
				if(!_selectionOrder[_currentOrderIteration].animating){
					_selectionOrder[_currentOrderIteration].selected();
					_currentOrderIteration++;
				}
			}else{
				_currentOrderIteration = 0;
				_state = STATE_PLAYER_MIMICS_ORDER;
			}
		}
		
		/*
		function state()
		getter for state of game
		*/
		public function get state():String
		{
			return _state;
		}
		
		/*
		function checkMimicSelection
		@param - selectedID : string - player's selection
		checks current selection with order series
		*/
		public function checkMimicSelection(selectedID:String):Boolean{
			var isCorrectSelection:Boolean = false;
			if(_selectionOrder[_currentOrderIteration].id == selectedID){
				trace("Correct " + selectedID);
				isCorrectSelection = true;
			}else{
				trace("Incorrect " + selectedID + " / " + _selectionOrder[_currentOrderIteration].id);
			}
			_currentOrderIteration++;
			
			return isCorrectSelection;
		}
		
		/*
		function isEndOfMimicSelection()
		condition for whether suer had gone through current game series pattern
		*/
		public function isEndOfMimicSelection():Boolean{
			if(_currentOrderIteration == _randomSelectNum){
				return true;
			}else{
				return false;
			}
		}

		/*
		function randomSelectionNum()
		getter for randomSelectNum
		*/
		public function get randomSelectNum():Number
		{
			return _randomSelectNum;
		}
		
		/*
		function randomSelectionNum()
		setter for randomSelectNum
		*/
		public function set randomSelectNum(value:Number):void
		{
			_randomSelectNum = value;
		}


	}
}