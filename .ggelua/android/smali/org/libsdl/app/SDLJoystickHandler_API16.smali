.class Lorg/libsdl/app/SDLJoystickHandler_API16;
.super Lorg/libsdl/app/SDLJoystickHandler;
.source "SDLControllerManager.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lorg/libsdl/app/SDLJoystickHandler_API16$RangeComparator;,
        Lorg/libsdl/app/SDLJoystickHandler_API16$SDLJoystick;
    }
.end annotation


# instance fields
.field private final mJoysticks:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Lorg/libsdl/app/SDLJoystickHandler_API16$SDLJoystick;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 177
    invoke-direct {p0}, Lorg/libsdl/app/SDLJoystickHandler;-><init>()V

    .line 179
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lorg/libsdl/app/SDLJoystickHandler_API16;->mJoysticks:Ljava/util/ArrayList;

    .line 180
    return-void
.end method


# virtual methods
.method public getButtonMask(Landroid/view/InputDevice;)I
    .locals 1
    .param p1, "joystickDevice"    # Landroid/view/InputDevice;

    .line 295
    const/4 v0, -0x1

    return v0
.end method

.method protected getJoystick(I)Lorg/libsdl/app/SDLJoystickHandler_API16$SDLJoystick;
    .locals 3
    .param p1, "device_id"    # I

    .line 248
    iget-object v0, p0, Lorg/libsdl/app/SDLJoystickHandler_API16;->mJoysticks:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lorg/libsdl/app/SDLJoystickHandler_API16$SDLJoystick;

    .line 249
    .local v1, "joystick":Lorg/libsdl/app/SDLJoystickHandler_API16$SDLJoystick;
    iget v2, v1, Lorg/libsdl/app/SDLJoystickHandler_API16$SDLJoystick;->device_id:I

    if-ne v2, p1, :cond_0

    .line 250
    return-object v1

    .line 252
    .end local v1    # "joystick":Lorg/libsdl/app/SDLJoystickHandler_API16$SDLJoystick;
    :cond_0
    goto :goto_0

    .line 253
    :cond_1
    const/4 v0, 0x0

    return-object v0
.end method

.method public getJoystickDescriptor(Landroid/view/InputDevice;)Ljava/lang/String;
    .locals 2
    .param p1, "joystickDevice"    # Landroid/view/InputDevice;

    .line 280
    invoke-virtual {p1}, Landroid/view/InputDevice;->getDescriptor()Ljava/lang/String;

    move-result-object v0

    .line 282
    .local v0, "desc":Ljava/lang/String;
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_0

    .line 283
    return-object v0

    .line 286
    :cond_0
    invoke-virtual {p1}, Landroid/view/InputDevice;->getName()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public getProductId(Landroid/view/InputDevice;)I
    .locals 1
    .param p1, "joystickDevice"    # Landroid/view/InputDevice;

    .line 289
    const/4 v0, 0x0

    return v0
.end method

.method public getVendorId(Landroid/view/InputDevice;)I
    .locals 1
    .param p1, "joystickDevice"    # Landroid/view/InputDevice;

    .line 292
    const/4 v0, 0x0

    return v0
.end method

.method public handleMotionEvent(Landroid/view/MotionEvent;)Z
    .locals 9
    .param p1, "event"    # Landroid/view/MotionEvent;

    .line 258
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getActionIndex()I

    move-result v0

    .line 259
    .local v0, "actionPointerIndex":I
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getActionMasked()I

    move-result v1

    .line 260
    .local v1, "action":I
    const/4 v2, 0x1

    const/4 v3, 0x2

    if-ne v1, v3, :cond_1

    .line 261
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getDeviceId()I

    move-result v4

    invoke-virtual {p0, v4}, Lorg/libsdl/app/SDLJoystickHandler_API16;->getJoystick(I)Lorg/libsdl/app/SDLJoystickHandler_API16$SDLJoystick;

    move-result-object v4

    .line 262
    .local v4, "joystick":Lorg/libsdl/app/SDLJoystickHandler_API16$SDLJoystick;
    if-eqz v4, :cond_1

    .line 263
    const/4 v5, 0x0

    .local v5, "i":I
    :goto_0
    iget-object v6, v4, Lorg/libsdl/app/SDLJoystickHandler_API16$SDLJoystick;->axes:Ljava/util/ArrayList;

    invoke-virtual {v6}, Ljava/util/ArrayList;->size()I

    move-result v6

    if-ge v5, v6, :cond_0

    .line 264
    iget-object v6, v4, Lorg/libsdl/app/SDLJoystickHandler_API16$SDLJoystick;->axes:Ljava/util/ArrayList;

    invoke-virtual {v6, v5}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Landroid/view/InputDevice$MotionRange;

    .line 266
    .local v6, "range":Landroid/view/InputDevice$MotionRange;
    invoke-virtual {v6}, Landroid/view/InputDevice$MotionRange;->getAxis()I

    move-result v7

    invoke-virtual {p1, v7, v0}, Landroid/view/MotionEvent;->getAxisValue(II)F

    move-result v7

    invoke-virtual {v6}, Landroid/view/InputDevice$MotionRange;->getMin()F

    move-result v8

    sub-float/2addr v7, v8

    invoke-virtual {v6}, Landroid/view/InputDevice$MotionRange;->getRange()F

    move-result v8

    div-float/2addr v7, v8

    const/high16 v8, 0x40000000    # 2.0f

    mul-float/2addr v7, v8

    const/high16 v8, 0x3f800000    # 1.0f

    sub-float/2addr v7, v8

    .line 267
    .local v7, "value":F
    iget v8, v4, Lorg/libsdl/app/SDLJoystickHandler_API16$SDLJoystick;->device_id:I

    invoke-static {v8, v5, v7}, Lorg/libsdl/app/SDLControllerManager;->onNativeJoy(IIF)V

    .line 263
    .end local v6    # "range":Landroid/view/InputDevice$MotionRange;
    .end local v7    # "value":F
    add-int/lit8 v5, v5, 0x1

    goto :goto_0

    .line 269
    .end local v5    # "i":I
    :cond_0
    const/4 v5, 0x0

    .restart local v5    # "i":I
    :goto_1
    iget-object v6, v4, Lorg/libsdl/app/SDLJoystickHandler_API16$SDLJoystick;->hats:Ljava/util/ArrayList;

    invoke-virtual {v6}, Ljava/util/ArrayList;->size()I

    move-result v6

    div-int/2addr v6, v3

    if-ge v5, v6, :cond_1

    .line 270
    iget-object v6, v4, Lorg/libsdl/app/SDLJoystickHandler_API16$SDLJoystick;->hats:Ljava/util/ArrayList;

    mul-int/lit8 v7, v5, 0x2

    invoke-virtual {v6, v7}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Landroid/view/InputDevice$MotionRange;

    invoke-virtual {v6}, Landroid/view/InputDevice$MotionRange;->getAxis()I

    move-result v6

    invoke-virtual {p1, v6, v0}, Landroid/view/MotionEvent;->getAxisValue(II)F

    move-result v6

    invoke-static {v6}, Ljava/lang/Math;->round(F)I

    move-result v6

    .line 271
    .local v6, "hatX":I
    iget-object v7, v4, Lorg/libsdl/app/SDLJoystickHandler_API16$SDLJoystick;->hats:Ljava/util/ArrayList;

    mul-int/lit8 v8, v5, 0x2

    add-int/2addr v8, v2

    invoke-virtual {v7, v8}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Landroid/view/InputDevice$MotionRange;

    invoke-virtual {v7}, Landroid/view/InputDevice$MotionRange;->getAxis()I

    move-result v7

    invoke-virtual {p1, v7, v0}, Landroid/view/MotionEvent;->getAxisValue(II)F

    move-result v7

    invoke-static {v7}, Ljava/lang/Math;->round(F)I

    move-result v7

    .line 272
    .local v7, "hatY":I
    iget v8, v4, Lorg/libsdl/app/SDLJoystickHandler_API16$SDLJoystick;->device_id:I

    invoke-static {v8, v5, v6, v7}, Lorg/libsdl/app/SDLControllerManager;->onNativeHat(IIII)V

    .line 269
    .end local v6    # "hatX":I
    .end local v7    # "hatY":I
    add-int/lit8 v5, v5, 0x1

    goto :goto_1

    .line 276
    .end local v4    # "joystick":Lorg/libsdl/app/SDLJoystickHandler_API16$SDLJoystick;
    .end local v5    # "i":I
    :cond_1
    return v2
.end method

.method public pollInputDevices()V
    .locals 19

    .line 184
    move-object/from16 v0, p0

    invoke-static {}, Landroid/view/InputDevice;->getDeviceIds()[I

    move-result-object v1

    .line 186
    .local v1, "deviceIds":[I
    array-length v2, v1

    const/4 v3, 0x0

    :goto_0
    if-ge v3, v2, :cond_5

    aget v4, v1, v3

    .line 187
    .local v4, "device_id":I
    invoke-static {v4}, Lorg/libsdl/app/SDLControllerManager;->isDeviceSDLJoystick(I)Z

    move-result v5

    if-eqz v5, :cond_4

    .line 188
    invoke-virtual {v0, v4}, Lorg/libsdl/app/SDLJoystickHandler_API16;->getJoystick(I)Lorg/libsdl/app/SDLJoystickHandler_API16$SDLJoystick;

    move-result-object v5

    .line 189
    .local v5, "joystick":Lorg/libsdl/app/SDLJoystickHandler_API16$SDLJoystick;
    if-nez v5, :cond_4

    .line 190
    invoke-static {v4}, Landroid/view/InputDevice;->getDevice(I)Landroid/view/InputDevice;

    move-result-object v6

    .line 191
    .local v6, "joystickDevice":Landroid/view/InputDevice;
    new-instance v7, Lorg/libsdl/app/SDLJoystickHandler_API16$SDLJoystick;

    invoke-direct {v7}, Lorg/libsdl/app/SDLJoystickHandler_API16$SDLJoystick;-><init>()V

    move-object v5, v7

    .line 192
    iput v4, v5, Lorg/libsdl/app/SDLJoystickHandler_API16$SDLJoystick;->device_id:I

    .line 193
    invoke-virtual {v6}, Landroid/view/InputDevice;->getName()Ljava/lang/String;

    move-result-object v7

    iput-object v7, v5, Lorg/libsdl/app/SDLJoystickHandler_API16$SDLJoystick;->name:Ljava/lang/String;

    .line 194
    invoke-virtual {v0, v6}, Lorg/libsdl/app/SDLJoystickHandler_API16;->getJoystickDescriptor(Landroid/view/InputDevice;)Ljava/lang/String;

    move-result-object v7

    iput-object v7, v5, Lorg/libsdl/app/SDLJoystickHandler_API16$SDLJoystick;->desc:Ljava/lang/String;

    .line 195
    new-instance v7, Ljava/util/ArrayList;

    invoke-direct {v7}, Ljava/util/ArrayList;-><init>()V

    iput-object v7, v5, Lorg/libsdl/app/SDLJoystickHandler_API16$SDLJoystick;->axes:Ljava/util/ArrayList;

    .line 196
    new-instance v7, Ljava/util/ArrayList;

    invoke-direct {v7}, Ljava/util/ArrayList;-><init>()V

    iput-object v7, v5, Lorg/libsdl/app/SDLJoystickHandler_API16$SDLJoystick;->hats:Ljava/util/ArrayList;

    .line 198
    invoke-virtual {v6}, Landroid/view/InputDevice;->getMotionRanges()Ljava/util/List;

    move-result-object v7

    .line 199
    .local v7, "ranges":Ljava/util/List;, "Ljava/util/List<Landroid/view/InputDevice$MotionRange;>;"
    new-instance v8, Lorg/libsdl/app/SDLJoystickHandler_API16$RangeComparator;

    invoke-direct {v8}, Lorg/libsdl/app/SDLJoystickHandler_API16$RangeComparator;-><init>()V

    invoke-static {v7, v8}, Ljava/util/Collections;->sort(Ljava/util/List;Ljava/util/Comparator;)V

    .line 200
    invoke-interface {v7}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v8

    :goto_1
    invoke-interface {v8}, Ljava/util/Iterator;->hasNext()Z

    move-result v9

    if-eqz v9, :cond_3

    invoke-interface {v8}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Landroid/view/InputDevice$MotionRange;

    .line 201
    .local v9, "range":Landroid/view/InputDevice$MotionRange;
    invoke-virtual {v9}, Landroid/view/InputDevice$MotionRange;->getSource()I

    move-result v10

    const/16 v11, 0x10

    and-int/2addr v10, v11

    if-eqz v10, :cond_2

    .line 202
    invoke-virtual {v9}, Landroid/view/InputDevice$MotionRange;->getAxis()I

    move-result v10

    const/16 v12, 0xf

    if-eq v10, v12, :cond_1

    invoke-virtual {v9}, Landroid/view/InputDevice$MotionRange;->getAxis()I

    move-result v10

    if-ne v10, v11, :cond_0

    goto :goto_2

    .line 205
    :cond_0
    iget-object v10, v5, Lorg/libsdl/app/SDLJoystickHandler_API16$SDLJoystick;->axes:Ljava/util/ArrayList;

    invoke-virtual {v10, v9}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_3

    .line 203
    :cond_1
    :goto_2
    iget-object v10, v5, Lorg/libsdl/app/SDLJoystickHandler_API16$SDLJoystick;->hats:Ljava/util/ArrayList;

    invoke-virtual {v10, v9}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 208
    .end local v9    # "range":Landroid/view/InputDevice$MotionRange;
    :cond_2
    :goto_3
    goto :goto_1

    .line 210
    :cond_3
    iget-object v8, v0, Lorg/libsdl/app/SDLJoystickHandler_API16;->mJoysticks:Ljava/util/ArrayList;

    invoke-virtual {v8, v5}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 211
    iget v9, v5, Lorg/libsdl/app/SDLJoystickHandler_API16$SDLJoystick;->device_id:I

    iget-object v10, v5, Lorg/libsdl/app/SDLJoystickHandler_API16$SDLJoystick;->name:Ljava/lang/String;

    iget-object v11, v5, Lorg/libsdl/app/SDLJoystickHandler_API16$SDLJoystick;->desc:Ljava/lang/String;

    .line 212
    invoke-virtual {v0, v6}, Lorg/libsdl/app/SDLJoystickHandler_API16;->getVendorId(Landroid/view/InputDevice;)I

    move-result v12

    invoke-virtual {v0, v6}, Lorg/libsdl/app/SDLJoystickHandler_API16;->getProductId(Landroid/view/InputDevice;)I

    move-result v13

    const/4 v14, 0x0

    .line 213
    invoke-virtual {v0, v6}, Lorg/libsdl/app/SDLJoystickHandler_API16;->getButtonMask(Landroid/view/InputDevice;)I

    move-result v15

    iget-object v8, v5, Lorg/libsdl/app/SDLJoystickHandler_API16$SDLJoystick;->axes:Ljava/util/ArrayList;

    invoke-virtual {v8}, Ljava/util/ArrayList;->size()I

    move-result v16

    iget-object v8, v5, Lorg/libsdl/app/SDLJoystickHandler_API16$SDLJoystick;->hats:Ljava/util/ArrayList;

    invoke-virtual {v8}, Ljava/util/ArrayList;->size()I

    move-result v8

    div-int/lit8 v17, v8, 0x2

    const/16 v18, 0x0

    .line 211
    invoke-static/range {v9 .. v18}, Lorg/libsdl/app/SDLControllerManager;->nativeAddJoystick(ILjava/lang/String;Ljava/lang/String;IIZIIII)I

    .line 186
    .end local v4    # "device_id":I
    .end local v5    # "joystick":Lorg/libsdl/app/SDLJoystickHandler_API16$SDLJoystick;
    .end local v6    # "joystickDevice":Landroid/view/InputDevice;
    .end local v7    # "ranges":Ljava/util/List;, "Ljava/util/List<Landroid/view/InputDevice$MotionRange;>;"
    :cond_4
    add-int/lit8 v3, v3, 0x1

    goto/16 :goto_0

    .line 219
    :cond_5
    const/4 v2, 0x0

    .line 220
    .local v2, "removedDevices":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/Integer;>;"
    iget-object v3, v0, Lorg/libsdl/app/SDLJoystickHandler_API16;->mJoysticks:Ljava/util/ArrayList;

    invoke-virtual {v3}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_4
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_a

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lorg/libsdl/app/SDLJoystickHandler_API16$SDLJoystick;

    .line 221
    .local v4, "joystick":Lorg/libsdl/app/SDLJoystickHandler_API16$SDLJoystick;
    iget v5, v4, Lorg/libsdl/app/SDLJoystickHandler_API16$SDLJoystick;->device_id:I

    .line 223
    .local v5, "device_id":I
    const/4 v6, 0x0

    .local v6, "i":I
    :goto_5
    array-length v7, v1

    if-ge v6, v7, :cond_7

    .line 224
    aget v7, v1, v6

    if-ne v5, v7, :cond_6

    goto :goto_6

    .line 223
    :cond_6
    add-int/lit8 v6, v6, 0x1

    goto :goto_5

    .line 226
    :cond_7
    :goto_6
    array-length v7, v1

    if-ne v6, v7, :cond_9

    .line 227
    if-nez v2, :cond_8

    .line 228
    new-instance v7, Ljava/util/ArrayList;

    invoke-direct {v7}, Ljava/util/ArrayList;-><init>()V

    move-object v2, v7

    .line 230
    :cond_8
    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v7

    invoke-virtual {v2, v7}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 232
    .end local v4    # "joystick":Lorg/libsdl/app/SDLJoystickHandler_API16$SDLJoystick;
    .end local v5    # "device_id":I
    .end local v6    # "i":I
    :cond_9
    goto :goto_4

    .line 234
    :cond_a
    if-eqz v2, :cond_d

    .line 235
    invoke-virtual {v2}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_7
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_d

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/Integer;

    invoke-virtual {v4}, Ljava/lang/Integer;->intValue()I

    move-result v4

    .line 236
    .local v4, "device_id":I
    invoke-static {v4}, Lorg/libsdl/app/SDLControllerManager;->nativeRemoveJoystick(I)I

    .line 237
    const/4 v5, 0x0

    .local v5, "i":I
    :goto_8
    iget-object v6, v0, Lorg/libsdl/app/SDLJoystickHandler_API16;->mJoysticks:Ljava/util/ArrayList;

    invoke-virtual {v6}, Ljava/util/ArrayList;->size()I

    move-result v6

    if-ge v5, v6, :cond_c

    .line 238
    iget-object v6, v0, Lorg/libsdl/app/SDLJoystickHandler_API16;->mJoysticks:Ljava/util/ArrayList;

    invoke-virtual {v6, v5}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Lorg/libsdl/app/SDLJoystickHandler_API16$SDLJoystick;

    iget v6, v6, Lorg/libsdl/app/SDLJoystickHandler_API16$SDLJoystick;->device_id:I

    if-ne v6, v4, :cond_b

    .line 239
    iget-object v6, v0, Lorg/libsdl/app/SDLJoystickHandler_API16;->mJoysticks:Ljava/util/ArrayList;

    invoke-virtual {v6, v5}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    .line 240
    goto :goto_9

    .line 237
    :cond_b
    add-int/lit8 v5, v5, 0x1

    goto :goto_8

    .line 243
    .end local v4    # "device_id":I
    .end local v5    # "i":I
    :cond_c
    :goto_9
    goto :goto_7

    .line 245
    :cond_d
    return-void
.end method
