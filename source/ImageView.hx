package;

import motion.Actuate;
import motion.easing.Expo;
import openfl.events.MouseEvent;
import openfl.geom.Rectangle;
import openfl.display.BitmapData;
import openfl.display.Bitmap;
import openfl.display.Sprite;

class ImageView extends Sprite {
	var bg:Bitmap;
	var imageContainer:Sprite;
	var imagePreview:Bitmap;

	var backButton:TextButton;
	var helpLabel:Label;

	public function new(imageData:BitmapData){
		super();

		bg = new Bitmap(new BitmapData(Common.screenWidth, Common.screenHeight));
		bg.bitmapData.fillRect(new Rectangle(0, 0, Common.screenWidth, Common.screenHeight), 0xFFFFFFFF);
		addChild(bg);

		imageContainer = new Sprite();
		imageContainer.y = 24;
		addChild(imageContainer);

		imagePreview = new Bitmap(imageData);
		imagePreview.width = Common.screenWidth;
		imagePreview.height = Common.screenHeight - 24;
		imageContainer.addChild(imagePreview);
		imageContainer.addEventListener(MouseEvent.CLICK, onImageClick);

		backButton = new TextButton("< Back");
		backButton.x = 2;
		backButton.y = 2;
		addChild(backButton);
		backButton.addEventListener(MouseEvent.CLICK, onBackButtonClick);

		helpLabel = new Label("Select as many colors as needed from the image.");
		helpLabel.x = Common.screenWidth - helpLabel.width - 2;
		helpLabel.y = 2;
		addChild(helpLabel);

		this.alpha = 0;
		Actuate.tween(this, Common.animationLength, {alpha:1}).ease(Expo.easeOut);
	}

	function onImageClick(evt:MouseEvent){
		Common.palette.addColor(new Color(imagePreview.bitmapData.getPixel32(Std.int(evt.localX / imagePreview.scaleX), Std.int(evt.localY / imagePreview.scaleY))));
	}

	function onBackButtonClick(evt:MouseEvent){
		dismiss();
	}

	function dismiss(){
		//var timer = new haxe.Timer(Common.animationLength * 1000);
		var timer = new haxe.Timer(500);
		Actuate.tween(this, Common.animationLength, {alpha:0}).ease(Expo.easeOut);
		timer.run = function(){
			parent.removeChild(this);
			timer.stop();
		}
	}
}