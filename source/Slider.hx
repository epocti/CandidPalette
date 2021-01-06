package;

import openfl.geom.Rectangle;
import openfl.events.MouseEvent;
import openfl.utils.Assets;
import openfl.display.Bitmap;
import openfl.display.Sprite;

class Slider extends Sprite {
	var slider:Sprite;
	var sliderTrack:Bitmap;
	var length:Int;

	public function new(length:Int){
		super();

		this.length = length;

		sliderTrack = new Bitmap(Assets.getBitmapData("assets/ui/sliderTrack.png"));
		sliderTrack.y = 4;
		sliderTrack.scaleX = length + 12;
		this.addChild(sliderTrack);

		slider = new Sprite();
		slider.addChild(new Bitmap(Assets.getBitmapData("assets/ui/slider.png")));
		this.addChild(slider);

		slider.addEventListener(MouseEvent.MOUSE_DOWN, onSliderDown);
		slider.addEventListener(MouseEvent.MOUSE_UP, onSliderUp);
	}

	function onSliderDown(evt:MouseEvent){
		slider.startDrag(false, new Rectangle(0, 0, length, 0));
	}
	function onSliderUp(evt:MouseEvent){
		slider.stopDrag();
	}

	public function getValue(){
		return Std.int(slider.x);
	}

	public function setValue(newVal:Int){
		if(newVal > length) slider.x = length;
		else if(newVal < 0) slider.x = 0;
		else slider.x = newVal;
	}
}