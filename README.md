<h1>Audio-based OTP generator</h1>
<h3>Introduction and Objective</h3>
<p>The goal of the project is to utilise an audio signal to generate a string of random numbers to be used for one-time passwords (OTP).
<br>
From a playlist of 25000 songs, the user would use the random shuffle feature to play a song randomly when he/she wants to generate an OTP.
<br>
The voltage of the audio signal is then converted by a CMOD-A7's XADC to a digital output that acts as the seed for the random number generation.</p>
<br>
<h3>Here's how the random number generation works:</h3>
We used a 16 Bit Linear Feedback Shift Register (LFSR) for our pseudo random generator. For the initial input, we used a seed value that is captured from the XADC (the analogue pin of the CMOD A7). For the subsequent inputs, we chose to tap the values at 0,2,3,5 and use the output as a feedback loop into the input.

The seed value is captured every second from the constant input of the XADC and is therefore constantly changing. When the reset button is pressed, the seed value would then return to its default seed value. 

We used the LFSR as it has a relatively normal distribution in its output in generating random numbers.
<h4>Advantages of using our method:</h4>
LFSR has a low power consumption, is easy to construct from simple electromechanical or electronic circuits, has long periods, and very uniformly distributed output streams.
<h4>Disadvantages of using our method:</h4>
A 16-bit Linear Feedback shift register would not entirely have a normal distribution constantly since it is heavily dependent on the input seed value. This can cause repetition in the outputs in some special cases. 
Since the input seed is constantly changing due to the nature of the input music, there might be special cases where the first value prompted from the secondary seed to equate to the previous outputs. 
There might also be cases where the song/audio signal repeats exactly within the time delay in capturing the seed value, this would cause the seed value to be constant and the output to be unchanged since the first output of the same seed is always being produced. 
<br>
<h3>Future improvements:</h3>
Another method can be by identifying the pattern of the input music and deriving an algorithm to calculate a special seed value. This way, the calculated seed value would be unique for that song despite having fluctuations in the audio input. 
<h4>Alternative methods that could be explored:</h4>
The correlation of the input song to the output of the LFSR can be studied to maximise the normal distribution of the LFSR. 
This can be done by changing to different genres of songs / the beats per minute (BPM) of the input song and studying the correlation of BPM, type of song played, and delayed time in capturing the output of the song which affects the output of the LFSR.
<h4>Potential drawbacks of alternative methods:</h4>
The downside of constantly capturing music at a fixed interval as an input seed would be that there would be too many variables. Latency of the audio input / latency of audio amplifier / type of songs available might affect the input seed which could cause more repetitions in the output. 
<br>

<h3>Analogue Input to FPGA</h3>
Our analogue input signal is derived from audio signals. Music played from the device is output through a 3.5mm mono jack and is fed into a LM386 audio amplifier. The audio signal output is controlled with a variable resistor, and is adjusted to range approximately between -1.2V to +1.2V. 
The AC output audio signal is then DC biased using a coupling capacitor and a potential divider circuit. DC bias can be adjusted using the variable resistor. We considered the RC time constant of the coupling capacitor, ensuring the time constant of the capacitor used must be below 50microseconds, so the discharge would not distort the output of the AC audio signal. The AC signal is given a 1.5V DC bias so the FPGA analogue input is hovering between 0V and +2.7V. This fits within the 0 to 3.3V range of the FPGA analogue input.

<h4>Here's the schematic to our circuit:</h4>

![Analogue Input Circuit](https://github.com/ynng1/RNG-2D/assets/94187124/015c58da-4cce-41cd-ad53-e021a67f68df)


<br>
<h3>This is a video of the circuit working:</h3>

<br>
<video width="630" height="300" src="https://github.com/ynng1/RNG-2D/assets/163510534/4efd0c9e-b643-474c-8d42-8fd5adb239fd"></video>
<br>
<p>The video demonstrates the circuit taking in an audio input from the phone and generates a randomised OTP on the 7-segment display using our algorithm that was flashed onto the Cmod-A7 beforehand.</p>


<br>
<h3>Team reflection:</h3>
<h4>Challenges faced:</h4>
<p>Figuring out the algorithm for generating random numbers using a seed proved to the most challenging aspect of this project since we were not able to use numpy's built-in functions to act as our generator. Hence, a significant amount of time was spent tweaking the algorithm and proving that our generated random numbers fits a gaussian distribution. Alas, we were not able to settle on an algorithm that would generate a string of random numbers that always fit a gaussian distribution with our given input, but we believe that with more time we could have explored our proposed alternative methods and achieve a better result.</p>

<p>Tweaking of the analogue signal to match our use case was also a challenge. Certain knowledge learnt from Circuits and Electronics were required to understand how to translate the AC voltage wave so the FPGA analogue input would be values in the positive region. There were issues of the AC voltage clipping, distortion of the signal which required careful consideration of the electronic components. Thanks to Prof. Joel, and Prof. Tee Hui, together with friends (Tom, Wyndham, Elvis) that really helped us figure things out.<p>
  
<h4>Learnings:</h4>
<p>Through this project, our team has been exposed to the importance of the statistical and numerical research that are being done by mathematicians. While we did not delve into the complexities of proving our methods numerically, we are now well aware of the number of factors that needs to be proved before we can validate that our method of random number generation is sufficiently robust to be put into real application. Delving into the adjusting of our analogue signal also helped recall our electronics knowledge and exposed us to some useful simulation tools. All in all, our team has grown to have a new profound respect for the academics that spend their lives honing and improving the reliability of the cybersecurity space.</p>
