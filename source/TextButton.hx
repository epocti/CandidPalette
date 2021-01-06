package;

import openfl.geom.Rectangle;
import openfl.display.Sprite;
import openfl.events.MouseEvent;
import openfl.display.BitmapData;
import openfl.display.Bitmap;

class TextButton extends Sprite {
	var bgImage:Bitmap;
	var textLabel:Label;

	public function new(text:String){
		super();

		textLabel = new Label();
		textLabel.x = 4;
		textLabel.setText(text);

		bgImage = new Bitmap(new BitmapData(Std.int(textLabel.width + 8), 20));
		bgImage.bitmapData.fillRect(new Rectangle(0, 0, textLabel.width + 8, 20), 0xFFDDDDDD);
		addChild(bgImage);

		addChild(textLabel);

		addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
		addEventListener(MouseEvent.MOUSE_OUT, onMouseLeave);
	}

	function onMouseDown(evt:MouseEvent){
		bgImage.bitmapData.fillRect(new Rectangle(0, 0, textLabel.width + 8, 20), 0xFF66A1CC);
	}

	function onMouseUp(evt:MouseEvent){
		bgImage.bitmapData.fillRect(new Rectangle(0, 0, textLabel.width + 8, 20), 0xFFDDDDDD);
	}

	function onMouseOver(evt:MouseEvent){
		bgImage.bitmapData.fillRect(new Rectangle(0, 0, textLabel.width + 8, 20), 0xFF7FC9FF);
	}

	function onMouseLeave(evt:MouseEvent){
		bgImage.bitmapData.fillRect(new Rectangle(0, 0, textLabel.width + 8, 20), 0xFFDDDDDD);
	}
}
