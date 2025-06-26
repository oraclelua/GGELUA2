.class public Lorg/libsdl/app/HIDDeviceManager;
.super Ljava/lang/Object;
.source "HIDDeviceManager.java"


# static fields
.field private static final ACTION_USB_PERMISSION:Ljava/lang/String; = "org.libsdl.app.USB_PERMISSION"

.field private static final TAG:Ljava/lang/String; = "hidapi"

.field private static sManager:Lorg/libsdl/app/HIDDeviceManager;

.field private static sManagerRefCount:I


# instance fields
.field private final mBluetoothBroadcast:Landroid/content/BroadcastReceiver;

.field private mBluetoothDevices:Ljava/util/HashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashMap<",
            "Landroid/bluetooth/BluetoothDevice;",
            "Lorg/libsdl/app/HIDDeviceBLESteamController;",
            ">;"
        }
    .end annotation
.end field

.field private mBluetoothManager:Landroid/bluetooth/BluetoothManager;

.field private mContext:Landroid/content/Context;

.field private mDevicesById:Ljava/util/HashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashMap<",
            "Ljava/lang/Integer;",
            "Lorg/libsdl/app/HIDDevice;",
            ">;"
        }
    .end annotation
.end field

.field private mHandler:Landroid/os/Handler;

.field private mIsChromebook:Z

.field private mLastBluetoothDevices:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Landroid/bluetooth/BluetoothDevice;",
            ">;"
        }
    .end annotation
.end field

.field private mNextDeviceId:I

.field private mSharedPreferences:Landroid/content/SharedPreferences;

.field private final mUsbBroadcast:Landroid/content/BroadcastReceiver;

.field private mUsbManager:Landroid/hardware/usb/UsbManager;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 33
    const/4 v0, 0x0

    sput v0, Lorg/libsdl/app/HIDDeviceManager;->sManagerRefCount:I

    return-void
.end method

.method private constructor <init>(Landroid/content/Context;)V
    .locals 3
    .param p1, "context"    # Landroid/content/Context;

    .line 105
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 54
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lorg/libsdl/app/HIDDeviceManager;->mDevicesById:Ljava/util/HashMap;

    .line 55
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lorg/libsdl/app/HIDDeviceManager;->mBluetoothDevices:Ljava/util/HashMap;

    .line 56
    const/4 v0, 0x0

    iput v0, p0, Lorg/libsdl/app/HIDDeviceManager;->mNextDeviceId:I

    .line 57
    const/4 v1, 0x0

    iput-object v1, p0, Lorg/libsdl/app/HIDDeviceManager;->mSharedPreferences:Landroid/content/SharedPreferences;

    .line 58
    iput-boolean v0, p0, Lorg/libsdl/app/HIDDeviceManager;->mIsChromebook:Z

    .line 64
    new-instance v1, Lorg/libsdl/app/HIDDeviceManager$1;

    invoke-direct {v1, p0}, Lorg/libsdl/app/HIDDeviceManager$1;-><init>(Lorg/libsdl/app/HIDDeviceManager;)V

    iput-object v1, p0, Lorg/libsdl/app/HIDDeviceManager;->mUsbBroadcast:Landroid/content/BroadcastReceiver;

    .line 81
    new-instance v1, Lorg/libsdl/app/HIDDeviceManager$2;

    invoke-direct {v1, p0}, Lorg/libsdl/app/HIDDeviceManager$2;-><init>(Lorg/libsdl/app/HIDDeviceManager;)V

    iput-object v1, p0, Lorg/libsdl/app/HIDDeviceManager;->mBluetoothBroadcast:Landroid/content/BroadcastReceiver;

    .line 106
    iput-object p1, p0, Lorg/libsdl/app/HIDDeviceManager;->mContext:Landroid/content/Context;

    .line 108
    invoke-direct {p0}, Lorg/libsdl/app/HIDDeviceManager;->HIDDeviceRegisterCallback()V

    .line 110
    iget-object v1, p0, Lorg/libsdl/app/HIDDeviceManager;->mContext:Landroid/content/Context;

    const-string v2, "hidapi"

    invoke-virtual {v1, v2, v0}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v1

    iput-object v1, p0, Lorg/libsdl/app/HIDDeviceManager;->mSharedPreferences:Landroid/content/SharedPreferences;

    .line 111
    iget-object v1, p0, Lorg/libsdl/app/HIDDeviceManager;->mContext:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v1

    const-string v2, "org.chromium.arc.device_management"

    invoke-virtual {v1, v2}, Landroid/content/pm/PackageManager;->hasSystemFeature(Ljava/lang/String;)Z

    move-result v1

    iput-boolean v1, p0, Lorg/libsdl/app/HIDDeviceManager;->mIsChromebook:Z

    .line 120
    iget-object v1, p0, Lorg/libsdl/app/HIDDeviceManager;->mSharedPreferences:Landroid/content/SharedPreferences;

    const-string v2, "next_device_id"

    invoke-interface {v1, v2, v0}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result v0

    iput v0, p0, Lorg/libsdl/app/HIDDeviceManager;->mNextDeviceId:I

    .line 122
    return-void
.end method

.method private native HIDDeviceRegisterCallback()V
.end method

.method private native HIDDeviceReleaseCallback()V
.end method

.method static synthetic access$000(Lorg/libsdl/app/HIDDeviceManager;Landroid/hardware/usb/UsbDevice;)V
    .locals 0
    .param p0, "x0"    # Lorg/libsdl/app/HIDDeviceManager;
    .param p1, "x1"    # Landroid/hardware/usb/UsbDevice;

    .line 28
    invoke-direct {p0, p1}, Lorg/libsdl/app/HIDDeviceManager;->handleUsbDeviceAttached(Landroid/hardware/usb/UsbDevice;)V

    return-void
.end method

.method static synthetic access$100(Lorg/libsdl/app/HIDDeviceManager;Landroid/hardware/usb/UsbDevice;)V
    .locals 0
    .param p0, "x0"    # Lorg/libsdl/app/HIDDeviceManager;
    .param p1, "x1"    # Landroid/hardware/usb/UsbDevice;

    .line 28
    invoke-direct {p0, p1}, Lorg/libsdl/app/HIDDeviceManager;->handleUsbDeviceDetached(Landroid/hardware/usb/UsbDevice;)V

    return-void
.end method

.method static synthetic access$200(Lorg/libsdl/app/HIDDeviceManager;Landroid/hardware/usb/UsbDevice;Z)V
    .locals 0
    .param p0, "x0"    # Lorg/libsdl/app/HIDDeviceManager;
    .param p1, "x1"    # Landroid/hardware/usb/UsbDevice;
    .param p2, "x2"    # Z

    .line 28
    invoke-direct {p0, p1, p2}, Lorg/libsdl/app/HIDDeviceManager;->handleUsbDevicePermission(Landroid/hardware/usb/UsbDevice;Z)V

    return-void
.end method

.method public static acquire(Landroid/content/Context;)Lorg/libsdl/app/HIDDeviceManager;
    .locals 1
    .param p0, "context"    # Landroid/content/Context;

    .line 36
    sget v0, Lorg/libsdl/app/HIDDeviceManager;->sManagerRefCount:I

    if-nez v0, :cond_0

    .line 37
    new-instance v0, Lorg/libsdl/app/HIDDeviceManager;

    invoke-direct {v0, p0}, Lorg/libsdl/app/HIDDeviceManager;-><init>(Landroid/content/Context;)V

    sput-object v0, Lorg/libsdl/app/HIDDeviceManager;->sManager:Lorg/libsdl/app/HIDDeviceManager;

    .line 39
    :cond_0
    sget v0, Lorg/libsdl/app/HIDDeviceManager;->sManagerRefCount:I

    add-int/lit8 v0, v0, 0x1

    sput v0, Lorg/libsdl/app/HIDDeviceManager;->sManagerRefCount:I

    .line 40
    sget-object v0, Lorg/libsdl/app/HIDDeviceManager;->sManager:Lorg/libsdl/app/HIDDeviceManager;

    return-object v0
.end method

.method private close()V
    .locals 2

    .line 510
    invoke-direct {p0}, Lorg/libsdl/app/HIDDeviceManager;->shutdownUSB()V

    .line 511
    invoke-direct {p0}, Lorg/libsdl/app/HIDDeviceManager;->shutdownBluetooth()V

    .line 512
    monitor-enter p0

    .line 513
    :try_start_0
    iget-object v0, p0, Lorg/libsdl/app/HIDDeviceManager;->mDevicesById:Ljava/util/HashMap;

    invoke-virtual {v0}, Ljava/util/HashMap;->values()Ljava/util/Collection;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lorg/libsdl/app/HIDDevice;

    .line 514
    .local v1, "device":Lorg/libsdl/app/HIDDevice;
    invoke-interface {v1}, Lorg/libsdl/app/HIDDevice;->shutdown()V

    .line 515
    .end local v1    # "device":Lorg/libsdl/app/HIDDevice;
    goto :goto_0

    .line 516
    :cond_0
    iget-object v0, p0, Lorg/libsdl/app/HIDDeviceManager;->mDevicesById:Ljava/util/HashMap;

    invoke-virtual {v0}, Ljava/util/HashMap;->clear()V

    .line 517
    iget-object v0, p0, Lorg/libsdl/app/HIDDeviceManager;->mBluetoothDevices:Ljava/util/HashMap;

    invoke-virtual {v0}, Ljava/util/HashMap;->clear()V

    .line 518
    invoke-direct {p0}, Lorg/libsdl/app/HIDDeviceManager;->HIDDeviceReleaseCallback()V

    .line 519
    monitor-exit p0

    .line 520
    return-void

    .line 519
    :catchall_0
    move-exception v0

    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method private connectHIDDeviceUSB(Landroid/hardware/usb/UsbDevice;)V
    .locals 21
    .param p1, "usbDevice"    # Landroid/hardware/usb/UsbDevice;

    .line 331
    move-object/from16 v14, p0

    move-object/from16 v15, p1

    monitor-enter p0

    .line 332
    const/4 v0, 0x0

    .line 333
    .local v0, "interface_mask":I
    const/4 v1, 0x0

    move v13, v1

    .local v13, "interface_index":I
    :goto_0
    :try_start_0
    invoke-virtual/range {p1 .. p1}, Landroid/hardware/usb/UsbDevice;->getInterfaceCount()I

    move-result v1

    if-ge v13, v1, :cond_2

    .line 334
    invoke-virtual {v15, v13}, Landroid/hardware/usb/UsbDevice;->getInterface(I)Landroid/hardware/usb/UsbInterface;

    move-result-object v1

    move-object v12, v1

    .line 335
    .local v12, "usbInterface":Landroid/hardware/usb/UsbInterface;
    invoke-direct {v14, v15, v12}, Lorg/libsdl/app/HIDDeviceManager;->isHIDDeviceInterface(Landroid/hardware/usb/UsbDevice;Landroid/hardware/usb/UsbInterface;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 338
    invoke-virtual {v12}, Landroid/hardware/usb/UsbInterface;->getId()I

    move-result v1

    move/from16 v16, v1

    .line 339
    .local v16, "interface_id":I
    const/4 v1, 0x1

    shl-int v2, v1, v16

    and-int/2addr v2, v0

    if-eqz v2, :cond_0

    .line 340
    move/from16 v18, v13

    goto :goto_1

    .line 342
    :cond_0
    shl-int v1, v1, v16

    or-int/2addr v0, v1

    .line 344
    new-instance v1, Lorg/libsdl/app/HIDDeviceUSB;

    invoke-direct {v1, v14, v15, v13}, Lorg/libsdl/app/HIDDeviceUSB;-><init>(Lorg/libsdl/app/HIDDeviceManager;Landroid/hardware/usb/UsbDevice;I)V

    move-object v11, v1

    .line 345
    .local v11, "device":Lorg/libsdl/app/HIDDeviceUSB;
    invoke-virtual {v11}, Lorg/libsdl/app/HIDDeviceUSB;->getId()I

    move-result v2

    .line 346
    .local v2, "id":I
    iget-object v1, v14, Lorg/libsdl/app/HIDDeviceManager;->mDevicesById:Ljava/util/HashMap;

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-virtual {v1, v3, v11}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 347
    invoke-virtual {v11}, Lorg/libsdl/app/HIDDeviceUSB;->getIdentifier()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v11}, Lorg/libsdl/app/HIDDeviceUSB;->getVendorId()I

    move-result v4

    invoke-virtual {v11}, Lorg/libsdl/app/HIDDeviceUSB;->getProductId()I

    move-result v5

    invoke-virtual {v11}, Lorg/libsdl/app/HIDDeviceUSB;->getSerialNumber()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v11}, Lorg/libsdl/app/HIDDeviceUSB;->getVersion()I

    move-result v7

    invoke-virtual {v11}, Lorg/libsdl/app/HIDDeviceUSB;->getManufacturerName()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v11}, Lorg/libsdl/app/HIDDeviceUSB;->getProductName()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v12}, Landroid/hardware/usb/UsbInterface;->getId()I

    move-result v10

    invoke-virtual {v12}, Landroid/hardware/usb/UsbInterface;->getInterfaceClass()I

    move-result v17

    invoke-virtual {v12}, Landroid/hardware/usb/UsbInterface;->getInterfaceSubclass()I

    move-result v18

    invoke-virtual {v12}, Landroid/hardware/usb/UsbInterface;->getInterfaceProtocol()I

    move-result v19

    move-object/from16 v1, p0

    move-object/from16 v20, v11

    .end local v11    # "device":Lorg/libsdl/app/HIDDeviceUSB;
    .local v20, "device":Lorg/libsdl/app/HIDDeviceUSB;
    move/from16 v11, v17

    move-object/from16 v17, v12

    .end local v12    # "usbInterface":Landroid/hardware/usb/UsbInterface;
    .local v17, "usbInterface":Landroid/hardware/usb/UsbInterface;
    move/from16 v12, v18

    move/from16 v18, v13

    .end local v13    # "interface_index":I
    .local v18, "interface_index":I
    move/from16 v13, v19

    invoke-virtual/range {v1 .. v13}, Lorg/libsdl/app/HIDDeviceManager;->HIDDeviceConnected(ILjava/lang/String;IILjava/lang/String;ILjava/lang/String;Ljava/lang/String;IIII)V

    goto :goto_1

    .line 335
    .end local v2    # "id":I
    .end local v16    # "interface_id":I
    .end local v17    # "usbInterface":Landroid/hardware/usb/UsbInterface;
    .end local v18    # "interface_index":I
    .end local v20    # "device":Lorg/libsdl/app/HIDDeviceUSB;
    .restart local v12    # "usbInterface":Landroid/hardware/usb/UsbInterface;
    .restart local v13    # "interface_index":I
    :cond_1
    move-object/from16 v17, v12

    move/from16 v18, v13

    .line 333
    .end local v12    # "usbInterface":Landroid/hardware/usb/UsbInterface;
    .end local v13    # "interface_index":I
    .restart local v18    # "interface_index":I
    :goto_1
    add-int/lit8 v13, v18, 0x1

    .end local v18    # "interface_index":I
    .restart local v13    # "interface_index":I
    goto :goto_0

    :cond_2
    move/from16 v18, v13

    .line 350
    .end local v0    # "interface_mask":I
    .end local v13    # "interface_index":I
    monitor-exit p0

    .line 351
    return-void

    .line 350
    :catchall_0
    move-exception v0

    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method private getDevice(I)Lorg/libsdl/app/HIDDevice;
    .locals 4
    .param p1, "id"    # I

    .line 535
    monitor-enter p0

    .line 536
    :try_start_0
    iget-object v0, p0, Lorg/libsdl/app/HIDDeviceManager;->mDevicesById:Ljava/util/HashMap;

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lorg/libsdl/app/HIDDevice;

    .line 537
    .local v0, "result":Lorg/libsdl/app/HIDDevice;
    if-nez v0, :cond_0

    .line 538
    const-string v1, "hidapi"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "No device for id: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 539
    const-string v1, "hidapi"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Available devices: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lorg/libsdl/app/HIDDeviceManager;->mDevicesById:Ljava/util/HashMap;

    invoke-virtual {v3}, Ljava/util/HashMap;->keySet()Ljava/util/Set;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 541
    :cond_0
    monitor-exit p0

    return-object v0

    .line 542
    .end local v0    # "result":Lorg/libsdl/app/HIDDevice;
    :catchall_0
    move-exception v0

    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method private handleUsbDeviceAttached(Landroid/hardware/usb/UsbDevice;)V
    .locals 0
    .param p1, "usbDevice"    # Landroid/hardware/usb/UsbDevice;

    .line 300
    invoke-direct {p0, p1}, Lorg/libsdl/app/HIDDeviceManager;->connectHIDDeviceUSB(Landroid/hardware/usb/UsbDevice;)V

    .line 301
    return-void
.end method

.method private handleUsbDeviceDetached(Landroid/hardware/usb/UsbDevice;)V
    .locals 6
    .param p1, "usbDevice"    # Landroid/hardware/usb/UsbDevice;

    .line 304
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 305
    .local v0, "devices":Ljava/util/List;, "Ljava/util/List<Ljava/lang/Integer;>;"
    iget-object v1, p0, Lorg/libsdl/app/HIDDeviceManager;->mDevicesById:Ljava/util/HashMap;

    invoke-virtual {v1}, Ljava/util/HashMap;->values()Ljava/util/Collection;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_1

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lorg/libsdl/app/HIDDevice;

    .line 306
    .local v2, "device":Lorg/libsdl/app/HIDDevice;
    invoke-interface {v2}, Lorg/libsdl/app/HIDDevice;->getDevice()Landroid/hardware/usb/UsbDevice;

    move-result-object v3

    invoke-virtual {p1, v3}, Landroid/hardware/usb/UsbDevice;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_0

    .line 307
    invoke-interface {v2}, Lorg/libsdl/app/HIDDevice;->getId()I

    move-result v3

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v0, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 309
    .end local v2    # "device":Lorg/libsdl/app/HIDDevice;
    :cond_0
    goto :goto_0

    .line 310
    :cond_1
    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_1
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_2

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/Integer;

    invoke-virtual {v2}, Ljava/lang/Integer;->intValue()I

    move-result v2

    .line 311
    .local v2, "id":I
    iget-object v3, p0, Lorg/libsdl/app/HIDDeviceManager;->mDevicesById:Ljava/util/HashMap;

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lorg/libsdl/app/HIDDevice;

    .line 312
    .local v3, "device":Lorg/libsdl/app/HIDDevice;
    iget-object v4, p0, Lorg/libsdl/app/HIDDeviceManager;->mDevicesById:Ljava/util/HashMap;

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/util/HashMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    .line 313
    invoke-interface {v3}, Lorg/libsdl/app/HIDDevice;->shutdown()V

    .line 314
    invoke-virtual {p0, v2}, Lorg/libsdl/app/HIDDeviceManager;->HIDDeviceDisconnected(I)V

    .line 315
    .end local v2    # "id":I
    .end local v3    # "device":Lorg/libsdl/app/HIDDevice;
    goto :goto_1

    .line 316
    :cond_2
    return-void
.end method

.method private handleUsbDevicePermission(Landroid/hardware/usb/UsbDevice;Z)V
    .locals 4
    .param p1, "usbDevice"    # Landroid/hardware/usb/UsbDevice;
    .param p2, "permission_granted"    # Z

    .line 319
    iget-object v0, p0, Lorg/libsdl/app/HIDDeviceManager;->mDevicesById:Ljava/util/HashMap;

    invoke-virtual {v0}, Ljava/util/HashMap;->values()Ljava/util/Collection;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_2

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lorg/libsdl/app/HIDDevice;

    .line 320
    .local v1, "device":Lorg/libsdl/app/HIDDevice;
    invoke-interface {v1}, Lorg/libsdl/app/HIDDevice;->getDevice()Landroid/hardware/usb/UsbDevice;

    move-result-object v2

    invoke-virtual {p1, v2}, Landroid/hardware/usb/UsbDevice;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 321
    const/4 v2, 0x0

    .line 322
    .local v2, "opened":Z
    if-eqz p2, :cond_0

    .line 323
    invoke-interface {v1}, Lorg/libsdl/app/HIDDevice;->open()Z

    move-result v2

    .line 325
    :cond_0
    invoke-interface {v1}, Lorg/libsdl/app/HIDDevice;->getId()I

    move-result v3

    invoke-virtual {p0, v3, v2}, Lorg/libsdl/app/HIDDeviceManager;->HIDDeviceOpenResult(IZ)V

    .line 327
    .end local v1    # "device":Lorg/libsdl/app/HIDDevice;
    .end local v2    # "opened":Z
    :cond_1
    goto :goto_0

    .line 328
    :cond_2
    return-void
.end method

.method private initializeBluetooth()V
    .locals 6

    .line 354
    const-string v0, "hidapi"

    const-string v1, "Initializing Bluetooth"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 356
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x1e

    if-gt v1, v2, :cond_0

    iget-object v1, p0, Lorg/libsdl/app/HIDDeviceManager;->mContext:Landroid/content/Context;

    .line 357
    invoke-virtual {v1}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v1

    iget-object v2, p0, Lorg/libsdl/app/HIDDeviceManager;->mContext:Landroid/content/Context;

    invoke-virtual {v2}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v2

    const-string v3, "android.permission.BLUETOOTH"

    invoke-virtual {v1, v3, v2}, Landroid/content/pm/PackageManager;->checkPermission(Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    if-eqz v1, :cond_0

    .line 358
    const-string v1, "Couldn\'t initialize Bluetooth, missing android.permission.BLUETOOTH"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 359
    return-void

    .line 362
    :cond_0
    iget-object v1, p0, Lorg/libsdl/app/HIDDeviceManager;->mContext:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v1

    const-string v2, "android.hardware.bluetooth_le"

    invoke-virtual {v1, v2}, Landroid/content/pm/PackageManager;->hasSystemFeature(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_7

    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x12

    if-ge v1, v2, :cond_1

    goto/16 :goto_1

    .line 368
    :cond_1
    iget-object v1, p0, Lorg/libsdl/app/HIDDeviceManager;->mContext:Landroid/content/Context;

    const-string v2, "bluetooth"

    invoke-virtual {v1, v2}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/bluetooth/BluetoothManager;

    iput-object v1, p0, Lorg/libsdl/app/HIDDeviceManager;->mBluetoothManager:Landroid/bluetooth/BluetoothManager;

    .line 369
    if-nez v1, :cond_2

    .line 371
    return-void

    .line 374
    :cond_2
    invoke-virtual {v1}, Landroid/bluetooth/BluetoothManager;->getAdapter()Landroid/bluetooth/BluetoothAdapter;

    move-result-object v1

    .line 375
    .local v1, "btAdapter":Landroid/bluetooth/BluetoothAdapter;
    if-nez v1, :cond_3

    .line 377
    return-void

    .line 381
    :cond_3
    invoke-virtual {v1}, Landroid/bluetooth/BluetoothAdapter;->getBondedDevices()Ljava/util/Set;

    move-result-object v2

    invoke-interface {v2}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_5

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Landroid/bluetooth/BluetoothDevice;

    .line 383
    .local v3, "device":Landroid/bluetooth/BluetoothDevice;
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Bluetooth device available: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v0, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 384
    invoke-virtual {p0, v3}, Lorg/libsdl/app/HIDDeviceManager;->isSteamController(Landroid/bluetooth/BluetoothDevice;)Z

    move-result v4

    if-eqz v4, :cond_4

    .line 385
    invoke-virtual {p0, v3}, Lorg/libsdl/app/HIDDeviceManager;->connectBluetoothDevice(Landroid/bluetooth/BluetoothDevice;)Z

    .line 388
    .end local v3    # "device":Landroid/bluetooth/BluetoothDevice;
    :cond_4
    goto :goto_0

    .line 391
    :cond_5
    new-instance v0, Landroid/content/IntentFilter;

    invoke-direct {v0}, Landroid/content/IntentFilter;-><init>()V

    .line 392
    .local v0, "filter":Landroid/content/IntentFilter;
    const-string v2, "android.bluetooth.device.action.ACL_CONNECTED"

    invoke-virtual {v0, v2}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    .line 393
    const-string v2, "android.bluetooth.device.action.ACL_DISCONNECTED"

    invoke-virtual {v0, v2}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    .line 394
    iget-object v2, p0, Lorg/libsdl/app/HIDDeviceManager;->mContext:Landroid/content/Context;

    iget-object v3, p0, Lorg/libsdl/app/HIDDeviceManager;->mBluetoothBroadcast:Landroid/content/BroadcastReceiver;

    invoke-virtual {v2, v3, v0}, Landroid/content/Context;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;

    .line 396
    iget-boolean v2, p0, Lorg/libsdl/app/HIDDeviceManager;->mIsChromebook:Z

    if-eqz v2, :cond_6

    .line 397
    new-instance v2, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v3

    invoke-direct {v2, v3}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    iput-object v2, p0, Lorg/libsdl/app/HIDDeviceManager;->mHandler:Landroid/os/Handler;

    .line 398
    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    iput-object v2, p0, Lorg/libsdl/app/HIDDeviceManager;->mLastBluetoothDevices:Ljava/util/List;

    .line 408
    :cond_6
    return-void

    .line 363
    .end local v0    # "filter":Landroid/content/IntentFilter;
    .end local v1    # "btAdapter":Landroid/bluetooth/BluetoothAdapter;
    :cond_7
    :goto_1
    const-string v1, "Couldn\'t initialize Bluetooth, this version of Android does not support Bluetooth LE"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 364
    return-void
.end method

.method private initializeUSB()V
    .locals 3

    .line 143
    iget-object v0, p0, Lorg/libsdl/app/HIDDeviceManager;->mContext:Landroid/content/Context;

    const-string v1, "usb"

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/hardware/usb/UsbManager;

    iput-object v0, p0, Lorg/libsdl/app/HIDDeviceManager;->mUsbManager:Landroid/hardware/usb/UsbManager;

    .line 144
    if-nez v0, :cond_0

    .line 145
    return-void

    .line 192
    :cond_0
    new-instance v0, Landroid/content/IntentFilter;

    invoke-direct {v0}, Landroid/content/IntentFilter;-><init>()V

    .line 193
    .local v0, "filter":Landroid/content/IntentFilter;
    const-string v1, "android.hardware.usb.action.USB_DEVICE_ATTACHED"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    .line 194
    const-string v1, "android.hardware.usb.action.USB_DEVICE_DETACHED"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    .line 195
    const-string v1, "org.libsdl.app.USB_PERMISSION"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    .line 196
    iget-object v1, p0, Lorg/libsdl/app/HIDDeviceManager;->mContext:Landroid/content/Context;

    iget-object v2, p0, Lorg/libsdl/app/HIDDeviceManager;->mUsbBroadcast:Landroid/content/BroadcastReceiver;

    invoke-virtual {v1, v2, v0}, Landroid/content/Context;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;

    .line 198
    iget-object v1, p0, Lorg/libsdl/app/HIDDeviceManager;->mUsbManager:Landroid/hardware/usb/UsbManager;

    invoke-virtual {v1}, Landroid/hardware/usb/UsbManager;->getDeviceList()Ljava/util/HashMap;

    move-result-object v1

    invoke-virtual {v1}, Ljava/util/HashMap;->values()Ljava/util/Collection;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_1

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/hardware/usb/UsbDevice;

    .line 199
    .local v2, "usbDevice":Landroid/hardware/usb/UsbDevice;
    invoke-direct {p0, v2}, Lorg/libsdl/app/HIDDeviceManager;->handleUsbDeviceAttached(Landroid/hardware/usb/UsbDevice;)V

    .line 200
    .end local v2    # "usbDevice":Landroid/hardware/usb/UsbDevice;
    goto :goto_0

    .line 201
    :cond_1
    return-void
.end method

.method private isHIDDeviceInterface(Landroid/hardware/usb/UsbDevice;Landroid/hardware/usb/UsbInterface;)Z
    .locals 3
    .param p1, "usbDevice"    # Landroid/hardware/usb/UsbDevice;
    .param p2, "usbInterface"    # Landroid/hardware/usb/UsbInterface;

    .line 216
    invoke-virtual {p2}, Landroid/hardware/usb/UsbInterface;->getInterfaceClass()I

    move-result v0

    const/4 v1, 0x1

    const/4 v2, 0x3

    if-ne v0, v2, :cond_0

    .line 217
    return v1

    .line 219
    :cond_0
    invoke-direct {p0, p1, p2}, Lorg/libsdl/app/HIDDeviceManager;->isXbox360Controller(Landroid/hardware/usb/UsbDevice;Landroid/hardware/usb/UsbInterface;)Z

    move-result v0

    if-nez v0, :cond_2

    invoke-direct {p0, p1, p2}, Lorg/libsdl/app/HIDDeviceManager;->isXboxOneController(Landroid/hardware/usb/UsbDevice;Landroid/hardware/usb/UsbInterface;)Z

    move-result v0

    if-eqz v0, :cond_1

    goto :goto_0

    .line 222
    :cond_1
    const/4 v0, 0x0

    return v0

    .line 220
    :cond_2
    :goto_0
    return v1
.end method

.method private isXbox360Controller(Landroid/hardware/usb/UsbDevice;Landroid/hardware/usb/UsbInterface;)Z
    .locals 10
    .param p1, "usbDevice"    # Landroid/hardware/usb/UsbDevice;
    .param p2, "usbInterface"    # Landroid/hardware/usb/UsbInterface;

    .line 226
    const/16 v0, 0x5d

    .line 227
    .local v0, "XB360_IFACE_SUBCLASS":I
    const/4 v1, 0x1

    .line 228
    .local v1, "XB360_IFACE_PROTOCOL":I
    const/16 v2, 0x81

    .line 229
    .local v2, "XB360W_IFACE_PROTOCOL":I
    const/16 v3, 0x18

    new-array v3, v3, [I

    fill-array-data v3, :array_0

    .line 256
    .local v3, "SUPPORTED_VENDORS":[I
    invoke-virtual {p2}, Landroid/hardware/usb/UsbInterface;->getInterfaceClass()I

    move-result v4

    const/4 v5, 0x0

    const/16 v6, 0xff

    if-ne v4, v6, :cond_2

    .line 257
    invoke-virtual {p2}, Landroid/hardware/usb/UsbInterface;->getInterfaceSubclass()I

    move-result v4

    const/16 v6, 0x5d

    if-ne v4, v6, :cond_2

    .line 258
    invoke-virtual {p2}, Landroid/hardware/usb/UsbInterface;->getInterfaceProtocol()I

    move-result v4

    const/4 v6, 0x1

    if-eq v4, v6, :cond_0

    .line 259
    invoke-virtual {p2}, Landroid/hardware/usb/UsbInterface;->getInterfaceProtocol()I

    move-result v4

    const/16 v7, 0x81

    if-ne v4, v7, :cond_2

    .line 260
    :cond_0
    invoke-virtual {p1}, Landroid/hardware/usb/UsbDevice;->getVendorId()I

    move-result v4

    .line 261
    .local v4, "vendor_id":I
    array-length v7, v3

    move v8, v5

    :goto_0
    if-ge v8, v7, :cond_2

    aget v9, v3, v8

    .line 262
    .local v9, "supportedVid":I
    if-ne v4, v9, :cond_1

    .line 263
    return v6

    .line 261
    .end local v9    # "supportedVid":I
    :cond_1
    add-int/lit8 v8, v8, 0x1

    goto :goto_0

    .line 267
    .end local v4    # "vendor_id":I
    :cond_2
    return v5

    nop

    :array_0
    .array-data 4
        0x79
        0x44f
        0x45e
        0x46d
        0x56e
        0x6a3
        0x738
        0x7ff
        0xe6f
        0xf0d
        0x1038
        0x11c9
        0x12ab
        0x1430
        0x146b
        0x1532
        0x15e4
        0x162e
        0x1689
        0x1949
        0x1bad
        0x20d6
        0x24c6
        0x2c22
    .end array-data
.end method

.method private isXboxOneController(Landroid/hardware/usb/UsbDevice;Landroid/hardware/usb/UsbInterface;)Z
    .locals 8
    .param p1, "usbDevice"    # Landroid/hardware/usb/UsbDevice;
    .param p2, "usbInterface"    # Landroid/hardware/usb/UsbInterface;

    .line 271
    const/16 v0, 0x47

    .line 272
    .local v0, "XB1_IFACE_SUBCLASS":I
    const/16 v1, 0xd0

    .line 273
    .local v1, "XB1_IFACE_PROTOCOL":I
    const/16 v2, 0x9

    new-array v2, v2, [I

    fill-array-data v2, :array_0

    .line 285
    .local v2, "SUPPORTED_VENDORS":[I
    invoke-virtual {p2}, Landroid/hardware/usb/UsbInterface;->getId()I

    move-result v3

    const/4 v4, 0x0

    if-nez v3, :cond_1

    .line 286
    invoke-virtual {p2}, Landroid/hardware/usb/UsbInterface;->getInterfaceClass()I

    move-result v3

    const/16 v5, 0xff

    if-ne v3, v5, :cond_1

    .line 287
    invoke-virtual {p2}, Landroid/hardware/usb/UsbInterface;->getInterfaceSubclass()I

    move-result v3

    const/16 v5, 0x47

    if-ne v3, v5, :cond_1

    .line 288
    invoke-virtual {p2}, Landroid/hardware/usb/UsbInterface;->getInterfaceProtocol()I

    move-result v3

    const/16 v5, 0xd0

    if-ne v3, v5, :cond_1

    .line 289
    invoke-virtual {p1}, Landroid/hardware/usb/UsbDevice;->getVendorId()I

    move-result v3

    .line 290
    .local v3, "vendor_id":I
    array-length v5, v2

    move v6, v4

    :goto_0
    if-ge v6, v5, :cond_1

    aget v7, v2, v6

    .line 291
    .local v7, "supportedVid":I
    if-ne v3, v7, :cond_0

    .line 292
    const/4 v4, 0x1

    return v4

    .line 290
    .end local v7    # "supportedVid":I
    :cond_0
    add-int/lit8 v6, v6, 0x1

    goto :goto_0

    .line 296
    .end local v3    # "vendor_id":I
    :cond_1
    return v4

    :array_0
    .array-data 4
        0x45e
        0x738
        0xe6f
        0xf0d
        0x1532
        0x20d6
        0x24c6
        0x2dc8
        0x2e24
    .end array-data
.end method

.method public static release(Lorg/libsdl/app/HIDDeviceManager;)V
    .locals 2
    .param p0, "manager"    # Lorg/libsdl/app/HIDDeviceManager;

    .line 44
    sget-object v0, Lorg/libsdl/app/HIDDeviceManager;->sManager:Lorg/libsdl/app/HIDDeviceManager;

    if-ne p0, v0, :cond_0

    .line 45
    sget v1, Lorg/libsdl/app/HIDDeviceManager;->sManagerRefCount:I

    add-int/lit8 v1, v1, -0x1

    sput v1, Lorg/libsdl/app/HIDDeviceManager;->sManagerRefCount:I

    .line 46
    if-nez v1, :cond_0

    .line 47
    invoke-direct {v0}, Lorg/libsdl/app/HIDDeviceManager;->close()V

    .line 48
    const/4 v0, 0x0

    sput-object v0, Lorg/libsdl/app/HIDDeviceManager;->sManager:Lorg/libsdl/app/HIDDeviceManager;

    .line 51
    :cond_0
    return-void
.end method

.method private shutdownBluetooth()V
    .locals 2

    .line 412
    :try_start_0
    iget-object v0, p0, Lorg/libsdl/app/HIDDeviceManager;->mContext:Landroid/content/Context;

    iget-object v1, p0, Lorg/libsdl/app/HIDDeviceManager;->mBluetoothBroadcast:Landroid/content/BroadcastReceiver;

    invoke-virtual {v0, v1}, Landroid/content/Context;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 415
    goto :goto_0

    .line 413
    :catch_0
    move-exception v0

    .line 416
    :goto_0
    return-void
.end method

.method private shutdownUSB()V
    .locals 2

    .line 209
    :try_start_0
    iget-object v0, p0, Lorg/libsdl/app/HIDDeviceManager;->mContext:Landroid/content/Context;

    iget-object v1, p0, Lorg/libsdl/app/HIDDeviceManager;->mUsbBroadcast:Landroid/content/BroadcastReceiver;

    invoke-virtual {v0, v1}, Landroid/content/Context;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 212
    goto :goto_0

    .line 210
    :catch_0
    move-exception v0

    .line 213
    :goto_0
    return-void
.end method


# virtual methods
.method native HIDDeviceConnected(ILjava/lang/String;IILjava/lang/String;ILjava/lang/String;Ljava/lang/String;IIII)V
.end method

.method native HIDDeviceDisconnected(I)V
.end method

.method native HIDDeviceFeatureReport(I[B)V
.end method

.method native HIDDeviceInputReport(I[B)V
.end method

.method native HIDDeviceOpenPending(I)V
.end method

.method native HIDDeviceOpenResult(IZ)V
.end method

.method public chromebookConnectionHandler()V
    .locals 8

    .line 422
    iget-boolean v0, p0, Lorg/libsdl/app/HIDDeviceManager;->mIsChromebook:Z

    if-nez v0, :cond_0

    .line 423
    return-void

    .line 426
    :cond_0
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 427
    .local v0, "disconnected":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/bluetooth/BluetoothDevice;>;"
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    .line 429
    .local v1, "connected":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/bluetooth/BluetoothDevice;>;"
    iget-object v2, p0, Lorg/libsdl/app/HIDDeviceManager;->mBluetoothManager:Landroid/bluetooth/BluetoothManager;

    const/4 v3, 0x7

    invoke-virtual {v2, v3}, Landroid/bluetooth/BluetoothManager;->getConnectedDevices(I)Ljava/util/List;

    move-result-object v2

    .line 431
    .local v2, "currentConnected":Ljava/util/List;, "Ljava/util/List<Landroid/bluetooth/BluetoothDevice;>;"
    invoke-interface {v2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_0
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_2

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Landroid/bluetooth/BluetoothDevice;

    .line 432
    .local v4, "bluetoothDevice":Landroid/bluetooth/BluetoothDevice;
    iget-object v5, p0, Lorg/libsdl/app/HIDDeviceManager;->mLastBluetoothDevices:Ljava/util/List;

    invoke-interface {v5, v4}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v5

    if-nez v5, :cond_1

    .line 433
    invoke-virtual {v1, v4}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 435
    .end local v4    # "bluetoothDevice":Landroid/bluetooth/BluetoothDevice;
    :cond_1
    goto :goto_0

    .line 436
    :cond_2
    iget-object v3, p0, Lorg/libsdl/app/HIDDeviceManager;->mLastBluetoothDevices:Ljava/util/List;

    invoke-interface {v3}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_1
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_4

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Landroid/bluetooth/BluetoothDevice;

    .line 437
    .restart local v4    # "bluetoothDevice":Landroid/bluetooth/BluetoothDevice;
    invoke-interface {v2, v4}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v5

    if-nez v5, :cond_3

    .line 438
    invoke-virtual {v0, v4}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 440
    .end local v4    # "bluetoothDevice":Landroid/bluetooth/BluetoothDevice;
    :cond_3
    goto :goto_1

    .line 442
    :cond_4
    iput-object v2, p0, Lorg/libsdl/app/HIDDeviceManager;->mLastBluetoothDevices:Ljava/util/List;

    .line 444
    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_2
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_5

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Landroid/bluetooth/BluetoothDevice;

    .line 445
    .restart local v4    # "bluetoothDevice":Landroid/bluetooth/BluetoothDevice;
    invoke-virtual {p0, v4}, Lorg/libsdl/app/HIDDeviceManager;->disconnectBluetoothDevice(Landroid/bluetooth/BluetoothDevice;)V

    .line 446
    .end local v4    # "bluetoothDevice":Landroid/bluetooth/BluetoothDevice;
    goto :goto_2

    .line 447
    :cond_5
    invoke-virtual {v1}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_3
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_6

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Landroid/bluetooth/BluetoothDevice;

    .line 448
    .restart local v4    # "bluetoothDevice":Landroid/bluetooth/BluetoothDevice;
    invoke-virtual {p0, v4}, Lorg/libsdl/app/HIDDeviceManager;->connectBluetoothDevice(Landroid/bluetooth/BluetoothDevice;)Z

    .line 449
    .end local v4    # "bluetoothDevice":Landroid/bluetooth/BluetoothDevice;
    goto :goto_3

    .line 451
    :cond_6
    move-object v3, p0

    .line 452
    .local v3, "finalThis":Lorg/libsdl/app/HIDDeviceManager;
    iget-object v4, p0, Lorg/libsdl/app/HIDDeviceManager;->mHandler:Landroid/os/Handler;

    new-instance v5, Lorg/libsdl/app/HIDDeviceManager$3;

    invoke-direct {v5, p0, v3}, Lorg/libsdl/app/HIDDeviceManager$3;-><init>(Lorg/libsdl/app/HIDDeviceManager;Lorg/libsdl/app/HIDDeviceManager;)V

    const-wide/16 v6, 0x2710

    invoke-virtual {v4, v5, v6, v7}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    .line 458
    return-void
.end method

.method public closeDevice(I)V
    .locals 4
    .param p1, "deviceID"    # I

    .line 650
    const-string v0, "hidapi"

    :try_start_0
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "closeDevice deviceID="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 652
    invoke-direct {p0, p1}, Lorg/libsdl/app/HIDDeviceManager;->getDevice(I)Lorg/libsdl/app/HIDDevice;

    move-result-object v1

    .line 653
    .local v1, "device":Lorg/libsdl/app/HIDDevice;
    if-nez v1, :cond_0

    .line 654
    invoke-virtual {p0, p1}, Lorg/libsdl/app/HIDDeviceManager;->HIDDeviceDisconnected(I)V

    .line 655
    return-void

    .line 658
    :cond_0
    invoke-interface {v1}, Lorg/libsdl/app/HIDDevice;->close()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 661
    .end local v1    # "device":Lorg/libsdl/app/HIDDevice;
    goto :goto_0

    .line 659
    :catch_0
    move-exception v1

    .line 660
    .local v1, "e":Ljava/lang/Exception;
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Got exception: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-static {v1}, Landroid/util/Log;->getStackTraceString(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 662
    .end local v1    # "e":Ljava/lang/Exception;
    :goto_0
    return-void
.end method

.method public connectBluetoothDevice(Landroid/bluetooth/BluetoothDevice;)Z
    .locals 4
    .param p1, "bluetoothDevice"    # Landroid/bluetooth/BluetoothDevice;

    .line 461
    const-string v0, "hidapi"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "connectBluetoothDevice device="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 462
    monitor-enter p0

    .line 463
    :try_start_0
    iget-object v0, p0, Lorg/libsdl/app/HIDDeviceManager;->mBluetoothDevices:Ljava/util/HashMap;

    invoke-virtual {v0, p1}, Ljava/util/HashMap;->containsKey(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 464
    const-string v0, "hidapi"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Steam controller with address "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " already exists, attempting reconnect"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 466
    iget-object v0, p0, Lorg/libsdl/app/HIDDeviceManager;->mBluetoothDevices:Ljava/util/HashMap;

    invoke-virtual {v0, p1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lorg/libsdl/app/HIDDeviceBLESteamController;

    .line 467
    .local v0, "device":Lorg/libsdl/app/HIDDeviceBLESteamController;
    invoke-virtual {v0}, Lorg/libsdl/app/HIDDeviceBLESteamController;->reconnect()V

    .line 469
    const/4 v1, 0x0

    monitor-exit p0

    return v1

    .line 471
    .end local v0    # "device":Lorg/libsdl/app/HIDDeviceBLESteamController;
    :cond_0
    new-instance v0, Lorg/libsdl/app/HIDDeviceBLESteamController;

    invoke-direct {v0, p0, p1}, Lorg/libsdl/app/HIDDeviceBLESteamController;-><init>(Lorg/libsdl/app/HIDDeviceManager;Landroid/bluetooth/BluetoothDevice;)V

    .line 472
    .restart local v0    # "device":Lorg/libsdl/app/HIDDeviceBLESteamController;
    invoke-virtual {v0}, Lorg/libsdl/app/HIDDeviceBLESteamController;->getId()I

    move-result v1

    .line 473
    .local v1, "id":I
    iget-object v2, p0, Lorg/libsdl/app/HIDDeviceManager;->mBluetoothDevices:Ljava/util/HashMap;

    invoke-virtual {v2, p1, v0}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 474
    iget-object v2, p0, Lorg/libsdl/app/HIDDeviceManager;->mDevicesById:Ljava/util/HashMap;

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-virtual {v2, v3, v0}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 477
    nop

    .end local v0    # "device":Lorg/libsdl/app/HIDDeviceBLESteamController;
    .end local v1    # "id":I
    monitor-exit p0

    .line 478
    const/4 v0, 0x1

    return v0

    .line 477
    :catchall_0
    move-exception v0

    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method public disconnectBluetoothDevice(Landroid/bluetooth/BluetoothDevice;)V
    .locals 4
    .param p1, "bluetoothDevice"    # Landroid/bluetooth/BluetoothDevice;

    .line 482
    monitor-enter p0

    .line 483
    :try_start_0
    iget-object v0, p0, Lorg/libsdl/app/HIDDeviceManager;->mBluetoothDevices:Ljava/util/HashMap;

    invoke-virtual {v0, p1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lorg/libsdl/app/HIDDeviceBLESteamController;

    .line 484
    .local v0, "device":Lorg/libsdl/app/HIDDeviceBLESteamController;
    if-nez v0, :cond_0

    .line 485
    monitor-exit p0

    return-void

    .line 487
    :cond_0
    invoke-virtual {v0}, Lorg/libsdl/app/HIDDeviceBLESteamController;->getId()I

    move-result v1

    .line 488
    .local v1, "id":I
    iget-object v2, p0, Lorg/libsdl/app/HIDDeviceManager;->mBluetoothDevices:Ljava/util/HashMap;

    invoke-virtual {v2, p1}, Ljava/util/HashMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    .line 489
    iget-object v2, p0, Lorg/libsdl/app/HIDDeviceManager;->mDevicesById:Ljava/util/HashMap;

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/util/HashMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    .line 490
    invoke-virtual {v0}, Lorg/libsdl/app/HIDDeviceBLESteamController;->shutdown()V

    .line 491
    invoke-virtual {p0, v1}, Lorg/libsdl/app/HIDDeviceManager;->HIDDeviceDisconnected(I)V

    .line 492
    .end local v0    # "device":Lorg/libsdl/app/HIDDeviceBLESteamController;
    .end local v1    # "id":I
    monitor-exit p0

    .line 493
    return-void

    .line 492
    :catchall_0
    move-exception v0

    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method public getContext()Landroid/content/Context;
    .locals 1

    .line 125
    iget-object v0, p0, Lorg/libsdl/app/HIDDeviceManager;->mContext:Landroid/content/Context;

    return-object v0
.end method

.method public getDeviceIDForIdentifier(Ljava/lang/String;)I
    .locals 4
    .param p1, "identifier"    # Ljava/lang/String;

    .line 129
    iget-object v0, p0, Lorg/libsdl/app/HIDDeviceManager;->mSharedPreferences:Landroid/content/SharedPreferences;

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    .line 131
    .local v0, "spedit":Landroid/content/SharedPreferences$Editor;
    iget-object v1, p0, Lorg/libsdl/app/HIDDeviceManager;->mSharedPreferences:Landroid/content/SharedPreferences;

    const/4 v2, 0x0

    invoke-interface {v1, p1, v2}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result v1

    .line 132
    .local v1, "result":I
    if-nez v1, :cond_0

    .line 133
    iget v2, p0, Lorg/libsdl/app/HIDDeviceManager;->mNextDeviceId:I

    add-int/lit8 v3, v2, 0x1

    iput v3, p0, Lorg/libsdl/app/HIDDeviceManager;->mNextDeviceId:I

    move v1, v2

    .line 134
    const-string v2, "next_device_id"

    invoke-interface {v0, v2, v3}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;

    .line 137
    :cond_0
    invoke-interface {v0, p1, v1}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;

    .line 138
    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->commit()Z

    .line 139
    return v1
.end method

.method public getFeatureReport(I[B)Z
    .locals 4
    .param p1, "deviceID"    # I
    .param p2, "report"    # [B

    .line 635
    const/4 v0, 0x0

    :try_start_0
    invoke-direct {p0, p1}, Lorg/libsdl/app/HIDDeviceManager;->getDevice(I)Lorg/libsdl/app/HIDDevice;

    move-result-object v1

    .line 636
    .local v1, "device":Lorg/libsdl/app/HIDDevice;
    if-nez v1, :cond_0

    .line 637
    invoke-virtual {p0, p1}, Lorg/libsdl/app/HIDDeviceManager;->HIDDeviceDisconnected(I)V

    .line 638
    return v0

    .line 641
    :cond_0
    invoke-interface {v1, p2}, Lorg/libsdl/app/HIDDevice;->getFeatureReport([B)Z

    move-result v0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return v0

    .line 642
    .end local v1    # "device":Lorg/libsdl/app/HIDDevice;
    :catch_0
    move-exception v1

    .line 643
    .local v1, "e":Ljava/lang/Exception;
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Got exception: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-static {v1}, Landroid/util/Log;->getStackTraceString(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    const-string v3, "hidapi"

    invoke-static {v3, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 645
    .end local v1    # "e":Ljava/lang/Exception;
    return v0
.end method

.method getUSBManager()Landroid/hardware/usb/UsbManager;
    .locals 1

    .line 204
    iget-object v0, p0, Lorg/libsdl/app/HIDDeviceManager;->mUsbManager:Landroid/hardware/usb/UsbManager;

    return-object v0
.end method

.method public initialize(ZZ)Z
    .locals 2
    .param p1, "usb"    # Z
    .param p2, "bluetooth"    # Z

    .line 550
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "initialize("

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ")"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "hidapi"

    invoke-static {v1, v0}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 552
    if-eqz p1, :cond_0

    .line 553
    invoke-direct {p0}, Lorg/libsdl/app/HIDDeviceManager;->initializeUSB()V

    .line 555
    :cond_0
    if-eqz p2, :cond_1

    .line 556
    invoke-direct {p0}, Lorg/libsdl/app/HIDDeviceManager;->initializeBluetooth()V

    .line 558
    :cond_1
    const/4 v0, 0x1

    return v0
.end method

.method public isSteamController(Landroid/bluetooth/BluetoothDevice;)Z
    .locals 3
    .param p1, "bluetoothDevice"    # Landroid/bluetooth/BluetoothDevice;

    .line 497
    const/4 v0, 0x0

    if-nez p1, :cond_0

    .line 498
    return v0

    .line 502
    :cond_0
    invoke-virtual {p1}, Landroid/bluetooth/BluetoothDevice;->getName()Ljava/lang/String;

    move-result-object v1

    if-nez v1, :cond_1

    .line 503
    return v0

    .line 506
    :cond_1
    invoke-virtual {p1}, Landroid/bluetooth/BluetoothDevice;->getName()Ljava/lang/String;

    move-result-object v1

    const-string v2, "SteamController"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_2

    invoke-virtual {p1}, Landroid/bluetooth/BluetoothDevice;->getType()I

    move-result v1

    and-int/lit8 v1, v1, 0x2

    if-eqz v1, :cond_2

    const/4 v0, 0x1

    :cond_2
    return v0
.end method

.method public openDevice(I)Z
    .locals 10
    .param p1, "deviceID"    # I

    .line 562
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "openDevice deviceID="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "hidapi"

    invoke-static {v1, v0}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 563
    invoke-direct {p0, p1}, Lorg/libsdl/app/HIDDeviceManager;->getDevice(I)Lorg/libsdl/app/HIDDevice;

    move-result-object v0

    .line 564
    .local v0, "device":Lorg/libsdl/app/HIDDevice;
    const/4 v2, 0x0

    if-nez v0, :cond_0

    .line 565
    invoke-virtual {p0, p1}, Lorg/libsdl/app/HIDDeviceManager;->HIDDeviceDisconnected(I)V

    .line 566
    return v2

    .line 570
    :cond_0
    invoke-interface {v0}, Lorg/libsdl/app/HIDDevice;->getDevice()Landroid/hardware/usb/UsbDevice;

    move-result-object v3

    .line 571
    .local v3, "usbDevice":Landroid/hardware/usb/UsbDevice;
    if-eqz v3, :cond_2

    iget-object v4, p0, Lorg/libsdl/app/HIDDeviceManager;->mUsbManager:Landroid/hardware/usb/UsbManager;

    invoke-virtual {v4, v3}, Landroid/hardware/usb/UsbManager;->hasPermission(Landroid/hardware/usb/UsbDevice;)Z

    move-result v4

    if-nez v4, :cond_2

    .line 572
    invoke-virtual {p0, p1}, Lorg/libsdl/app/HIDDeviceManager;->HIDDeviceOpenPending(I)V

    .line 574
    const/high16 v4, 0x2000000

    .line 576
    .local v4, "FLAG_MUTABLE":I
    :try_start_0
    sget v5, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v6, 0x1f

    if-lt v5, v6, :cond_1

    .line 577
    const/high16 v5, 0x2000000

    .local v5, "flags":I
    goto :goto_0

    .line 579
    .end local v5    # "flags":I
    :cond_1
    const/4 v5, 0x0

    .line 581
    .restart local v5    # "flags":I
    :goto_0
    iget-object v6, p0, Lorg/libsdl/app/HIDDeviceManager;->mUsbManager:Landroid/hardware/usb/UsbManager;

    iget-object v7, p0, Lorg/libsdl/app/HIDDeviceManager;->mContext:Landroid/content/Context;

    new-instance v8, Landroid/content/Intent;

    const-string v9, "org.libsdl.app.USB_PERMISSION"

    invoke-direct {v8, v9}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    invoke-static {v7, v2, v8, v5}, Landroid/app/PendingIntent;->getBroadcast(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object v7

    invoke-virtual {v6, v3, v7}, Landroid/hardware/usb/UsbManager;->requestPermission(Landroid/hardware/usb/UsbDevice;Landroid/app/PendingIntent;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 585
    .end local v4    # "FLAG_MUTABLE":I
    .end local v5    # "flags":I
    goto :goto_1

    .line 582
    :catch_0
    move-exception v4

    .line 583
    .local v4, "e":Ljava/lang/Exception;
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "Couldn\'t request permission for USB device "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v1, v5}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 584
    invoke-virtual {p0, p1, v2}, Lorg/libsdl/app/HIDDeviceManager;->HIDDeviceOpenResult(IZ)V

    .line 586
    .end local v4    # "e":Ljava/lang/Exception;
    :goto_1
    return v2

    .line 590
    :cond_2
    :try_start_1
    invoke-interface {v0}, Lorg/libsdl/app/HIDDevice;->open()Z

    move-result v1
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    return v1

    .line 591
    :catch_1
    move-exception v4

    .line 592
    .restart local v4    # "e":Ljava/lang/Exception;
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "Got exception: "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-static {v4}, Landroid/util/Log;->getStackTraceString(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v1, v5}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 594
    .end local v4    # "e":Ljava/lang/Exception;
    return v2
.end method

.method public sendFeatureReport(I[B)I
    .locals 4
    .param p1, "deviceID"    # I
    .param p2, "report"    # [B

    .line 618
    const/4 v0, -0x1

    :try_start_0
    invoke-direct {p0, p1}, Lorg/libsdl/app/HIDDeviceManager;->getDevice(I)Lorg/libsdl/app/HIDDevice;

    move-result-object v1

    .line 619
    .local v1, "device":Lorg/libsdl/app/HIDDevice;
    if-nez v1, :cond_0

    .line 620
    invoke-virtual {p0, p1}, Lorg/libsdl/app/HIDDeviceManager;->HIDDeviceDisconnected(I)V

    .line 621
    return v0

    .line 624
    :cond_0
    invoke-interface {v1, p2}, Lorg/libsdl/app/HIDDevice;->sendFeatureReport([B)I

    move-result v0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return v0

    .line 625
    .end local v1    # "device":Lorg/libsdl/app/HIDDevice;
    :catch_0
    move-exception v1

    .line 626
    .local v1, "e":Ljava/lang/Exception;
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Got exception: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-static {v1}, Landroid/util/Log;->getStackTraceString(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    const-string v3, "hidapi"

    invoke-static {v3, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 628
    .end local v1    # "e":Ljava/lang/Exception;
    return v0
.end method

.method public sendOutputReport(I[B)I
    .locals 4
    .param p1, "deviceID"    # I
    .param p2, "report"    # [B

    .line 601
    const/4 v0, -0x1

    :try_start_0
    invoke-direct {p0, p1}, Lorg/libsdl/app/HIDDeviceManager;->getDevice(I)Lorg/libsdl/app/HIDDevice;

    move-result-object v1

    .line 602
    .local v1, "device":Lorg/libsdl/app/HIDDevice;
    if-nez v1, :cond_0

    .line 603
    invoke-virtual {p0, p1}, Lorg/libsdl/app/HIDDeviceManager;->HIDDeviceDisconnected(I)V

    .line 604
    return v0

    .line 607
    :cond_0
    invoke-interface {v1, p2}, Lorg/libsdl/app/HIDDevice;->sendOutputReport([B)I

    move-result v0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return v0

    .line 608
    .end local v1    # "device":Lorg/libsdl/app/HIDDevice;
    :catch_0
    move-exception v1

    .line 609
    .local v1, "e":Ljava/lang/Exception;
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Got exception: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-static {v1}, Landroid/util/Log;->getStackTraceString(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    const-string v3, "hidapi"

    invoke-static {v3, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 611
    .end local v1    # "e":Ljava/lang/Exception;
    return v0
.end method

.method public setFrozen(Z)V
    .locals 2
    .param p1, "frozen"    # Z

    .line 523
    monitor-enter p0

    .line 524
    :try_start_0
    iget-object v0, p0, Lorg/libsdl/app/HIDDeviceManager;->mDevicesById:Ljava/util/HashMap;

    invoke-virtual {v0}, Ljava/util/HashMap;->values()Ljava/util/Collection;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lorg/libsdl/app/HIDDevice;

    .line 525
    .local v1, "device":Lorg/libsdl/app/HIDDevice;
    invoke-interface {v1, p1}, Lorg/libsdl/app/HIDDevice;->setFrozen(Z)V

    .line 526
    .end local v1    # "device":Lorg/libsdl/app/HIDDevice;
    goto :goto_0

    .line 527
    :cond_0
    monitor-exit p0

    .line 528
    return-void

    .line 527
    :catchall_0
    move-exception v0

    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method
