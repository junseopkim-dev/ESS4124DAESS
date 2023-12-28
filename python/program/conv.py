"""
Created on Thu Nov 21 16:20:00 2023

@author: kjs
"""

import numpy as np
import matplotlib.pyplot as plt

def convolution(s1,s2):
    n=len(s1)
    m=len(s2)
    nm=n+m-1
    
    cn = np.zeros(nm)
    
    for k in range(n):
        for l in range(m):
            cn[k+l] += s1[k]*s2[l]
    return cn



