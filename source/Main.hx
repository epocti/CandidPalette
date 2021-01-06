package;

import openfl.display.BitmapData;
import openfl.net.FileFilter;
import openfl.net.FileReference;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.display.Sprite;

class Main extends Sprite {
	public function new(){
		super();
		// Stage setup - no resize, window size constants, 60fps
		lime.app.Application.current.window.resizable = false;
		lime.app.Application.current.window.width = Common.screenWidth;
		lime.app.Application.current.window.height = Common.screenHeight;
		stage.frameRate = 60;

		// Init palette
		Common.palette = new Palette();

		// Color from image button
		var colFromImageButton:TextButton = new TextButton("Color From Image");
		colFromImageButton.x = 2;
		colFromImageButton.y = 2;
		addChild(colFromImageButton);
		colFromImageButton.addEventListener(MouseEvent.CLICK, onColFromImageButtonClick);

		// Palette from image button
		var palFromImageButton:TextButton = new TextButton("Palette From Image");
		palFromImageButton.x = colFromImageButton.x + colFromImageButton.width + 2;
		palFromImageButton.y = 2;
		addChild(palFromImageButton);
		palFromImageButton.addEventListener(MouseEvent.CLICK, onPalFromImageButtonClick);

		// Load button
		var loadPalButton:TextButton = new TextButton("Load...");
		loadPalButton.x = palFromImageButton.x + palFromImageButton.width + 2;
		loadPalButton.y = 2;
		addChild(loadPalButton);
		loadPalButton.addEventListener(MouseEvent.CLICK, onOpenButtonClick);

		// Save button
		var savePalButton:TextButton = new TextButton("Save...");
		savePalButton.x = loadPalButton.x + loadPalButton.width + 2;
		savePalButton.y = 2;
		addChild(savePalButton);
		savePalButton.addEventListener(MouseEvent.CLICK, onSaveButtonClick);
		savePalButton.addEventListener(MouseEvent.RIGHT_CLICK, onSaveButtonRightClick);
		savePalButton.addEventListener(MouseEvent.MIDDLE_CLICK, onSaveButtonMidClick);

		addChild(Common.palette);
	}

	// Color from image
	function onColFromImageButtonClick(evt:MouseEvent){
		// Init dialog
		var openDialog:FileReference = new FileReference();
		openDialog.browse([new FileFilter("PNG Images", "png")]);
		// On open
		openDialog.addEventListener(Event.SELECT, function(evt:Event){
			cast(evt.target, FileReference).load();
		});
		// On load
		openDialog.addEventListener(Event.COMPLETE, function(evt:Event){
			var view:ImageView = new ImageView(BitmapData.fromBytes(cast(evt.target, FileReference).data));
			addChild(view);
		});
	}

	// Palette from image
	function onPalFromImageButtonClick(evt:MouseEvent){
		// Init dialog
		var openDialog:FileReference = new FileReference();
		openDialog.browse([new FileFilter("PNG Images", "png")]);
		// On file open
		openDialog.addEventListener(Event.SELECT, function(evt:Event){
			cast(evt.target, FileReference).load();
		});
		// On load finish
		openDialog.addEventListener(Event.COMPLETE, function(evt:Event){
			var imgData:BitmapData = BitmapData.fromBytes(cast(evt.target, FileReference).data);
			Common.palette.newPaletteFromImage(imgData);
		});
	}

	// Loading
	function onOpenButtonClick(evt:MouseEvent){
		// Init dialog
		var openDialog:FileReference = new FileReference();
		openDialog.browse([new FileFilter("PowerPalette palettes (.epl)", "epl")]);
		// On open
		openDialog.addEventListener(Event.SELECT, function(evt:Event){
			cast(evt.target, FileReference).load();
		});
		// On load finish
		openDialog.addEventListener(Event.COMPLETE, function(evt:Event){
			var data:String = cast(evt.target, FileReference).data.toString();
			// Check if file matches
			if(data.substring(0, 14) == "; powerpalette"){
				Common.palette.clear();
				trace("is a powerpalette file");
				// Make all new line indicators consistent
				data = StringTools.replace(data, "\r\n", "\n\r");
				data = StringTools.replace(data, "\n\r", "\r");
				data = StringTools.replace(data, "\n", "\r");
				// Add all colors into the palette
				for(i in 1...data.split("\r").length - 1){
					Common.palette.addColor(new Color(Std.parseInt(data.split("\r")[i])));
				}
				Common.palette.updateDisplay(true);
			}
			else trace("Not a PowerPalette file!");
		});
	}

	// Save as powerpalette file (epl)
	function onSaveButtonClick(evt:MouseEvent){
		// Init dialog + data
		var saveDialog:FileReference = new FileReference();
		var data:String = "; powerpalette\r\n";

		// Get each color into the data
		for(color in Common.palette.colors){
			data += "0x" + StringTools.hex(color.getColor()) + "\r\n";
		}

		// Open dialog and save
		saveDialog.save(data, "Untitled Palette.epl");
	}

	// Save as paint.net-compatible palette (txt)
	function onSaveButtonRightClick(evt:MouseEvent){
		// Init dialog + data
		var saveDialog:FileReference = new FileReference();
		var data:String = "; paint.net Palette File\r\n";

		// Get each color into the data
		for(color in Common.palette.colors){
			data += StringTools.hex(color.getColor()) + "\r\n";
		}

		// Open dialog and save
		saveDialog.save(data, "Untitled Palette.txt");
	}

	// Save as GIMP/Aseprite-compatible palette (gpl)
	function onSaveButtonMidClick(evt:MouseEvent){
		// Init dialog + data
		var saveDialog:FileReference = new FileReference();
		var data:String = "GIMP Palette\r\n#\r\n";

		// Get each color into the data
		for(color in Common.palette.colors){
			data += Color.getRed(color.getColor()) + "\t" + Color.getGreen(color.getColor()) + "\t" + Color.getBlue(color.getColor()) + "\tUntitled\r\n";
		}

		// Open dialog and save
		saveDialog.save(data, "Untitled Palette.gpl");
	}
}
