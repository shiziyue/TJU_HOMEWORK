from keras.datasets import mnist

train_data = mnist.load_data()[0]
test_data = mnist.load_data()[1]
train_X , train_y = train_data
test_X, test_y = test_data
print(train_X.shape, train_y.shape)
print(test_X.shape, test_y.shape)