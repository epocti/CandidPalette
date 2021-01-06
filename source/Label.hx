package;

import openfl.text.TextFormat;
import openfl.text.TextFieldAutoSize;
import openfl.text.TextField;
import openfl.display.Sprite;

class Label extends Sprite {
	var textField:TextField;

	public function new(initText = "Label"){
		super();

		textField = new TextField();
		textField.defaultTextFormat = new TextFormat("Nunito Regular");
		textField.selectable = false;
		textField.autoSize = TextFieldAutoSize.LEFT;
		textField.text = initText;
		addChild(textField);
	}

	public function getText():String {
		return textField.text;
	}

	public function setText(newText:String){
		textField.text = newText;
	}
}
