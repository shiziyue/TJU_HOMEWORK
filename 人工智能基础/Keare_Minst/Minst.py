from keras.datasets import mnist
from tensorflow.python.keras.utils.np_utils import to_categorical

train_X, train_y = mnist.load_data()[0]
train_X = train_X.reshape(-1, 28, 28, 1)
train_X = train_X.astype('float32')
train_X /= 255
train_y = to_categorical(train_y, 10)
print(train_X.shape, train_y.shape)
from keras.models import Sequential
from keras.layers import Conv2D, MaxPool2D, Flatten, Dropout, Dense
from keras.losses import categorical_crossentropy
from tensorflow.keras.optimizers import Adadelta
import keras
import tensorflow

model = Sequential()

model.add(Conv2D(6, (5,5), activation='relu', input_shape=(28,28,1)))
model.add(MaxPool2D(pool_size=(2,2)))
model.add(Conv2D(16, (5,5), activation='relu'))
model.add(MaxPool2D(pool_size=(2,2)))
model.add(Flatten())
model.add(Dense(120, activation='relu'))
model.add(Dense(84, activation='relu'))
model.add(Dense(10, activation='softmax'))

model.compile(loss=categorical_crossentropy,
             #optimizer=Adadelta(),
             optimizer=tensorflow.keras.optimizers.SGD(),
             metrics=['accuracy'])

batch_size = 100
epochs = 8
model.fit(train_X, train_y,
         batch_size=batch_size,
         epochs=epochs)

test_X, test_y = mnist.load_data()[1]
test_X = test_X.reshape(-1, 28, 28, 1)
test_X = test_X.astype('float32')
test_X /= 255
test_y = to_categorical(test_y, 10)
loss, accuracy = model.evaluate(test_X, test_y, verbose=1)
print('loss:%.4f accuracy:%.4f' %(loss, accuracy))

model.save('Minst_model.h5')