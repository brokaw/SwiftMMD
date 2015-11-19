SwiftMMD
========

This is a Swift wrapper around [MultiMarkdown 5](https://github.com/fletcher/MultiMarkdown-5). 

This software is exteremly young, untested, and is likely to catch your computer on fire. I haven't even tried running all the functions I've written. _Caveat computer_. 

I've defined a few methods in an extension on String.

```swift
let myMarkdown: String = ...
let myDoc: String = myMarkdown.mmdToHTMLDocument()
let myOutput: String = myMarkdown.mmeRenderToFormat(...)
//and others
```

It's designed to be very thin. The primary aim is to sheild you from the indelicacies of `UnsafeMutablePointer<Int8>` when all you want is a `String`, and other unsavory aspects of C interop.