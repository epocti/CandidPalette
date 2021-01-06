package;

import openfl.events.MouseEvent;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.Sprite;

class ImageButton extends Sprite {
	var image:Bitmap;

	var defPath:String;
	var hoverPath:String;
	var clickPath:String;

	public function new(defImagePath:String, hoverImagePath:String, clickImagePath:String){
		super();

		image = new Bitmap(Assets.getBitmapData(defImagePath));
		addChild(image);

		defPath = defImagePath;
		hoverPath = hoverImagePath;
		clickPath = clickImagePath;

		addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
		addEventListener(MouseEvent.MOUSE_OUT, onMouseLeave);
	}

	function onMouseDown(evt:MouseEvent){
		image.bitmapData = Assets.getBitmapData(clickPath);
	}

	function onMouseUp(evt:MouseEvent){
		image.bitmapData = Assets.getBitmapData(defPath);
	}

	function onMouseOver(evt:MouseEvent){
		image.bitmapData = Assets.getBitmapData(hoverPath);
	}

	function onMouseLeave(evt:MouseEvent){
		image.bitmapData = Assets.getBitmapData(defPath);
	}
}
