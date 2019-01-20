# iOSLoadingButtonView
this is a small library to show loading and indicator in UIButton, colors are customizable

# TOP_LINE
![TOP_LINE](https://cdn.rawgit.com/farshadjahanmanesh/iOSLoadingButtonView/0056f06b/loadingButton/examples/__uberLike.gif)

# INDICATOR,
![INDICATOR](https://cdn.rawgit.com/farshadjahanmanesh/iOSLoadingButtonView/0056f06b/loadingButton/examples/__indicatorViewEx.gif)

# BACKGROUND_HIGHLIGHTER
![BACKGROUND_HIGHLIGHTER](https://cdn.rawgit.com/farshadjahanmanesh/iOSLoadingButtonView/0056f06b/loadingButton/examples/__fillngEx.gif)

# CIRCLE_AND_TICK
![CIRCLE_AND_TICK](https://cdn.rawgit.com/farshadjahanmanesh/iOSLoadingButtonView/0056f06b/loadingButton/examples/__circleEx.gif)

# ALL
![ALL](https://cdn.rawgit.com/farshadjahanmanesh/iOSLoadingButtonView/0056f06b/loadingButton/examples/__allInOneEx.gif)

# installation cocoapods
just add this line into your podfile
```swift
  pod 'loadingButtonOBJC'
```
or simply copy the source into your project, take a look at example project for more info

# Configs
```objective-c
  //you can set these in interface builder or code
   
  // AnimationType in Interfacebuilder
  Int setAnimationType;
  (default)  NONE = 0,
    TOP_LINE = 1,
    INDICATOR = 2,
    BACKGROUND_HIGHLIGHTER = 3,
    CIRCLE_AND_TICK = 4,
    ALL = 5

  //or in code - default none
  LoadingType animationType;
  
  //loading color, set this in code or IB - default black
  UIColor setLoadingColor;
  
  //loading color, set this in code or IB - default black
  UIColor setFilledBackgroundColor;
  
  // indicator view color (white or gray) - default white
  BOOL setIndicatorViewDarkStyle;
  
```

# start and stop loading, update percent
```objective-c
// just import this
#import "LBVLoadingButtonView.h"

//start
[button startLoading:BACKGROUND_HIGHLIGHTER];

//stop
[button endLoading];

//update filling background 
[self fillTheButtonWith:percent];

//update circle stroke in circle mode
[self fillTheCircleStrokeLoadingWith:percent];

//(e.g)
[NSTimer scheduledTimerWithTimeInterval:1 repeats:true block:^(NSTimer * _Nonnull timer) {
        percent += 10;
       [self fillTheCircleStrokeLoadingWith:percent];
       [self fillTheButtonWith:percent];
 }];
```

also you can use it as a class for your buttons in interface builder, and change those options from interface builder

## set class
![ALL](https://raw.githubusercontent.com/farshadjahanmanesh/iOSLoadingButtonView/master/loadingButton/examples/_setClass.png)

## change attributes
![ALL](https://raw.githubusercontent.com/farshadjahanmanesh/iOSLoadingButtonView/master/loadingButton/examples/_properties.png)

<video width="320" height="240" controls>
  <source src="https://raw.githubusercontent.com/farshadjahanmanesh/iOSLoadingButtonView/master/loadingButton/examples/video.mp4" type="video/mp4">
</video
