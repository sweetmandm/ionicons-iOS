# ionicons-iOS
Easily use ionicons in your native SDK iOS projects

*Currently using ionicons 1.5.2*  

### About
The ionicons icon set includes a lot of iOS system icons as well as plenty of handy additions. The great thing about ionicons is it makes the system icons a lot handier and more customizable, while adding more icon options. Also, with ionicons-iOS you can use iOS 7 system icons in your native SDK iOS 5+ projects, so your designs will have a consistent appearance across all OS versions.

### Usage:

For available icons, look at ionicons-codes.h or [browse them at the **ionicons** website](http://ionicons.com).

Get the font:

    UIFont *ionIconsFont = [IonIcons fontWithSize:30.0f];

Make a UILabel with an ionicons icon:

    UILabel *label = [IonIcons labelWithIcon:icon_ionic size:20.0f color:[UIColor blackColor]];

Render an ionicons icon in a UIImage:

        UIImage *icon = [IonIcons imageWithIcon:icon_ionic
                                      iconColor:[UIColor redColor] 
                                       iconSize:60.0f 
                                      imageSize:CGSizeMake(90.0f, 90.0f)];


### Installation Step 1:

CocoaPods is great:

1. add `pod 'ionicons'` to your Podfile
2. `pod install`
3. open the xcworkspace
4. Modify your project's Info.plist file as described below

Non-CocoaPods is easy too:

1. Drag the folder 'ionicons' with the source files into your project
2. Modify your project's Info.plist file as described below

### Installation Step 2:

Modify your project's Info.plist file:

1. Open your project's Info.plist file by clicking on the project in the Navigator on the left, then choosing 'Info'.
2. Under 'Custom iOS Target Properties', click the last Key in the list, then click on the '+' icon.
3. For the new key, type 'Fonts provided by application'.
4. Twirl down the arrow icon, double-tap the right-most box to enter the string value, and type 'ionicons.ttf'.
![Info.plist modification](https://raw.github.com/TapTemplate/ionicons-iOS/master/Example-ionicons/img/install-instructions.png)

## Shameles Plug:
I built this for inclusion in my app design templates available at [TapTemplate](http://www.taptemplate.com)

### License
ionicons is released under the MIT license.  
The stuff specific to ionicons-iOS is also released under the MIT license
