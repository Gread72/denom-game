package com.gread.denom.controller{
	/*
	GameController Class
	Controller to game view - reference memory buttons, add event listeners, 
	*/
	
	import com.gread.denom.model.ApplicationModel;
	import com.gread.denom.model.GameStatusVO;
	import com.gread.denom.view.GamePanel;
	import com.gread.denom.view.components.MemoryButton;
	import flash.events.MouseEvent;
	
	public class GameController{
		
		private var _gameMgr:GameManager;
		private var _gamePanel:GamePanel;
		private var _model:ApplicationModel;
		
		/* constructor function */
		public function GameController(panel:GamePanel, model:ApplicationModel){
			_gamePanel = panel;
			_model = model;
			_gameMgr = new GameManager();
			
			init();
			
			addEventListeners();
		}
		
		/* initialize function */
		private function init():void{
			_gameMgr.memoryButtons.push(_gamePanel.blueBtn);
			_gameMgr.memoryButtons.push(_gamePanel.redBtn);
			_gameMgr.memoryButtons.push(_gamePanel.greenBtn);
			_gameMgr.memoryButtons.push(_gamePanel.yellowBtn);
			
		}
		
		/*
		function addEventListeners()
		method for adding listeners to components and model
		*/
		protected function addEventListeners():void{
			_gamePanel.blueBtn.addEventListener(MouseEvent.CLICK, onClickBtn);
			_gamePanel.redBtn.addEventListener(MouseEvent.CLICK, onClickBtn);
			_gamePanel.greenBtn.addEventListener(MouseEvent.CLICK, onClickBtn);
			_gamePanel.yellowBtn.addEventListener(MouseEvent.CLICK, onClickBtn);
			
			_gamePanel.blueBtn.selectedEnd.add(onSelectedEnd);
			_gamePanel.redBtn.selectedEnd.add(onSelectedEnd);
			_gamePanel.greenBtn.selectedEnd.add(onSelectedEnd);
			_gamePanel.yellowBtn.selectedEnd.add(onSelectedEnd);
			
			_model.gameTallyChanged.add(onGameTallyChanged);
			
			_gamePanel.startGame.add(onStartGame);
		}
		
		/*
		function onGameTallyChanged()
		@param - evt : Object - signal result object - GameStatusVO
		event handler for game status - get current level
		*/
		private function onGameTallyChanged(evt:Object):void{
			var statusResult:GameStatusVO = evt.status;
//				trace("Num of games: " + statusResult.numGames);
//				trace("Losts of games: " + statusResult.lost);
//				trace("Wins in games: " + statusResult.won);
//			
			switch(statusResult.level){
				case 1:
					_gameMgr.randomSelectNum = 4;
					break;
				
				case 2:
					_gameMgr.randomSelectNum = 5;
					break;
				
				case 3:
					_gameMgr.randomSelectNum = 6;
					break;
				
				default: // no default
					//_gameMgr.randomSelectNum = 6;
					break;
			}
			
		}
		
		/*
		function onStartGame()
		start game series - create selection pattern and start game play
		*/
		private function onStartGame():void{
			_gameMgr.runSelectionSeries();
			_gameMgr.startGame();
		}
		
		/*
		function onClickBtn()
		@param - evt : MouseEvent - mouse event
		click memory buttons to recreate pattern created - miss one step lose game
		*/
		private function onClickBtn(evt:MouseEvent):void{
			//trace("Button Clicked");
			if(evt.currentTarget is MemoryButton){
				
				evt.currentTarget.selected();
				
				var isSelectionCorrect = _gameMgr.checkMimicSelection( MemoryButton(evt.currentTarget).id );
				if(!isSelectionCorrect){
					_gamePanel.resultsOfGame("Denom:Memory Pattern Game - You Lost!");
					_model.gameLost();
				}else{
					if(_gameMgr.isEndOfMimicSelection()){
						_gamePanel.resultsOfGame("Denom:Memory Pattern Game - You Won!");
						_model.gameWon();
					}
				}
			}
		}
		
		/*
		function onSelectedEnd()
		Play memory button animation/sound on next "played" selection
		Note: in the state of display the pattern that the user needs to recreate
		*/
		private function onSelectedEnd():void{
			if(_gameMgr.state == GameManager.STATE_RUN_ORDER){
				_gameMgr.playMem();
			}
		}
	}
}