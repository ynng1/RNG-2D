<h1>Audio-based OTP generator</h1>
<br>
<p>The goal of the project is to utilise an audio signal to generate a string of random numbers to be used for one-time passwords(OTP).
<br>
From a playlist of 25000 songs, the user would use the random shuffle feature to play a song randomly when he/she wants to generate an OTP.
<br>
The voltage of the audio signal is then converted by a CMOD-A7's XADC to a digital output that acts as the seed for the random number generation.</p>
<br>
<h3>Here's how the random number generation works:</h3>
<h5>Advantages of using our method:</h5>
<h5>Disadvantages of using our method:</h5>
<br>
<h3>Future improvements:</h3>
<h5>Alternative methods that could be explored:</h5>
<h5>Potential drawbacks of alternative methods:</h5>
<br>
<h3>Here's the schemetic to our circuit:</h3>
<h3>Some important point to note about the circuit: (How the circuit works)</h3>
<br>
<h3>This is a video of the circuit working:</h3>
<br>
<h3>Team reflection:</h3>
<h5>Challenges faced:</h5>
<p>Figuring out the algorithm for generating random numbers using a seed proved to the most challenging aspect of this project since we were not able to use numpy's built-in functions to act as our generator. Hence, a significant amount of time was spent tweaking the algorithm and proving that our generated random numbers fits a gaussian distribution. Alas, we were not able to settle on an algorithm that would generate a string of random numbers that always fit a gaussian distribution with our given input, but we believe that with more time we could have explored our proposed alternative methods and achieve a better result.</p>
<p>Insert circuit's challenges</p>
<h5>Learnings:</h5>
<p></p>
