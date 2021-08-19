# Lövely Toasts: toasts for Löve2D
Made and tested in Löve2D v11.3

![](https://i.imgur.com/yWbfz0l.gif)
## Usage
Step 1: Place the "lovelyToasts.lua" library somewhere in your source folder (e.g. "/lib/soupy.lua")<br/><br/>
Step 2: Add a variable to require the library in your main.lua file:
```lua
lovelyToasts = require("lib.lovelyToasts")
```
Step 3: Call lovelyToast's draw and update functions
```lua
function love.update(dt)
  lovelyToasts.update(dt)
end

function love.draw()
  lovelyToasts.draw()
end
```
Step 4: Show a toast message!
```lua
lovelyToasts.show("This is a Lövely toast :)")
```

For best looking toasts, set `t.window.msaa` in your conf.lua to 16

## Customization
Other than the toast message you can also pass a duration and position
```lua
lovelyToasts.show("Lövely toast :)", 2, "top")
```
This will create a toast messsage at the top of the screen that appears for 2 seconds. Other options for the position are "middle", to put the toast in the center of the screen, "bottom", the default value, or a number for the Y position.

### Styling
Various attributes of the toast message can be changed by changing the values in `lovelyToasts.style`
- **lovelyToasts.style.font** The font to use for the toast message
- **lovelyToasts.style.textColor** The color of the text
- **lovelyToasts.style.backgroundColor** The color of the toast
- **lovelyToasts.style.paddingLR** Left and right padding in the toast
- **lovelyToasts.style.paddingTB** Top and bottom padding in the toast

### Other options
- **lovelyToasts.options.tapToDismiss** (set to false by default)<br/>Allows user to tap or click on the toast message to dismiss it
- **lovelyToasts.options.queueEnabled** (set to false by default)<br/>When set to true the toasts don't replace, but enter a queue so you can queue multiple toasts in a row
- **lovelyToasts.options.animationDuration** (set to 0.3 by default)<br/>Animation duration for appear and disappear animation

In order for `lovelyToasts.options.tapToDismiss` to work you need to implement Love's mousereleased for mouse and/or touchreleased for touch screens such a mobile devices.
```lua
function love.mousereleased(x, y, button)
  lovelyToasts.mousereleased(x, y, button)
end

function love.touchreleased(id, x, y, dx, dy, pressure)
  lovelyToasts.touchreleased(id, x, y, dx, dy, pressure)
end
```

- **lovelyToasts.canvasSize**<br/>If you're using a rendering library such as TLfres to scale your game you might run into issues where LT doesn't renders toasts in the center of the screen, to fix this issue you just have to pass the canvas size you're rendering your game for to LT's canvasSize property.

Example:
```lua
local CANVAS_WIDTH = 1920
local CANVAS_HEIGHT = 1080

function love.load()
	--

	LovelyToasts.canvasSize = { CANVAS_WIDTH, CANVAS_HEIGHT }
end

function love.draw()
	tlfres.beginRendering(CANVAS_WIDTH, CANVAS_HEIGHT)
	love.graphics.setBackgroundColor(1, 1, 1)
	LovelyToasts.draw()
	tlfres.endRendering()
end
```

## License
MIT
