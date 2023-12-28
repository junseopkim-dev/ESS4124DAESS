# -*- coding: utf-8 -*-
"""
Created on Tue Nov  7 15:07:45 2023

@author: kjs
"""

"""
matlab은 .m으로 끝나는 파일로 저장했다면
python은 .py로 저장

python은 줄맞춤, 들여쓰기에 민감
콜론으로 끝나면 그 뒤에선 들여쓰기.

매틀랩에서는 그 패스에 있으면 커맨드만 치면 됐지만
파이썬에서는 아주 베이직한 커멘드 외에는 전부 그때마다 임포트 해줘야 함.

내가 만든 파일도 임포트 해야됨

from (파일명) import (함수명)
"""
import numpy as np # 별명은 np

def average(x): # 함수 정의는 def
    ss=sum(x) #매틀랩
    mm=ss/len(x) #divide by length
    
    return mm

# end

def standard(x): 
    mm = average(x)
    #N = len(x)
    ss = sum((x-mm)**2) #제곱 : **2로 표시
    ss = ss/(len(x)-1)
    ss = np.sqrt(ss)
    
    return ss

##파이썬 주의할 점 : 들여쓰기 수준 같아야 함.
    