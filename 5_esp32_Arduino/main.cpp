#include <Arduino.h>
#include <BLEDevice.h>
#include <BLEServer.h>
#include <BLEUtils.h>
#include <BLE2902.h>
#include <iostream>
#include <SPI.h>
#include "I2Cdev.h"
#include "Wire.h"
#include "MPU6050_6Axis_MotionApps20.h"
// 宏定义
#define IMU_I2C_SDA 19 
#define IMU_I2C_SCL 18
#define PIN_CS0 15
#define FPGA_RSTN 17
#define FOOT_BACKPRESS 5
#define FOOT_BUSYSTATE 21
#define SERVICE_UUID "12a59900-17cc-11ec-9621-0242ac130002" // UART service UUID
#define CHARACTERISTIC_UUID_RX "12a59e0a-17cc-11ec-9621-0242ac130002"
#define CHARACTERISTIC_UUID_TX "12a5a148-17cc-11ec-9621-0242ac130002"
#define NOTIFY_LEN 10
#define QUEUE_LEN 32768


// BLE things
uint32_t ble_notify_cnt = 0;
uint32_t heartCount = 0;
uint8_t  broadcastValue[NOTIFY_LEN];
BLEServer *pServer = NULL;                   // BLEServer指针 pServer
BLECharacteristic *pTxCharacteristic = NULL; // BLECharacteristic指针 pTxCharacteristic
BLECharacteristic *pRxCharacteristic = NULL;
bool deviceConnected = false;                // 本次连接状态
bool oldDeviceConnected = false;             // 上次连接状态
uint8_t cmd_err_num = 0;
// mpu things
MPU6050 mpu;
bool dmpReady = false;  // set true if DMP init was successful
uint8_t mpuIntStatus;   // holds actual interrupt status byte from MPU
uint8_t devStatus;      // return status after each device operation (0 = success, !0 = error)
uint16_t packetSize;    // expected DMP packet size (default is 42 bytes)
uint16_t fifoCount;     // count of all bytes currently in FIFO
uint8_t fifoBuffer[64]; // FIFO storage buffer
Quaternion q;           // [w, x, y, z]         quaternion container
VectorInt16 aa;         // [x, y, z]            accel sensor measurements
VectorInt16 aaReal;     // [x, y, z]            gravity-free accel sensor measurements
VectorInt16 aaWorld;    // [x, y, z]            world-frame accel sensor measurements
VectorFloat gravity;    // [x, y, z]            gravity vector
float euler[3];         // [psi, theta, phi]    Euler angle container
float ypr[3];           // [yaw, pitch, roll]   yaw/pitch/roll container and gravity vector
uint8_t teapotPacket[14] = { '$', 0x02, 0,0, 0,0, 0,0, 0,0, 0x00, 0x00, '\r', '\n' };


class CircularQueue {
private:
  int front, rear;
  int capacity;
  uint8_t* queue;
public:
  CircularQueue(int k) {
    capacity = k + 1;
    queue = new uint8_t[capacity];
    front = rear = 0;
  }
  void enQueue(uint8_t value) {
    queue[rear] = value;
    rear = (rear + 1) % capacity;
  }
  uint8_t deQueue() {
    uint8_t ddd = queue[front];
    front = (front + 1) % capacity;
    return ddd;
  }
  bool isEmpty() {
    return rear == front;
  }
  bool isFull() {
    return (rear + 1) % capacity == front;
  }
  int getRear() {
    return rear;
  }
  int getFront() {
    return front;
  }
};

// 循环队列初始化
CircularQueue bleQueue(QUEUE_LEN);

class MyServerCallbacks : public BLEServerCallbacks
{
  void onConnect(BLEServer *pServer)
  {
    deviceConnected = true;
  };
  void onDisconnect(BLEServer *pServer)
  {
    deviceConnected = false;
  }
};

class MyCallbacks : public BLECharacteristicCallbacks
{
  void onWrite(BLECharacteristic *pCharacteristic)
  {
    Serial.printf("onWrite\n");
    std::string rxValue = pCharacteristic->getValue(); // 接收信息
    if (rxValue.length() > 0)
    {
      for (int i = 0; i < rxValue.length(); i++) {
        bleQueue.enQueue(rxValue[i]);
      }
    }
  }
};

void notifyWx() {
  int8_t temp = 0;
  if (!dmpReady) return;
  if (mpu.dmpGetCurrentFIFOPacket(fifoBuffer)) {
  mpu.dmpGetQuaternion(&q, fifoBuffer);
  mpu.dmpGetGravity(&gravity, &q);
  mpu.dmpGetYawPitchRoll(ypr, &q, &gravity);
    /*Serial.print("ypr\t");
    Serial.print(ypr[0] * 180/M_PI);
    Serial.print("\t");
    Serial.print(ypr[1] * 180/M_PI);
    Serial.print("\t");
    Serial.println(ypr[2] * 180/M_PI);*/
  }
  heartCount = heartCount + 1;
  for(int i=0;i<4;i++) {
    broadcastValue[NOTIFY_LEN-1-i] = static_cast<uint8_t>((heartCount>>(8*i)) & 255);
  }
  temp = (int8_t)(ypr[2] * 180/M_PI);
  if (temp<0) temp = temp + 256;
  for(int i=4;i<5;i++) {
    broadcastValue[NOTIFY_LEN-1-i] = static_cast<uint8_t>(temp & 255);
  }
  temp = (int8_t)(ypr[1] * 180/M_PI);
  if (temp<0) temp = temp + 256;
  for(int i=5;i<6;i++) {
    broadcastValue[NOTIFY_LEN-1-i] = static_cast<uint8_t>(temp & 255);
  }
  temp = (int8_t)(ypr[0] * 180/M_PI);
  if (temp<0) temp = temp + 256;
  for(int i=6;i<7;i++) {
    broadcastValue[NOTIFY_LEN-1-i] = static_cast<uint8_t>(temp & 255);
  }
  for(int i=7;i<8;i++) {
    broadcastValue[NOTIFY_LEN-1-i] = static_cast<uint8_t>(cmd_err_num);
  }
  Serial.printf("cmd_err_num is %d\n", cmd_err_num);
  for(int i=8;i<9;i++) {
    broadcastValue[NOTIFY_LEN-1-i] = static_cast<uint8_t>((digitalRead(FOOT_BACKPRESS)==1) ? 255 : 0);
  }
  for(int i=9;i<10;i++) {
    broadcastValue[NOTIFY_LEN-1-i] = static_cast<uint8_t>((digitalRead(FOOT_BUSYSTATE)==1) ? 255 : 0);
  }
  pTxCharacteristic->setValue(broadcastValue, NOTIFY_LEN);       // 设置要发送的值
  pTxCharacteristic->notify();              // 广播
}

void clearQueue() {
  if (bleQueue.isEmpty()) return;
  uint8_t ccc = 0;
  //Serial.printf("BLE RECV:");
  digitalWrite(PIN_CS0, LOW);
  while (!bleQueue.isEmpty()) {
    if (digitalRead(FOOT_BACKPRESS)==1) {
      Serial.println("FOOT_BACKPRESS==1");
      //Serial.printf("rear is %d, front is %d\n", bleQueue.getRear(), bleQueue.getFront());
      notifyWx();
      delay(1000);
      break;
    }
    ccc = bleQueue.deQueue();
    cmd_err_num = SPI.transfer(ccc);
    //Serial.printf("%c", ccc);
  }
  //Serial.println();
  digitalWrite(PIN_CS0, HIGH);
}

void serialISP() {
  uint8_t ccc = 0;
  if (Serial.available()>0) {
    Serial.printf("UART RECV:");
    digitalWrite(PIN_CS0, LOW);
    while (Serial.available()>0) {
      ccc = Serial.read();
      cmd_err_num = SPI.transfer(ccc);
      Serial.printf("%c", ccc);
    }
    Serial.println();
    digitalWrite(PIN_CS0, HIGH);
  }
}

void bleLoop() {
  // deviceConnected 已连接
  if (deviceConnected)
  {
    notifyWx();
  }
  // disconnecting  断开连接
  if (!deviceConnected && oldDeviceConnected)
  {
    delay(500);                  // 留时间给蓝牙缓冲
    pServer->startAdvertising(); // 重新广播
    Serial.println("BLE Restart Advertising");
    oldDeviceConnected = deviceConnected;
  }
  // connecting  正在连接
  if (deviceConnected && !oldDeviceConnected)
  {
    Serial.println("BLE Connect Successfully");
    // do stuff here on connecting
    oldDeviceConnected = deviceConnected;
  }
}

void bleSetup() {
  // 创建一个 BLE 设备
  BLEDevice::init("UART_BLE");
  // 创建一个 BLE 服务
  pServer = BLEDevice::createServer();
  pServer->setCallbacks(new MyServerCallbacks()); // 设置回调
  BLEService *pService = pServer->createService(SERVICE_UUID);
  // 创建一个 BLE 特征
  pTxCharacteristic = pService->createCharacteristic(CHARACTERISTIC_UUID_TX, BLECharacteristic::PROPERTY_NOTIFY);
  pTxCharacteristic->addDescriptor(new BLE2902());
  pRxCharacteristic = pService->createCharacteristic(CHARACTERISTIC_UUID_RX, BLECharacteristic::PROPERTY_WRITE);
  pRxCharacteristic->setCallbacks(new MyCallbacks()); // 设置回调
  // BLE开始
  pService->start();                  // 开始服务
  pServer->getAdvertising()->start(); // 开始广播
  Serial.println("BLE OK... ");
}

void mpuSetup() {
  Wire.begin(IMU_I2C_SDA, IMU_I2C_SCL);
  Wire.setClock(400000);
  mpu.initialize();
  Serial.println("Testing device connections...");
  Serial.println(mpu.testConnection() ? "MPU6050 connection successful" : "MPU6050 connection failed");
  mpu.setXGyroOffset(220);
  mpu.setYGyroOffset(76);
  mpu.setZGyroOffset(-85);
  mpu.setZAccelOffset(1788); // 1688 factory default for my test chip
  for (int k=0;k<4;k++) {
    Serial.printf("init dmp times: %d\n", k);
    mpu.setDMPEnabled(false);
    devStatus = mpu.dmpInitialize();
    mpu.CalibrateAccel(6);
    mpu.CalibrateGyro(6);
    mpu.setDMPEnabled(true);
  }
  Serial.println(devStatus ? "DMP initialize failed" : "DMP initialize success");
  dmpReady = devStatus ? false : true;
}

void setup() {
  // put your setup code here, to run once:
  pinMode(PIN_CS0, OUTPUT);
  pinMode(FPGA_RSTN, OUTPUT);
  pinMode(FOOT_BACKPRESS, INPUT);
  pinMode(FOOT_BUSYSTATE, INPUT);
  digitalWrite(FPGA_RSTN, LOW);
  // UART初始化
  Serial.begin(115200);
  Serial.printf("This is a caotai program\n");
  // SPI初始化
  SPI.begin(14,13,12,15); // sclk, miso, mosi, scs0
  SPI.setClockDivider(SPI_CLOCK_DIV8); // (1025-857)/7 = 24, 1707-857=850
  // BLE初始化
  bleSetup();
  digitalWrite(FPGA_RSTN, HIGH);
  delay(100);
  // MPU初始化
  mpuSetup();
}

void loop() {
  // receive uart char, then send to spi
  serialISP();
  // receive BLE char, then send to spi
  clearQueue();
  // read DMP, then notify to ble master
  if (ble_notify_cnt==499999) {
    bleLoop();
    ble_notify_cnt = 0;
  }
  else {
    ble_notify_cnt = ble_notify_cnt + 1;
  }
}
