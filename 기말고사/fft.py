import numpy as np
import matplotlib.pyplot as plt


plt.figure(1)
x = np.arange(30)
y = np.arange(30) + 3 * np.random.randn(30)

plt.plot(x,y,'go--',linewidth=0.75,markersize=3.5)
plt.xlabel('Year')
plt.ylabel('Books Read')

plt.figure(2)
plt.plot(x,y,'b--')
plt.xlabel('Who is')
plt.ylabel('then')

plt.show() # 그래프 보여주기
