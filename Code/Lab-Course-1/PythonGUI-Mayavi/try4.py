from mayavi import mlab
#-----------------------------
from numpy import exp, sin, cos, tan, random, mgrid, ogrid, linspace, sqrt, pi
mlab.figure(fgcolor=(0, 0, 0), bgcolor=(1, 1, 1))  # 更改背景色
 #添加matlab的peaks函数
def peaks(x, y):
    return 3.0 * (1.0 - x) ** 2 * exp(-(x ** 2) - (y + 1.0) ** 2) - 10 * (x / 5.0 - x ** 3 - y ** 5) * exp(
        -x ** 2 - y ** 2) - 1.0 / 3.0 * exp(-(x + 1.0) ** 2 - y ** 2)
#-----------------------------
from matplotlib.pyplot import cm
import numpy as np
import matplotlib.pyplot as plt

# Contour Plot


X, Y = np.mgrid[-4:4:200j, -4:4:200j]#  每组最后那个参数带j是点数，不带j是间距

# Z = X*np.exp(-(X**2 + Y**2))         #Z的表达式
#------尝试区------
#                  假设一个正电荷在(1,0),一个负电荷在(-1,0)电量相等
Z=1/np.sqrt((X-1)**2+Y**2)-1/np.sqrt((X+1)**2+Y**2)
#------------
cp = plt.contour(X, Y, Z,400,colors='r', linestyles='--')         #画等高线，最后一个参数是设定等高线条数
#cb = plt.colorbar(cp)

# Vector Field
Y, X = np.mgrid[-4:4:40j, -4:4:40j]
U = -(X-1)/(np.sqrt((X-1)**2+Y**2)**(1.5))+(X+1)/(np.sqrt((X+1)**2+Y**2)**(1.5))  #X偏导数
V = -(Y)/(np.sqrt((X-1)**2+Y**2)**(1.5))+(Y)/(np.sqrt((X+1)**2+Y**2)**(1.5))      #Y偏导数
speed = np.sqrt(U**2 + V**2)                    #这三行是用来归一化的
UN = U/speed
VN = V/speed
quiv = plt.quiver(X, Y, UN, VN,  # assign to var
           headlength=7)                        #画出矢量线
plt.show()

#下面开始三维
x, y, z = np.mgrid[-4:4:200j, -4:4:200j, -4:4:200j]         #范围
scalars = 1/np.sqrt((x-1)**2+y**2+z**2)-1/np.sqrt((x+1)**2+y**2+z**2)       #电势
mlab.contour3d(x,y,z,scalars, contours=51, transparent=True)
# mlab.colorbar()




















x, y, z = np.mgrid[-4:4:40j, -4:4:40j, -4:4:40j]
u=-(x-1)/((np.sqrt((x-1)**2+y**2+z**2))**(1.5))+(x+1)/((np.sqrt((x+1)**2+y**2+z**2))**(1.5))
v=-(y)/((np.sqrt((x-1)**2+y**2+z**2))**(1.5))+(y)/((np.sqrt((x+1)**2+y**2+z**2))**(1.5))
w=-(z)/((np.sqrt((x-1)**2+y**2+z**2))**(1.5))+(z)/((np.sqrt((x+1)**2+y**2+z**2))**(1.5))
mlab.quiver3d(x,y,z,u,v,w)
mlab.show()