# `TypedNotification`: Strongly typed notifications in Swift

Notifications are a common communication mechanism on Apple platforms, but their API is [stringly-typed](http://wiki.c2.com/?StringlyTyped) and uses a `Dictionary` to carry extra information, both of which mean that failures are totally silent. That ain't Swifty!™

`TypedNotification` provides a wrapper around `Foundation.NotificationCenter` that lets the compiler help you out. It removes the magic strings, and provides a strongly typed way to send extra data.

`TypedNotification` is implemented as a protocol. Just make your `enum`s conform, and BAM you're done.

## This repo

This repo contains an Xcode playground demonstrating the use of `TypedNotification`. Launch the playground, and poke around the Sources folder. You're free to also use the pug-themed code.

This repo also contains the presentation I gave at [SLUG](https://www.meetup.com/swift-language/events/237430703/) (video forthcoming).

## Suggestions?

Make a [PR](https://github.com/mrh-is/PugNotification/pulls)! I've already improved this code several times while writing the presentation, so there's surely more ways to make it better.
