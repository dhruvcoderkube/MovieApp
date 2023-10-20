# MovieApp
A sample project that demonstrates how to create a view that will secure from screenshots or screen recording. It also provide a placeholder view that you can modify according to choice. 

## Requirements
1. Xcode 12.1 or later
2. iOS 13.0 or later

## Demo
- Clone this project, then build for any iOS simulator to test this out.
- By triggering screenshot on simulator, look for Simulator > Device > Trigger Screenshot.

## Example
- You can wrap view you don't want to be screenshot or record inside SecureView.

```swift
class SecureView: UIView {

    // placeholder will become visible when user try to capture screenshot
    // or try to record the screen
    private(set) var placeholderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // add your content in this view
    // it will be secure
    private(set) var contentView: UIView = {
        let hiddenView = UIView()
        hiddenView.makeSecure()
        hiddenView.translatesAutoresizingMaskIntoConstraints = false
        return hiddenView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    fileprivate func setupView() {

        self.addSubview(placeholderView)
        self.addSubview(contentView)

        NSLayoutConstraint.activate([
            placeholderView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            placeholderView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            placeholderView.topAnchor.constraint(equalTo: self.topAnchor),
            placeholderView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: self.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
}
```

- And Use your SecureView like this 
```swift
view.addSubview(secureView)
secureView.contentView.addSubview(movieTableView)
secureView.placeholderView.addSubview(placeholderTextLabel)
```
