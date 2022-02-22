# DissolvingImageView

https://user-images.githubusercontent.com/1835776/155226214-897fa06d-7d35-4438-8ef5-f743dd2b066d.mp4

Apply a dissolve effect when loading an image on UIKit. Displaying so smoothly.

First prepare a thumbnail-sized image, then apply blur, and set it to the image view.

Next, retrieve the full size image from the network and replace the thumbnail. Dissolve animation is then applied.
(The demo version does not have a network feature.)

## DissolvingImageView.swift

This is a subclass of UIImageView. It has two main methods.

`setPreloadImage(_ baseImage: UIImage)`

`setImageDissolving(_ image: UIImage, duration: TimeInterval)`
