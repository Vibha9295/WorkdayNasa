# WorkdayNasa
A simple iOS application that exposes the search functionality of the NASA Image with API and details.

# Description
The iOS app demonstrates clean architecture by implementing MVVM software desgin pattern. The app has been integrated with Nasa Open API with URL sessions for search (for example: "Mars") with pagination to load more data. When tap on any image, it will pop up next detail page screen, it will show some details such as image, title, description and when it was created.

# Architecture ⚒️ 
I used the MVVM architecture pattern, because I think it has the perfect balance between response data and functionality for a small-medium sized project.

# API Calls
I used the URL session-REST way to implement the API calls using NetworkingService class.

# UI
I used storyboard to design the UI. I also design a couple of views programmatically when it's necessary.

# Libraries or Dependency 📚
I have used CocoaPods for loading GIF - FLAnimatedImage is a performant animated GIF engine for iOS.
To add it to your app, copy the two classes FLAnimatedImage.h/.m and FLAnimatedImageView.h/.m into your Xcode project or add via CocoaPods by adding this to your Podfile:

pod 'FLAnimatedImage', '~> 1.0'

# Running the Tests
I have write XCTest for application perfomace and API.

