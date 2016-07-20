# Navigation Stack Gesture Animator (What a mouth full)
Navigation Controllers are a pain to make transitions for later in the game. Right?    
**NOT ANY MOAR**


Interactive transitions with custom animations make you look like a better developer and they make your product seem more properly engineered. Its that last 5% not everything has. 

The issue is how clunky it is to retroactively add them.  Wouldn't it be nice to just add a protocol to your view controller that allows you to call a segue with a dynamic animator. Something like this

````
extension ViewController : CYNavigationPush {
    var seguePush:String {
        return "viewControllerPush"
    }
    var pushAnimator:UIViewControllerAnimatedTransitioning? { 
    	return PushAnimator() 
    }
}
extension ViewController : CYNavigationPop  {
    var popAnimator:UIViewControllerAnimatedTransitioning? { 
    	return PopAnimator() 
    }
}
````

Adding gesture invocation is especially hard to do later on. Wouldn't it be nice to just tell the `UINavigationController` that swipe left means push. Something like this

````
navigationController.swipeLeftForPushRightForPop()

````



###So that is what I created. 
THE OVERHEAD WORK IS DONE. SPENT THE TIME ON YOUR ANIMATION. 

The `UIViewController` protocol mixed with a subclass of a `UINavigationController` now gives you the the ability to change after the view controller relationships are written.

- a dynamic segue to be called  
- a dynamic animator to perform  

 A gesture recognizer powered by a direction extended enum provides:

- the flexiblility to change the gesture that invokes the segue 
- the ability to customize your navigation controller as you see fit

The example project shows you the simple power. Anywhere in the navigation stack you can change the animation method to push and pop in any order you like while maintaining the original stack.
 
 
<br/>
*Note: We have to subclass the `UINavigationController` because its delegate methods for the gesture recognizer are not passed through the protocol. I don't like it either but BOO HOO*


