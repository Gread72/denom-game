package com.gread.denom.controller  {
	/*
	DenomMain Class
	Binds Model, Views and Controllers
	*/
	import com.gread.denom.model.ApplicationModel;
	import com.gread.denom.model.GameStatusVO;
	import com.gread.denom.view.GamePanel;
	import com.gread.denom.view.StatusPanel;
	import flash.display.MovieClip;
	
	public class DenomMain extends MovieClip {
		
		private var _appDomain:ApplicationModel;
		private var _gamePanel:GamePanel;
		private var _gameController:GameController;
		private var _statusPanel:StatusPanel;
		private var _statusController:StatusController;
		
		/* constructor function */
		public function DenomMain() {
			init();
		}
		
		/* initialize function */
		protected function init():void{
			// create application model
			_appDomain = new ApplicationModel();
			
			// reference view and bind to controller
			_gamePanel = new GamePanel(this);
			_gameController = new GameController(_gamePanel, _appDomain);	
			
			_statusPanel = new StatusPanel(this);
			_statusController = new StatusController(_statusPanel, _appDomain);
			_statusPanel.x = 458;
			_statusPanel.y = 44;
			
			// this will setup the initial status after the view have been created
			// Ideally, there should be a storage object that contains the status
			_appDomain.status = new GameStatusVO();
		}
		
	}
	
}
