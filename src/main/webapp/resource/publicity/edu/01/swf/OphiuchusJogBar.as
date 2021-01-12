/*
2011 . 02. 30
============== Made in Ophiuchus ====================
Author : Ophiuchus
E-Mail : creativemk@Ophiuchus.co.kr
Messenger : creativemk@nate.com
Comment : OphiuchusJogBar.as
=====================================================
*/

import mx.utils.Delegate;
import mx.transitions.Tween;
import mx.transitions.easing.*;
import flash.external.ExternalInterface;

class OphiuchusJogBar{

	private var baseHolder:Object;
	private var jogValue:Object;
	private var __target:Object;
	private var __state:String;
	private var __endCheck:Boolean;
	private var __scriptObj:Object;
	private var __scriptState:String;
	private var __queArr:Array;
	private var __saveLastLabel:Number;
	private var __soundState:String;
	private var __volumeObj:Object;
	
	//사운드관련
	private var __sound:Sound;
	
	// 0.초기화 1.클래스내 2. 외부
	private var __playAndPauseObj:Number;
	
	//
	private var __cntNum:Number;
	private var __preframeNum:Number;

	/*
	path : 메인프레임
	target : 버튼들이있는 무비클립 인스턴스
	fps : 해당 fps
	*/
	function OphiuchusJogBar(path:Object, target:Object, fps:Number,queArr:Array) {
		jogValue = new Object();
		__queArr = new Array();
		__endCheck = false;
		__state = "";
		baseHolder = path;
		__target = target;
		__scriptState = "close";
		__soundState = "open";
		__queArr = queArr;
		__sound = new Sound(baseHolder);
		__cntNum = 0;
		__preframeNum = 0;
		jogInit(fps);
		valueScriptObj();
		changeMask();
		//valueScriptObj();
		btnSetting();
	}
	private function valueScriptObj():Void
	{
		__scriptObj = new Object();
		__scriptObj.inity = baseHolder.script._y;
		__scriptObj.changey = 520;
	}
	private function jogInit(fps:Number):Void {
		jogValue.xMaxValue = __target.conBar_mc._x+__target.conBar_mc._width;
		jogValue.xMinValue = __target.conBar_mc._x;
		jogValue.yPos = __target.conButton_mc._y;
		jogValue.Fps = fps;
		timeCheck();
		jogDraggerInit();
		jogCheck();
		firstSetting();
	}
	private function firstSetting():Void
	{
		__state = "play";
		btnRelease();
		__target.block._visible = true;
	}
	//__버튼 세팅하는부분
	//**************************
	public function btnSetting():Void {
		//volumeControl();
		with (__target) {
			conReplay_mc.onRollOver = Delegate.create(this,function(){
				(this.__state=="replay") ? trace("replay Save") : conReplay_mc.gotoAndStop(3);
																	 });
			conPlay_mc.onRollOver = Delegate.create(this, function () {
				(this.__state == "play") ?trace("play Save") : conPlay_mc.gotoAndStop(3);
			});
			
			conPause_mc.onRollOver = Delegate.create(this, function () {
				(this.__state == "pause") ? trace("pause Save") :conPause_mc.gotoAndStop(3);
			});
			conPause_mc.onRollOut = Delegate.create(this, function () {
				(this.__state == "pause") ? trace("pause Save") : conPause_mc.gotoAndStop(1);
			});
			conPause_mc.onRelease = Delegate.create(this, function () {
				if(this.__playAndPauseObj != 2){  
						if(this.baseHolder._currentframe != this.baseHolder._totalframes){
							this.__playAndPauseObj = 1;
							this.__state = "pause";
							this.baseHolder.stop();
							this.btnRelease();
						}else{
							trace("__마지막프레임에서는 지원하지않습니다__");
						}
				}else{
					trace("_______현재모드는 잠금기능입니다__________");
				}
				this.soundClick();
			});
			conStop_mc.onRollOver = Delegate.create(this, function () {
				(this.__state == "stop") ? trace("stop Save") : conStop_mc.gotoAndStop(3);
			});
			conPlay_mc.onRollOut = Delegate.create(this, function () {
				(this.__state == "play") ?trace("play Save") : conPlay_mc.gotoAndStop(1);
			});
			
			conStop_mc.onRollOut = Delegate.create(this, function () {
				(this.__state == "stop") ? trace("stop Save") :conStop_mc.gotoAndStop(1);
			});
			conReplay_mc.onRollOut = Delegate.create(this,function(){
				(this.__state == "replay") ? trace("replay Save") : conReplay_mc.gotoAndStop(1);
																	});
			conPlay_mc.onRelease = Delegate.create(this, function () {
				if(this.__playAndPauseObj !=2){
						this.__playAndPauseObj = 1;
						this.__state = "play";
						this.btnRelease();
						(this.baseHolder._currentframe != this.baseHolder._totalframes) ? this.baseHolder.play() : this.baseHolder.gotoAndPlay(2);
				}else{
					trace("_________현재 잠금모드가 작동중입니다____________");
				}
				this.soundClick();
			});
			conStop_mc.onRelease = Delegate.create(this, function () {
				this.__playAndPauseObj = 1;
				this.__state = "play";
				this.baseHolder.gotoAndPlay(2);
				this.btnRelease();
				this.soundClick();
			});
			conReplay_mc.onRelease = Delegate.create(this,function(){
				this.__playAndPauseObj = 1;
				this.__state = "play";
				this.baseHolder.gotoAndPlay(2);
				this.btnRelease();
				this.soundClick();
																	});
			scriptBt.onPress = Delegate.create(this,function(){
						if(this.__scriptState == "open"){
							scriptBt.gotoAndStop(1);
							this.__scriptState = "close";
						}else{
							scriptBt.gotoAndStop(2);
							this.__scriptState = "open";
						}
						this.changeMask();
						this.soundClick();
																});
			scriptBt.onRollOver = Delegate.create(this,function(){
						(this.__scriptState =="close") ? scriptBt.gotoAndStop(3) :scriptBt.gotoAndStop(1);
																 });
			scriptBt.onRollOut = Delegate.create(this,function(){
						(this.__scriptState =="close") ? scriptBt.gotoAndStop(1): scriptBt.gotoAndStop(2);
																});
			soundBt.onRelease = Delegate.create(this,function(){
						if(this.__soundState=="open"){
							this.__sound.setVolume(0);
							soundBt.gotoAndStop(2);
							this.__soundState = "close";
						}else{
							this.__sound.setVolume(100);
							soundBt.gotoAndStop(1);
							this.__soundState = "open";
						}
															   });
			soundBt.onRollOver = Delegate.create(this,function(){
						(this.__soundState=="open") ? soundBt.gotoAndStop(2) : soundBt.gotoAndStop(1);
																});
			soundBt.onRollOut = Delegate.create(this,function(){
						(this.__soundState=="open") ? soundBt.gotoAndStop(1) : soundBt.gotoAndStop(2);
															   });
		}
		//볼륨추가	
	}
	//************************
	//사운드추가
		//*******************************************
	//볼륨컨트롤바 초기화
	private function volumeControl():Void
	{
		__volumeObj = new Object();
		__target.soundMc.bar._width = __target.soundMc.bgMC._width;
		__volumeObj.minX = 12;
		__volumeObj.ypos = __target.soundMc.btn._y;
		__volumeObj.maxX = __target.soundMc.bgMC._width-(__target.soundMc.btn._width/2)+3;
		addEventVolume();
		//초기볼륨값
		inputVolumeNum(100);
	}
	
	
	//이벤트등록
	private function addEventVolume():Void 
	{
		__target.soundMc.btn.onPress = Delegate.create(this,function(){;
			this.volMcPressEvt();
		});
		__target.soundMc.btn.onRelease = __target.soundMc.btn.onReleaseOutside = Delegate.create(this,function(){;
			this.volMcReleaseEvt();
		});
		__target.soundMc.bgMC.onPress = Delegate.create(this, function () {
			this.bgMcPressEvt();
		});
		__target.soundMc.bgMC.onRelease = __target.soundMc.bgMC.onReleaseOutside=Delegate.create(this, function () {
			this.volMcReleaseEvt();
		});
	}
	
	//볼륨버튼 x값조정
	private function bgMcPressEvt():Void 
	{
		var knum:Number = __target.soundMc._xmouse-Math.floor(__volumeObj.minX);
		if (knum<__volumeObj.minX) {
			knum = __volumeObj.minX;
		} else if (knum>__volumeObj.maxX) {
			knum = __volumeObj.maxX;
		} else {
		}
		__target.soundMc.btn._x = knum;

		volMcPressEvt();
	}
	
	//이벤트
	private function volMcPressEvt():Void 
	{
		var kobj:Object = new Object();
		kobj = __target.soundMc.btn;
		kobj.startDrag(false,__volumeObj.minX,__volumeObj.ypos,__volumeObj.maxX,__volumeObj.ypos);
		checkVolumeNum();
	}
	
	
	private function volMcReleaseEvt():Void 
	{
		var kobj:Object = new Object();
		kobj = __target.soundMc.btn;
		kobj.stopDrag();
		delete kobj.onEnterFrame;
	}
	
	//
	private function checkVolumeNum():Void 
	{
		var kobj:Object = new Object();
		kobj = __target.soundMc.btn;
		kobj.onEnterFrame = Delegate.create(this, function () {
			var klength:Number = __volumeObj.maxX-__volumeObj.minX-1;
			var knum:Number = Math.floor((int(kobj._x)-__volumeObj.minX)/klength*100);
			volumeSetFn(knum);
		});

	}
	
	
	private function volumeSetFn(num:Number):Void 
	{
		if (num<=0) {
			__target.soundMc.btn.gotoAndStop(2);
		} else {
			__target.soundMc.btn.gotoAndStop(1);
		}
		__target.soundMc.bar._xscale = num;
		trace(num);
		__sound.setVolume(num);
	}
	
	//볼륨값입력하면 .....
	private function inputVolumeNum(num:Number):Void
	{
		var kobj:Object = new Object();
		kobj = __target.soundMc;
		var klength:Number = __volumeObj.maxX-__volumeObj.minX-1;
		kobj.btn._x = __volumeObj.minX+(klength*(num/100));
		volumeSetFn(num);
	}
	
	//************************
	public function outDoorMask(str:String):Void
	{
		__scriptState = str;
		(str=="close") ? __target.scriptBt.gotoAndStop(1): __target.scriptBt.gotoAndStop(2);
		changeMask();
	}
	private function changeMask():Void
	{
		trace(baseHolder.script._y+"//");
		(__scriptState=="close") ? __target._parent._parent.script._visible = false : __target._parent._parent.script._visible = true;
	}
	//************************
	private function btnRelease(mc:MovieClip):Void {
		if(mc._currentframe==2){
		}else{
		switch (__state) {
				case "play" :
					__target.conPlay_mc.gotoAndStop(2);
					__target.conPause_mc.gotoAndStop(1);
					__target.conStop_mc.gotoAndStop(1);
					__target.conReplay_mc.gotoAndStop(1);
					__target.conPlay_mc._visible = false;
					__target.conPause_mc._visible = true;
					break;
				case "pause" :
					__target.conPause_mc.gotoAndStop(2);
					__target.conPlay_mc.gotoAndStop(1);
					__target.conStop_mc.gotoAndStop(1);
					__target.conReplay_mc.gotoAndStop(1);
					__target.conPlay_mc._visible = true;
					__target.conPause_mc._visible = false;
					break;
				case "stop" :
					__target.conPlay_mc.gotoAndStop(1);
					__target.conStop_mc.gotoAndStop(2);
					__target.conReplay_mc.gotoAndStop(1);
					__target.conPause_mc.gotoAndStop(1);
					break;
				default :
					trace("맞는 조건이 없습니다.");
					break;
			}
		}
	}
	
	//조그드래그 이벤트
	private function jogDraggerInit():Void {
			with (__target) {
				conBar_mc._alpha = 100;
				conButton_mc.onPress = Delegate.create(this,function(){
																	  this.conButtonPressEvt();
																	  });
				conButton_mc.onRelease = conButton_mc.onReleaseOutside = Delegate.create(this,function (){
																		this.conButtonReleaseEvt();
																										 });
				conBar_mc.onPress = Delegate.create(this,function() {
																       this.conBarPressEvt();
																   });
				conBar_mc.onRelease = conBar_mc.onReleaseOutside = Delegate.create(this,function(){
																								  this.conButtonReleaseEvt();
																								  });
		}
			
	}
	
	private function conBarPressEvt():Void
	{
		var knum:Number = __target.conBar_mc._xmouse - jogValue.xMinValue;
		if(knum <= jogValue.xMinValue){
			knum = jogValue.xMinValue;
		}else if(knum >= jogValue.xMaxValue){
			knum = jogValue.xMaxValue;
		}else{
		}
		__target.conButton_mc._x = knum + __target.conButton_mc._width/2;
		frameBefore();
		conButtonPressEvt();
		
	}
	private function conButtonPressEvt():Void
	{
		__target.conButton_mc.onMouseMove = Delegate.create(this,function(){
																		   this.frameBefore();
																		   });
		baseHolder.stop();
		__state = "pause";
		btnRelease();
		delete __target.onEnterFrame;
		__target.conButton_mc.startDrag(false,this.jogValue.xMinValue,this.jogValue.yPos ,this.jogValue.xMaxValue,this.jogValue.yPos)
	}
	private function conButtonReleaseEvt():Void
	{
		
		__target.conButton_mc.stopDrag();
		delete __target.conButton_mc.onMouseMove;
		if(baseHolder._totalframes != baseHolder._currentframe){
			__playAndPauseObj = 1;
			baseHolder.play();
			__state = "play";
			btnRelease();
		}
		jogCheck();
	}
	//_____________________
	//onEnterFrame를 돌려서 체크
	private function timeCheck():Void {
		var kmc:MovieClip = __target.createEmptyMovieClip("kmc", __target.getNextHighestDepth());
		kmc.onEnterFrame = Delegate.create(this, function () {
			checkingTime();
			jogLastFrameCheck();
			jogFill();
			//checkScriptObj();
		});
	}
	//시간
	private function checkingTime():Void {
		var totalTimes:Number = this.baseHolder._totalframes;
		var curTimes:Number = this.baseHolder._currentframe;
		var tolMinutes:String = timezeroCheck(Math.floor(Math.floor(totalTimes/this.jogValue.Fps)/60));
		var tolSeconds:String = timezeroCheck(Math.floor(Math.floor(totalTimes/this.jogValue.Fps)%60));
		var curMinutes:String = timezeroCheck(Math.floor(Math.floor(curTimes/this.jogValue.Fps)/60));
		var curSeconds:String = timezeroCheck(Math.floor(Math.floor(curTimes/this.jogValue.Fps)%60));
		__target.totalTimes.text = tolMinutes+":"+tolSeconds;
		__target.curTimes.text = curMinutes+":"+curSeconds
	}
	//0붙이기
	private function timezeroCheck(num:Number):String {
		var kstr:String = new String();
		(num<10) ? kstr="0"+String(num) : kstr=String(num);
		return kstr;
	}
	//jog last check
	private function jogLastFrameCheck():Void {
		
		if(__state != "pause"){
			__cntNum++;
		}else{
		}
		if(__cntNum % 10 ==0){
			if(baseHolder._currentframe < baseHolder._totalframes){
				if(__preframeNum == baseHolder._currentframe){
					__state = "pause";
					btnRelease(__target.conPause_mc);
					//__playAndPauseObj = 2;
				}else{
					__state = "play";
					btnRelease(__target.conPlay_mc);
					__playAndPauseObj = 1;
					__preframeNum = baseHolder._currentframe;
				}
			}
			__cntNum = 0;
		}else{
		}
		if (baseHolder._totalframes == baseHolder._currentframe) {
			__state = "pause";
			baseHolder.stop();
			(__target._parent._parent.strictWatch == false) ? __target._parent._parent.strictWatch = true : trace("__event end__"); 
			if (__endCheck == false) {
				__endCheck = true;
				(__target._parent._parent.culNum==__target._parent._parent.tolNum) ? __target._parent._parent.next_cl2.gotoAndPlay(2) : __target._parent._parent.next_cl.gotoAndPlay(2);
				btnRelease();
			}

		} else {
			__endCheck = false;
		 	__target._parent._parent.next_cl.gotoAndStop(1);
			__target._parent._parent.next_cl2.gotoAndStop(1);
		}
		
	}
	//color
	private function jogFill():Void {
		var knum:Number = __target.conButton_mc._x-__target.conBar1_mc._x;
		__target.conBar1_mc._width = __target.conButton_mc._x-__target.conBar1_mc._x;
	}
	//jogValue
	private function jogCheck():Void {
		__target.onEnterFrame = Delegate.create(this, function () {
			jogPos();
		});
	}
	private function jogPos():Void {
		var kpos:Number = __target.conBar_mc._width*(baseHolder._currentframe/baseHolder._totalframes)+jogValue.xMinValue;
		__target.conButton_mc._x = kpos;
		// 2010.12.20 kangTeam add
		if(__target._parent.pageComplete()){
			__target.block._visible = false;
		}
	}
	//미리보기(프레임)
	private function frameBefore():Void {
		var knum:Number = Math.floor(baseHolder._totalframes*((__target.conButton_mc._x - (jogValue.xMinValue))/__target.conBar_mc._width));
		(knum  > 1) ? baseHolder.gotoAndStop(knum+3) : baseHolder.gotoAndStop(2)
	}
}
