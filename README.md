Flat-SlideControl
=====================

Made in [![Appus Studio](https://github.com/appus-studio/Appus-Splash/blob/master/image/logo.png)](http://appus.pro)

'Flat-SlideControl' is a control in material design, which gives you an opportunity to make a selection of a range of values

* [Demo](#demo)
* [Setup](#setup)
* [Usage example](#usage-example)
* [Info](#info)

# Demo

##Configuration:

![](https://github.com/CrazyRA2Ivan/Test/blob/qweqwe/storyboardConfig.gif)

##Usage:

![](https://github.com/CrazyRA2Ivan/Test/blob/qweqwe/usage.gif)

##Setup:
```Ruby
pod 'Flat-SlideControl', '~> 0.0.1'
```

##Usage example:

    FlatSlideControl *flatSlideControl = [[FlatSlideControl alloc] initWithFrame:slideControlFrame];
    flatSlideControl.groundColor = [UIColor lightGrayColor];
    flatSlideControl.tintColor = [UIColor redColor];
    flatSlideControl.thumbRadius = 30;
    flatSlideControl.lineWidth = 5;
    flatSlideControl.thumbsCount = 4;
    [flatSlideControl setLeftValue:1 rightValue:2];
    [self.view addSubview:flatSlideControl];

# Info

Developed By
------------

* Alexey Kubas, Appus Studio

License
--------

    Copyright 2015 Appus Studio.

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
