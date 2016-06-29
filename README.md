# Olimpo

Olimpo simplifies image caching and download operations. It manages downloaded image and moves to given UIimageView.

## Example

In this example, olimpo downloads given url data and converts data to uiimage, when olimpo finishes conversion, it assigns image to imageView's image.

```swift

Olimpo.load("https://assets-cdn.github.com/images/modules/logos_page/GitHub-Mark.png").into(imageView);

```

To see how does olimpo work with TableView, check out olimpoDemo project.

## TODO

Scaling options for downloaded image<br />
Making caching machanism more dynamic



