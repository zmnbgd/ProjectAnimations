DAY 32

Today you have five topics to work through, in which you’ll learn about implicit animations, explicit animations, binding animations, and more.



Animation: Introduction

Animations are there for a few reasons, of which one definitely is to make our user interfaces look better. However, they are also there to help users understand what’s going on with our program.



Creating implicit animations

In SwiftUI, the simplest type of animation is an implicit one: we tell our views ahead of time “if someone wants to animate you, here’s how you should respond”, and nothing more. SwiftUI will then take care of making sure any changes that do occur follow the animation you requested. In practice this makes animation trivial – it literally could not be any easier.

Let’s start with an example. This code shows a simple red button with no action, using 50 points of padding and a circular clip shape:

Button("Tap Me") {
    // do nothing
}
.padding(50)
.background(.red)
.foregroundColor(.white)
.clipShape(Circle())

What we want is for that button to get bigger every time it’s tapped, and we can do that with a new modifier called scaleEffect(). You provide this with a value from 0 up, and it will be drawn at that size – a value of 1.0 is equivalent to 100%, i.e. the button’s normal size.

Because we want to change the scale effect value every time the button is tapped, we need to use an @State property that will store a Double.

@State private var animationAmount = 1.0

Now we can make the button use that for its scale effect, by adding this modifier:

Now we can make the button use that for its scale effect, by adding this modifier:

Finally, when the button is tapped we want to increase the animation amount by 1, so use this for the button’s action:

animationAmount += 1

If you run that code you’ll see that you can tap the button repeatedly to have it scale up and up. It won’t get redrawn at increasingly high resolutions, so as the button gets bigger you’ll see it gets a bit blurry, but that’s OK.

Now, the human eye is highly sensitive to movement – we’re extremely good at detecting when things move or change their appearance, which is what makes animation both so important and so pleasing. So, we can ask SwiftUI to create an implicit animation for our changes so that all the scaling happens smoothly by adding an animation() modifier to the button:

.animation(.default, value: animationAmount)

That asks SwiftUI to apply a default animation whenever the value of animationAmount changes, and immediately you’ll see that tapping the button now causes it to scale up with an animation.

That implicit animation takes effect on all properties of the view that change, meaning that if we attach more animating modifiers to the view then they will all change together. For example, we could add a second new modifier to the button, .blur(), which lets us add a Gaussian blur with a special radius – add this before the animation() modifier:

.blur(radius: (animationAmount - 1) * 3)

A radius of (animationAmount - 1) * 3 means the blur radius will start at 0 (no blur), but then move to 3 points, 6 points, 9 points, and beyond as you tap the button.

















