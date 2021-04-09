import sys
import math
import numpy as np
from wbsy3 import Ui_Dialog
from mpl_toolkits.mplot3d import Axes3D
from matplotlib import cm
import mpl_toolkits.mplot3d
import matplotlib
matplotlib.use("Qt5Agg")  # 声明使用QT5
import matplotlib.pyplot as plt
from PyQt5 import QtCore, QtGui, QtWidgets
from PyQt5.QtWidgets import QMainWindow, QWidget, QApplication,QGridLayout
from matplotlib.widgets import Button
import matplotlib.animation as animation
from mpl_toolkits.mplot3d import Axes3D


class CoperQt(QtWidgets.QDialog,Ui_Dialog):#创建一个Qt对象
#这里的第一个变量是你该窗口的类型，第二个是该窗口对象。
#这里是主窗口类型。所以设置成当QtWidgets.QMainWindow。
#你的窗口是一个会话框时你需要设置成:QtWidgets.QDialog
    def __init__(self):
        super(CoperQt, self).__init__()
        self.setupUi(self)#配置主界面对象
        self.begin.clicked.connect(self.run)
        self.over.clicked.connect(self.jieshu)


    def run(self):
        self.p=0
        u0 = 4 * np.pi * 10 ** (-7)
        e0 = 1 / (36 * np.pi) * 10 ** (-9)
        u = u0
        e = e0
        f = float(self.f.text()) * 10 ** 9  # 9.375 * 10 ** 9
        w = 2 * np.pi * f
        a = 22.86 / 1000
        b = 10.16 / 1000
        H10 = 1
        vc = 3*10**8
        d = 15
        T=2*np.pi/w
        lc = 2 * a  # TE10截止波长
        l0 = (3 * 10 ^ 8) / f
        lg = l0 / ((1 - (l0 / lc) ** 2) ** 0.5)
        c = lg
        beta = 2 * np.pi / lg
        x = np.arange(0, a, a / d)
        y = np.arange(0, b, b / d)
        z = np.arange(0, c, c / d)
        [x1, y1, z1] = np.meshgrid(x, y, z)
        t=0
        fig = plt.figure()
        ax = fig.gca(projection='3d')
        while t<10*T:
            if self.p==1:
                plt.close()
                break
            ey = w * u * a * H10 * np.sin(np.pi / a * x1) * np.sin(w * t - beta * z1) / np.pi * 0.000000000002
            hx = beta * a * H10 * np.sin(np.pi / a * x1) * np.cos(w * t - beta * z1 + np.pi / 2) / np.pi
            hz = H10 * np.cos(np.pi / a * x1) * np.cos(w * t - beta * z1)
            ax.quiver3D(z1, x1, y1, 0, 0, ey,color='r')
            ax.quiver3D(z1, x1, y1, hz, hx, 0, color='deepskyblue', length=0.00000000008)
            plt.rcParams['font.sans-serif'] = ['SimHei']  # 显示中文标签
            plt.rcParams['axes.unicode_minus'] = False  # 解决负号“-”显示为方块的问题
            ax.set_xlabel('传输方向')
            ax.set_ylabel('波导宽边a')
            ax.set_zlabel('波导窄边b')
            plt.pause(0.1)
            plt.cla()
            t = t + T / 10
            plt.show()





    def jieshu(self):
        self.p=1



if __name__ == "__main__":
    app = QtWidgets.QApplication(sys.argv)
    window = CoperQt()  # 创建QT对象
    window.show()  # QT对象显示
    sys.exit(app.exec_())