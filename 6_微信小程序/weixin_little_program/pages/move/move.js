// pages/move/move.js
var ble_utils = require("../../utils/ble_utils")

Page({

  /**
   * 页面的初始数据
   */
  data: {
    switchA    : true,
    switchB    : false,
    switchC    : false,
    switchD    : false,
    currChoice : "A",
    yourself   : {
        "A" : 1,
        "B" : 2,
        "C" : 4,
        "D" : 8
    },
    opposite   : {
        "A" : 8,
        "B" : 4,
        "C" : 2,
        "D" : 1
    },
    neighbor   : {
        "A" : 6,
        "B" : 9,
        "C" : 9,
        "D" : 6
    },
    sbDirect   : {
        "A" : -145,
        "B" : - 35,
        "C" : +120,
        "D" : + 60
    },
    standBias  : {
        "A" :   10,
        "B" :   10,
        "C" :   27,
        "D" :   27
    },
    outerBias  : {
        "A" :   74,
        "B" :   93,
        "C" : -130,
        "D" : -155
    },
    stepSize   : {
        "A" :   20,
        "B" :   22,
        "C" :    1,
        "D" :    4
    },
    stepDept   : {
        "A" :   28,
        "B" :   28,
        "C" :   26,
        "D" :   26
    },
    magicStr1  : null,
    musicSpeed : 85, //《一笑江湖》每分钟85拍
    danceBias  : {
        "A" :   65,
        "B" :  100,
        "C" :- 105,
        "D" :  140
    },
    danceSize  : {
        "A" :    6,
        "B" :    2,
        "C" :    3.5,
        "D" :    6
    },
    danceDept  : {
        "A" :   26,
        "B" :   26,
        "C" :   26,
        "D" :   26
    },
    magicStr2  : null,
    curr_state : null
  },

  dance1() {
    let ttt = 60*1000 / this.data.musicSpeed
    let cC  = this.data.currChoice
    let yt  = this.data.yourself[cC]
    let nt  = this.data.neighbor[cC]
    let ot  = this.data.opposite[cC]
    let sbD = this.data.sbDirect[cC]
    let sb  = this.data.standBias[cC]
    let sD  = this.data.danceDept[cC]
    let ob  = this.data.danceBias[cC]
    let sS  = this.data.danceSize[cC]
    ble_utils.writeCaotaiGcode("1", yt, ttt,  0,   0, 41)
    ble_utils.writeCaotaiGcode("1", nt, ttt, sb, sbD, 37)
    ble_utils.writeCaotaiGcode("1", ot, ttt,  0,   0, 32)
    ble_utils.writeCaotaiGcode("1", yt, ttt, sS,  ob, sD)
    ble_utils.writeCaotaiGcode("1", nt, ttt, sb, sbD, 37)
    ble_utils.writeCaotaiGcode("1", ot, ttt,  0,   0, 35)
    ble_utils.sendCaotaiGcode()
    let next_state = {
      "which1" : yt,
      "data1_1": sS,
      "data1_2": ob,
      "data1_3": sD,
      "which2" : nt,
      "data2_1": sb,
      "data2_2": sbD,
      "data2_3": 37,
      "which3" : ot,
      "data3_1": 0,
      "data3_2": 0,
      "data3_3": 35
    }
    this.setData({curr_state : next_state})
  },

  dance2() {
    let ttt = 60*1000 / this.data.musicSpeed
    let cC  = this.data.currChoice
    let yt  = this.data.yourself[cC]
    let nt  = this.data.neighbor[cC]
    let ot  = this.data.opposite[cC]
    let sbD = this.data.sbDirect[cC]
    let sb  = this.data.standBias[cC]
    let sD  = this.data.danceDept[cC]
    let ob  = this.data.danceBias[cC]
    let sS  = this.data.danceSize[cC]
    ble_utils.writeCaotaiGcode("1", yt, ttt, sS,  ob, sD)
    ble_utils.writeCaotaiGcode("1", nt, ttt, sb, sbD, 37)
    ble_utils.writeCaotaiGcode("1", ot, ttt,  0,   0, 35)
    ble_utils.writeCaotaiGcode("1", yt, ttt, sS,  ob, sD)
    ble_utils.writeCaotaiGcode("1", nt, ttt, sb, sbD, 31)
    ble_utils.writeCaotaiGcode("1", ot, ttt,  0,   0, 35)
    ble_utils.writeCaotaiGcode("1", yt, ttt,  0,   0, 31.5)
    ble_utils.writeCaotaiGcode("1", nt, ttt,  0,   0, 31.5)
    ble_utils.writeCaotaiGcode("1", ot, ttt,  0,   0, 31.5)
    ble_utils.sendCaotaiGcode()
    let next_state = {
      "which1" : yt,
      "data1_1": 0,
      "data1_2": 0,
      "data1_3": 31.5,
      "which2" : nt,
      "data2_1": 0,
      "data2_2": 0,
      "data2_3": 31.5,
      "which3" : ot,
      "data3_1": 0,
      "data3_2": 0,
      "data3_3": 31.5
    }
    this.setData({curr_state : next_state})
  },

  dance3() {
    let ttt = 60*1000 / this.data.musicSpeed
    let yt  = this.data.curr_state["which1"]
    let d11 = this.data.curr_state["data1_1"]
    let d12 = this.data.curr_state["data1_2"]
    let d13 = this.data.curr_state["data1_3"]
    let nt  = this.data.curr_state["which2"]
    let d21 = this.data.curr_state["data2_1"]
    let d22 = this.data.curr_state["data2_2"]
    let d23 = this.data.curr_state["data2_3"]
    let ot  = this.data.curr_state["which3"]
    let d31 = this.data.curr_state["data3_1"]
    let d32 = this.data.curr_state["data3_2"]
    let d33 = this.data.curr_state["data3_3"]
    ble_utils.writeCaotaiGcode("1", yt, ttt, d11, d12, d13)
    ble_utils.writeCaotaiGcode("1", nt, ttt, d21, d22, d23)
    ble_utils.writeCaotaiGcode("1", ot, ttt, d31, d32, d33)
    ble_utils.sendCaotaiGcode()
  },

  dance4() {
    let ttt = 60*1000 / this.data.musicSpeed
    let cC  = this.data.currChoice
    let yt  = this.data.yourself[cC]
    let nt  = this.data.neighbor[cC]
    let ot  = this.data.opposite[cC]
    let sbD = this.data.sbDirect[cC]
    let sb  = this.data.standBias[cC]
    let sD  = this.data.danceDept[cC]
    let ob  = this.data.danceBias[cC]
    let sS  = this.data.danceSize[cC]
    ble_utils.writeCaotaiGcode("1", yt, ttt, sS,  ob, sD)
    ble_utils.writeCaotaiGcode("1", nt, ttt, sb, sbD, 37)
    ble_utils.writeCaotaiGcode("1", ot, ttt,  0,   0, 35)
    ble_utils.sendCaotaiGcode()
    let next_state = {
      "which1" : yt,
      "data1_1": sS,
      "data1_2": ob,
      "data1_3": sD,
      "which2" : nt,
      "data2_1": sb,
      "data2_2": sbD,
      "data2_3": 37,
      "which3" : ot,
      "data3_1": 0,
      "data3_2": 0,
      "data3_3": 35
    }
    this.setData({curr_state : next_state})
  },

  dance5(oAngle, rAngle, hOpposite) {
    let ttt = 60*1000 / this.data.musicSpeed
    let cC  = this.data.currChoice
    let yt  = this.data.yourself[cC]
    let nt  = this.data.neighbor[cC]
    let ot  = this.data.opposite[cC]
    let sbD = this.data.sbDirect[cC]
    let sb  = this.data.standBias[cC]
    let sD  = this.data.danceDept[cC]
    ble_utils.writeCaotaiGcode("1", yt, ttt, oAngle, rAngle, 31.5)
    ble_utils.writeCaotaiGcode("1", nt, ttt, sb, sbD, 37)
    ble_utils.writeCaotaiGcode("1", ot, ttt,  0,   0, hOpposite)
    ble_utils.sendCaotaiGcode()
    let next_state = {
      "which1" : yt,
      "data1_1": oAngle,
      "data1_2": rAngle,
      "data1_3": 31.5,
      "which2" : nt,
      "data2_1": sb,
      "data2_2": sbD,
      "data2_3": 37,
      "which3" : ot,
      "data3_1": 0,
      "data3_2": 0,
      "data3_3": hOpposite
    }
    this.setData({curr_state : next_state})
  },

  dance6(oFace, rFace, avgH) {
    let ttt = 60*1000 / this.data.musicSpeed
    let faceLength = 167.7
    // let oFace = 5
    // let rFace = -135
    let xVector = Math.cos(rFace/180*Math.PI)
    let yVector = Math.sin(rFace/180*Math.PI)
    let zVector = 1 / Math.tan(oFace/180*Math.PI)
    let heightA = -(xVector*( faceLength/2) + yVector*( faceLength/2)) / zVector + avgH
    let heightB = -(xVector*(-faceLength/2) + yVector*( faceLength/2)) / zVector + avgH
    let heightC = -(xVector*( faceLength/2) + yVector*(-faceLength/2)) / zVector + avgH
    let heightD = -(xVector*(-faceLength/2) + yVector*(-faceLength/2)) / zVector + avgH
    ble_utils.writeCaotaiGcode("1", 1, ttt, 0, 0, heightA)
    ble_utils.writeCaotaiGcode("1", 2, ttt, 0, 0, heightB)
    ble_utils.writeCaotaiGcode("1", 4, ttt, 0, 0, heightC)
    ble_utils.writeCaotaiGcode("1", 8, ttt, 0, 0, heightD)
    ble_utils.sendCaotaiGcode()
  },

  beat1() {
    let old_temp = this.data.currChoice
    // 江湖一笑浪滔滔，红尘尽忘了，9
    this.setData({currChoice : "D"})
    this.dance1()
    this.dance2()
    this.dance3()
    this.dance3()
    this.dance3()
    this.dance3()
    // 俱往矣何足言道，7
    this.setData({currChoice : "B"})
    this.dance1()
    this.dance2()
    this.dance3()
    this.dance3()
    // 苍天一笑笑不老，豪情却会了，9
    this.setData({currChoice : "A"})
    this.dance1()
    this.dance2()
    this.dance3()
    this.dance3()
    this.dance3()
    this.dance3()
    // 对月吟一杯寂寥，7
    this.setData({currChoice : "C"})
    this.dance1()
    this.dance2()
    this.dance3()
    this.dance3()
    // 长音，1
    this.dance3()
    this.setData({currChoice : old_temp})
  },

  beat2() {
    let old_temp = this.data.currChoice
    // 剑起江湖恩怨拂袖罩明月，8
    this.setData({currChoice : "A"})
    this.dance1()
    this.dance5(50, 140, 35)
    this.dance5(50,  40, 35)
    this.dance4()
    this.dance2()
    // 西风叶落花谢枕刀剑难眠，8
    this.setData({currChoice : "B"})
    this.dance1()
    this.dance5(50,  40, 35)
    this.dance5(50, 140, 35)
    this.dance4()
    this.dance2()
    // 汝为山河过客却总长叹伤离别，8
    this.setData({currChoice : "A"})
    this.dance1()
    this.dance5(50,  50, 35)
    this.dance5(50, -50, 35)
    this.dance4()
    this.dance2()
    // 鬓如霜一杯浓烈，8
    this.setData({currChoice : "B"})
    this.dance1()
    this.dance5(50,  130, 35)
    this.dance5(50, -130, 35)
    this.dance4()
    this.dance2()
    this.setData({currChoice : old_temp})
  },

  beat3() {
    let old_temp = this.data.currChoice
    // 只身走过多少的岁月看惯刀光照亮过黑夜，侠骨魔心如何来分辨弹指一梦不过一瞬间，16
    this.setData({currChoice : "A"})
    this.dance1()
    this.dance5(50, 90, 33)
    this.dance5(40, 18, 33)
    this.dance5(30,-54, 33)
    this.dance5(30,-126, 33)
    this.dance5(40, 162, 33)
    this.dance5(50, 90, 33)
    this.dance5(40, 18, 33)
    this.dance5(30,-54, 33)
    this.dance5(30,-126, 33)
    this.dance5(40, 162, 33)
    this.dance4()
    this.dance2()
    // 黄沙之中的残阳如血，多少魂魄在此地寂灭，这成败有谁来了解，15
    this.setData({currChoice : "B"})
    this.dance1()
    this.dance5(50, 90, 31)
    this.dance5(30,-150, 31)
    this.dance5(30,-30, 31)
    this.dance5(50, 90, 31)
    this.dance5(30,-150, 31)
    this.dance5(30,-30, 31)
    this.dance5(50, 90, 31)
    this.dance5(30,-150, 31)
    this.dance5(30,-30, 31)
    this.dance4()
    this.dance2()
    this.setData({currChoice : old_temp})
  },

  beat4() {
    let old_temp = this.data.currChoice
    // 江湖一笑浪滔滔，红尘尽忘了，俱往矣何足言道，16
    this.setData({currChoice : "D"})
    this.dance1()
    this.dance5(50, -180, 30)
    this.dance4()
    this.dance5(50, -157.5, 30)
    this.dance4()
    this.dance5(50, -135, 30)
    this.dance4()
    this.dance5(50, -112.5, 30)
    this.dance4()
    this.dance5(50, -90, 30)
    this.dance4()
    this.dance4()
    this.dance2()
    // 苍天一笑笑不老，豪情却会了，对月吟一杯寂寥，16
    this.setData({currChoice : "C"})
    this.dance1()
    this.dance5(50, -90, 30)
    this.dance4()
    this.dance5(50, -67.5, 30)
    this.dance4()
    this.dance5(50, -45, 30)
    this.dance4()
    this.dance5(50, -22.5, 30)
    this.dance4()
    this.dance5(50,  0, 30)
    this.dance4()
    this.dance4()
    this.dance2()
    this.setData({currChoice : old_temp})
  },

  beat5() {
    // ,9
    this.dance6(  5,   0, 31.5)
    this.dance6(  5,  45, 31.5)
    this.dance6(  5,  90, 31.5)
    this.dance6(  5, 135, 31.5)
    this.dance6(  5, 180, 31.5)
    this.dance6(  5,-135, 31.5)
    this.dance6(  5,- 90, 31.5)
    this.dance6(  5,- 45, 31.5)
    this.dance6(  5,   0, 31.5)
    // ,7
    this.dance6(  5,- 45, 31.5)
    this.dance6(  5,- 90, 31.5)
    this.dance6(  5,-135, 31.5)
    this.dance6(  5, 180, 31.5)
    this.dance6(  5, 135, 31.5)
    this.dance6(  5,  90, 31.5)
    this.dance6(  5,  45, 31.5)
    // ,9
    this.dance6(  5,   0, 31.5)
    this.dance6(  5,  45, 31.5)
    this.dance6(  5,  90, 31.5)
    this.dance6(  5, 135, 31.5)
    this.dance6(  5, 180, 31.5)
    this.dance6(  5,-135, 31.5)
    this.dance6(  5,- 90, 31.5)
    this.dance6(  5,- 45, 31.5)
    this.dance6(  5,   0, 31.5)
    // ,7
    this.dance6(  5,- 45, 31.5)
    this.dance6(  5,- 90, 31.5)
    this.dance6(  5,-135, 31.5)
    this.dance6(  5, 180, 31.5)
    this.dance6(  5, 135, 31.5)
    this.dance6(  5,  90, 31.5)
    this.dance6(  5,  45, 31.5)
    // ,1
    this.dance6(  0,   0, 31.5)
  },

  beat6() {
    let old_temp = this.data.currChoice
    // 只身走过多少的岁月看惯刀光照亮过黑夜，8
    this.setData({currChoice : "B"})
    this.dance1()
    this.dance5(50,  30, 35)
    this.dance4()
    this.dance5(50,- 30, 35)
    this.dance4()
    this.dance5(50,  30, 35)
    this.dance4()
    // 峡谷魔心如何来分辨弹指一梦不过一瞬间，8
    this.dance5(50,-120, 35)
    this.dance4()
    this.dance5(50,- 60, 35)
    this.dance4()
    this.dance5(50,-120, 35)
    this.dance4()
    this.dance5(50,- 60, 35)
    this.dance4()
    // 黄沙之中的残阳如血，多少魂魄在此地寂灭，8
    this.dance5(50,  60, 30)
    this.dance5(50, 120, 30)
    this.dance5(50,  60, 30)
    this.dance5(50, 120, 30)
    this.dance5(50, 105, 35)
    this.dance5(50,  90, 30)
    this.dance5(50,  75, 35)
    this.dance5(50,  60, 30)
    // 这成败有谁来了解，7
    this.dance5(50,  30, 35)
    this.dance4()
    this.dance5(50,- 30, 35)
    this.dance4()
    this.dance2()
    // 江湖一笑浪滔滔，5
    this.setData({currChoice : "A"})
    this.dance1()
    this.dance5(50,  75, 30)
    this.dance5(50, 105, 30)
    this.dance5(50, 135, 30)
    // 红尘尽忘了，4
    this.dance5(50, 105, 30)
    this.dance5(50,  75, 30)
    this.dance5(50,  45, 30)
    this.dance4()
    // 俱往矣何足言道，7
    this.dance5(50, 150, 35)
    this.dance4()
    this.dance5(50,-150, 35)
    this.dance4()
    this.dance5(50, 150, 35)
    this.dance5(25, 150, 35)
    this.dance4()
    // 苍天一笑笑不老，5
    this.dance5(50,  50, 30)
    this.dance5(35,  50, 32)
    this.dance5(20,  50, 34)
    this.dance5( 5,  50, 35)
    this.dance4()
    // 豪情却会了，4
    this.dance5(50, 130, 30)
    this.dance5(30, 130, 33)
    this.dance5(10, 130, 35)
    this.dance4()
    // 对月吟一杯寂寥，7
    this.dance5(20,   0, 33)
    this.dance5(20, 180, 33)
    this.dance5(20,   0, 33)
    this.dance4()
    this.dance2()
    this.setData({currChoice : old_temp})
  },

  beat7() {
    let old_temp = this.data.currChoice
    // 也曾横刀向天笑数过路迢迢，9
    this.setData({currChoice : "D"})
    this.dance1()
    this.dance5(50,- 160, 35)
    this.dance5(50,- 160, 32)
    this.dance5(50,- 160, 30)
    this.dance4()
    this.dance2()
    // 数不完夕阳晚照，7
    this.dance6(  3,  90, 31.5)
    this.dance6(  3,- 90, 31.5)
    this.dance6(  0,   0, 31.5)
    this.dance6(  3,   0, 31.5)
    this.dance6(  3, 180, 31.5)
    this.dance6(  0,   0, 34.5)
    this.dance6(  0,   0, 31.5)
    // 苍天一笑乐逍遥江湖人自扰，9
    this.setData({currChoice : "C"})
    this.dance1()
    this.dance5(50,-  20, 35)
    this.dance5(50,-  20, 32)
    this.dance5(50,-  20, 30)
    this.dance4()
    this.dance2()
    // 留不住爱恨离潮，7
    this.dance6(  3, 180, 31.5)
    this.dance6(  3,   0, 31.5)
    this.dance6(  0,   0, 31.5)
    this.dance6(  3,- 90, 31.5)
    this.dance6(  3,  90, 31.5)
    this.dance6(  0,   0, 34.5)
    this.dance6(  0,   0, 31.5)
    this.setData({currChoice : old_temp})
  },

  beat8() {
    this.setData({currChoice : "B"})
    this.dance1()
    this.dance5(50, 120, 30)
    this.dance5(30, 120, 35)
    this.dance5(50, 120, 30)
    this.dance5(30, 120, 35)
    this.dance5(50, 120, 30)
    this.dance5(30, 120, 35)
    this.dance4()
    this.dance2()
  },

  action1() {
    let ttt = 60*1000 / this.data.musicSpeed
    let cC  = this.data.currChoice
    let yt  = this.data.yourself[cC]
    let nt  = this.data.neighbor[cC]
    let ot  = this.data.opposite[cC]
    let sbD = this.data.sbDirect[cC]
    let sb  = this.data.standBias[cC]
    ble_utils.writeCaotaiGcode("1", yt, ttt,  0,   0, 41)
    ble_utils.writeCaotaiGcode("1", nt, ttt, sb, sbD, 37)
    ble_utils.writeCaotaiGcode("1", ot, ttt,  0,   0, 32)
    ble_utils.sendCaotaiGcode()
  },

  action2() {
    let ttt = 60*1000 / this.data.musicSpeed
    let cC  = this.data.currChoice
    let yt  = this.data.yourself[cC]
    let nt  = this.data.neighbor[cC]
    let ot  = this.data.opposite[cC]
    let sbD = this.data.sbDirect[cC]
    let sb  = this.data.standBias[cC]
    ble_utils.writeCaotaiGcode("1", yt, ttt,  0,   0, 23)
    ble_utils.writeCaotaiGcode("1", nt, ttt, sb, sbD, 39)
    ble_utils.writeCaotaiGcode("1", ot, ttt,  0,   0, 35)
    ble_utils.sendCaotaiGcode()
  },

  action3() {
    let ttt = 60*1000 / this.data.musicSpeed
    let cC  = this.data.currChoice
    let yt  = this.data.yourself[cC]
    let nt  = this.data.neighbor[cC]
    let ot  = this.data.opposite[cC]
    let sbD = this.data.sbDirect[cC]
    let sb  = this.data.standBias[cC]
    let ob  = this.data.outerBias[cC]
    ble_utils.writeCaotaiGcode("1", yt, ttt, 50,  ob, 25)
    ble_utils.writeCaotaiGcode("1", nt, ttt, sb, sbD, 39)
    ble_utils.writeCaotaiGcode("1", ot, ttt,  0,   0, 35)
    ble_utils.sendCaotaiGcode()
  },

  action4() {
    let ttt = 60*1000 / this.data.musicSpeed
    let cC  = this.data.currChoice
    let yt  = this.data.yourself[cC]
    let nt  = this.data.neighbor[cC]
    let ot  = this.data.opposite[cC]
    let sbD = this.data.sbDirect[cC]
    let sb  = this.data.standBias[cC]
    let ob  = this.data.outerBias[cC]
    let sS  = this.data.stepSize[cC]
    let sD  = this.data.stepDept[cC]
    ble_utils.writeCaotaiGcode("1", yt, ttt, sS,  ob, sD)
    ble_utils.writeCaotaiGcode("1", nt, ttt, sb, sbD, 37)
    ble_utils.writeCaotaiGcode("1", ot, ttt,  0,   0, 35)
    ble_utils.sendCaotaiGcode()
  },

  action5() {
    let ttt = 60*1000 / this.data.musicSpeed
    let cC  = this.data.currChoice
    let yt  = this.data.yourself[cC]
    let nt  = this.data.neighbor[cC]
    let ot  = this.data.opposite[cC]
    let sbD = this.data.sbDirect[cC]
    let sb  = this.data.standBias[cC]
    let ob  = this.data.outerBias[cC]
    let sS  = this.data.stepSize[cC]
    let sD  = this.data.stepDept[cC]
    ble_utils.writeCaotaiGcode("1", yt, ttt, sS,  ob, sD)
    ble_utils.writeCaotaiGcode("1", nt, ttt, sb, sbD, 31)
    ble_utils.writeCaotaiGcode("1", ot, ttt,  0,   0, 35)
    ble_utils.sendCaotaiGcode()
  },

  action6() {
    let ttt = 60*1000 / this.data.musicSpeed
    let cC  = this.data.currChoice
    let yt  = this.data.yourself[cC]
    let nt  = this.data.neighbor[cC]
    let ot  = this.data.opposite[cC]
    let sbD = this.data.sbDirect[cC]
    let sb  = this.data.standBias[cC]
    console.log(ttt + yt + nt + ot)
    ble_utils.writeCaotaiGcode("1", yt, ttt,  0,   0, 31.5)
    ble_utils.writeCaotaiGcode("1", nt, ttt,  0,   0, 31.5)
    ble_utils.writeCaotaiGcode("1", ot, ttt,  0,   0, 31.5)
    ble_utils.sendCaotaiGcode()
  },

  action7() {
    let ttt = 60*1000 / this.data.musicSpeed
    ble_utils.writeCaotaiGcode("1",  1, ttt,  0,   0, 20)
    ble_utils.writeCaotaiGcode("1",  2, ttt,  0,   0, 20)
    ble_utils.writeCaotaiGcode("1",  4, ttt,  8,- 80, 39)
    ble_utils.writeCaotaiGcode("1",  8, ttt,  8,-100, 39)
    ble_utils.sendCaotaiGcode()
  },

  foot_switch_change(e) {
    let nnn = e.target.dataset.name
    let vvv = e.detail.value
    if ("A"===nnn) {this.setData({switchA : vvv})}
    if ("B"===nnn) {this.setData({switchB : vvv})}
    if ("C"===nnn) {this.setData({switchC : vvv})}
    if ("D"===nnn) {this.setData({switchD : vvv})}
    if (this.data.switchA) {this.setData({currChoice : "A"})}
    if (this.data.switchB) {this.setData({currChoice : "B"})}
    if (this.data.switchC) {this.setData({currChoice : "C"})}
    if (this.data.switchD) {this.setData({currChoice : "D"})}
  },

  foot1() {
    let old_temp = this.data.currChoice
    this.setData({currChoice : "A"})
    this.action1()
    this.action2()
    this.action3()
    this.action4()
    this.action5()
    this.action6()
    this.setData({currChoice : "B"})
    this.action1()
    this.action2()
    this.action3()
    this.action4()
    this.action5()
    this.action6()
    this.action7()
    this.action7()
    this.action7()
    this.action7() //故意的四个action7，受惯性影响，稳定了以后才能继续走，否则翻车
    this.setData({currChoice : "C"})
    this.action1()
    this.action2()
    this.action3()
    this.action4()
    this.action5()
    this.action6()
    this.setData({currChoice : "D"})
    this.action1()
    this.action2()
    this.action3()
    this.action4()
    this.action5()
    this.action6()
    this.setData({currChoice : old_temp})
  },

  foot2() {
    let old_temp = this.data.currChoice
    this.setData({currChoice : "A"})
    this.action1()
    this.action4()
    this.action5()
    this.action6()
    this.setData({currChoice : "B"})
    this.action1()
    this.action4()
    this.action5()
    this.action6()
    this.action7()
    this.setData({currChoice : "C"})
    this.action1()
    this.action4()
    this.action6()
    this.setData({currChoice : "D"})
    this.action1()
    this.action4()
    this.action6()
    this.setData({currChoice : old_temp})
  },

  foot3() {
    for (var i=0;i<20;i++) {
      this.action6()
    }
  },

  my2Str() {
    let m1 = this.data.outerBias["A"]
    let m2 = this.data.outerBias["B"]
    let m3 = this.data.outerBias["C"]
    let m4 = this.data.outerBias["D"]
    let m5 = this.data.stepSize["A"]
    let m6 = this.data.stepSize["B"]
    let m7 = this.data.stepSize["C"]
    let m8 = this.data.stepSize["D"]
    let ss = m1.toFixed(1) + ";" + m2.toFixed(1) + ";" + m3.toFixed(1) + ";" + m4.toFixed(1) + ";"
    ss = ss + m5.toFixed(1) + ";" + m6.toFixed(1) + ";" + m7.toFixed(1) + ";" + m8.toFixed(1)
    this.setData({magicStr1 : ss})
    m1 = this.data.danceBias["A"]
    m2 = this.data.danceBias["B"]
    m3 = this.data.danceBias["C"]
    m4 = this.data.danceBias["D"]
    m5 = this.data.danceSize["A"]
    m6 = this.data.danceSize["B"]
    m7 = this.data.danceSize["C"]
    m8 = this.data.danceSize["D"]
    ss = m1.toFixed(1) + ";" + m2.toFixed(1) + ";" + m3.toFixed(1) + ";" + m4.toFixed(1) + ";"
    ss = ss + m5.toFixed(1) + ";" + m6.toFixed(1) + ";" + m7.toFixed(1) + ";" + m8.toFixed(1)
    this.setData({magicStr2 : ss})
  },

  my2Num(ss, t) {
    let ns = ss.split(";").map(Number);
    //console.log(ns)
    let new1 = {
      "A" : ns[0],
      "B" : ns[1],
      "C" : ns[2],
      "D" : ns[3]
    }
    let new2 = {
      "A" : ns[4],
      "B" : ns[5],
      "C" : ns[6],
      "D" : ns[7]
    }
    if (1===t) {
      this.setData({
        outerBias : new1,
        stepSize  : new2
      })
    }
    else {
      this.setData({
        danceBias : new1,
        danceSize : new2
      })
    }
    this.my2Str()
  },

  textareaInput(e) {
    let nnn = e.target.dataset.typeof
    if ("walk"===nnn) {
      this.my2Num(e.detail.value, 1)
    }
    else if ("dance"===nnn) {
      this.my2Num(e.detail.value, 2)
    }
    
  },


  /**
   * 生命周期函数--监听页面加载
   */
  onLoad(options) {
    this.my2Str()
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

  /**
   * 页面相关事件处理函数--监听用户下拉动作
   */
  onPullDownRefresh() {

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