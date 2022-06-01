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



Customizing animations in SwiftUI 


When we attach the animation() modifier to a view, SwiftUI will automatically animate any changes that happen to that view using whatever is the default system animation, whenever the value we’re watching changes. In practice, that is an “ease in, ease out” animation, which means iOS will start the animation slow, make it pick up speed, then slow down as it approaches its end.

We can control the type of animation used by passing in different values to the modifier. For example, we could use .easeOut to make the animation start fast then slow down to a smooth stop:

.animation(.easeOut, value: animationAmount)

Tip: If you were curious, implicit animations always need to watch a particular value otherwise animations would be triggered for every small change – even rotating the device from portrait to landscape would trigger the animation, which would look strange.

There are even spring animations, that cause the movement to overshoot then return to settle at its target. You can control the initial stiffness of the spring (which sets its initial velocity when the animation starts), and also how fast the animation should be “damped” – lower values cause the spring to bounce back and forth for longer.

For example, this makes our button scale up quickly then bounce:

.animation(.interpolatingSpring(stiffness: 50, damping: 1), value: animationAmount)

For more precise control, we can customize the animation with a duration specified as a number of seconds. So, we could get an ease-in-out animation that lasts for two seconds like this:

struct ContentView: View {
    @State private var animationAmount = 1.0

    var body: some View {
        Button("Tap Me") {
            animationAmount += 1
        }
        .padding(50)
        .background(.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .scaleEffect(animationAmount)
        .animation(.easeInOut(duration: 2), value: animationAmount)
    }
}

When we say .easeInOut(duration: 2) we’re actually creating an instance of an Animation struct that has its own set of modifiers. So, we can attach modifiers directly to the animation to add a delay like this:

.animation(
    .easeInOut(duration: 2)
        .delay(1),
    value: animationAmount
)

With that in place, tapping the button will now wait for a second before executing a two-second animation.
We can also ask the animation to repeat a certain number of times, and even make it bounce back and forward by setting autoreverses to true. This creates a one-second animation that will bounce up and down before reaching its final size:

.animation(
    .easeInOut(duration: 1)
        .repeatCount(3, autoreverses: true),
    value: animationAmount
)

If we had set repeat count to 2 then the button would scale up then down again, then jump immediately back up to its larger scale. This is because ultimately the button must match the state of our program, regardless of what animations we apply – when the animation finishes the button must have whatever value is set in animationAmount.
For continuous animations, there is a repeatForever() modifier that can be used like this:

.animation(
    .easeInOut(duration: 1)
        .repeatForever(autoreverses: true),
    value: animationAmount
)

We can use these repeatForever() animations in combination with onAppear() to make animations that start immediately and continue animating for the life of the view.

To demonstrate this, we’re going to remove the animation from the button itself and instead apply it an overlay to make a sort of pulsating circle around the button. Overlays are created using an overlay() modifier, which lets us create new views at the same size and position as the view we’re overlaying.

So, first add this overlay() modifier to the button before the animation() modifier:

.overlay(
    Circle()
        .stroke(.red)
        .scaleEffect(animationAmount)
        .opacity(2 - animationAmount)
)

That makes a stroked red circle over our button, using an opacity value of 2 - animationAmount so that when animationAmount is 1 the opacity is 1 (it’s opaque) and when animationAmount is 2 the opacity is 0 (it’s transparent).
Next, remove the scaleEffect() and blur() modifiers from the button and comment out the animationAmount += 1 action part too, because we don’t want that to change any more, and move its animation modifier up to the circle inside the overlay:

.overlay(
    Circle()
        .stroke(.red)
        .scaleEffect(animationAmount)
        .opacity(2 - animationAmount)
        .animation(
            .easeOut(duration: 1)
                .repeatForever(autoreverses: false),
            value: animationAmount
        )
)

I’ve switched autoreverses to false, but otherwise it’s the same animation.
Finally, add an onAppear() modifier to the button, which will set animationAmount to 2:

.onAppear {
    animationAmount = 2
}

Because the overlay circle uses that for a “repeat forever” animation without autoreversing, you’ll see the overlay circle scale up and fade out continuously.
Your finished code should look like this:

Button("Tap Me") {
    // animationAmount += 1
}
.padding(50)
.background(.red)
.foregroundColor(.white)
.clipShape(Circle())
.overlay(
    Circle()
        .stroke(.red)
        .scaleEffect(animationAmount)
        .opacity(2 - animationAmount)
        .animation(
            .easeInOut(duration: 1)
                .repeatForever(autoreverses: false),
            value: animationAmount
        )
)
.onAppear {
    animationAmount = 2
}
















