from scipy import signal
import matplotlib.pyplot as plt
import numpy as np
import os

ROOT = os.getcwd()
filename = (ROOT + "/ps/mic_data/delay_.txt")

fs = 15625
data = np.loadtxt(open(filename, 'rb').readlines()[:-1], delimiter=',') # load data from txt file to np array
fs = data[0,2]  # sampling frequency
data = data[:,4:]    # take out mic data

singel_mic_data = data[:,1]


f, t, Sxx = signal.spectrogram(data[:,45], fs, nfft=4028)
plt.pcolormesh(t, f, Sxx)
plt.ylabel('Frequency [Hz]')
plt.xlabel('Time [sec]')
plt.show()