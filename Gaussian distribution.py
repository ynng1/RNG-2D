import numpy as np
import matplotlib.pyplot as plt
from scipy.stats import shapiro

def process_data(data):
    data_next = [0] * 16  # Initialize data_next with all zeros
    
    data_next[15] = data[15] ^ data[1]
    data_next[14] = data[14] ^ data[0]
    data_next[13] = data[13] ^ data_next[15]
    data_next[12] = data[12] ^ data_next[14]
    data_next[11] = data[11] ^ data_next[13]
    data_next[10] = data[10] ^ data_next[12]
    data_next[9] = data[9] ^ data_next[11]
    data_next[8] = data[8] ^ data_next[10]
    data_next[7] = data[7] ^ data_next[9]
    data_next[6] = data[6] ^ data_next[8]
    data_next[5] = data[5] ^ data_next[7]
    data_next[4] = data[4] ^ data_next[6]
    data_next[3] = data[3] ^ data_next[5]
    data_next[2] = data[2] ^ data_next[4]
    data_next[1] = data[1] ^ data_next[3]
    data_next[0] = data[0] ^ data_next[2]
    
    return data_next

###########

seed_count = 0
while seed_count < 300:
    seed = np.random.randint(1, 65537) # Generate random seed
    #print(seed)

    count = 0
    decimal_number = seed
    binary_number = bin(decimal_number)[2:]  # Convert decimal to binary, remove the '0b' prefix
    binary_list = [int(bit) for bit in binary_number] # Place each binary number into a list
    generated_list = []
    #print(binary_list)

    while count < 65538:
        data =  binary_list
        while len(binary_list)<16: 
            binary_list.insert(0,0)
        #print(binary_list)
        next_data = process_data(data)
        new_decimal_number = int(''.join(map(str, next_data)), 2)
        generated_list.append(new_decimal_number)
        #print(generated_list)
        new_binary_number = bin(new_decimal_number)[2:]
        binary_list = [int(bit) for bit in new_binary_number]
        count += 1
    
    seed_count += 1



#print(generated_list)
###########

# Plotting a histogram
plt.hist(generated_list, bins=16, density=True, alpha=0.7, color='skyblue')
plt.xlabel('Value')
plt.ylabel('Frequency')
plt.title('Histogram of Generated Random Numbers')
plt.show()

# Plotting a density plot
plt.figure()
sns.kdeplot(r_gen, shade=True, color='skyblue')
plt.xlabel('Value')
plt.ylabel('Density')
plt.title('Density Plot of Generated Random Numbers')
plt.show()


'''
# Perform the Shapiro-Wilk test
statistic, p_value = shapiro(generated_list)

# Print the test results
print("Shapiro-Wilk test statistic:", statistic)
print("p-value:", p_value)

# Check the significance level (e.g., 0.05) to determine if the sample is normally distributed
if p_value > 0.05:
    print("The sample is likely to be normally distributed.")
else:
    print("The sample is not likely to be normally distributed.")
'''