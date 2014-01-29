to.do
====

a simple todo list management application, built for iPhone on iOS.

## Usage

#### To add a new todo
touch the _+_

![adding a new todo](https://dl.dropboxusercontent.com/u/3992486/app_screenshots/todo/add_a_new_todo.PNG)



#### To remove a completed todo
touch _Edit_ then _-_

![remove a completed todo](https://dl.dropboxusercontent.com/u/3992486/app_screenshots/todo/remove_a_todo.PNG)



#### To re-prioritize a todo
touch _Edit_ then drag the _==_

![reprioritize a todo](https://dl.dropboxusercontent.com/u/3992486/app_screenshots/todo/move_a_todo.PNG)



## Architecture Decision Records (ADRs)

[Haven't heard of an ADR before?](http://thinkrelevance.com/blog/2011/11/15/documenting-architecture-decisions)

The simple to.do app is built mostly with vanilla iOS components, but there are a few deviations.

#### no storyboard, no interface builder

I opted to define the entire layout in code for this project. I believe this was the right choice, it forced me to learn a little of the complicated relationships between UIKit classes (checkout UITextView, NSTextContainer, NSTextStorage, NSLayoutManager, NSAttributedString!), which would have been hard to do had I just relied on Interface Builder.


#### custom UIKit subclasses

Initially, I went way overboard trying to subclass all the UIKit classes I was using. It got far too complicated and I refactored out many of them, but I still have subclasses for UITableViewController, UITableViewCell and UITextView. The UITextView subclass was the most beneficial since it allowed me to be very precise in the layout settings & contraints.


#### using NSNotificationCenter

After subclassing all the UIKit objects and maintaining only one-way references, I needed a way to notify updates from the individual views back up to the UITableViewController. It seemed like the choices were maintaining direct references (delegation), [method swizzling](http://funwithobjc.tumblr.com/post/1482839994/method-swizzling), [key-value observing](https://developer.apple.com/library/mac/documentation/cocoa/conceptual/KeyValueObserving/KeyValueObserving.html) or [NSNotificationCenter](https://developer.apple.com/library/mac/documentation/cocoa/reference/foundation/Classes/NSNotificationCenter_Class/Reference/Reference.html). I went with NSNotificationCenter because it supported notifying with object references easily.
NSNotificationCenter is great, but it is definitely intended for more asynchronous applications. There is a noticable time delay between a UITextView notifying a UITableCellView, then notifying a UITableViewController before re-rendering the views. Some delay could have been removed by observing some UITextView notifications directly in the UITableViewController, but others require data that only the UITableViewCell derivative contains.


#### using Parse

[Parse](parse.com) is the data storage backend, used for storing & retrieving todo items. I could have chosen to use the iOS CoreData API, but opted for the trendier Parse because I had used it before. Unfortunately, I previously used the ruby API and the Objective-C API for Parse is completely different. I actually found the Objective-C API quite a challenge; my attempt at subclassing PFObject & calling [self saveInBackground] was giving runtime crashes with stacktraces deep in the Parse library. Not cool. The custom PFObject subclass is still in the codebase, but sitting there unused until more time can be invested in debugging it's usage.
Instead, I converted to using the simple store/retrieve by key which works but is not as nice.

I haven't gotten around to doing Parse login & user association yet; that would be an obvious next feature to add.


