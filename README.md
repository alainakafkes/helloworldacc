# Welcome to the helloworldacc repository! #

## About the Developer ##
Hi there! My name is Alaina Kafkes, and I created helloworldacc as a mini-hack for EECS 395 Mobile & Wireless Health at Northwestern University.
I've had a long time interest in developing medically relevant technologies, and I'm excited to show my first efforts here.

## About the App ##
Helloworldacc (henceforth denoted by HWA) is a single-view application created on Xcode using the Swift programming language.
It relies heavily on the iOS Core Motion framework, which gives Apple developers the ability to access and process motion data
from the hardware (i.e. accelerometers, gyroscopes, etc.) built into Apple devices. I decided to use the accelerometer as my sensor
for this project.

According to my application's logic, if the maximum X-direction acceleration experienced by the Apple Device exceeds
some minimum threshold value, the word "hello" is displayed. If the maximum X-direction acceleration experienced by the Apple Device
stays below said threshold, the word "world" is displayed. The user additionally has the capability to reset ("zero") the maximum
X-direction acceleration to zero if they so choose. I chose to work with maximum X-direction acceleration rather than real-time
X-direction acceleration because it is difficult to read the words "hello" and "world" if the Apple Device is shaken fast enough.


HWA additionally allows the user to set the threshold value that distinguishes between "hello" and "world" – a user can type a number
into a text box on the graphical interface and simply press "set!," thereby altering the threshold. A default threshold value is also
set.

HWA communicates with [my personal databse on Firebase](https://fiery-inferno-9226.firebaseio.com/#) such that "hello" is displayed
on Firebase when the maximum X-acceleration is above the threshold, and "world" is displayed when the maximum X-acceleration is below
the threshold. I found this database easiest to use for the limited data storage needs of HWA.

Though I have some experience in programming for Apple devices, this project represents my first foray into Swift and my first time
using the Core Motion framework. I'm excited about the skils I have developed and I hope I get the opportunity to create applications
on iOS again in the near future.

I tested and debugged this application on an iPhone 5, so its graphical user interface is optimized for that device.
