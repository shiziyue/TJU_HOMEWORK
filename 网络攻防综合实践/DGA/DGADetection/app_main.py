from PyQt5.QtWidgets import QApplication, QMainWindow,QWidget,QMessageBox
import sys
from PyQt5 import QtCore
QtCore.QCoreApplication.setAttribute(QtCore.Qt.AA_EnableHighDpiScaling)

import sys,os
sys.path.append(os.path.dirname(__file__))

from Ui_main import Ui_MainWindow
if __name__ == "__main__":

    App = QApplication(sys.argv)    # 创建QApplication对象，作为GUI主程序入口
    mainwindow = Ui_MainWindow()    # 创建主窗体对象，实例化Ui_MainWindow
    QM = QMainWindow()      # 实例化QMainWindow类
    #检查必须文件
    try:
        model_folder = r"./data/model"
        from detection import KNNClassifier,SVMClassifier
        knn = KNNClassifier()
        knn.load(model_folder)
        svm = SVMClassifier()
        svm.load(model_folder)
    except:
        from PyQt5 import QtWidgets
        QtWidgets.QMessageBox.warning(QtWidgets.QWidget() ,"系统所需文件缺失", "请仔细检查是否存在模型文件")
        sys.exit(0)
    
    mainwindow.setupUi(QM,knn,svm)         # 主窗体对象调用setupUi方法，对QMainWindow对象进行设置
    QM.show()              # 显示主窗体
    sys.exit(App.exec_())   # 循环中等待退出程序