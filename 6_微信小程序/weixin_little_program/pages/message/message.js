const app = getApp()
var ble_utils = require("../../utils/ble_utils")

Page({
  data: {
    modeWriterSel : true,
    shortTime  : 130,
    pageWidth  : 15,
    areaSize   : "width: 15px; height: 15px;",
    switchA    : true,
    switchB    : false,
    switchC    : false,
    switchD    : false,
    ctxWriter  : null,
    writerPosX : 0,
    writerPosY : 0,
    writerPosZ : 38,
    writerSpeed: 0.02,
    hhhWriter  : 38,
    writeryeild: 10,
    ctxAngle   : null,
    angleAlpha : 0,
    angleBelta : 0,
    hhhAngle   : 31,
    angleTime  : 500,
    angleStamp : 0,
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
        "C" : +125,
        "D" : + 55
    },
    standBias  : {
        "A" :   10,
        "B" :   10,
        "C" :   25,
        "D" :   25
    }
  },

  mode_change(e) {
    this.setData({modeWriterSel : e.detail.value})
    if (this.data.modeWriterSel) {
      this.writerInit()
    }
    else {
      this.angleInit()
    }
  },

  sliderChanging(e) {
    let ttt = e.target.dataset.type
    let vvv = e.detail.value
    if ("writer"===ttt) {
      this.setData({hhhWriter : vvv})
      let xxx = this.data.writerPosX
      let yyy = this.data.writerPosY
      let zzz = this.data.hhhWriter
      let range = this.data.switchA ? 1 : (this.data.switchB ? 2: (this.data.switchA ? 4 : 8))
      let time = this.writerCalTime(xxx, yyy, zzz)
      ble_utils.writeCaotaiGcode("2", range, time, xxx, yyy, zzz)
      this.writerCommitPos(xxx, yyy, zzz)
      ble_utils.sendCaotaiGcode()
    }
    if ("angle"===ttt) {
      this.setData({hhhAngle : vvv})
      let aaa = this.data.angleAlpha
      let bbb = this.data.angleBelta
      let hhh = this.data.hhhAngle
      let range = this.data.switchA * 1 + this.data.switchB * 2 + this.data.switchC * 4 + this.data.switchD * 8
      let time = this.data.angleTime
      ble_utils.writeCaotaiGcode("1", range, time, aaa, bbb, hhh)
      this.angleCommitPos(aaa, bbb, hhh)
      ble_utils.sendCaotaiGcode()
    }
  },

  foot_switch_change(e) {
    let nnn = e.target.dataset.name
    let vvv = e.detail.value
    if ("A"===nnn) {this.setData({switchA : vvv})}
    if ("B"===nnn) {this.setData({switchB : vvv})}
    if ("C"===nnn) {this.setData({switchC : vvv})}
    if ("D"===nnn) {this.setData({switchD : vvv})}
  },

  writerCommitPos(xxx, yyy, zzz) {
    this.setData({
      writerPosX : xxx,
      writerPosY : yyy,
      writerPosZ : zzz
    })
  },

  writerCalTime(xxx, yyy, zzz) {
    let distance = (this.data.writerPosX - xxx) ** 2
                 + (this.data.writerPosY - yyy) ** 2
                 + (this.data.writerPosZ - zzz) ** 2
    return Math.sqrt(distance) / this.data.writerSpeed
  },

  writerLinearly(range, xxx, yyy, zzz, step, time) {
    let distance = (this.data.writerPosX - xxx) ** 2
                 + (this.data.writerPosY - yyy) ** 2
                 + (this.data.writerPosZ - zzz) ** 2
    let listLen = Math.sqrt(distance) / step
    let xStep = (this.data.writerPosX - xxx) / listLen
    let yStep = (this.data.writerPosY - yyy) / listLen
    let zStep = (this.data.writerPosZ - zzz) / listLen
    for (var i=listLen-1;i>=0;i--) {
      ble_utils.writeCaotaiGcode("2", range, time, xxx+xStep*i, yyy+yStep*i, zzz+zStep*i)
    }
  },

  writerTouchInt(e, step) {
    let xAxis = (e.changedTouches[0].x / this.data.pageWidth * 750 - 375)
    let yAxis = (e.changedTouches[0].y / this.data.pageWidth * 750 - 375)
    let xxx = xAxis * 0.2
    let yyy = yAxis * 0.2
    let zzz = this.data.hhhWriter
    let range = this.data.switchA ? 1 : (this.data.switchB ? 2: (this.data.switchA ? 4 : 8))
    let blelim = this.data.switchA * 1 + this.data.switchB * 1 + this.data.switchC * 1 + this.data.switchD * 1
    let time = 0
    let doDraw = false
    if (1===step) {
      this.writerLinearly(range, xxx, yyy, zzz-this.data.writeryeild, 5, this.data.shortTime*blelim)
      this.writerCommitPos(xxx, yyy, zzz-this.data.writeryeild)
      ble_utils.sendCaotaiGcode()
    }
    time = this.writerCalTime(xxx, yyy, zzz)
    if ((1===step) || (3===step) || ((2===step) && (time>(this.data.shortTime*blelim)))) {
      ble_utils.writeCaotaiGcode("2", range, time, xxx, yyy, zzz)
      this.writerCommitPos(xxx, yyy, zzz)
      doDraw = true
    }
    if (3===step) {
      time = this.writerCalTime(xxx, yyy, zzz-this.data.writeryeild)
      ble_utils.writeCaotaiGcode("2", range, time, xxx, yyy, zzz-this.data.writeryeild)
      this.writerCommitPos(xxx, yyy, zzz-this.data.writeryeild)
      ble_utils.sendCaotaiGcode()
    }
    return {x :xAxis, y : yAxis, en : doDraw}
  },

  writerTouchStart(e) {
    let ctx = this.data.ctxWriter
    let xy = this.writerTouchInt(e, 1)
    if (xy.en) {
      ctx.moveTo(xy.x, xy.y)
    }
  },

  writerTouchMove(e) {
    let ctx = this.data.ctxWriter
    let xy = this.writerTouchInt(e, 2)
    if (xy.en) {
      ctx.lineTo(xy.x, xy.y)
      ctx.stroke()
    }
  },

  writerTouchEnd(e) {
    let ctx = this.data.ctxWriter
    let xy = this.writerTouchInt(e, 3)
    if (xy.en) {
      ctx.lineTo(xy.x, xy.y)
      ctx.stroke()
    }
  },

  writerInit() {
    wx.createSelectorQuery()
    .select(`#canvasWriter`) // 在 WXML 中填入的 id
    .fields({ node: true, size: true })
    .exec((res) => {
        // Canvas 对象
        const canvas = res[0].node
        // 渲染上下文
        const ctx = canvas.getContext('2d')
        // Canvas 画布的实际绘制宽高
        const dpr = wx.getWindowInfo().pixelRatio
        const dpw = wx.getWindowInfo().screenWidth
        res[0].width = dpw
        res[0].height = dpw
        const width = res[0].width
        const height = res[0].height
        canvas.width = width * dpr
        canvas.height = height * dpr
        ctx.scale(dpr*dpw/375/2, dpr*dpw/375/2)
        this.setData({
          areaSize  : "width: " + dpw + "px; height: " + dpw + "px;",
          ctxWriter : ctx,
          pageWidth : dpw
        })
        ctx.translate(375, 375)
        ctx.clearRect(-375, -375, 750, 750)
        ctx.beginPath()
        ctx.fillStyle="#bbccbb"
        ctx.arc(0, 0, 365, 0, 2 * Math.PI)
        ctx.fill()
    })
  },

  writerReset() {
    this.writerInit()
    let xxx = 0
    let yyy = 0
    let zzz = this.data.hhhWriter - this.data.writeryeild
    let cC  = this.data.switchA ? "A" : (this.data.switchB ? "B": (this.data.switchA ? "C" : "D"))
    let yt  = this.data.yourself[cC]
    let nt  = this.data.neighbor[cC]
    let ot  = this.data.opposite[cC]
    let sbD = this.data.sbDirect[cC]
    let sb  = this.data.standBias[cC]
    let time = 600
    // ble_utils.writeCaotaiGcode("1", yt, time,  0,   0, 41)
    // ble_utils.writeCaotaiGcode("1", nt, time, sb, sbD, 37)
    // ble_utils.writeCaotaiGcode("1", ot, time,  0,   0, 32)
    ble_utils.writeCaotaiGcode("2", yt, time,  0,   0, zzz)
    ble_utils.writeCaotaiGcode("1", nt, time, sb, sbD, 39)
    ble_utils.writeCaotaiGcode("1", ot, time,  0,   0, 40)
    ble_utils.sendCaotaiGcode()
    this.writerCommitPos(xxx, yyy, zzz)
    ble_utils.sendCaotaiGcode()
  },

  angleCalDis(aaa, bbb) {
    let distance = Math.abs(this.data.angleAlpha - aaa)
                 + Math.abs(this.data.angleBelta - bbb)
    return distance
  },

  angleCommitPos(aaa, bbb, hhh) {
    this.setData({
      angleAlpha : aaa,
      angleBelta : bbb,
      hhhAngle   : hhh
    })
  },

  angleTouchInt(e, step) {
    let ctx = this.data.ctxAngle
    let xAxis = (e.changedTouches[0].x / this.data.pageWidth * 750 - 375)
    let yAxis = (e.changedTouches[0].y / this.data.pageWidth * 750 - 375)
    let aaa = Math.sqrt(xAxis**2 + yAxis**2) / 350 * 70
    let bbb = -Math.atan2(yAxis, xAxis) / Math.PI * 180
    let hhh = this.data.hhhAngle
    let range = this.data.switchA * 1 + this.data.switchB * 2 + this.data.switchC * 4 + this.data.switchD * 8
    let time = this.data.angleTime
    let distance = this.angleCalDis(aaa, bbb)
    let newTime = new Date().getTime()
    this.setData({angleStamp : newTime})
    if ((1===step) || (3===step)) {
      ble_utils.writeCaotaiGcode("1", range, time, aaa, bbb, hhh)
      ble_utils.sendCaotaiGcode()
      this.angleCommitPos(aaa, bbb, hhh)
    }
    if (2===step) {setTimeout(()=>{
      if (newTime===this.data.angleStamp) {
        ble_utils.writeCaotaiGcode("1", range, time, aaa, bbb, hhh)
        ble_utils.sendCaotaiGcode()
        this.angleCommitPos(aaa, bbb, hhh)
      }
    }, time)}
    if ((1===step) || (3===step) || ((2===step) && (distance>0))) {
      ctx.clearRect(-375, -375, 750, 750)
      ctx.beginPath()
      ctx.fillStyle="#ffcccc"
      ctx.arc(0, 0, 365, 0, 2 * Math.PI)
      ctx.fill()
      ctx.beginPath()
      ctx.fillStyle="#7777cc"
      ctx.arc(xAxis, yAxis, 80, 0, 2 * Math.PI)
      ctx.fill()
    }
  },

  angleTouchStart(e) {
    this.angleTouchInt(e, 1)
  },

  angleTouchMove(e) {
    this.angleTouchInt(e, 2)
  },

  angleTouchEnd(e) {
    this.angleTouchInt(e, 3)
  },

  angleInit() {
    wx.createSelectorQuery()
    .select(`#canvasAngle`) // 在 WXML 中填入的 id
    .fields({ node: true, size: true })
    .exec((res) => {
        // Canvas 对象
        const canvas = res[0].node
        // 渲染上下文
        const ctx = canvas.getContext('2d')
        // Canvas 画布的实际绘制宽高
        const dpr = wx.getWindowInfo().pixelRatio
        const dpw = wx.getWindowInfo().screenWidth
        res[0].width = dpw
        res[0].height = dpw
        const width = res[0].width
        const height = res[0].height
        canvas.width = width * dpr
        canvas.height = height * dpr
        ctx.scale(dpr*dpw/375/2, dpr*dpw/375/2)
        this.setData({
          areaSize  : "width: " + dpw + "px; height: " + dpw + "px;",
          ctxAngle  : ctx,
          pageWidth : dpw
        })
        ctx.translate(375, 375)
        ctx.clearRect(-375, -375, 750, 750)
        ctx.beginPath()
        ctx.fillStyle="#ffcccc"
        ctx.arc(0, 0, 365, 0, 2 * Math.PI)
        ctx.fill()
        ctx.beginPath()
        ctx.fillStyle="#7777cc"
        ctx.arc(0, 0, 80, 0, 2 * Math.PI)
        ctx.fill()
    })
  },

  angleReset() {
    this.angleInit()
    let aaa = 0
    let bbb = 0
    let hhh = 31
    let range = this.data.switchA * 1 + this.data.switchB * 2 + this.data.switchC * 4 + this.data.switchD * 8
    let time = this.data.angleTime
    ble_utils.writeCaotaiGcode("1", range, time, aaa, bbb, hhh)
    this.angleCommitPos(aaa, bbb, hhh)
    ble_utils.sendCaotaiGcode()
  },

  onLoad(options) {
    if (this.data.modeWriterSel) {
      this.writerInit()
    }
    else {
      this.angleInit()
    }
  },
})
