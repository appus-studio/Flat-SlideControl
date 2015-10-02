RangeBar
=====================

Made in [![Appus Studio](https://github.com/appus-studio/Appus-Splash/blob/master/image/logo.png)](http://appus.pro)

RangeBar is a bar in material design, which is similar to SeekBar widget, that gives you an opportunity to make a selection of a range of values.

* [Demo](#demo)
* [Getting Started](#getting-started)
* [Customization](#customization)
* [Info](#info)

# Demo

##Usage:

![](https://github.com/appus-studio/Appus-RangeBar/blob/master/image/main.gif)

##Custom color:

![](https://github.com/appus-studio/Appus-RangeBar/blob/master/image/color.gif)

##Custom line width:

![](https://github.com/appus-studio/Appus-RangeBar/blob/master/image/line_size.gif)

##Custom pin radius:

![](https://github.com/appus-studio/Appus-RangeBar/blob/master/image/pin_size.gif)

##Custom value interval:

![](https://github.com/appus-studio/Appus-RangeBar/blob/master/image/interval.gif)


# Getting Started


##Setup:

1. If you use JCenter repository in your project, just add dependence to main build.gradle:

        dependencies {
                compile 'pro.appus:rangebar:1.0.0'
        }
   
   Else add repository to the same build.gradle:
   
        repositories {
                maven {
                        url 'https://dl.bintray.com/roman-voronoy/maven/'
                }
        }
        
        
2. Done!

##Usage example:

RangeBar can send callbacks for subscribers. For subscribing you need to set a listener:

    yourRangeBar.setOnRangeBarChangeListener(new RangeBar.OnRangeBarChangeListener() {
        @Override
        public void onValueChanged(RangeBar rangeBar, int leftIndex, int rightIndex, String leftValue, String rightValue) {

            ... your code here ...

        }
    });

# Customization

##Tick attributes:
tickStartValue - integer
tickEndValue - integer
tickInterval - float
tickRadius - dimension
tickColor - color

##Pin attributes:
pinWidth - dimension
pinColor - color

##Thumb attributes:
thumbColor - color
thumbLeftIndex - integer
thumbRightIndex - integer

##Connecting line attributes:
connectingLineStrokeWidth - dimension
connectingLineColor - color

##Text attributes:
textColor - color


# Info

Developed By
------------

* Igor Malytsky, Appus Studio

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
