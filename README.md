# Olimpo

Olimpo is simplifies image caching and download operations. It manages downloaded image and moves to given UIimageView.

## Example

In this example, olimpo downloads given url data and converts it to uiimage, when it finishes conversion, it assigns image to imageView's image.

```swift

Olimpo.load("https://assets-cdn.github.com/images/modules/logos_page/GitHub-Mark.png").into(imageView);

```

To see how does it work with TableView, check out olimpoDemo project.

## TODO

Scaling options for downloaded image
Making caching machanism more dynamic



