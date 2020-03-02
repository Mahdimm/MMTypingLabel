# MMTypingLabel
This Library provides type writer animation for `UILabel` of `UIKit`.

<img src="https://raw.githubusercontent.com/Mahdimm/MMTypinglabel/develop/Typinglabel.gif" width="340" height="550">

## Installation

### Manual
Drag and drop `MMTypingLabel.swift` into you're project.


## Usage

1. Change the class of a label to `MMTypingLabel`

2. Set text property 

3. Set interval for typing delay


## Sample Code

```swift
let label = MMTypingLabel()
label.text = "hi it would be cool"
// Set constraints

label.didFinishAnimating = { [weak self] in
   print("Finished")
}
```
You can pause and continue animation with help of these two function

```swift
label.pause()

label.continueAnimating()
```

## License

This code is distributed under the terms and conditions of the MIT license.
