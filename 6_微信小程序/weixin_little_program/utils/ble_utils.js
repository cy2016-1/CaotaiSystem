var pageHome = require("../pages/home/home")
var sendBuffer = ""
var rotateFoot1 = -27.16  - 90
var rotateFoot2 = -117.16 - 90
var rotateFoot3 =  62.84  - 90
var rotateFoot4 =  152.84 - 90
//蓝牙初始化处理函数，根据蓝牙开关调整状态
exports.my_ble_init = function() {
  //如果关闭了小程序的蓝牙功能
  if (false===pageHome.pageData.ble_switch) {
    if (true===pageHome.pageData.isDicovering) {
      this.my_stop_discovery()
    }
    wx.offBluetoothAdapterStateChange()
    wx.closeBluetoothAdapter()
    pageHome.setVar("isListening",false)
    pageHome.setVar("adapter_state",false)
    pageHome.setVar("hardware_state",false)
    return
  }
  //打开蓝牙适配器
  if (false===pageHome.pageData.adapter_state) {
    wx.openBluetoothAdapter({
      success : (res) => {
        console.log('openBluetoothAdapter success', res)
        pageHome.setVar("hardware_state",true)
      },
      fail    : (res) => {
        console.log('openBluetoothAdapter fail', res)
      }
    })
    pageHome.setVar("adapter_state",true)
  }
  //监听手机蓝牙状态改变
  if (false===pageHome.pageData.isListening) {
    wx.onBluetoothAdapterStateChange((res) => {
      if (res.available) {
        console.log('onBluetoothAdapterStateChange available', res)
      }
      else {
        console.log('onBluetoothAdapterStateChange unavailable', res)
      }
      pageHome.setVar("hardware_state",res.available)
    })
    pageHome.setVar("isListening",true)
  }
},

//搜索周围的蓝牙设备（只有下拉刷新才会调用）
exports.my_ble_discovery = function() {
  //该方法要在蓝牙可用的基础上进行
  if (false===pageHome.pageData.hardware_state) {
    wx.showLoading({title: "你打开蓝牙先O.o"})
    setTimeout(()=>{wx.hideLoading()}, 2000)
    return
  }
  wx.showLoading({title: "启动蓝牙搜索-.-"})
  setTimeout(()=>{wx.hideLoading()}, 2000)
  //如果已经在搜索设备了，就不要再开启啦
  if (false===pageHome.pageData.isDicovering) {
    pageHome.setVar("isDicovering",true)
    setTimeout(()=>{
      this.my_stop_discovery()
    }, 6000)
    wx.startBluetoothDevicesDiscovery({
      allowDuplicatesKey: true,
      success: (res) => {
        console.log('startBluetoothDevicesDiscovery success', res)
        pageHome.setVar("devices",[])
        this.my_found_device()
      },
    })
  }
},

//本打算把这部分代码放在my_ble_discovery方法中，毕竟只调用一次
//但考虑到代码可读性，还是把这部分单拎出来了
exports.my_found_device = function() {
  wx.onBluetoothDeviceFound((res) => {
    res.devices.forEach(device => {
      const foundDevices = pageHome.pageData.devices
      var idx = 0
      for (let i=0; i<foundDevices.length; i++) {
        if (foundDevices[i]['deviceId'] === device.deviceId) {
          idx = i;
          break;
        }
        if (i===(foundDevices.length-1)) {
          idx = -1;
        }
      }
      const ddd = {}
      if (-1 === idx) {
        console.log(res.devices)
        ddd[`devices[${foundDevices.length}]`] = device
        for(var i=0;i<pageHome.pageData.devices.length;i++) {
          pageHome.showSignalInfo(pageHome.pageData.devices[i])
        }
      } else {
        ddd[`devices[${idx}]`] = device
      }
      pageHome.setVar("magic",ddd)
    })
  })
},

//建立BLE连接并获得serviceId
exports.createBLEConnection = function(e) {
  const ds = e.currentTarget.dataset
  const deviceId = ds.deviceId
  const name = ds.name
  //第一步：使用搜索到的deviceId连接至BLE server
  wx.createBLEConnection({
    deviceId,
    success: (res) => {
      //设置连接成功flag，保存对方的名字和deviceId
      pageHome.setVar("connected",true)
      pageHome.setVar("name",name)
      pageHome.setVar("deviceId",deviceId)
      //第二步：获得BLE service
      wx.getBLEDeviceServices({
        deviceId,
        success: (res) => {
          for (let i = 0; i < res.services.length; i++) {
            if (res.services[i].isPrimary) {
              this.getBLEDeviceCharacteristics(deviceId, res.services[i].uuid)
              return
            }
          }
        }
      })
    }
  })
},

//获得BLE characteristics及其读、写、广播通道
exports.getBLEDeviceCharacteristics = function(deviceId, serviceId) {
  //第三步：获得BLE characteristics
  wx.getBLEDeviceCharacteristics({
    deviceId,
    serviceId,
    success: (res) => {
      for (let i = 0; i < res.characteristics.length; i++) {
        let item = res.characteristics[i]
        //如果这个characteristics是读通道
        if (item.properties.read) {
          console.log("characteristics can read")
          wx.readBLECharacteristicValue({
            deviceId,
            serviceId,
            characteristicId: item.uuid,
          })
        }
        //如果这个characteristics是写通道
        if (item.properties.write) {
          console.log("characteristics can write")
          pageHome.setVar("canWrite",true)
          pageHome.setVar("serviceId",serviceId)
          pageHome.setVar("characteristicId",item.uuid)
          //this.writeBLEAsciiValue("Hello, new device!!!")
        }
        //如果这个characteristics是广播通道
        if (item.properties.notify || item.properties.indicate) {
          console.log("characteristics can notify")
          wx.notifyBLECharacteristicValueChange({
            deviceId,
            serviceId,
            characteristicId: item.uuid,
            state: true,
          })
          this.onCharacteristicValueChange()
        }
      }
    }
  })
},

//第四步：监听广播通道，把广播内容及其characteristic存在chs中
exports.onCharacteristicValueChange = function() {
  wx.onBLECharacteristicValueChange((characteristic) => {
    var isNew = true
    const ddd = {}
    let int8_ddd = this.ab2int8(characteristic.value)
    for (let i=0; i<pageHome.pageData.chs.length; i++) {
      if (pageHome.pageData.chs[i]['uuid'] === characteristic.characteristicId) {
        ddd[`chs[${i}]`] = {
          uuid: characteristic.characteristicId,
          value: this.ab2hex(characteristic.value),
          busy_state : int8_ddd[0],
          hangxiangjiao : int8_ddd[3],
          fuyangjiao : int8_ddd[4],
          henggunjiao : int8_ddd[5]
        }
        isNew = false
        break;
      }
    }
    if (true===isNew) {
      ddd[`chs[${pageHome.pageData.chs.length}]`] = {
        uuid: characteristic.characteristicId,
        value: this.ab2hex(characteristic.value),
        busy_state : int8_ddd[0],
        hangxiangjiao : int8_ddd[3],
        fuyangjiao : int8_ddd[4],
        henggunjiao : int8_ddd[5]
      }
    }
    pageHome.setVar("magic",ddd)
  })
},

//停止搜索设备
exports.my_stop_discovery = function() {
  wx.stopBluetoothDevicesDiscovery()
  pageHome.setVar("isDicovering",false)
  for(var i=0;i<pageHome.pageData.devices.length;i++) {
    pageHome.showSignalInfo(pageHome.pageData.devices[i])
  }
},

// 关闭蓝牙连接
exports.closeBLEConnection = function() {
  console.log("In closeBLEConnection")
  if (true===pageHome.pageData.connected) {
    wx.offBLECharacteristicValueChange()
    wx.closeBLEConnection({
      deviceId: pageHome.pageData.deviceId,
      fail    : (res) => {
        console.log('爱关不关，报你妹的错', res)
      }
    })
  }
  pageHome.setVar("connected",false)
  pageHome.setVar("chs",[])
  pageHome.setVar("devices",[])
  pageHome.setVar("canWrite",false)
},

// ArrayBuffer转16进度字符串示例
exports.ab2hex = function(buffer) {
  var hexArr = Array.prototype.map.call(
    new Uint8Array(buffer),
    function (bit) {
      //slice(-2)表示只取最后两个bit，前面又加了'00'，所以实现了限制位数和补零的功能
      return ('00' + bit.toString(16)).slice(-2)
  })
  return hexArr.join('');
},

exports.ab2int8 = function(buffer) {
  const dataView = new DataView(buffer)
  const dataArray = []
  let bbb = 0
  for (var i=0;i<dataView.byteLength;i++) {
    bbb = dataView.getInt8(i)
    dataArray.push(bbb)
  }
  return dataArray
},

// 向蓝牙设备发送一个整数列表
exports.writeBLECharacteristicValue = function(lllist) {
  let buffer = new ArrayBuffer(lllist.length)
  let dataView = new DataView(buffer)
  for(var i=0;i<lllist.length;i++) {
    dataView.setUint8(i, lllist[i])
  }
  //console.log(buffer)
  wx.writeBLECharacteristicValue({
    deviceId: pageHome.pageData.deviceId,
    serviceId: pageHome.pageData.serviceId,
    characteristicId: pageHome.pageData.characteristicId,
    value: buffer,
  })
},

//向设备发送字符串
exports.writeBLEAsciiValue = function(sss) {
  let lllist = []
  for(var i=0;i<sss.length;i++) {
    lllist.push(sss.charCodeAt(i))
  }
  console.log(sss)
  this.writeBLECharacteristicValue(lllist)
},

//向草太发送运动指令
exports.writeCaotaiGcode = function(type, range, time, data1, data2, data3) {
  let sinvalue = 0
  let cosvalue = 0
  let newdata1 = 0
  let newdata2 = 0
  let sss = ""
  // 足1的位置控制
  if (("2"===type.substr(-1,1)) && (1===(range&1))) {
    sinvalue = Math.sin(rotateFoot1/180*Math.PI)
    cosvalue = Math.cos(rotateFoot1/180*Math.PI)
    newdata1 = data1 * cosvalue - data2 * sinvalue
    newdata2 = data1 * sinvalue + data2 * cosvalue
    sss = sss + "G" + type.substr(-1,1) + "1" + " " + time.toFixed(0).toString() + " "
    sss = sss + newdata1.toFixed(1).toString() + " " 
              + newdata2.toFixed(1).toString() + " " 
              + data3.toFixed(1).toString()
    sss = sss + ";"
  }
  // 足1的角度控制
  if (("1"===type.substr(-1,1)) && (1===(range&1))) {
    newdata2 = data2 - 27.16
    while(newdata2<-180) {newdata2+=360}
    while(newdata2> 180) {newdata2-=360}
    sss = sss + "G" + type.substr(-1,1) + "1" + " " + time.toFixed(0).toString() + " "
    sss = sss + data1.toFixed(1).toString() + " " 
              + newdata2.toFixed(1).toString() + " " 
              + data3.toFixed(1).toString()
    sss = sss + ";"
  }
  // 足2的位置控制
  if (("2"===type.substr(-1,1)) && (2===(range&2))) {
    sinvalue = Math.sin(rotateFoot2/180*Math.PI)
    cosvalue = Math.cos(rotateFoot2/180*Math.PI)
    newdata1 = data1 * cosvalue - data2 * sinvalue
    newdata2 = data1 * sinvalue + data2 * cosvalue
    sss = sss + "G" + type.substr(-1,1) + "2" + " " + time.toFixed(0).toString() + " "
    sss = sss + newdata1.toFixed(1).toString() + " " 
              + newdata2.toFixed(1).toString() + " " 
              + data3.toFixed(1).toString()
    sss = sss + ";"
  }
  // 足2的角度控制
  if (("1"===type.substr(-1,1)) && (2===(range&2))) {
    newdata2 = data2 - 117.16
    while(newdata2<-180) {newdata2+=360}
    while(newdata2> 180) {newdata2-=360}
    sss = sss + "G" + type.substr(-1,1) + "2" + " " + time.toFixed(0).toString() + " "
    sss = sss + data1.toFixed(1).toString() + " " 
              + newdata2.toFixed(1).toString() + " " 
              + data3.toFixed(1).toString()
    sss = sss + ";"
  }
  // 足3的位置控制
  if (("2"===type.substr(-1,1)) && (4===(range&4))) {
    sinvalue = Math.sin(rotateFoot3/180*Math.PI)
    cosvalue = Math.cos(rotateFoot3/180*Math.PI)
    newdata1 = data1 * cosvalue - data2 * sinvalue
    newdata2 = data1 * sinvalue + data2 * cosvalue
    sss = sss + "G" + type.substr(-1,1) + "4" + " " + time.toFixed(0).toString() + " "
    sss = sss + newdata1.toFixed(1).toString() + " " 
              + newdata2.toFixed(1).toString() + " " 
              + data3.toFixed(1).toString()
    sss = sss + ";"
  }
  // 足3的角度控制
  if (("1"===type.substr(-1,1)) && (4===(range&4))) {
    newdata2 = data2 + 62.84
    while(newdata2<-180) {newdata2+=360}
    while(newdata2> 180) {newdata2-=360}
    sss = sss + "G" + type.substr(-1,1) + "4" + " " + time.toFixed(0).toString() + " "
    sss = sss + data1.toFixed(1).toString() + " " 
              + newdata2.toFixed(1).toString() + " " 
              + data3.toFixed(1).toString()
    sss = sss + ";"
  }
  // 足3的位置控制
  if (("2"===type.substr(-1,1)) && (8===(range&8))) {
    sinvalue = Math.sin(rotateFoot4/180*Math.PI)
    cosvalue = Math.cos(rotateFoot4/180*Math.PI)
    newdata1 = data1 * cosvalue - data2 * sinvalue
    newdata2 = data1 * sinvalue + data2 * cosvalue
    sss = sss + "G" + type.substr(-1,1) + "8" + " " + time.toFixed(0).toString() + " "
    sss = sss + newdata1.toFixed(1).toString() + " " 
              + newdata2.toFixed(1).toString() + " " 
              + data3.toFixed(1).toString()
    sss = sss + ";"
  }
  // 足4的角度控制
  if (("1"===type.substr(-1,1)) && (8===(range&8))) {
    newdata2 = data2 + 152.84
    while(newdata2<-180) {newdata2+=360}
    while(newdata2> 180) {newdata2-=360}
    sss = sss + "G" + type.substr(-1,1) + "8" + " " + time.toFixed(0).toString() + " "
    sss = sss + data1.toFixed(1).toString() + " " 
              + newdata2.toFixed(1).toString() + " " 
              + data3.toFixed(1).toString()
    sss = sss + ";"
  }
  sss = sss + "\n"
  let c_len = sendBuffer.length + sss.length
  if (c_len>500) {
    this.sendCaotaiGcode()
  }
  sendBuffer += sss  
}

exports.sendCaotaiGcode = function() {
  if (true===pageHome.pageData.connected) {
    this.writeBLEAsciiValue(sendBuffer)
  }
  else {
    console.log(sendBuffer)
  }
  sendBuffer = "";
}




