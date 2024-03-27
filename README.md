# CaotaiSystem

#### 介绍
一只会走路、会跳舞、会写字的草太椅子

<img src='5_esp32_Arduino/system.jpg'/>

#### 文件内容

##### 1_结构

这个文件夹里放了草太椅子机械结构相关的文件，
1.  `草太椅子`文件夹是椅子主体，使用SOLIDWORKS Premium 2021 SP5.0绘制，考虑到Solidworks向下兼容，所以应该使用同版本或更高版本打开。
2.  `鞋子`文件夹放了三种鞋子，如果是走路功能，则使用`鞋子-前脚`和`鞋子-后脚`，如果是写字功能和跳舞功能，则换用`后脚-稳定站立`，因为稳定站立版本不容易前倾，所以摔倒风险会小一些，但是走路时难以向前移动重心。
3.  `单轴往复运动STL`放了单轴往复子装配体的STL文件，可用于3D打印切片。

##### 2_电路

这个文件夹里放了电路板相关的文件
1.  `ProProject_caotai_ctrl_v2.epro`是嘉立创EDA pro另存为本地的工程文件，嘉立创EDA挺好用的，我已经从Cadence转到国产EDA了。打开步骤如下：     
（1）进入https://lceda.cn/ ，微信扫码登录     
（2）依次点开嘉立创EDA 编辑器、专业版，进入在线编辑器界面     
（3）点击文件->导入->嘉立创EDA专业版，在弹出的文件选择窗口选择`ProProject_caotai_ctrl_v2.epro`     
（4）等待导入完成，1分钟左右     
（5）在弹出的导入窗口中点击保存按钮，即可导入完成     
（6）点开PCB1，屏幕右上角有个类似购物车的图标，点击可以进入打样，下单之前别忘了领取4层板沉金免费券。
2.  `草太控制板-电子元器件BOM.xlsx`是物料清单，都是正确的，大胆购买吧。

##### 3_算法

这个文件夹里放了算法相关的代码，并不是很高深，是用了2个相互独立的全连接神经网络。
已知我们的草太椅子有4条腿，每条腿有3个伸缩连杆，我们算法的目的是解算出某个单腿姿态下3只伸缩连杆的高度，因为针对单条腿进行解算，没有把4条腿都联结起来，所以动作会有些生硬(T.T)     
第一个神经网络是2-64-64-2的结构，输入的2个神经元分别代表草太腿的外倾角和旋转角，输出的2个神经元分别代表伸缩连杆B、C和伸缩连杆A的高度之差。     
第二个神经网络是3-64-64-64-3的结构，输入的3个神经元分别代表草太脚尖的XYZ坐标，输出的3个神经元分别代表3只伸缩连杆的高度。
1.  `dataset_angle.m`和`dataset_draw.m`分别用于生成上述两个神经网络的数据集，数据集是通过解方程组产生的，核心代码在`function_forward.m`里面。
2.  `train_angle.ipynb`和`train_draw.ipynb`是训练这两个神经网络的代码，用到了`Tensorflow`框架。
3.  `eval_angle.m`和`eval_draw.m`用于评估这两个神经网络的精度，包括浮点精度和在FPGA实现时的定点精度。
4.  `make_para_rom.m`、`make_h2t_rom.m`和`make_sin_rom.m`用于FPGA实现时生成相关的查找表文件。

##### 4_FPGA

这个文件夹里放了FPGA的工程，使用安路FPGA`TD4.6.4`进行开发

<img src='4_FPGA/fpga_system.jpg'/>

##### 5_esp32_Arduino

这个文件夹里放了esp32的代码，主要完成2个功能：1.把从蓝牙收到的指令透传给FPGA；2.读取mpu6050的姿态。
1.使用VS code作为开发环境，Arduino作为框架来开发esp32
2.在PIO Home新建工程，板卡选择Espressif ESP32 Dev Module，框架选择Arduino
3.在PIO Home搜索mpu6050，在搜索到的库中选择I2Cdevlib-MPU6050 by Jeff Rowberg，add to project
4.编译、下载即可
##### 6_微信小程序

<img src='6_微信小程序/小程序码.jpg'/>

草太椅子采用微信小程序作为上位机来进行控制，有3种方法打开
1.  微信首页搜索`上仙的蓝牙法器`即可在搜索的小程序结果中找到对应小程序
2.  扫描上面的小程序码可以进入小程序
3.  把代码下载到本地，然后使用`微信开发者工具`自行编码，使用`真机调试`功能既可体验小程序




#### 复刻方法

1.  xxxx
2.  xxxx
3.  xxxx

#### 参与贡献

1.  Fork 本仓库
2.  新建 Feat_xxx 分支
3.  提交代码
4.  新建 Pull Request


