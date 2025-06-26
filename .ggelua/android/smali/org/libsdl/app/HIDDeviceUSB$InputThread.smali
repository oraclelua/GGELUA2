.class public Lorg/libsdl/app/HIDDeviceUSB$InputThread;
.super Ljava/lang/Thread;
.source "HIDDeviceUSB.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lorg/libsdl/app/HIDDeviceUSB;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x4
    name = "InputThread"
.end annotation


# instance fields
.field final synthetic this$0:Lorg/libsdl/app/HIDDeviceUSB;


# direct methods
.method protected constructor <init>(Lorg/libsdl/app/HIDDeviceUSB;)V
    .locals 0
    .param p1, "this$0"    # Lorg/libsdl/app/HIDDeviceUSB;

    .line 275
    iput-object p1, p0, Lorg/libsdl/app/HIDDeviceUSB$InputThread;->this$0:Lorg/libsdl/app/HIDDeviceUSB;

    invoke-direct {p0}, Ljava/lang/Thread;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 6

    .line 278
    iget-object v0, p0, Lorg/libsdl/app/HIDDeviceUSB$InputThread;->this$0:Lorg/libsdl/app/HIDDeviceUSB;

    iget-object v0, v0, Lorg/libsdl/app/HIDDeviceUSB;->mInputEndpoint:Landroid/hardware/usb/UsbEndpoint;

    invoke-virtual {v0}, Landroid/hardware/usb/UsbEndpoint;->getMaxPacketSize()I

    move-result v0

    .line 279
    .local v0, "packetSize":I
    new-array v1, v0, [B

    .line 280
    .local v1, "packet":[B
    :goto_0
    iget-object v2, p0, Lorg/libsdl/app/HIDDeviceUSB$InputThread;->this$0:Lorg/libsdl/app/HIDDeviceUSB;

    iget-boolean v2, v2, Lorg/libsdl/app/HIDDeviceUSB;->mRunning:Z

    if-eqz v2, :cond_2

    .line 284
    :try_start_0
    iget-object v2, p0, Lorg/libsdl/app/HIDDeviceUSB$InputThread;->this$0:Lorg/libsdl/app/HIDDeviceUSB;

    iget-object v2, v2, Lorg/libsdl/app/HIDDeviceUSB;->mConnection:Landroid/hardware/usb/UsbDeviceConnection;

    iget-object v3, p0, Lorg/libsdl/app/HIDDeviceUSB$InputThread;->this$0:Lorg/libsdl/app/HIDDeviceUSB;

    iget-object v3, v3, Lorg/libsdl/app/HIDDeviceUSB;->mInputEndpoint:Landroid/hardware/usb/UsbEndpoint;

    const/16 v4, 0x3e8

    invoke-virtual {v2, v3, v1, v0, v4}, Landroid/hardware/usb/UsbDeviceConnection;->bulkTransfer(Landroid/hardware/usb/UsbEndpoint;[BII)I

    move-result v2
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 290
    .local v2, "r":I
    nop

    .line 291
    nop

    .line 294
    if-lez v2, :cond_1

    .line 296
    if-ne v2, v0, :cond_0

    .line 297
    move-object v3, v1

    .local v3, "data":[B
    goto :goto_1

    .line 299
    .end local v3    # "data":[B
    :cond_0
    const/4 v3, 0x0

    invoke-static {v1, v3, v2}, Ljava/util/Arrays;->copyOfRange([BII)[B

    move-result-object v3

    .line 302
    .restart local v3    # "data":[B
    :goto_1
    iget-object v4, p0, Lorg/libsdl/app/HIDDeviceUSB$InputThread;->this$0:Lorg/libsdl/app/HIDDeviceUSB;

    iget-boolean v4, v4, Lorg/libsdl/app/HIDDeviceUSB;->mFrozen:Z

    if-nez v4, :cond_1

    .line 303
    iget-object v4, p0, Lorg/libsdl/app/HIDDeviceUSB$InputThread;->this$0:Lorg/libsdl/app/HIDDeviceUSB;

    iget-object v4, v4, Lorg/libsdl/app/HIDDeviceUSB;->mManager:Lorg/libsdl/app/HIDDeviceManager;

    iget-object v5, p0, Lorg/libsdl/app/HIDDeviceUSB$InputThread;->this$0:Lorg/libsdl/app/HIDDeviceUSB;

    iget v5, v5, Lorg/libsdl/app/HIDDeviceUSB;->mDeviceId:I

    invoke-virtual {v4, v5, v3}, Lorg/libsdl/app/HIDDeviceManager;->HIDDeviceInputReport(I[B)V

    .line 306
    .end local v2    # "r":I
    .end local v3    # "data":[B
    :cond_1
    goto :goto_0

    .line 286
    :catch_0
    move-exception v2

    .line 288
    .local v2, "e":Ljava/lang/Exception;
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Exception in UsbDeviceConnection bulktransfer: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    const-string v4, "hidapi"

    invoke-static {v4, v3}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 307
    .end local v2    # "e":Ljava/lang/Exception;
    :cond_2
    return-void
.end method
