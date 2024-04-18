import matplotlib.pyplot as plt

collated_list = []

class LFSR:
    def __init__(self, seed):
        self.state = seed & 0xFFFF  # Ensure seed is 16 bits
        self.tap_positions = [0, 2, 3, 5]  # Tap positions for 16-bit LFSR

    def shift(self):
        feedback = 0
        print(bin(self.state))
        for tap in self.tap_positions:
            print("tap is ")
            print(tap)
            feedback ^= (self.state >> tap) & 1
            print(bin(feedback))
        self.state = ((self.state << 1) | feedback) & 0xFFFF
        print(bin(self.state))
        return self.state

seed = 0b1010  
lfsr = LFSR(seed)

for _ in range(2**16):  
    collated_list.append(bin(lfsr.shift()))
print(collated_list)
plt.hist(collated_list, bins=65, color='skyblue', edgecolor='black')
plt.show()
print("------------")