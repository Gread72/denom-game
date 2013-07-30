package com.gread.denom.controller{
	/*
	StatusController Class
	Controller for status display
	*/
	import com.gread.denom.model.ApplicationModel;
	import com.gread.denom.model.GameStatusVO;
	import com.gread.denom.view.StatusPanel;
	
	public class StatusController{
		
		private var _statusPanel:StatusPanel;
		private var _model:ApplicationModel;
		
		/* constructor function 
		@param - panel : StatusPanel - view
		@param - model : ApplicationModel - model
		*/
		public function StatusController(panel:StatusPanel, model:ApplicationModel){
			_model = model;
			_statusPanel = panel;
			
			init();
		}
		
		/* initialize function */
		private function init():void{
			_model.gameTallyChanged.add(onGameTallyChanged);
		}
		
		/*
		function onGameTallyChanged
		@param - evt : Object - signal object
		handler of Game Tally Change - end of game series
		*/
		private function onGameTallyChanged(evt:Object):void{
			var statusResult:GameStatusVO = evt.status;
			
			_statusPanel.setText("Level: " + statusResult.level + "\n"
								+ "# of Games: " + statusResult.numGames + "\n"
								+ "Losses: " + statusResult.lost + "\n"
								+ "Wins: " + statusResult.won);
			
//			trace("Num of games: " + statusResult.numGames);
//			trace("Losts of games: " + statusResult.lost);
//			trace("Wins in games: " + statusResult.won);
		}
	}
}