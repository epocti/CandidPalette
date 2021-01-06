package;

import openfl.events.Event;
import motion.Actuate;
import motion.easing.Expo;
import openfl.events.MouseEvent;
import openfl.geom.Rectangle;
import openfl.display.BitmapData;
import openfl.display.Bitmap;
import openfl.display.Sprite;

class ColorView extends Sprite {
	var bg:Bitmap;
	var colorPreview:Bitmap;

	var backButton:TextButton;
	var deleteButton:TextButton;
	var duplicateButton:TextButton;

	var indexLabel:Label;

	var shortHexCodeLabel:Label;
	var fullHexCodeLabel:Label;
	var readableLabel:Label;

	var redSlider:Slider;
	var redSliderLabel:Label;
	var greenSlider:Slider;
	var greenSliderLabel:Label;
	var blueSlider:Slider;
	var blueSliderLabel:Label;
	var alphaSlider:Slider;
	var alphaSliderLabel:Label;

	var previewXOffset:Int = 64;
	var index:Int;
	var mouseIsDown:Bool;

	public function new(paletteIndex:Int){
		super();

		index = paletteIndex;

		// Create background
		bg = new Bitmap(new BitmapData(Common.screenWidth, Common.screenHeight));
		bg.bitmapData.fillRect(new Rectangle(0, 0, Common.screenWidth, Common.screenHeight), 0xFFFFFFFF);
		addChild(bg);
		// Create color preview
		colorPreview = new Bitmap(new BitmapData(previewXOffset, Common.screenHeight));
		colorPreview.bitmapData.fillRect(new Rectangle(0, 0, previewXOffset, Common.screenHeight), Common.palette.getColorHexByIndex(paletteIndex));
		addChild(colorPreview);

		// Back button
		backButton = new TextButton("< Back");
		backButton.x = previewXOffset + 2;
		backButton.y = 2;
		addChild(backButton);
		backButton.addEventListener(MouseEvent.CLICK, onBackButtonClick);
		// Duplicate button
		duplicateButton = new TextButton("Duplicate Color");
		duplicateButton.x = previewXOffset + 2;
		duplicateButton.y = Common.screenHeight - duplicateButton.height - 2;
		addChild(duplicateButton);
		duplicateButton.addEventListener(MouseEvent.CLICK, onDuplicateButtonClick);
		// Delete button
		deleteButton = new TextButton("Delete Color");
		deleteButton.x = duplicateButton.x + duplicateButton.width + 2;
		deleteButton.y = Common.screenHeight - deleteButton.height - 2;
		addChild(deleteButton);
		deleteButton.addEventListener(MouseEvent.CLICK, onDeleteButtonClick);

		// Color index label
		indexLabel = new Label("Color " + (index + 1));
		indexLabel.x = Common.screenWidth - indexLabel.width - 2;
		indexLabel.y = 2;
		addChild(indexLabel);

		// RGB hex label
		shortHexCodeLabel = new Label();
		shortHexCodeLabel.x = previewXOffset;
		shortHexCodeLabel.y = 32;
		shortHexCodeLabel.scaleX = 4;
		shortHexCodeLabel.scaleY = 4;
		shortHexCodeLabel.setText("#" + StringTools.hex(Color.toRGB(Color.getRed(Common.palette.getColorHexByIndex(index)), Color.getGreen(Common.palette.getColorHexByIndex(index)), Color.getBlue(Common.palette.getColorHexByIndex(index)))));
		// In cases where the leading 0s were not added, add them in
		if(shortHexCodeLabel.getText().length <= 6){
			for(i in 0...7-shortHexCodeLabel.getText().length){
				shortHexCodeLabel.setText("#" + 0 + shortHexCodeLabel.getText().substring(1, shortHexCodeLabel.getText().length));
			}
		}
		addChild(shortHexCodeLabel);

		// ARGB hex label
		fullHexCodeLabel = new Label();
		fullHexCodeLabel.x = previewXOffset + 2;
		fullHexCodeLabel.y = shortHexCodeLabel.y + shortHexCodeLabel.height;
		fullHexCodeLabel.scaleX = 1.25;
		fullHexCodeLabel.scaleY = 1.25;
		fullHexCodeLabel.setText("ARGB Hex: #" + StringTools.hex(Common.palette.getColorHexByIndex(index)));
		// In cases where the leading 0s were not added, add them in
		if(fullHexCodeLabel.getText().length <= 8){
			for(i in 0...9-fullHexCodeLabel.getText().length){
				fullHexCodeLabel.setText("ARGB Hex: #" + 0 + fullHexCodeLabel.getText().substring(1, fullHexCodeLabel.getText().length));
			}
		}
		addChild(fullHexCodeLabel);

		// RGB readable label
		readableLabel = new Label();
		readableLabel.x = previewXOffset + 2;
		readableLabel.y = (fullHexCodeLabel.y + fullHexCodeLabel.height) - 8;
		readableLabel.scaleX = 1.25;
		readableLabel.scaleY = 1.25;
		readableLabel.setText("RGBA: (" + Color.getRed(Common.palette.getColorHexByIndex(index)) + ", " + Color.getGreen(Common.palette.getColorHexByIndex(index)) + ", " + Color.getBlue(Common.palette.getColorHexByIndex(index)) + ", " + Color.getAlpha(Common.palette.getColorHexByIndex(index)) + ")");
		addChild(readableLabel);

		// Red value slider
		redSlider = new Slider(255);
		redSlider.setValue(Color.getRed(Common.palette.getColorHexByIndex(index)));
		redSlider.x = previewXOffset + 5;
		redSlider.y = 170;
		addChild(redSlider);
		// Red value label
		redSliderLabel = new Label();
		redSliderLabel.x = previewXOffset + 2;
		redSliderLabel.y = redSlider.y - 18;
		redSliderLabel.setText("Red: " + Color.getRed(Common.palette.getColorHexByIndex(index)));
		addChild(redSliderLabel);

		// Green value slider
		greenSlider = new Slider(255);
		greenSlider.setValue(Color.getGreen(Common.palette.getColorHexByIndex(index)));
		greenSlider.x = previewXOffset + 5;
		greenSlider.y = 200;
		addChild(greenSlider);
		// Green value label
		greenSliderLabel = new Label();
		greenSliderLabel.x = previewXOffset + 2;
		greenSliderLabel.y = greenSlider.y - 18;
		greenSliderLabel.setText("Green: " + Color.getGreen(Common.palette.getColorHexByIndex(index)));
		addChild(greenSliderLabel);

		// Blue value slider
		blueSlider = new Slider(255);
		blueSlider.setValue(Color.getBlue(Common.palette.getColorHexByIndex(index)));
		blueSlider.x = previewXOffset + 5;
		blueSlider.y = 230;
		addChild(blueSlider);
		// Blue value label
		blueSliderLabel = new Label();
		blueSliderLabel.x = previewXOffset + 2;
		blueSliderLabel.y = blueSlider.y - 18;
		blueSliderLabel.setText("Blue: " + Color.getBlue(Common.palette.getColorHexByIndex(index)));
		addChild(blueSliderLabel);

		// Alpha value slider
		alphaSlider = new Slider(255);
		alphaSlider.setValue(Color.getAlpha(Common.palette.getColorHexByIndex(index)));
		alphaSlider.x = previewXOffset + 5;
		alphaSlider.y = 260;
		addChild(alphaSlider);
		// Alpha value label
		alphaSliderLabel = new Label();
		alphaSliderLabel.x = previewXOffset + 2;
		alphaSliderLabel.y = alphaSlider.y - 18;
		alphaSliderLabel.setText("Alpha: " + Color.getAlpha(Common.palette.getColorHexByIndex(index)));
		addChild(alphaSliderLabel);

		// Slider events
		redSlider.addEventListener(MouseEvent.MOUSE_DOWN, function(evt:MouseEvent){
			mouseIsDown = true;
		});
		greenSlider.addEventListener(MouseEvent.MOUSE_DOWN, function(evt:MouseEvent){
			mouseIsDown = true;
		});
		blueSlider.addEventListener(MouseEvent.MOUSE_DOWN, function(evt:MouseEvent){
			mouseIsDown = true;
		});
		alphaSlider.addEventListener(MouseEvent.MOUSE_DOWN, function(evt:MouseEvent){
			mouseIsDown = true;
		});

		redSlider.addEventListener(MouseEvent.MOUSE_UP, function(evt:MouseEvent){
			mouseIsDown = false;
		});
		greenSlider.addEventListener(MouseEvent.MOUSE_UP, function(evt:MouseEvent){
			mouseIsDown = false;
		});
		blueSlider.addEventListener(MouseEvent.MOUSE_UP, function(evt:MouseEvent){
			mouseIsDown = false;
		});
		alphaSlider.addEventListener(MouseEvent.MOUSE_UP, function(evt:MouseEvent){
			mouseIsDown = false;
		});

		addEventListener(Event.ENTER_FRAME, onUpdate);

		// Fade in
		this.alpha = 0;
		Actuate.tween(this, Common.animationLength, {alpha:1}).ease(Expo.easeOut);
	}

	function onUpdate(evt:Event){
		if(mouseIsDown){
			// Update color
			Common.palette.setColor(index, Color.toARGB(redSlider.getValue(), greenSlider.getValue(), blueSlider.getValue(), alphaSlider.getValue()));

			// Update color preview
			colorPreview.bitmapData.floodFill(0, 0, 0xFFFFFFFF);
			colorPreview.bitmapData.fillRect(new Rectangle(0, 0, previewXOffset, Common.screenHeight), Common.palette.getColorHexByIndex(index));

			shortHexCodeLabel.setText("#" + StringTools.hex(Color.toRGB(Color.getRed(Common.palette.getColorHexByIndex(index)), Color.getGreen(Common.palette.getColorHexByIndex(index)), Color.getBlue(Common.palette.getColorHexByIndex(index)))));
			// In cases where the leading 0s were not added, add them in
			if(shortHexCodeLabel.getText().length <= 6){
				for(i in 0...7-shortHexCodeLabel.getText().length){
					shortHexCodeLabel.setText("#" + 0 + shortHexCodeLabel.getText().substring(1, shortHexCodeLabel.getText().length));
				}
			}

			fullHexCodeLabel.setText("ARGB Hex: #" + StringTools.hex(Common.palette.getColorHexByIndex(index)));
			if(fullHexCodeLabel.getText().length <= 18){
				for(i in 0...19-fullHexCodeLabel.getText().length){
					fullHexCodeLabel.setText("ARGB Hex: #" + 0 + fullHexCodeLabel.getText().substring(11, fullHexCodeLabel.getText().length));
				}
			}

			readableLabel.setText("RGBA: (" + Color.getRed(Common.palette.getColorHexByIndex(index)) + ", " + Color.getGreen(Common.palette.getColorHexByIndex(index)) + ", " + Color.getBlue(Common.palette.getColorHexByIndex(index)) + ", " + Color.getAlpha(Common.palette.getColorHexByIndex(index)) + ")");

			redSliderLabel.setText("Red: " + Color.getRed(Common.palette.getColorHexByIndex(index)));
			greenSliderLabel.setText("Green: " + Color.getGreen(Common.palette.getColorHexByIndex(index)));
			blueSliderLabel.setText("Blue: " + Color.getBlue(Common.palette.getColorHexByIndex(index)));
			alphaSliderLabel.setText("Alpha: " + Color.getAlpha(Common.palette.getColorHexByIndex(index)));
		}
	}

	function onBackButtonClick(evt:MouseEvent){
		dismiss();
	}

	function onDuplicateButtonClick(evt:MouseEvent){
		if(Common.palette.canAddColors()) Common.palette.addColor(new Color(Common.palette.getColorHexByIndex(index)));
		dismiss();
	}

	function onDeleteButtonClick(evt:MouseEvent){
		Common.palette.removeColor(index);
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
