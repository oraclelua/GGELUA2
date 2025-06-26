.class public Lorg/libsdl/app/SDLSurface;
.super Landroid/view/SurfaceView;
.source "SDLSurface.java"

# interfaces
.implements Landroid/view/SurfaceHolder$Callback;
.implements Landroid/view/View$OnKeyListener;
.implements Landroid/view/View$OnTouchListener;
.implements Landroid/hardware/SensorEventListener;


# instance fields
.field protected mDisplay:Landroid/view/Display;

.field protected mHeight:F

.field public mIsSurfaceReady:Z

.field protected mSensorManager:Landroid/hardware/SensorManager;

.field protected mWidth:F


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;

    .line 45
    invoke-direct {p0, p1}, Landroid/view/SurfaceView;-><init>(Landroid/content/Context;)V

    .line 46
    invoke-virtual {p0}, Lorg/libsdl/app/SDLSurface;->getHolder()Landroid/view/SurfaceHolder;

    move-result-object v0

    invoke-interface {v0, p0}, Landroid/view/SurfaceHolder;->addCallback(Landroid/view/SurfaceHolder$Callback;)V

    .line 48
    const/4 v0, 0x1

    invoke-virtual {p0, v0}, Lorg/libsdl/app/SDLSurface;->setFocusable(Z)V

    .line 49
    invoke-virtual {p0, v0}, Lorg/libsdl/app/SDLSurface;->setFocusableInTouchMode(Z)V

    .line 50
    invoke-virtual {p0}, Lorg/libsdl/app/SDLSurface;->requestFocus()Z

    .line 51
    invoke-virtual {p0, p0}, Lorg/libsdl/app/SDLSurface;->setOnKeyListener(Landroid/view/View$OnKeyListener;)V

    .line 52
    invoke-virtual {p0, p0}, Lorg/libsdl/app/SDLSurface;->setOnTouchListener(Landroid/view/View$OnTouchListener;)V

    .line 54
    const-string v0, "window"

    invoke-virtual {p1, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/WindowManager;

    invoke-interface {v0}, Landroid/view/WindowManager;->getDefaultDisplay()Landroid/view/Display;

    move-result-object v0

    iput-object v0, p0, Lorg/libsdl/app/SDLSurface;->mDisplay:Landroid/view/Display;

    .line 55
    const-string v0, "sensor"

    invoke-virtual {p1, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/hardware/SensorManager;

    iput-object v0, p0, Lorg/libsdl/app/SDLSurface;->mSensorManager:Landroid/hardware/SensorManager;

    .line 57
    invoke-static {}, Lorg/libsdl/app/SDLActivity;->getMotionListener()Lorg/libsdl/app/SDLGenericMotionListener_API12;

    move-result-object v0

    invoke-virtual {p0, v0}, Lorg/libsdl/app/SDLSurface;->setOnGenericMotionListener(Landroid/view/View$OnGenericMotionListener;)V

    .line 60
    const/high16 v0, 0x3f800000    # 1.0f

    iput v0, p0, Lorg/libsdl/app/SDLSurface;->mWidth:F

    .line 61
    iput v0, p0, Lorg/libsdl/app/SDLSurface;->mHeight:F

    .line 63
    const/4 v0, 0x0

    iput-boolean v0, p0, Lorg/libsdl/app/SDLSurface;->mIsSurfaceReady:Z

    .line 64
    return-void
.end method


# virtual methods
.method public enableSensor(IZ)V
    .locals 4
    .param p1, "sensortype"    # I
    .param p2, "enabled"    # Z

    .line 304
    if-eqz p2, :cond_0

    .line 305
    iget-object v0, p0, Lorg/libsdl/app/SDLSurface;->mSensorManager:Landroid/hardware/SensorManager;

    .line 306
    invoke-virtual {v0, p1}, Landroid/hardware/SensorManager;->getDefaultSensor(I)Landroid/hardware/Sensor;

    move-result-object v1

    const/4 v2, 0x1

    const/4 v3, 0x0

    .line 305
    invoke-virtual {v0, p0, v1, v2, v3}, Landroid/hardware/SensorManager;->registerListener(Landroid/hardware/SensorEventListener;Landroid/hardware/Sensor;ILandroid/os/Handler;)Z

    goto :goto_0

    .line 309
    :cond_0
    iget-object v0, p0, Lorg/libsdl/app/SDLSurface;->mSensorManager:Landroid/hardware/SensorManager;

    .line 310
    invoke-virtual {v0, p1}, Landroid/hardware/SensorManager;->getDefaultSensor(I)Landroid/hardware/Sensor;

    move-result-object v1

    .line 309
    invoke-virtual {v0, p0, v1}, Landroid/hardware/SensorManager;->unregisterListener(Landroid/hardware/SensorEventListener;Landroid/hardware/Sensor;)V

    .line 312
    :goto_0
    return-void
.end method

.method public getNativeSurface()Landroid/view/Surface;
    .locals 1

    .line 80
    invoke-virtual {p0}, Lorg/libsdl/app/SDLSurface;->getHolder()Landroid/view/SurfaceHolder;

    move-result-object v0

    invoke-interface {v0}, Landroid/view/SurfaceHolder;->getSurface()Landroid/view/Surface;

    move-result-object v0

    return-object v0
.end method

.method public handlePause()V
    .locals 2

    .line 67
    const/4 v0, 0x1

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Lorg/libsdl/app/SDLSurface;->enableSensor(IZ)V

    .line 68
    return-void
.end method

.method public handleResume()V
    .locals 1

    .line 71
    const/4 v0, 0x1

    invoke-virtual {p0, v0}, Lorg/libsdl/app/SDLSurface;->setFocusable(Z)V

    .line 72
    invoke-virtual {p0, v0}, Lorg/libsdl/app/SDLSurface;->setFocusableInTouchMode(Z)V

    .line 73
    invoke-virtual {p0}, Lorg/libsdl/app/SDLSurface;->requestFocus()Z

    .line 74
    invoke-virtual {p0, p0}, Lorg/libsdl/app/SDLSurface;->setOnKeyListener(Landroid/view/View$OnKeyListener;)V

    .line 75
    invoke-virtual {p0, p0}, Lorg/libsdl/app/SDLSurface;->setOnTouchListener(Landroid/view/View$OnTouchListener;)V

    .line 76
    invoke-virtual {p0, v0, v0}, Lorg/libsdl/app/SDLSurface;->enableSensor(IZ)V

    .line 77
    return-void
.end method

.method public onAccuracyChanged(Landroid/hardware/Sensor;I)V
    .locals 0
    .param p1, "sensor"    # Landroid/hardware/Sensor;
    .param p2, "accuracy"    # I

    .line 317
    return-void
.end method

.method public onCapturedPointerEvent(Landroid/view/MotionEvent;)Z
    .locals 5
    .param p1, "event"    # Landroid/view/MotionEvent;

    .line 368
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getActionMasked()I

    move-result v0

    .line 371
    .local v0, "action":I
    const/4 v1, 0x1

    const/4 v2, 0x0

    sparse-switch v0, :sswitch_data_0

    .line 403
    return v2

    .line 389
    :sswitch_0
    const/16 v3, 0xb

    if-ne v0, v3, :cond_0

    .line 390
    const/4 v0, 0x0

    goto :goto_0

    .line 392
    :cond_0
    const/4 v0, 0x1

    .line 395
    :goto_0
    invoke-virtual {p1, v2}, Landroid/view/MotionEvent;->getX(I)F

    move-result v3

    .line 396
    .local v3, "x":F
    invoke-virtual {p1, v2}, Landroid/view/MotionEvent;->getY(I)F

    move-result v2

    .line 397
    .local v2, "y":F
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getButtonState()I

    move-result v4

    .line 399
    .local v4, "button":I
    invoke-static {v4, v0, v3, v2, v1}, Lorg/libsdl/app/SDLActivity;->onNativeMouse(IIFFZ)V

    .line 400
    return v1

    .line 373
    .end local v2    # "y":F
    .end local v3    # "x":F
    .end local v4    # "button":I
    :sswitch_1
    const/16 v3, 0xa

    invoke-virtual {p1, v3, v2}, Landroid/view/MotionEvent;->getAxisValue(II)F

    move-result v3

    .line 374
    .restart local v3    # "x":F
    const/16 v4, 0x9

    invoke-virtual {p1, v4, v2}, Landroid/view/MotionEvent;->getAxisValue(II)F

    move-result v4

    .line 375
    .local v4, "y":F
    invoke-static {v2, v0, v3, v4, v2}, Lorg/libsdl/app/SDLActivity;->onNativeMouse(IIFFZ)V

    .line 376
    return v1

    .line 380
    .end local v3    # "x":F
    .end local v4    # "y":F
    :sswitch_2
    invoke-virtual {p1, v2}, Landroid/view/MotionEvent;->getX(I)F

    move-result v3

    .line 381
    .restart local v3    # "x":F
    invoke-virtual {p1, v2}, Landroid/view/MotionEvent;->getY(I)F

    move-result v4

    .line 382
    .restart local v4    # "y":F
    invoke-static {v2, v0, v3, v4, v1}, Lorg/libsdl/app/SDLActivity;->onNativeMouse(IIFFZ)V

    .line 383
    return v1

    nop

    :sswitch_data_0
    .sparse-switch
        0x2 -> :sswitch_2
        0x7 -> :sswitch_2
        0x8 -> :sswitch_1
        0xb -> :sswitch_0
        0xc -> :sswitch_0
    .end sparse-switch
.end method

.method public onKey(Landroid/view/View;ILandroid/view/KeyEvent;)Z
    .locals 1
    .param p1, "v"    # Landroid/view/View;
    .param p2, "keyCode"    # I
    .param p3, "event"    # Landroid/view/KeyEvent;

    .line 193
    const/4 v0, 0x0

    invoke-static {p1, p2, p3, v0}, Lorg/libsdl/app/SDLActivity;->handleKeyEvent(Landroid/view/View;ILandroid/view/KeyEvent;Landroid/view/inputmethod/InputConnection;)Z

    move-result v0

    return v0
.end method

.method public onSensorChanged(Landroid/hardware/SensorEvent;)V
    .locals 8
    .param p1, "event"    # Landroid/hardware/SensorEvent;

    .line 321
    iget-object v0, p1, Landroid/hardware/SensorEvent;->sensor:Landroid/hardware/Sensor;

    invoke-virtual {v0}, Landroid/hardware/Sensor;->getType()I

    move-result v0

    const/4 v1, 0x1

    if-ne v0, v1, :cond_1

    .line 328
    iget-object v0, p0, Lorg/libsdl/app/SDLSurface;->mDisplay:Landroid/view/Display;

    invoke-virtual {v0}, Landroid/view/Display;->getRotation()I

    move-result v0

    const/4 v2, 0x0

    packed-switch v0, :pswitch_data_0

    .line 346
    iget-object v0, p1, Landroid/hardware/SensorEvent;->values:[F

    aget v0, v0, v2

    .line 347
    .local v0, "x":F
    iget-object v2, p1, Landroid/hardware/SensorEvent;->values:[F

    aget v1, v2, v1

    .line 348
    .local v1, "y":F
    const/4 v2, 0x3

    .local v2, "newOrientation":I
    goto :goto_0

    .line 335
    .end local v0    # "x":F
    .end local v1    # "y":F
    .end local v2    # "newOrientation":I
    :pswitch_0
    iget-object v0, p1, Landroid/hardware/SensorEvent;->values:[F

    aget v0, v0, v1

    .line 336
    .restart local v0    # "x":F
    iget-object v1, p1, Landroid/hardware/SensorEvent;->values:[F

    aget v1, v1, v2

    neg-float v1, v1

    .line 337
    .restart local v1    # "y":F
    const/4 v2, 0x2

    .line 338
    .restart local v2    # "newOrientation":I
    goto :goto_0

    .line 340
    .end local v0    # "x":F
    .end local v1    # "y":F
    .end local v2    # "newOrientation":I
    :pswitch_1
    iget-object v0, p1, Landroid/hardware/SensorEvent;->values:[F

    aget v0, v0, v2

    neg-float v0, v0

    .line 341
    .restart local v0    # "x":F
    iget-object v2, p1, Landroid/hardware/SensorEvent;->values:[F

    aget v1, v2, v1

    neg-float v1, v1

    .line 342
    .restart local v1    # "y":F
    const/4 v2, 0x4

    .line 343
    .restart local v2    # "newOrientation":I
    goto :goto_0

    .line 330
    .end local v0    # "x":F
    .end local v1    # "y":F
    .end local v2    # "newOrientation":I
    :pswitch_2
    iget-object v0, p1, Landroid/hardware/SensorEvent;->values:[F

    aget v0, v0, v1

    neg-float v0, v0

    .line 331
    .restart local v0    # "x":F
    iget-object v1, p1, Landroid/hardware/SensorEvent;->values:[F

    aget v1, v1, v2

    .line 332
    .restart local v1    # "y":F
    const/4 v2, 0x1

    .line 333
    .restart local v2    # "newOrientation":I
    nop

    .line 352
    :goto_0
    sget v3, Lorg/libsdl/app/SDLActivity;->mCurrentOrientation:I

    if-eq v2, v3, :cond_0

    .line 353
    sput v2, Lorg/libsdl/app/SDLActivity;->mCurrentOrientation:I

    .line 354
    invoke-static {v2}, Lorg/libsdl/app/SDLActivity;->onNativeOrientationChanged(I)V

    .line 357
    :cond_0
    neg-float v3, v0

    const v4, 0x411ce80a

    div-float/2addr v3, v4

    div-float v5, v1, v4

    iget-object v6, p1, Landroid/hardware/SensorEvent;->values:[F

    const/4 v7, 0x2

    aget v6, v6, v7

    div-float/2addr v6, v4

    invoke-static {v3, v5, v6}, Lorg/libsdl/app/SDLActivity;->onNativeAccel(FFF)V

    .line 363
    .end local v0    # "x":F
    .end local v1    # "y":F
    .end local v2    # "newOrientation":I
    :cond_1
    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public onTouch(Landroid/view/View;Landroid/view/MotionEvent;)Z
    .locals 18
    .param p1, "v"    # Landroid/view/View;
    .param p2, "event"    # Landroid/view/MotionEvent;

    .line 200
    move-object/from16 v1, p0

    move-object/from16 v2, p2

    invoke-virtual/range {p2 .. p2}, Landroid/view/MotionEvent;->getDeviceId()I

    move-result v0

    .line 201
    .local v0, "touchDevId":I
    invoke-virtual/range {p2 .. p2}, Landroid/view/MotionEvent;->getPointerCount()I

    move-result v3

    .line 202
    .local v3, "pointerCount":I
    invoke-virtual/range {p2 .. p2}, Landroid/view/MotionEvent;->getActionMasked()I

    move-result v10

    .line 204
    .local v10, "action":I
    const/4 v4, -0x1

    .line 213
    .local v4, "i":I
    if-gez v0, :cond_0

    .line 214
    add-int/lit8 v0, v0, -0x1

    move/from16 v17, v0

    goto :goto_0

    .line 213
    :cond_0
    move/from16 v17, v0

    .line 220
    .end local v0    # "touchDevId":I
    .local v17, "touchDevId":I
    :goto_0
    invoke-virtual/range {p2 .. p2}, Landroid/view/MotionEvent;->getSource()I

    move-result v0

    const/16 v5, 0x2002

    if-eq v0, v5, :cond_7

    invoke-virtual/range {p2 .. p2}, Landroid/view/MotionEvent;->getSource()I

    move-result v0

    const/16 v5, 0x3002

    if-ne v0, v5, :cond_1

    goto/16 :goto_6

    .line 238
    :cond_1
    const/high16 v0, 0x3f800000    # 1.0f

    packed-switch v10, :pswitch_data_0

    :pswitch_0
    goto/16 :goto_8

    .line 279
    :pswitch_1
    const/4 v4, 0x0

    :goto_1
    if-ge v4, v3, :cond_9

    .line 280
    invoke-virtual {v2, v4}, Landroid/view/MotionEvent;->getPointerId(I)I

    move-result v5

    .line 281
    .local v5, "pointerFingerId":I
    invoke-virtual {v2, v4}, Landroid/view/MotionEvent;->getX(I)F

    move-result v6

    iget v7, v1, Lorg/libsdl/app/SDLSurface;->mWidth:F

    div-float/2addr v6, v7

    .line 282
    .local v6, "x":F
    invoke-virtual {v2, v4}, Landroid/view/MotionEvent;->getY(I)F

    move-result v7

    iget v8, v1, Lorg/libsdl/app/SDLSurface;->mHeight:F

    div-float/2addr v7, v8

    .line 283
    .local v7, "y":F
    invoke-virtual {v2, v4}, Landroid/view/MotionEvent;->getPressure(I)F

    move-result v8

    .line 284
    .local v8, "p":F
    cmpl-float v9, v8, v0

    if-lez v9, :cond_2

    .line 287
    const/high16 v8, 0x3f800000    # 1.0f

    .line 289
    :cond_2
    const/4 v13, 0x1

    move/from16 v11, v17

    move v12, v5

    move v14, v6

    move v15, v7

    move/from16 v16, v8

    invoke-static/range {v11 .. v16}, Lorg/libsdl/app/SDLActivity;->onNativeTouch(IIIFFF)V

    .line 279
    add-int/lit8 v4, v4, 0x1

    goto :goto_1

    .line 240
    .end local v5    # "pointerFingerId":I
    .end local v6    # "x":F
    .end local v7    # "y":F
    .end local v8    # "p":F
    :pswitch_2
    const/4 v4, 0x0

    move v11, v4

    .end local v4    # "i":I
    .local v11, "i":I
    :goto_2
    if-ge v11, v3, :cond_4

    .line 241
    invoke-virtual {v2, v11}, Landroid/view/MotionEvent;->getPointerId(I)I

    move-result v12

    .line 242
    .local v12, "pointerFingerId":I
    invoke-virtual {v2, v11}, Landroid/view/MotionEvent;->getX(I)F

    move-result v4

    iget v5, v1, Lorg/libsdl/app/SDLSurface;->mWidth:F

    div-float v13, v4, v5

    .line 243
    .local v13, "x":F
    invoke-virtual {v2, v11}, Landroid/view/MotionEvent;->getY(I)F

    move-result v4

    iget v5, v1, Lorg/libsdl/app/SDLSurface;->mHeight:F

    div-float v14, v4, v5

    .line 244
    .local v14, "y":F
    invoke-virtual {v2, v11}, Landroid/view/MotionEvent;->getPressure(I)F

    move-result v4

    .line 245
    .local v4, "p":F
    cmpl-float v5, v4, v0

    if-lez v5, :cond_3

    .line 248
    const/high16 v4, 0x3f800000    # 1.0f

    move v15, v4

    goto :goto_3

    .line 245
    :cond_3
    move v15, v4

    .line 250
    .end local v4    # "p":F
    .local v15, "p":F
    :goto_3
    move/from16 v4, v17

    move v5, v12

    move v6, v10

    move v7, v13

    move v8, v14

    move v9, v15

    invoke-static/range {v4 .. v9}, Lorg/libsdl/app/SDLActivity;->onNativeTouch(IIIFFF)V

    .line 240
    add-int/lit8 v11, v11, 0x1

    goto :goto_2

    .end local v12    # "pointerFingerId":I
    .end local v13    # "x":F
    .end local v14    # "y":F
    .end local v15    # "p":F
    :cond_4
    move v4, v11

    goto/16 :goto_8

    .line 257
    .end local v11    # "i":I
    .local v4, "i":I
    :pswitch_3
    const/4 v4, 0x0

    .line 262
    :pswitch_4
    const/4 v5, -0x1

    if-ne v4, v5, :cond_5

    .line 263
    invoke-virtual/range {p2 .. p2}, Landroid/view/MotionEvent;->getActionIndex()I

    move-result v4

    move v11, v4

    goto :goto_4

    .line 262
    :cond_5
    move v11, v4

    .line 266
    .end local v4    # "i":I
    .restart local v11    # "i":I
    :goto_4
    invoke-virtual {v2, v11}, Landroid/view/MotionEvent;->getPointerId(I)I

    move-result v12

    .line 267
    .restart local v12    # "pointerFingerId":I
    invoke-virtual {v2, v11}, Landroid/view/MotionEvent;->getX(I)F

    move-result v4

    iget v5, v1, Lorg/libsdl/app/SDLSurface;->mWidth:F

    div-float v13, v4, v5

    .line 268
    .restart local v13    # "x":F
    invoke-virtual {v2, v11}, Landroid/view/MotionEvent;->getY(I)F

    move-result v4

    iget v5, v1, Lorg/libsdl/app/SDLSurface;->mHeight:F

    div-float v14, v4, v5

    .line 269
    .restart local v14    # "y":F
    invoke-virtual {v2, v11}, Landroid/view/MotionEvent;->getPressure(I)F

    move-result v4

    .line 270
    .local v4, "p":F
    cmpl-float v0, v4, v0

    if-lez v0, :cond_6

    .line 273
    const/high16 v4, 0x3f800000    # 1.0f

    move v0, v4

    goto :goto_5

    .line 270
    :cond_6
    move v0, v4

    .line 275
    .end local v4    # "p":F
    .local v0, "p":F
    :goto_5
    move/from16 v4, v17

    move v5, v12

    move v6, v10

    move v7, v13

    move v8, v14

    move v9, v0

    invoke-static/range {v4 .. v9}, Lorg/libsdl/app/SDLActivity;->onNativeTouch(IIIFFF)V

    .line 276
    move v4, v11

    goto :goto_8

    .line 221
    .end local v0    # "p":F
    .end local v11    # "i":I
    .end local v12    # "pointerFingerId":I
    .end local v13    # "x":F
    .end local v14    # "y":F
    .local v4, "i":I
    :cond_7
    :goto_6
    const/4 v5, 0x1

    .line 223
    .local v5, "mouseButton":I
    :try_start_0
    invoke-virtual/range {p2 .. p2}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    const-string v6, "getButtonState"

    const/4 v7, 0x0

    new-array v8, v7, [Ljava/lang/Class;

    invoke-virtual {v0, v6, v8}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    new-array v6, v7, [Ljava/lang/Object;

    invoke-virtual {v0, v2, v6}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .line 224
    .local v0, "object":Ljava/lang/Object;
    if-eqz v0, :cond_8

    .line 225
    move-object v6, v0

    check-cast v6, Ljava/lang/Integer;

    invoke-virtual {v6}, Ljava/lang/Integer;->intValue()I

    move-result v6
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move v5, v6

    .line 228
    .end local v0    # "object":Ljava/lang/Object;
    :cond_8
    goto :goto_7

    .line 227
    :catch_0
    move-exception v0

    .line 232
    :goto_7
    invoke-static {}, Lorg/libsdl/app/SDLActivity;->getMotionListener()Lorg/libsdl/app/SDLGenericMotionListener_API12;

    move-result-object v0

    .line 233
    .local v0, "motionListener":Lorg/libsdl/app/SDLGenericMotionListener_API12;
    invoke-virtual {v0, v2}, Lorg/libsdl/app/SDLGenericMotionListener_API12;->getEventX(Landroid/view/MotionEvent;)F

    move-result v6

    .line 234
    .restart local v6    # "x":F
    invoke-virtual {v0, v2}, Lorg/libsdl/app/SDLGenericMotionListener_API12;->getEventY(Landroid/view/MotionEvent;)F

    move-result v7

    .line 236
    .restart local v7    # "y":F
    invoke-virtual {v0}, Lorg/libsdl/app/SDLGenericMotionListener_API12;->inRelativeMode()Z

    move-result v8

    invoke-static {v5, v10, v6, v7, v8}, Lorg/libsdl/app/SDLActivity;->onNativeMouse(IIFFZ)V

    .line 237
    .end local v0    # "motionListener":Lorg/libsdl/app/SDLGenericMotionListener_API12;
    .end local v5    # "mouseButton":I
    nop

    .line 298
    .end local v6    # "x":F
    .end local v7    # "y":F
    :cond_9
    :goto_8
    const/4 v0, 0x1

    return v0

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_3
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
        :pswitch_4
        :pswitch_4
    .end packed-switch
.end method

.method public surfaceChanged(Landroid/view/SurfaceHolder;III)V
    .locals 16
    .param p1, "holder"    # Landroid/view/SurfaceHolder;
    .param p2, "format"    # I
    .param p3, "width"    # I
    .param p4, "height"    # I

    .line 107
    move-object/from16 v1, p0

    move/from16 v2, p3

    move/from16 v3, p4

    const-string v0, "SDL"

    const-string v4, "surfaceChanged()"

    invoke-static {v0, v4}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 109
    sget-object v0, Lorg/libsdl/app/SDLActivity;->mSingleton:Lorg/libsdl/app/SDLActivity;

    if-nez v0, :cond_0

    .line 110
    return-void

    .line 113
    :cond_0
    int-to-float v0, v2

    iput v0, v1, Lorg/libsdl/app/SDLSurface;->mWidth:F

    .line 114
    int-to-float v0, v3

    iput v0, v1, Lorg/libsdl/app/SDLSurface;->mHeight:F

    .line 115
    move/from16 v4, p3

    .line 116
    .local v4, "nDeviceWidth":I
    move/from16 v5, p4

    .line 119
    .local v5, "nDeviceHeight":I
    :try_start_0
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v6, 0x11

    if-lt v0, v6, :cond_1

    .line 120
    new-instance v0, Landroid/util/DisplayMetrics;

    invoke-direct {v0}, Landroid/util/DisplayMetrics;-><init>()V

    .line 121
    .local v0, "realMetrics":Landroid/util/DisplayMetrics;
    iget-object v6, v1, Lorg/libsdl/app/SDLSurface;->mDisplay:Landroid/view/Display;

    invoke-virtual {v6, v0}, Landroid/view/Display;->getRealMetrics(Landroid/util/DisplayMetrics;)V

    .line 122
    iget v6, v0, Landroid/util/DisplayMetrics;->widthPixels:I

    move v4, v6

    .line 123
    iget v6, v0, Landroid/util/DisplayMetrics;->heightPixels:I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move v5, v6

    .line 126
    .end local v0    # "realMetrics":Landroid/util/DisplayMetrics;
    :cond_1
    goto :goto_0

    .line 125
    :catch_0
    move-exception v0

    .line 128
    :goto_0
    invoke-static {}, Lorg/libsdl/app/SDLActivity;->getContext()Landroid/content/Context;

    move-result-object v6

    monitor-enter v6

    .line 130
    :try_start_1
    invoke-static {}, Lorg/libsdl/app/SDLActivity;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->notifyAll()V

    .line 131
    monitor-exit v6
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 133
    const-string v0, "SDL"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "Window size: "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, "x"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v0, v6}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 134
    const-string v0, "SDL"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "Device size: "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, "x"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v0, v6}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 135
    iget-object v0, v1, Lorg/libsdl/app/SDLSurface;->mDisplay:Landroid/view/Display;

    invoke-virtual {v0}, Landroid/view/Display;->getRefreshRate()F

    move-result v0

    invoke-static {v2, v3, v4, v5, v0}, Lorg/libsdl/app/SDLActivity;->nativeSetScreenResolution(IIIIF)V

    .line 136
    invoke-static {}, Lorg/libsdl/app/SDLActivity;->onNativeResize()V

    .line 140
    const/4 v0, 0x0

    .line 141
    .local v0, "skip":Z
    sget-object v6, Lorg/libsdl/app/SDLActivity;->mSingleton:Lorg/libsdl/app/SDLActivity;

    invoke-virtual {v6}, Lorg/libsdl/app/SDLActivity;->getRequestedOrientation()I

    move-result v6

    .line 143
    .local v6, "requestedOrientation":I
    const/4 v7, 0x1

    if-eq v6, v7, :cond_4

    const/4 v8, 0x7

    if-ne v6, v8, :cond_2

    goto :goto_1

    .line 147
    :cond_2
    if-eqz v6, :cond_3

    const/4 v8, 0x6

    if-ne v6, v8, :cond_5

    .line 148
    :cond_3
    iget v8, v1, Lorg/libsdl/app/SDLSurface;->mWidth:F

    iget v9, v1, Lorg/libsdl/app/SDLSurface;->mHeight:F

    cmpg-float v8, v8, v9

    if-gez v8, :cond_5

    .line 149
    const/4 v0, 0x1

    goto :goto_2

    .line 144
    :cond_4
    :goto_1
    iget v8, v1, Lorg/libsdl/app/SDLSurface;->mWidth:F

    iget v9, v1, Lorg/libsdl/app/SDLSurface;->mHeight:F

    cmpl-float v8, v8, v9

    if-lez v8, :cond_5

    .line 145
    const/4 v0, 0x1

    .line 154
    :cond_5
    :goto_2
    if-eqz v0, :cond_6

    .line 155
    iget v8, v1, Lorg/libsdl/app/SDLSurface;->mWidth:F

    iget v9, v1, Lorg/libsdl/app/SDLSurface;->mHeight:F

    invoke-static {v8, v9}, Ljava/lang/Math;->min(FF)F

    move-result v8

    float-to-double v8, v8

    .line 156
    .local v8, "min":D
    iget v10, v1, Lorg/libsdl/app/SDLSurface;->mWidth:F

    iget v11, v1, Lorg/libsdl/app/SDLSurface;->mHeight:F

    invoke-static {v10, v11}, Ljava/lang/Math;->max(FF)F

    move-result v10

    float-to-double v10, v10

    .line 158
    .local v10, "max":D
    div-double v12, v10, v8

    const-wide v14, 0x3ff3333333333333L    # 1.2

    cmpg-double v12, v12, v14

    if-gez v12, :cond_6

    .line 159
    const-string v12, "SDL"

    const-string v13, "Don\'t skip on such aspect-ratio. Could be a square resolution."

    invoke-static {v12, v13}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 160
    const/4 v0, 0x0

    .line 165
    .end local v8    # "min":D
    .end local v10    # "max":D
    :cond_6
    if-eqz v0, :cond_7

    .line 166
    sget v8, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v9, 0x18

    if-lt v8, v9, :cond_7

    .line 167
    sget-object v8, Lorg/libsdl/app/SDLActivity;->mSingleton:Lorg/libsdl/app/SDLActivity;

    invoke-virtual {v8}, Lorg/libsdl/app/SDLActivity;->isInMultiWindowMode()Z

    move-result v8

    if-eqz v8, :cond_7

    .line 168
    const-string v8, "SDL"

    const-string v9, "Don\'t skip in Multi-Window"

    invoke-static {v8, v9}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 169
    const/4 v0, 0x0

    .line 174
    :cond_7
    if-eqz v0, :cond_8

    .line 175
    const-string v7, "SDL"

    const-string v8, "Skip .. Surface is not ready."

    invoke-static {v7, v8}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 176
    const/4 v7, 0x0

    iput-boolean v7, v1, Lorg/libsdl/app/SDLSurface;->mIsSurfaceReady:Z

    .line 177
    return-void

    .line 181
    :cond_8
    invoke-static {}, Lorg/libsdl/app/SDLActivity;->onNativeSurfaceChanged()V

    .line 184
    iput-boolean v7, v1, Lorg/libsdl/app/SDLSurface;->mIsSurfaceReady:Z

    .line 186
    sget-object v7, Lorg/libsdl/app/SDLActivity$NativeState;->RESUMED:Lorg/libsdl/app/SDLActivity$NativeState;

    sput-object v7, Lorg/libsdl/app/SDLActivity;->mNextNativeState:Lorg/libsdl/app/SDLActivity$NativeState;

    .line 187
    invoke-static {}, Lorg/libsdl/app/SDLActivity;->handleNativeState()V

    .line 188
    return-void

    .line 131
    .end local v0    # "skip":Z
    .end local v6    # "requestedOrientation":I
    :catchall_0
    move-exception v0

    :try_start_2
    monitor-exit v6
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    throw v0
.end method

.method public surfaceCreated(Landroid/view/SurfaceHolder;)V
    .locals 2
    .param p1, "holder"    # Landroid/view/SurfaceHolder;

    .line 86
    const-string v0, "SDL"

    const-string v1, "surfaceCreated()"

    invoke-static {v0, v1}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 87
    invoke-static {}, Lorg/libsdl/app/SDLActivity;->onNativeSurfaceCreated()V

    .line 88
    return-void
.end method

.method public surfaceDestroyed(Landroid/view/SurfaceHolder;)V
    .locals 2
    .param p1, "holder"    # Landroid/view/SurfaceHolder;

    .line 93
    const-string v0, "SDL"

    const-string v1, "surfaceDestroyed()"

    invoke-static {v0, v1}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 96
    sget-object v0, Lorg/libsdl/app/SDLActivity$NativeState;->PAUSED:Lorg/libsdl/app/SDLActivity$NativeState;

    sput-object v0, Lorg/libsdl/app/SDLActivity;->mNextNativeState:Lorg/libsdl/app/SDLActivity$NativeState;

    .line 97
    invoke-static {}, Lorg/libsdl/app/SDLActivity;->handleNativeState()V

    .line 99
    const/4 v0, 0x0

    iput-boolean v0, p0, Lorg/libsdl/app/SDLSurface;->mIsSurfaceReady:Z

    .line 100
    invoke-static {}, Lorg/libsdl/app/SDLActivity;->onNativeSurfaceDestroyed()V

    .line 101
    return-void
.end method
