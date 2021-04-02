import tkinter as tk
from mayavi import mlab
import numpy as np
import matplotlib.pyplot as plt
from numpy import exp

# 第1步，实例化object，建立窗口window
window = tk.Tk()

# 第2步，给窗口的可视化起名字
window.title('Electromagnetic Field GUI')

# 第3步，设定窗口的大小kuan*chang
window.geometry('550x760')  # 这里的乘是小x

# 第4步，在图形界面上放置控件

#标签
tk.Label(window, text='charge1', font=('Arial', 10)).place(x=10, y=20)
tk.Label(window, text='x1', font=('Arial', 14)).place(x=170, y=20)
tk.Label(window, text='y1', font=('Arial', 14)).place(x=330, y=20)
tk.Label(window, text='charge2', font=('Arial', 10)).place(x=10, y=60)
tk.Label(window, text='x2', font=('Arial', 14)).place(x=170, y=60)
tk.Label(window, text='y2', font=('Arial', 14)).place(x=330, y=60)
tk.Label(window, text='charge3', font=('Arial', 10)).place(x=10, y=100)
tk.Label(window, text='x3', font=('Arial', 14)).place(x=170, y=100)
tk.Label(window, text='y3', font=('Arial', 14)).place(x=330, y=100)
tk.Label(window, text='Relative Dielectric Constant', font=('Arial', 10)).place(x=10, y=140)

#GUI信息
tk.Label(window, text='Python-GUI', font=('Arial', 14)).place(x=10, y=720)
tk.Label(window, text='Kilian_Di  Intern@HKUST Vision Group  2021/03/18', font=('Arial', 14)).place(x=10, y=690)

#输入框
dianliang1 = tk.Entry(window, font=('Arial', 14),width=4)
dianliang1.place(x=80,y=20)
dianliang2 = tk.Entry(window, font=('Arial', 14),width=4)
dianliang2.place(x=80,y=60)
dianliang3 = tk.Entry(window,  font=('Arial', 14),width=4)
dianliang3.place(x=80,y=100)
XX1 = tk.Entry(window, font=('Arial', 14),width=4)
XX1.place(x=240,y=20)
XX2 = tk.Entry(window, font=('Arial', 14),width=4)
XX2.place(x=240,y=60)
XX3 = tk.Entry(window,  font=('Arial', 14),width=4)
XX3.place(x=240,y=100)
YY1 = tk.Entry(window,  font=('Arial', 14),width=4)
YY1.place(x=400,y=20)
YY2 = tk.Entry(window,  font=('Arial', 14),width=4)
YY2.place(x=400,y=60)
YY3 = tk.Entry(window, font=('Arial', 14),width=4)
YY3.place(x=400,y=100)
XDJD = tk.Entry(window, font=('Arial', 14),width=4)
XDJD.place(x=240,y=140)

#定义用来画图的函数
def show2D3D():
    DL1 = float(dianliang1.get())
    DL2 = float(dianliang2.get())
    DL3 = float(dianliang3.get())
    X1 = float(XX1.get())
    X2 = float(XX2.get())
    X3 = float(XX3.get())
    Y1 = float(YY1.get())
    Y2 = float(YY2.get())
    Y3 = float(YY3.get())
    JDCS=1/float(XDJD.get())
    MAXXY=max(X1,X2,X3,Y1,Y2,Y3)+3
    MINXY=min(X1,X2,X3,Y1,Y2,Y3)-3
    X, Y = np.mgrid[MINXY:MAXXY:200j, MINXY:MAXXY:200j]  # 每组最后那个参数带j是点数，不带j是间距
    # Z = X*np.exp(-(X**2 + Y**2))         #Z的表达式
    # ------尝试区------
    Z = (JDCS*DL1)/np.sqrt((X-X1)**2+(Y-Y1)**2)+(JDCS*DL2)/np.sqrt((X-X2)**2+(Y-Y2)**2)+(JDCS*DL3)/np.sqrt((X-X3)**2+(Y-Y3)**2)
    # ------------
    cp = plt.contour(X, Y, Z, 400)  # 画等高线，最后一个参数是设定等高线条数
    # cb = plt.colorbar(cp)

    # Vector Field
    Y, X = np.mgrid[MINXY:MAXXY:40j, MINXY:MAXXY:40j]
    #U = -(X - 1) / (np.sqrt((X - 1) ** 2 + Y ** 2) ** (1.5)) + (X + 1) / (
    #            np.sqrt((X + 1) ** 2 + Y ** 2) ** (1.5))  # X偏导数
    U=-((X-X1)*JDCS*DL1)/(np.sqrt((X-X1)**2+(Y-Y1)**2)**(1.5))-((X-X2)*JDCS*DL2)/(np.sqrt((X-X2)**2+(Y-Y2)**2)**(1.5))-((X-X3)*JDCS*DL3)/(np.sqrt((X-X3)**2+(Y-Y3)**2)**(1.5))
    V = -((Y-Y1)*JDCS*DL1)/(np.sqrt((X-X1)**2+(Y-Y1)**2)**(1.5))-((Y-Y2)*JDCS*DL2)/(np.sqrt((X-X2)**2+(Y-Y2)**2)**(1.5))-((Y-Y3)*JDCS*DL3)/(np.sqrt((X-X3)**2+(Y-Y3)**2)**(1.5))  # Y偏导数
    speed = np.sqrt(U ** 2 + V ** 2)  # 这三行是用来归一化的
    UN = U / speed
    VN = V / speed
    quiv = plt.quiver(X, Y, -UN, -VN,  # assign to var
                      headlength=7)  # 画出矢量线
    plt.savefig('./2D.png')
    image_file = tk.PhotoImage(file='2D.png')  # 图片位置（相对路径，与.py文件同一文件夹下，也可以用绝对路径，需要给定图片具体绝对路径）
    canvas.create_image(260, 0, anchor='n', image=image_file)
   # plt.show()

    # 下面开始三维
    x, y, z = np.mgrid[MINXY:MAXXY:200j, MINXY:MAXXY:200j, MINXY:MAXXY:200j]  # 范围
    #scalars = 1 / np.sqrt((x - 1) ** 2 + y ** 2 + z ** 2) - 1 / np.sqrt((x + 1) ** 2 + y ** 2 + z ** 2)  # 电势
    scalars =(JDCS*DL1)/np.sqrt((x-X1)**2+(y-Y1)**2+z**2)+(JDCS*DL2)/np.sqrt((x-X2)**2+(y-Y2)**2+z**2)+(JDCS*DL3)/np.sqrt((x-X3)**2+(y-Y3)**2+z**2)
    mlab.contour3d(x, y, z, scalars, contours=51, transparent=True)
#    mlab.colorbar()

    x, y, z = np.mgrid[MINXY:MAXXY:40j, MINXY:MAXXY:40j, MINXY:MAXXY:40j]
    u=-((x-X1)*JDCS*DL1)/(np.sqrt((x-X1)**2+(y-Y1)**2+z**2)**(1.5))-((x-X2)*JDCS*DL2)/(np.sqrt((x-X2)**2+(y-Y2)**2+z**2)**(1.5))-((x-X3)*JDCS*DL3)/(np.sqrt((x-X3)**2+(y-Y3)**2+z**2)**(1.5))
    v = -((y - Y1) * JDCS * DL1) / (np.sqrt((x - X1) ** 2 + (y - Y1) ** 2 + z ** 2) ** (1.5))-((y - Y2) * JDCS * DL2) / (
                np.sqrt((x - X2) ** 2 + (y - Y2) ** 2 + z ** 2) ** (1.5)) - ((y - Y3) * JDCS * DL3) / (
                    np.sqrt((x - X3) ** 2 + (y - Y3) ** 2 + z ** 2) ** (1.5))
    w=-(z * JDCS * DL1) / (np.sqrt((x - X1) ** 2 + (y - Y1) ** 2 + z ** 2) ** (1.5))-(z* JDCS * DL2) / (
                np.sqrt((x - X2) ** 2 + (y - Y2) ** 2 + z ** 2) ** (1.5)) - (z * JDCS * DL3) / (
                    np.sqrt((x - X3) ** 2 + (y - Y3) ** 2 + z ** 2) ** (1.5))
    mlab.quiver3d(x, y, z, -u, -v, -w)
    mlab.show()


#按钮
b = tk.Button(window, text='Run', font=('Arial', 12), width=10, height=1,command=show2D3D)
b.place(x=310,y=140)

#画布
canvas = tk.Canvas(window, bg='green', height=480, width=530)
canvas.place(x=0,y=200)
# 第5步，主窗口循环显示
window.mainloop()