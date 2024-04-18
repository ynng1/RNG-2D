<h1>Audio-based OTP generator</h1>
<br>
<h3>Introduction and Objective</h3>
<p>The goal of the project is to utilise an audio signal to generate a string of random numbers to be used for one-time passwords(OTP).
<br>
From a playlist of 25000 songs, the user would use the random shuffle feature to play a song randomly when he/she wants to generate an OTP.
<br>
The voltage of the audio signal is then converted by a CMOD-A7's XADC to a digital output that acts as the seed for the random number generation.</p>
<br>
<h3>Here's how the random number generation works:</h3>
We use a 16 Bit Linear Feedback Shift Register (LFSR) for our pseudo random generator. For the initial input, we use a seed value that is captured from the XADC (the analog pin of the CMOD A7). For the subsequent inputs, We choose to tap the values at 0,2,3,5 and use the output as a feedback loop into the input.

The seed value is captured every second from the constant input from the XADC and is constantly therefore constantly changing. When the reset button is pressed, the seed value would then return to its default seed value. 

We used the LFSR as it has a relatively normal distribution in its output in generating random nummbers.
<h4>Advantages of using our method:</h4>
<h4>Disadvantages of using our method:</h4>
<br>
<h3>Future improvements:</h3>
<h4>Alternative methods that could be explored:</h4>
<h4>Potential drawbacks of alternative methods:</h4>
<br>

<h3>Analogue Input to FPGA</h3>
Our analogue input signal is derived from audio signals. Music played from the device is output through a 3.5mm auxiliary jack and is fed into a LM386 audio amplifier. The music volume output is controlled, and audio signal is adjusted to amplify a value ranging from approximately -1.2v to +1.2v. 
The AC audio signal is then DC biased using a coupling capacitor and a potential divider circuit. We considered the RC time constant of the coupling capacitor, ensuring the time constant of the capacitor used must be below 50microseconds, so the discharge would not distort the output of the AC audio signal. The AC signal is given a 1.5V DC bias so the FPGA analogue input is hovering between 0V and +2.7V. This fits within the 0 to 3.3V range of the FPGA analogue input.
<h4>Here's the schemetic to our circuit:</h4>

![Analogue Input Circuit](https://github.com/ynng1/RNG-2D/assets/94187124/015c58da-4cce-41cd-ad53-e021a67f68df)


<br>
<h3>This is a video of the circuit working:</h3>

<br>
<video width="630" height="300" src="https://github.com/ynng1/RNG-2D/assets/163510534/4efd0c9e-b643-474c-8d42-8fd5adb239fd"></video>
<br>
<p>The video demonstrates the cirucit taking in an audio input from the phone and generates an randomised OTP on the 7-segment display usingour algorithm that was flashed onto the Cmod-A7 beforehand.</p>


<br>
<h3>Team reflection:</h3>
<h4>Challenges faced:</h4>
<p>Figuring out the algorithm for generating random numbers using a seed proved to the most challenging aspect of this project since we were not able to use numpy's built-in functions to act as our generator. Hence, a significant amount of time was spent tweaking the algorithm and proving that our generated random numbers fits a gaussian distribution. Alas, we were not able to settle on an algorithm that would generate a string of random numbers that always fit a gaussian distribution with our given input, but we believe that with more time we could have explored our proposed alternative methods and achieve a better result.</p>

<p>Tweaking of the analogue signal to match our use case was also a challenge. Certain knowledge learnt from Circuits and Electronics were required to understand how to translate the AC voltage wave so the FPGA analogue input would be values in the positive region. Thankfully we had Prof. Joel, and Prof. Tee Hui, together with friends (Tom, Wyndham, Elvis) that really helped us figure things out.<p>
  
<p>Insert circuit's challenges</p>
<h4>Learnings:</h4>
<p>Through this project, our team has been exposed to the importance of the statistical and numerical researches that are being done by mathematicians. While we did not delve into the complexities of proving our methods numerically, we are now well aware of the number of factors that needs to be proved before we can validate that our method of random number generation is sufficiently robust to be put into real applicaiton. Delving into the adjusting of our analogue signal also helped recall our electronics knowledge, and exposed us to some useful simulation tools. All in all, our team has grown to have a new profound respect for the academics that spend their lives honing and improving the realiability of the cybersecruity space.</p>
