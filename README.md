# Flutter Simple Slideshow

I noticed in Windows 11 there is no slideshow option anymore and the slideshow option in the new Photos app doesn't behave how I want it to, so I created this.

There's a lot more to add to it, but I've got everything how I normally use the slideshow.

It is only designed for a desktop environment and has only been tested on Windows 11.

## Details

- Time per image is 5 seconds
- Images are randomly shuffled when you start the slideshow
  
## How To Use

- Drag in your files or folders, or select them from the pop-up menu
- Click start
  
### Controls
- Left and right arrow keys: go forward and backward in slideshow
- Space: pause
- ESC: go back to the main menu

### Creating an executable
- `flutter build windows`
- Executable located in `project/build/windows/runner/Release`

## Future Plans
- Adding in settings for the slideshow that the user can tweak in the menu
  - Shuffle
  - Time per image
  - Repeat when at end
- A redesign of the main menu to be more aesthetically pleasing
