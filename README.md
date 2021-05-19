# Lövely Toasts: toasts for Löve2D

## Usage
Step 1: Place the "lovelyToasts.lua" library somewhere in your source folder (e.g. "/lib/soupy.lua")<br/>
Step 2: Add a variable to require the library in your main.lua file:
```lua
lovelyToasts = require("lib.lovelyToasts")
```
Step 3: Show a toast message!
```lua
lovelyToasts.show("This is a Lövely toast :)")
```

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

## License
MIT
