# -*- coding: utf-8 -*-
from PyQt5 import QtWidgets, QtGui
import sys
from first import Ui_Form   # 导入生成first.py里生成的类
import math
import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
from mpl_toolkits import mplot3d
class mywindow(QtWidgets.QWidget,Ui_Form):
    def __init__(self):
        super(mywindow, self).__init__()
        self.setupUi(self)

    # 定义槽函数
    def slot1(self):
        if self.comboBox_2.currentText() == '平面波对理想导体平面边界的垂直入射':
            # 隐藏介质参数设置
            self.label_13.hide()
            self.label_14.hide()
            self.label_8.hide()
            self.label_5.hide()
            self.label_11.hide()
            self.label_12.hide()
            self.spinBox_4.hide()
            self.spinBox.hide()
            self.spinBox_7.hide()
            self.spinBox_8.hide()
        if self.comboBox_2.currentText() == '平面波对理想介质的垂直入射':
            # 显示介质参数设置
            self.label_13.show()
            self.label_14.show()
            self.label_8.show()
            self.label_5.show()
            self.label_11.show()
            self.label_12.show()
            self.spinBox_4.show()
            self.spinBox.show()
            self.spinBox_7.show()
            self.spinBox_8.show()

    def openimage(self):
        # 参数设置
        if self.comboBox_2.currentText() == '平面波对理想导体平面边界的垂直入射':
            # 计算参数
            u0 = 4 * math.pi * pow(10, -7)  # 真空中介电常数
            e0 = 1 / (36 * math.pi) * pow(10, -9)  # 真空中磁导率
            # 空气的介电常数和磁导率
            u1 = u0
            e1 = e0
            omiga = 2 * math.pi * pow(10, 3)  # 频率
            k1 = omiga * math.sqrt(u1 * e1)  # 波数k1
            eta1 = math.sqrt(u1 / e1)  # 复波阻抗
            Ei0 = 1  # 初始场强
            lambda1 = 2 * math.pi / k1  # 波长
            n = 2  # 波形起始位置
            z = np.linspace(-n * lambda1, 0, 100)
            scale = self.spinBox_9.value()         # 磁场放大倍数（便于可视化）
        if self.comboBox_2.currentText() == '平面波对理想介质的垂直入射':
            # 计算参数
            u0 = 4 * math.pi * pow(10, -7)  # 真空中介电常数
            e0 = 1 / (36 * math.pi) * pow(10, -9)  # 真空中磁导率
            # 介质1的介电常数和磁导率
            u1 = u0 * self.spinBox_4.value()
            e1 = e0 * self.spinBox.value()
            # 介质2的介电常数和磁导率
            u2 = u0 * self.spinBox_7.value()
            e2 = e0 * self.spinBox_8.value()
            omiga = 2 * math.pi * pow(10, 3)  # 频率
            k1 = omiga * math.sqrt(u1 * e1)  # 波数k1
            k2 = omiga * math.sqrt(u2 * e2)  # 波数k2
            eta1 = math.sqrt(u1 / e1)  # 复波阻抗eta1
            eta2 = math.sqrt(u2 / e2)  # 复波阻抗eta2
            Ei0 = 1  # 初始场强
            lambda1 = 2 * math.pi / k1  # 波长
            n = 2  # 波形起始位置
            z1 = np.linspace(-n * lambda1, 0, 100)
            z2 = np.linspace(0, n * lambda1, 100)
            z = np.append(z1, z2)
            R = (eta2 - eta1) / (eta2 + eta1)  # 反射系数
            T = 2 * eta2 / (eta2 + eta1)  # 透射系数
            scale = self.spinBox_9.value()     # 磁场放大倍数（便于可视化）
        # 时间循环
        t = np.linspace(0, 0.1, 100)
        for i in range(len(t)):
            if self.comboBox_2.currentText() == '平面波对理想导体平面边界的垂直入射':
                # 电场
                E1 = 2 * Ei0 * np.sin(k1 * z) * np.sin(omiga * t[i])  # 电场公式
                # 磁场
                H1 = 2 * Ei0 / eta1 * np.cos(k1 * z) * np.cos(omiga * t[i]) * scale  # 磁场公式
                # 绘制
                if self.comboBox.currentText() == '独立显示':       # 电场和磁场独立显示
                    self.label_2D_E_2.show()
                    self.label_2D_H_2.show()
                    self.label_2D_E_3.hide()
                    # 电场画图
                    plt.plot(z, E1, color='blue', alpha=0.5)
                    plt.fill_between(z, 0, E1, color='blue', alpha=.25)  # 填充两个函数之间的区域，本例中填充（0和Y+1之间的区域）
                    plt.xlim(-n * lambda1, 0)
                    plt.ylim(-2, 2)
                    plt.xlabel('Spatial location')
                    plt.ylabel('Electric field strength')
                    plt.title('Vertical incidence of plane wave on ideal conductor -- electric field')
                    filename_E_2D = './results_E/E_time=' + str(t[i]) + '.png'
                    plt.savefig(filename_E_2D)
                    plt.cla()

                    # 磁场画图
                    plt.plot(z, H1, color='red', alpha=0.5)
                    plt.fill_between(z, 0, H1, color='red', alpha=.25)  # 填充两个函数之间的区域，本例中填充（0和Y+1之间的区域）
                    plt.xlim(-n * lambda1, 0)
                    # plt.ylim(-0.01*scale, 0.01*scale)
                    plt.ylim(-2, 2)                         # 统一坐标轴，便于合并前后的流畅
                    plt.xlabel('Spatial location')
                    plt.ylabel('Magnetic induction, scale=100')
                    plt.title('Vertical incidence of plane wave on ideal conductor -- magnetic field')
                    filename_H_2D = './results_H/H_time=' + str(t[i]) + '.png'
                    plt.savefig(filename_H_2D)
                    plt.cla()

                    # 利用qlabel显示图片
                    png_E = QtGui.QPixmap(filename_E_2D)
                    self.label_2D_E_2.setPixmap(png_E)
                    QtWidgets.QApplication.processEvents()

                    png_H = QtGui.QPixmap(filename_H_2D)
                    self.label_2D_H_2.setPixmap(png_H)
                    QtWidgets.QApplication.processEvents()

                if self.comboBox.currentText() == '合并显示':               # # 电场和磁场合并显示
                    self.label_2D_E_2.hide()
                    self.label_2D_H_2.hide()
                    self.label_2D_E_3.show()

                    # 电场
                    plt.plot(z, E1, color='blue', alpha=0.5)
                    plt.fill_between(z, 0, E1, color='blue', alpha=.25)  # 填充两个函数之间的区域，本例中填充（0和Y+1之间的区域）

                    # 磁场
                    plt.plot(z, H1, color='red', alpha=0.5)
                    plt.fill_between(z, 0, H1, color='red', alpha=.25)  # 填充两个函数之间的区域，本例中填充（0和Y+1之间的区域）
                    plt.xlim(-n * lambda1, 0)
                    plt.ylim(-2, 2)
                    plt.xlabel('Spatial location')
                    plt.ylabel('Electric and Magnetic field strength')
                    plt.title('Vertical incidence of plane wave on ideal conductor')
                    filename_EH_2D = './results_E+H_2D/E+H_2D_time=' + str(t[i]) + '.png'
                    plt.savefig(filename_EH_2D)
                    plt.cla()

                    # 利用qlabel显示图片
                    png_E = QtGui.QPixmap(filename_EH_2D)
                    self.label_2D_E_3.setPixmap(png_E)
                    QtWidgets.QApplication.processEvents()

                # 绘制3D
                fig = plt.figure()
                ax = fig.gca(projection='3d')
                figure1 = ax.plot3D(E1, np.zeros_like(E1), z, c='b')
                figure2 = ax.plot3D(np.zeros_like(H1), H1, z, c='r')
                plt.xlim(-2, 2)
                plt.ylim(-0.01*scale, 0.01*scale)
                plt.xlabel('Electric field x')
                plt.ylabel('Magnetic field y')
                plt.title('Vertical incidence of plane wave on ideal conductor')
                filename_EH_3D = './results_E+H_3D/E+H_3D_time=' + str(t[i]) + '.png'
                plt.savefig(filename_EH_3D)
                plt.close()
                # 利用qlabel显示图片
                png_EH_3D = QtGui.QPixmap(filename_EH_3D)
                self.label_3D_EH.setPixmap(png_EH_3D)
                QtWidgets.QApplication.processEvents()

            if self.comboBox_2.currentText() == '平面波对理想介质的垂直入射':
                # 介质1、2电场
                E1 = Ei0 * (np.cos(omiga * t[i] - k1 * z1) + R * np.cos(omiga * t[i] + k1 * z1))  # 电场公式
                E2 = T * Ei0 * np.cos(omiga * t[i] - k2 * z2)
                E = np.append(E1, E2)
                # 介质1、2磁场
                H1 = Ei0 / eta1 * (np.cos(omiga * t[i] - k1 * z1) - R * np.cos(omiga * t[i] + k1 * z1))  # 磁场公式
                H2 = T * Ei0 / eta2 * np.cos(omiga * t[i] - k2 * z2)
                # scale = 100
                H = scale * np.append(H1, H2)
                # 绘制
                if self.comboBox.currentText() == '独立显示':
                    self.label_2D_E_2.show()
                    self.label_2D_H_2.show()
                    self.label_2D_E_3.hide()
                    # 电场画图
                    plt.plot(z, E, color='blue', alpha=0.5)
                    plt.fill_between(z, 0, E, color='blue', alpha=.25)  # 填充两个函数之间的区域，本例中填充（0和Y+1之间的区域）
                    plt.xlim(-n * lambda1, n * lambda1)
                    plt.ylim(-2, 2)
                    plt.xlabel('Spatial location')
                    plt.ylabel('Electric field strength')
                    plt.title('Normal incidence of plane waves on  ideal medium -- electric field')
                    filename_E_2D = './results_2_E/E_time=' + str(t[i]) + '.png'
                    plt.savefig(filename_E_2D)
                    plt.cla()

                    # 磁场画图
                    plt.plot(z, H, color='red', alpha=0.5)
                    plt.fill_between(z, 0, H, color='red', alpha=.25)  # 填充两个函数之间的区域，本例中填充（0和Y+1之间的区域）
                    plt.xlim(-n * lambda1, n * lambda1)
                    plt.ylim(-2, 2)                         # 统一坐标轴，便于合并前后的流畅
                    plt.xlabel('Spatial location')
                    plt.ylabel('Magnetic induction, scale=100')
                    plt.title('Normal incidence of plane waves on  ideal medium -- magnetic field')
                    filename_H_2D = './results_2_H/H_time=' + str(t[i]) + '.png'
                    plt.savefig(filename_H_2D)
                    plt.cla()

                    # 利用qlabel显示图片
                    png_E = QtGui.QPixmap(filename_E_2D)
                    self.label_2D_E_2.setPixmap(png_E)
                    QtWidgets.QApplication.processEvents()

                    png_H = QtGui.QPixmap(filename_H_2D)
                    self.label_2D_H_2.setPixmap(png_H)
                    QtWidgets.QApplication.processEvents()

                if self.comboBox.currentText() == '合并显示':
                    self.label_2D_E_2.hide()
                    self.label_2D_H_2.hide()
                    self.label_2D_E_3.show()

                    # 电场
                    plt.plot(z, E, color='blue', alpha=0.5)
                    plt.fill_between(z, 0, E, color='blue', alpha=.25)  # 填充两个函数之间的区域，本例中填充（0和Y+1之间的区域）

                    # 磁场
                    plt.plot(z, H, color='red', alpha=0.5)
                    plt.fill_between(z, 0, H, color='red', alpha=.25)  # 填充两个函数之间的区域，本例中填充（0和Y+1之间的区域）
                    plt.xlim(-n * lambda1, n * lambda1)
                    plt.ylim(-2, 2)                         # 统一坐标轴，便于合并前后的流畅
                    plt.xlabel('Spatial location')
                    plt.ylabel('Electric and Magnetic field strength')
                    plt.title('Normal incidence of plane waves on  ideal medium')
                    filename_EH_2D = './results_2_E+H_2D/E+H_2D_time=' + str(t[i]) + '.png'
                    plt.savefig(filename_EH_2D)
                    plt.cla()

                    # 利用qlabel显示图片
                    png_E = QtGui.QPixmap(filename_EH_2D)
                    self.label_2D_E_3.setPixmap(png_E)
                    QtWidgets.QApplication.processEvents()

                # 绘制3D
                fig = plt.figure()
                ax = fig.gca(projection='3d')
                figure1 = ax.plot3D(E, np.zeros_like(E), z, c='b')
                figure2 = ax.plot3D(np.zeros_like(H), H, z, c='r')
                plt.xlim(-2, 2)                         # 统一坐标轴，便于合并前后的流畅
                plt.ylim(-0.01*scale, 0.01*scale)
                plt.xlabel('Electric field x')
                plt.ylabel('Magnetic field y')
                plt.title('Normal incidence of plane waves on  ideal medium')
                filename_EH_3D = './results_2_E+H_3D/E+H_3D_time=' + str(t[i]) + '.png'
                plt.savefig(filename_EH_3D)
                plt.close()
                # 利用qlabel显示图片
                png_EH_3D = QtGui.QPixmap(filename_EH_3D)
                self.label_3D_EH.setPixmap(png_EH_3D)
                QtWidgets.QApplication.processEvents()



app = QtWidgets.QApplication(sys.argv)
window = mywindow()
# 空间显示初始化
window.label_2D_E_2.resize(640, 480)
window.label_2D_E_2.show()
window.label_2D_H_2.show()
window.label_2D_E_3.hide()
window.label_13.hide()
window.label_14.hide()
window.label_8.hide()
window.label_5.hide()
window.label_11.hide()
window.label_12.hide()
window.spinBox_4.hide()
window.spinBox.hide()
window.spinBox_7.hide()
window.spinBox_8.hide()

window.show()
sys.exit(app.exec_())
