# iOSLoadingButtonView
this is a small library about showing loading and indicator in UIButton


# Configs
```swift
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


#start and stop loading, update percent
```
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


