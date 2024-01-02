#-*- coding: UTF-8 -*-
from keras.models import load_model
my_model = load_model('Minst_model.h5')

import cv2
import numpy as np
img = cv2.imread('test.jpg',cv2.IMREAD_GRAYSCALE)
reshaped_img = np.reshape(img,(-1,28,28,1))

pred = my_model.predict(reshaped_img)
print('图片的热编码是',pred)
print('数字为',np.argmax(pred[0]))