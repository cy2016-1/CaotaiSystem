// pages/home/home.js
var ble_utils = require("../../utils/ble_utils")
const app = getApp()

Page({
  /**
   * 页面的初始数据
   */
  data: {
    useHex          : false,
    textareaContent : "G01 1000 48 31.5 31.5;\nG01 1000 15 31.5 31.5;\nG01 1000 48 31.5 31.5;\nG01 1000 15 31.5 31.5;\nG01 200 36 31.5 31.5;\nG01 1000 15 31.5 31.5;\nG01 400 48 31.5 31.5;\nG01 1000 15 31.5 31.5;\n"   ,
    name            : ""   ,
    deviceId        : ""   ,
    serviceId       : ""   ,
    characteristicId: ""   ,
    devices         : [/*
      {
        "RSSI"      : -65  ,
        "deviceId"  : "50:02:91:95:02:C2",
        "name"      : "aver",
        "localName" : "xlex"
      }
    */],
    ble_switch      : true ,
    adapter_state   : false,
    isListening     : false,
    isDicovering    : false,
    hardware_state  : false,
    connected       : false,
    canWrite        : false,
    chs             : []
  },

  setVar(kkk, vvv) {
    if(kkk=="name") {this.setData({name: vvv})}
    if(kkk=="deviceId") {this.setData({deviceId: vvv})}
    if(kkk=="serviceId") {this.setData({serviceId: vvv})}
    if(kkk=="characteristicId") {this.setData({characteristicId: vvv})}
    if(kkk=="isListening") {this.setData({isListening: vvv})}
    if(kkk=="adapter_state") {this.setData({adapter_state: vvv})}
    if(kkk=="hardware_state") {this.setData({hardware_state: vvv})}
    if(kkk=="isDicovering") {this.setData({isDicovering: vvv})}
    if(kkk=="devices") {this.setData({devices: vvv})}
    if(kkk=="connected") {this.setData({connected: vvv})}
    if(kkk=="canWrite") {this.setData({canWrite: vvv})}
    if(kkk=="chs") {this.setData({chs: vvv})}
    if(kkk=="magic") {this.setData(vvv)}
  },

  //显示信号质量提示
  showSignalInfo(device) {
    wx.createSelectorQuery()
    .select(`#X${device.deviceId}`) // 在 WXML 中填入的 id
    .fields({ node: true, size: true })
    .exec((res) => {
        // Canvas 对象
        const canvas = res[0].node
        // 渲染上下文
        const ctx = canvas.getContext('2d')
        // Canvas 画布的实际绘制宽高
        const width = res[0].width
        const height = res[0].height
        const dpr = wx.getWindowInfo().pixelRatio
        const dpw = wx.getWindowInfo().screenWidth
        canvas.width = width * dpr
        canvas.height = height * dpr
        ctx.scale(dpr*dpw/375/2, dpr*dpw/375/2)
        // 设置颜色
        ctx.fillStyle=device.RSSI>-90 ? (device.RSSI>-70 ? "#00FFFF" : "#FFFF00") : "#FF0000";
        ctx.fillRect(30,90,20,30);
        if (device.RSSI>-90) {ctx.fillRect(60,70,20,50);}
        if (device.RSSI>-80) {ctx.fillRect(90,50,20,70);}
        if (device.RSSI>-70) {ctx.fillRect(120,30,20,90);}
        if (device.RSSI>-60) {ctx.fillRect(150,10,20,110);}
    })
  },

  // 蓝牙开关改变事件处理函数
  ble_switch_change(e) {
    this.setData({ble_switch: e.detail.value})
    ble_utils.my_ble_init()
  },

  //点击设备名称
  tap_ble_item(e) {
    ble_utils.createBLEConnection(e)
  },

  //点击发送按钮
  tapSendButton(e) {
    var temp = ""
    var sss = ""
    sss = this.data.textareaContent
    if (this.data.useHex==true) {     //HEX转ASCII
      for(var i=0;i<sss.length-1;i+=3) {
        temp += String.fromCharCode(parseInt(sss.substr(i,2),16))
      }
      sss = temp
    }
    ble_utils.writeBLEAsciiValue(sss)
  },

  //修改发送格式
  changeChartype(e) {
    var temp = ""
    var sss  = ""
    sss = this.data.textareaContent
    this.setData({useHex: e.detail.value})
    if (this.data.useHex===true) {   //ASCII转HEX
      for(var i=0;i<sss.length;i++) {
        temp += ("00" + sss.charCodeAt(i).toString(16)).slice(-2).toUpperCase()
        if (i!=sss.length-1) {temp += " "}
      }
    }
    if (this.data.useHex===false) {   //HEX转ASCII
      for(var i=0;i<sss.length-1;i+=3) {
        temp += String.fromCharCode(parseInt(sss.substr(i,2),16)).toUpperCase()
      }
    }
    sss = temp
    this.setData({textareaContent: sss})
  },

  //输入字符串
  textareaInput(e) {
    var sss = ""
    sss = e.detail.value
    if (this.data.useHex===true) {
      sss = sss.replace(/[^0-9a-fA-F]/g, '')
      var temp = ""
      for(var i=0;i<sss.length;i++) {
        if (i%2===1 && i!=sss.length-1) {temp += sss[i] + " "}
        else {temp += sss[i]}
      }
      sss = temp
    }
    if (this.data.useHex===false) {
      sss = sss.replace(/[^0-9a-zA-Z ;\n+-.]/g, '')
    }
    sss = sss.toUpperCase()
    this.setData({textareaContent: sss})
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad(options) {
    exports.pageData = this.data//刚加载就exports数据
    exports.showSignalInfo = this.showSignalInfo
    exports.setVar = this.setVar
    app.watch(this, {      //刚加载就注册这个监听器
      hardware_state: function (newVal) {
        if (newVal===false) {
          ble_utils.closeBLEConnection()
          ble_utils.my_stop_discovery()
          wx.closeBluetoothAdapter()
        }
      }
    })
  },

  /**
   * 生命周期函数--监听页面初次渲染完成
   */
  onReady() {

  },

  /**
   * 生命周期函数--监听页面显示
   */
  onShow() {
    this.testBLEAdapter(this.getAuthState, this.authCallBacks, this.closeFlags, true)
  },

  /**
   * 生命周期函数--监听页面隐藏
   */
  onHide() {

  },

  /**
   * 生命周期函数--监听页面卸载
   */
  onUnload() {

  },

  // 无蓝牙权限时向用户发送弹窗
  warUserAuth() {
    wx.showModal({
      title: '申请权限',
      content: '需要使用'+"蓝牙"+'权限，请前往设置打开权限',
      success(res) {
        if (res.confirm) {
          console.log('用户打开了设置界面');
          wx.openSetting()
        }
        else {
          console.log('用户不想打开设置界面');
        }
      }
    })
  },

  closeFlags() {
    this.setData({//初始化前先关闭标志位
        isListening    : false,
        adapter_state  : false,
        hardware_state : false
    })
    ble_utils.my_ble_init()
  },

  // 回调函数，决定是否搜索设备
  authCallBacks(bbb) {
    if (true===bbb) {
      ble_utils.my_ble_discovery() //成功则搜索设备
    }
    else {
      this.warUserAuth()           //失败则去设置权限
    }
  },

  getAuthState(authType, closeFlags, authCallBacks) {
    wx.getSetting({
      success(res) {
        if (true===res.authSetting[authType]) { //下拉刷新蓝牙异常，但是有权限
          console.log(authType + "授权状态成功")
          closeFlags()
          setTimeout(()=>{authCallBacks(true)}, 800)
        }
        else {                                  //下拉刷新蓝牙异常，但是没权限
          console.log(authType + "授权状态失败")
          authCallBacks(false)
        }
      }
    })
  },

  testBLEAdapter(getAuthState, authCallBacks, closeFlags, isInit) {
    wx.getBluetoothAdapterState({
      success() {
        if (false===isInit) {
          authCallBacks(true) //下拉刷新且蓝牙正常，就直接搜索喽
          console.log("path 1")
        }
        else {
          console.log("path 2")
        }
      },
      fail() {
        if (false===isInit) {
          getAuthState("scope.bluetooth", closeFlags, authCallBacks) //下拉刷新时蓝牙异常的处理
          console.log("path 3")
        }
        else {
          closeFlags() //刚显示页面时蓝牙异常，就初始化蓝牙喽
          console.log("path 4")
        }
      }
    })
  },

  /**
   * 页面相关事件处理函数--监听用户下拉动作
   */
  onPullDownRefresh() {
    wx.stopPullDownRefresh()
    console.log("触发了下拉刷新效果")
    ble_utils.closeBLEConnection()
    this.testBLEAdapter(this.getAuthState, this.authCallBacks, this.closeFlags, false)
  },

  /**
   * 页面上拉触底事件的处理函数
   */
  onReachBottom() {

  },

  /**
   * 用户点击右上角分享
   */
  onShareAppMessage() {

  }
})
