.class Lorg/libsdl/app/SDLHapticHandler;
.super Ljava/lang/Object;
.source "SDLControllerManager.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lorg/libsdl/app/SDLHapticHandler$SDLHaptic;
    }
.end annotation


# instance fields
.field private final mHaptics:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Lorg/libsdl/app/SDLHapticHandler$SDLHaptic;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 449
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 450
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lorg/libsdl/app/SDLHapticHandler;->mHaptics:Ljava/util/ArrayList;

    .line 451
    return-void
.end method


# virtual methods
.method protected getHaptic(I)Lorg/libsdl/app/SDLHapticHandler$SDLHaptic;
    .locals 3
    .param p1, "device_id"    # I

    .line 545
    iget-object v0, p0, Lorg/libsdl/app/SDLHapticHandler;->mHaptics:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lorg/libsdl/app/SDLHapticHandler$SDLHaptic;

    .line 546
    .local v1, "haptic":Lorg/libsdl/app/SDLHapticHandler$SDLHaptic;
    iget v2, v1, Lorg/libsdl/app/SDLHapticHandler$SDLHaptic;->device_id:I

    if-ne v2, p1, :cond_0

    .line 547
    return-object v1

    .line 549
    .end local v1    # "haptic":Lorg/libsdl/app/SDLHapticHandler$SDLHaptic;
    :cond_0
    goto :goto_0

    .line 550
    :cond_1
    const/4 v0, 0x0

    return-object v0
.end method

.method public pollHapticDevices()V
    .locals 11

    .line 469
    const v0, 0xf423f

    .line 470
    .local v0, "deviceId_VIBRATOR_SERVICE":I
    const/4 v1, 0x0

    .line 472
    .local v1, "hasVibratorService":Z
    invoke-static {}, Landroid/view/InputDevice;->getDeviceIds()[I

    move-result-object v2

    .line 478
    .local v2, "deviceIds":[I
    array-length v3, v2

    add-int/lit8 v3, v3, -0x1

    .local v3, "i":I
    :goto_0
    const/4 v4, -0x1

    if-le v3, v4, :cond_1

    .line 479
    aget v4, v2, v3

    invoke-virtual {p0, v4}, Lorg/libsdl/app/SDLHapticHandler;->getHaptic(I)Lorg/libsdl/app/SDLHapticHandler$SDLHaptic;

    move-result-object v4

    .line 480
    .local v4, "haptic":Lorg/libsdl/app/SDLHapticHandler$SDLHaptic;
    if-nez v4, :cond_0

    .line 481
    aget v5, v2, v3

    invoke-static {v5}, Landroid/view/InputDevice;->getDevice(I)Landroid/view/InputDevice;

    move-result-object v5

    .line 482
    .local v5, "device":Landroid/view/InputDevice;
    invoke-virtual {v5}, Landroid/view/InputDevice;->getVibrator()Landroid/os/Vibrator;

    move-result-object v6

    .line 483
    .local v6, "vib":Landroid/os/Vibrator;
    invoke-virtual {v6}, Landroid/os/Vibrator;->hasVibrator()Z

    move-result v7

    if-eqz v7, :cond_0

    .line 484
    new-instance v7, Lorg/libsdl/app/SDLHapticHandler$SDLHaptic;

    invoke-direct {v7}, Lorg/libsdl/app/SDLHapticHandler$SDLHaptic;-><init>()V

    move-object v4, v7

    .line 485
    aget v7, v2, v3

    iput v7, v4, Lorg/libsdl/app/SDLHapticHandler$SDLHaptic;->device_id:I

    .line 486
    invoke-virtual {v5}, Landroid/view/InputDevice;->getName()Ljava/lang/String;

    move-result-object v7

    iput-object v7, v4, Lorg/libsdl/app/SDLHapticHandler$SDLHaptic;->name:Ljava/lang/String;

    .line 487
    iput-object v6, v4, Lorg/libsdl/app/SDLHapticHandler$SDLHaptic;->vib:Landroid/os/Vibrator;

    .line 488
    iget-object v7, p0, Lorg/libsdl/app/SDLHapticHandler;->mHaptics:Ljava/util/ArrayList;

    invoke-virtual {v7, v4}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 489
    iget v7, v4, Lorg/libsdl/app/SDLHapticHandler$SDLHaptic;->device_id:I

    iget-object v8, v4, Lorg/libsdl/app/SDLHapticHandler$SDLHaptic;->name:Ljava/lang/String;

    invoke-static {v7, v8}, Lorg/libsdl/app/SDLControllerManager;->nativeAddHaptic(ILjava/lang/String;)I

    .line 478
    .end local v4    # "haptic":Lorg/libsdl/app/SDLHapticHandler$SDLHaptic;
    .end local v5    # "device":Landroid/view/InputDevice;
    .end local v6    # "vib":Landroid/os/Vibrator;
    :cond_0
    add-int/lit8 v3, v3, -0x1

    goto :goto_0

    .line 495
    .end local v3    # "i":I
    :cond_1
    invoke-static {}, Lorg/libsdl/app/SDL;->getContext()Landroid/content/Context;

    move-result-object v3

    const-string v4, "vibrator"

    invoke-virtual {v3, v4}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Landroid/os/Vibrator;

    .line 496
    .local v3, "vib":Landroid/os/Vibrator;
    const v4, 0xf423f

    if-eqz v3, :cond_2

    .line 497
    invoke-virtual {v3}, Landroid/os/Vibrator;->hasVibrator()Z

    move-result v1

    .line 499
    if-eqz v1, :cond_2

    .line 500
    invoke-virtual {p0, v4}, Lorg/libsdl/app/SDLHapticHandler;->getHaptic(I)Lorg/libsdl/app/SDLHapticHandler$SDLHaptic;

    move-result-object v5

    .line 501
    .local v5, "haptic":Lorg/libsdl/app/SDLHapticHandler$SDLHaptic;
    if-nez v5, :cond_2

    .line 502
    new-instance v6, Lorg/libsdl/app/SDLHapticHandler$SDLHaptic;

    invoke-direct {v6}, Lorg/libsdl/app/SDLHapticHandler$SDLHaptic;-><init>()V

    move-object v5, v6

    .line 503
    iput v4, v5, Lorg/libsdl/app/SDLHapticHandler$SDLHaptic;->device_id:I

    .line 504
    const-string v6, "VIBRATOR_SERVICE"

    iput-object v6, v5, Lorg/libsdl/app/SDLHapticHandler$SDLHaptic;->name:Ljava/lang/String;

    .line 505
    iput-object v3, v5, Lorg/libsdl/app/SDLHapticHandler$SDLHaptic;->vib:Landroid/os/Vibrator;

    .line 506
    iget-object v6, p0, Lorg/libsdl/app/SDLHapticHandler;->mHaptics:Ljava/util/ArrayList;

    invoke-virtual {v6, v5}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 507
    iget v6, v5, Lorg/libsdl/app/SDLHapticHandler$SDLHaptic;->device_id:I

    iget-object v7, v5, Lorg/libsdl/app/SDLHapticHandler$SDLHaptic;->name:Ljava/lang/String;

    invoke-static {v6, v7}, Lorg/libsdl/app/SDLControllerManager;->nativeAddHaptic(ILjava/lang/String;)I

    .line 513
    .end local v5    # "haptic":Lorg/libsdl/app/SDLHapticHandler$SDLHaptic;
    :cond_2
    const/4 v5, 0x0

    .line 514
    .local v5, "removedDevices":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/Integer;>;"
    iget-object v6, p0, Lorg/libsdl/app/SDLHapticHandler;->mHaptics:Ljava/util/ArrayList;

    invoke-virtual {v6}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v6

    :goto_1
    invoke-interface {v6}, Ljava/util/Iterator;->hasNext()Z

    move-result v7

    if-eqz v7, :cond_8

    invoke-interface {v6}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lorg/libsdl/app/SDLHapticHandler$SDLHaptic;

    .line 515
    .local v7, "haptic":Lorg/libsdl/app/SDLHapticHandler$SDLHaptic;
    iget v8, v7, Lorg/libsdl/app/SDLHapticHandler$SDLHaptic;->device_id:I

    .line 517
    .local v8, "device_id":I
    const/4 v9, 0x0

    .local v9, "i":I
    :goto_2
    array-length v10, v2

    if-ge v9, v10, :cond_4

    .line 518
    aget v10, v2, v9

    if-ne v8, v10, :cond_3

    goto :goto_3

    .line 517
    :cond_3
    add-int/lit8 v9, v9, 0x1

    goto :goto_2

    .line 521
    :cond_4
    :goto_3
    if-ne v8, v4, :cond_5

    if-nez v1, :cond_7

    .line 522
    :cond_5
    array-length v10, v2

    if-ne v9, v10, :cond_7

    .line 523
    if-nez v5, :cond_6

    .line 524
    new-instance v10, Ljava/util/ArrayList;

    invoke-direct {v10}, Ljava/util/ArrayList;-><init>()V

    move-object v5, v10

    .line 526
    :cond_6
    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v10

    invoke-virtual {v5, v10}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 529
    .end local v7    # "haptic":Lorg/libsdl/app/SDLHapticHandler$SDLHaptic;
    .end local v8    # "device_id":I
    .end local v9    # "i":I
    :cond_7
    goto :goto_1

    .line 531
    :cond_8
    if-eqz v5, :cond_b

    .line 532
    invoke-virtual {v5}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v4

    :goto_4
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v6

    if-eqz v6, :cond_b

    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/lang/Integer;

    invoke-virtual {v6}, Ljava/lang/Integer;->intValue()I

    move-result v6

    .line 533
    .local v6, "device_id":I
    invoke-static {v6}, Lorg/libsdl/app/SDLControllerManager;->nativeRemoveHaptic(I)I

    .line 534
    const/4 v7, 0x0

    .local v7, "i":I
    :goto_5
    iget-object v8, p0, Lorg/libsdl/app/SDLHapticHandler;->mHaptics:Ljava/util/ArrayList;

    invoke-virtual {v8}, Ljava/util/ArrayList;->size()I

    move-result v8

    if-ge v7, v8, :cond_a

    .line 535
    iget-object v8, p0, Lorg/libsdl/app/SDLHapticHandler;->mHaptics:Ljava/util/ArrayList;

    invoke-virtual {v8, v7}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Lorg/libsdl/app/SDLHapticHandler$SDLHaptic;

    iget v8, v8, Lorg/libsdl/app/SDLHapticHandler$SDLHaptic;->device_id:I

    if-ne v8, v6, :cond_9

    .line 536
    iget-object v8, p0, Lorg/libsdl/app/SDLHapticHandler;->mHaptics:Ljava/util/ArrayList;

    invoke-virtual {v8, v7}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    .line 537
    goto :goto_6

    .line 534
    :cond_9
    add-int/lit8 v7, v7, 0x1

    goto :goto_5

    .line 540
    .end local v6    # "device_id":I
    .end local v7    # "i":I
    :cond_a
    :goto_6
    goto :goto_4

    .line 542
    :cond_b
    return-void
.end method

.method public run(IFI)V
    .locals 4
    .param p1, "device_id"    # I
    .param p2, "intensity"    # F
    .param p3, "length"    # I

    .line 454
    invoke-virtual {p0, p1}, Lorg/libsdl/app/SDLHapticHandler;->getHaptic(I)Lorg/libsdl/app/SDLHapticHandler$SDLHaptic;

    move-result-object v0

    .line 455
    .local v0, "haptic":Lorg/libsdl/app/SDLHapticHandler$SDLHaptic;
    if-eqz v0, :cond_0

    .line 456
    iget-object v1, v0, Lorg/libsdl/app/SDLHapticHandler$SDLHaptic;->vib:Landroid/os/Vibrator;

    int-to-long v2, p3

    invoke-virtual {v1, v2, v3}, Landroid/os/Vibrator;->vibrate(J)V

    .line 458
    :cond_0
    return-void
.end method

.method public stop(I)V
    .locals 2
    .param p1, "device_id"    # I

    .line 461
    invoke-virtual {p0, p1}, Lorg/libsdl/app/SDLHapticHandler;->getHaptic(I)Lorg/libsdl/app/SDLHapticHandler$SDLHaptic;

    move-result-object v0

    .line 462
    .local v0, "haptic":Lorg/libsdl/app/SDLHapticHandler$SDLHaptic;
    if-eqz v0, :cond_0

    .line 463
    iget-object v1, v0, Lorg/libsdl/app/SDLHapticHandler$SDLHaptic;->vib:Landroid/os/Vibrator;

    invoke-virtual {v1}, Landroid/os/Vibrator;->cancel()V

    .line 465
    :cond_0
    return-void
.end method
