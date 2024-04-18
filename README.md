<h1>Audio-based OTP generator</h1>
<br>
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
<h3>Here's the schemetic to our circuit:</h3>
<h3>Some important point to note about the circuit: (How the circuit works)</h3>
<br>
<h3>This is a video of the circuit working:</h3>
<br>
<h3>Team reflection:</h3>
<h4>Challenges faced:</h4>
<p>Figuring out the algorithm for generating random numbers using a seed proved to the most challenging aspect of this project since we were not able to use numpy's built-in functions to act as our generator. Hence, a significant amount of time was spent tweaking the algorithm and proving that our generated random numbers fits a gaussian distribution. Alas, we were not able to settle on an algorithm that would generate a string of random numbers that always fit a gaussian distribution with our given input, but we believe that with more time we could have explored our proposed alternative methods and achieve a better result.</p>
<p>Insert circuit's challenges</p>
<h4>Learnings:</h4>
<p>Through this project, our team has been exposed to the importance of the statistical and numerical researches that are being done by mathematicians. While we did not delve into the complexities of proving our methods numerically, we are now well aware of the number of factors that needs to be proved before we can validate that our method of random number generation is sufficiently robust to be put into real applicaiton. All in all, our team has grown to have a new profound respect for the academics that spend their lives honing and improving the realiability of the cybersecruity space.</p>
