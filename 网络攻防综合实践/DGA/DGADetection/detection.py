# -*- coding: utf-8 -*-
"""
Created on 2020/9/14 9:36

__author__ = "Congyi Deng"
__copyright__ = "Copyright (c) 2021 NKAMG"
__license__ = "GPL"
__contact__ = "dengcongyi0701@163.com"

Description:

"""
import pandas as pd
import numpy as np
import pickle
from sklearn.preprocessing import StandardScaler
from sklearn.neighbors import KNeighborsClassifier
from sklearn.neighbors import KNeighborsClassifier
from sklearn.svm import SVC
from sklearn.metrics import precision_score, accuracy_score, recall_score, f1_score
#ADD BY ZiyueShi
import sys,os
sys.path.append(os.path.dirname(__file__))
from feature_extraction import *

train_add = r"./data/feature/train_features.csv"
test_add = r"./data/feature/test_features.csv"
KNN_model_add = r"./data/model/KNN_model.pkl"
standard_scaler_add = r"./data/model/standardscalar.pkl"
model_folder = r"./data/model"
# KNN算法
class KNNClassifier:

    def __init__(self):
        self.KNN_clf = KNeighborsClassifier(n_neighbors=5, metric='minkowski')
        self.standard_scaler_add = StandardScaler()
        #DELETE BY ZiyueShi
        # self.train_score = None
        self.isload_ = False

    def train(self, model_folder, train_feature_add):
        """
        KNN算法训练数据
        :param model_folder: 模型存储路径
        :param train_feature_add: 训练数据路径
        :return:
        """
        train_df = pd.read_csv(train_feature_add, index_col=['domain_name'])
        train_df = train_df.fillna('0.0')
        x_train = train_df.drop(['label'], axis=1).values
        y_train = train_df['label'].values
        print("_______KNN Training_______")
        self.KNN_clf.fit(x_train, y_train)
        pickle.dump(self.KNN_clf, open("{}/KNN_model.pkl".format(model_folder), 'wb'))

    def load(self, model_folder):
        """
        将模型文件和归一化尺度读取到内存中
        :param model_folder: 模型存储路径
        :return:
        """
        self.KNN_clf = pickle.load(open("{}/KNN_model.pkl".format(model_folder), 'rb'))
        self.standardScaler = pickle.load(open("{}/standardscalar.pkl".format(model_folder), 'rb'))
        self.isload_ = True

    def predict(self, model_folder, test_feature_add):
        """
        测试集进行测试，计算准确率等
        :param model_folder: 模型存储路径
        :param test_feature_add: 测试数据路径
        :return:
        """
        self.load(model_folder)
        test_df = pd.read_csv(test_feature_add, index_col=['domain_name'])
        test_df = test_df.fillna('0.0')
        x_test = test_df.drop(['label'], axis=1).values
        y_test = test_df['label'].values
        print("_______KNN Predicting_______")
        y_predict = self.KNN_clf.predict(x_test)
        print("KNN accuracy: ", accuracy_score(y_test, y_predict))
        print("KNN precision: ", precision_score(y_test, y_predict))
        print("KNN recall: ", recall_score(y_test, y_predict,))
        print("KNN F1: ", f1_score(y_test, y_predict))

    def predict_single_dname(self, model_folder, dname):
        """
        对单个域名进行检测，输出检测结果及恶意概率
        :param model_folder: 模型存储路径
        :param dname: 域名
        :return: [预测标签，恶意概率，可信度]
        """
        if not self.isload_:
            self.load(model_folder)
        dname = dname.strip('/').strip('.')
        dname = dname.replace("http://", '')
        dname = dname.replace("www.", "")
        if dname == "":
            label = 0
            prob = 0.0000
            p_value = 1.0000
            print("\nknn dname:", dname)
            print('label:{}, pro:{}'.format(label, prob))
            return label, prob
        else:
            feature = self.standardScaler.transform(pd.DataFrame([get_feature(dname)]))
            label = self.KNN_clf.predict(feature)
            prob = self.KNN_clf.predict_proba(feature)
            print("\nknn dname:", dname)
            print('label:{}, pro:{}'.format(label[0], prob[0][1]))
            return label[0], prob[0][1]

# SVM算法，请补充
#ADD BY ZiyueShi
class SVMClassifier:

    def __init__(self):
        self.SVM_clf = SVC(C=1.0, kernel='linear', degree=3, gamma='auto', #惩罚参数#核函数类型
					coef0=0.0, shrinking=True, probability=True, tol=0.001, #是否启用概率估计
					cache_size=200, class_weight=None, verbose=False, max_iter=-1, 
					decision_function_shape='ovr', random_state=13)

        self.standard_scaler_add = StandardScaler()
        # self.train_score = None
        self.isload_ = False

    def train(self, model_folder, train_feature_add):
        """
        SVM算法训练数据
        :param model_folder: 模型存储路径
        :param train_feature_add: 训练数据路径
        :return:
        """
        train_df = pd.read_csv(train_feature_add, index_col=['domain_name'])
        train_df = train_df.fillna('0.0')
        x_train = train_df.drop(['label'], axis=1).values
        y_train = train_df['label'].values
        print("_______SVM Training_______")
        self.SVM_clf.fit(x_train, y_train)
        pickle.dump(self.SVM_clf, open("{}/SVM_model.pkl".format(model_folder), 'wb'))
        return
    def load(self, model_folder):
        """
        将模型文件和归一化尺度读取到内存中
        :param model_folder: 模型存储路径
        :return:
        """
        self.SVM_clf = pickle.load(open("{}/SVM_model.pkl".format(model_folder), 'rb'))
        self.standardScaler = pickle.load(open("{}/standardscalar.pkl".format(model_folder), 'rb'))
        self.isload_ = True
        return
    def predict(self, model_folder, test_feature_add):
        """
        测试集进行测试，计算准确率等
        :param model_folder: 模型存储路径
        :param test_feature_add: 测试数据路径
        :return:
        """
        self.load(model_folder)
        test_df = pd.read_csv(test_feature_add, index_col=['domain_name'])
        test_df = test_df.fillna('0.0')
        x_test = test_df.drop(['label'], axis=1).values
        y_test = test_df['label'].values
        print("_______SVM Predicting_______")
        y_predict = self.SVM_clf.predict(x_test)
        print("SVM accuracy: ", accuracy_score(y_test, y_predict))
        print("SVM precision: ", precision_score(y_test, y_predict))
        print("SVM recall: ", recall_score(y_test, y_predict))
        print("SVM F1: ", f1_score(y_test, y_predict))
        return
    def predict_single_dname(self, model_folder, dname):
        """
        对单个域名进行检测，输出检测结果及恶意概率
        :param model_folder: 模型存储路径
        :param dname: 域名
        :return: [预测标签，恶意概率，可信度]
        """
        if not self.isload_:
            self.load(model_folder)
        dname = dname.strip('/').strip('.')
        dname = dname.replace("http://", '')
        dname = dname.replace("www.", "")
        if dname == "":
            label = 0
            prob = 0.0000
            p_value = 1.0000
            print("\nsvm dname:", dname)
            print('label:{}, pro:{}'.format(label, prob))
            return label, prob
        else:
            feature = self.standardScaler.transform(pd.DataFrame([get_feature(dname)]))
            label = self.SVM_clf.predict(feature)
            prob = self.SVM_clf.predict_proba(feature)
            print("\nsvm dname:", dname)
            print('label:{}, pro:{}'.format(label[0], prob[0][1]))
            return label[0], prob[0][1]

if __name__ == "__main__":


    # clf = KNNClassifier()
    clf = SVMClassifier()
    # clf.train(model_folder, train_add)#train 过了
    clf.predict(model_folder, test_add)
    clf.predict_single_dname(model_folder, "159sgfgfd3dfhghv6.viajes")
