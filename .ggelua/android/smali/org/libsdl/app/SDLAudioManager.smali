.class public Lorg/libsdl/app/SDLAudioManager;
.super Ljava/lang/Object;
.source "SDLAudioManager.java"


# static fields
.field protected static final TAG:Ljava/lang/String; = "SDLAudio"

.field protected static mAudioRecord:Landroid/media/AudioRecord;

.field protected static mAudioTrack:Landroid/media/AudioTrack;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 11
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static audioClose()V
    .locals 1

    .line 358
    sget-object v0, Lorg/libsdl/app/SDLAudioManager;->mAudioTrack:Landroid/media/AudioTrack;

    if-eqz v0, :cond_0

    .line 359
    invoke-virtual {v0}, Landroid/media/AudioTrack;->stop()V

    .line 360
    sget-object v0, Lorg/libsdl/app/SDLAudioManager;->mAudioTrack:Landroid/media/AudioTrack;

    invoke-virtual {v0}, Landroid/media/AudioTrack;->release()V

    .line 361
    const/4 v0, 0x0

    sput-object v0, Lorg/libsdl/app/SDLAudioManager;->mAudioTrack:Landroid/media/AudioTrack;

    .line 363
    :cond_0
    return-void
.end method

.method public static audioOpen(IIII)[I
    .locals 1
    .param p0, "sampleRate"    # I
    .param p1, "audioFormat"    # I
    .param p2, "desiredChannels"    # I
    .param p3, "desiredFrames"    # I

    .line 245
    const/4 v0, 0x0

    invoke-static {v0, p0, p1, p2, p3}, Lorg/libsdl/app/SDLAudioManager;->open(ZIIII)[I

    move-result-object v0

    return-object v0
.end method

.method public static audioSetThreadPriority(ZI)V
    .locals 3
    .param p0, "iscapture"    # Z
    .param p1, "device_id"    # I

    .line 379
    if-eqz p0, :cond_0

    .line 380
    :try_start_0
    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "SDLAudioC"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/Thread;->setName(Ljava/lang/String;)V

    goto :goto_0

    .line 382
    :cond_0
    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "SDLAudioP"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/Thread;->setName(Ljava/lang/String;)V

    .line 386
    :goto_0
    const/16 v0, -0x10

    invoke-static {v0}, Landroid/os/Process;->setThreadPriority(I)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 390
    goto :goto_1

    .line 388
    :catch_0
    move-exception v0

    .line 389
    .local v0, "e":Ljava/lang/Exception;
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "modify thread properties failed "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v0}, Ljava/lang/Exception;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const-string v2, "SDLAudio"

    invoke-static {v2, v1}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 391
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_1
    return-void
.end method

.method public static audioWriteByteBuffer([B)V
    .locals 5
    .param p0, "buffer"    # [B

    .line 304
    sget-object v0, Lorg/libsdl/app/SDLAudioManager;->mAudioTrack:Landroid/media/AudioTrack;

    const-string v1, "SDLAudio"

    if-nez v0, :cond_0

    .line 305
    const-string v0, "Attempted to make audio call with uninitialized audio!"

    invoke-static {v1, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 306
    return-void

    .line 309
    :cond_0
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    array-length v2, p0

    if-ge v0, v2, :cond_3

    .line 310
    sget-object v2, Lorg/libsdl/app/SDLAudioManager;->mAudioTrack:Landroid/media/AudioTrack;

    array-length v3, p0

    sub-int/2addr v3, v0

    invoke-virtual {v2, p0, v0, v3}, Landroid/media/AudioTrack;->write([BII)I

    move-result v2

    .line 311
    .local v2, "result":I
    if-lez v2, :cond_1

    .line 312
    add-int/2addr v0, v2

    goto :goto_2

    .line 313
    :cond_1
    if-nez v2, :cond_2

    .line 315
    const-wide/16 v3, 0x1

    :try_start_0
    invoke-static {v3, v4}, Ljava/lang/Thread;->sleep(J)V
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0

    .line 318
    :goto_1
    goto :goto_2

    .line 316
    :catch_0
    move-exception v3

    goto :goto_1

    .line 323
    .end local v2    # "result":I
    :goto_2
    goto :goto_0

    .line 320
    .restart local v2    # "result":I
    :cond_2
    const-string v3, "SDL audio: error return from write(byte)"

    invoke-static {v1, v3}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 321
    return-void

    .line 324
    .end local v0    # "i":I
    .end local v2    # "result":I
    :cond_3
    return-void
.end method

.method public static audioWriteFloatBuffer([F)V
    .locals 5
    .param p0, "buffer"    # [F

    .line 252
    sget-object v0, Lorg/libsdl/app/SDLAudioManager;->mAudioTrack:Landroid/media/AudioTrack;

    const-string v1, "SDLAudio"

    if-nez v0, :cond_0

    .line 253
    const-string v0, "Attempted to make audio call with uninitialized audio!"

    invoke-static {v1, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 254
    return-void

    .line 257
    :cond_0
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    array-length v2, p0

    if-ge v0, v2, :cond_3

    .line 258
    sget-object v2, Lorg/libsdl/app/SDLAudioManager;->mAudioTrack:Landroid/media/AudioTrack;

    array-length v3, p0

    sub-int/2addr v3, v0

    const/4 v4, 0x0

    invoke-virtual {v2, p0, v0, v3, v4}, Landroid/media/AudioTrack;->write([FIII)I

    move-result v2

    .line 259
    .local v2, "result":I
    if-lez v2, :cond_1

    .line 260
    add-int/2addr v0, v2

    goto :goto_2

    .line 261
    :cond_1
    if-nez v2, :cond_2

    .line 263
    const-wide/16 v3, 0x1

    :try_start_0
    invoke-static {v3, v4}, Ljava/lang/Thread;->sleep(J)V
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0

    .line 266
    :goto_1
    goto :goto_2

    .line 264
    :catch_0
    move-exception v3

    goto :goto_1

    .line 271
    .end local v2    # "result":I
    :goto_2
    goto :goto_0

    .line 268
    .restart local v2    # "result":I
    :cond_2
    const-string v3, "SDL audio: error return from write(float)"

    invoke-static {v1, v3}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 269
    return-void

    .line 272
    .end local v0    # "i":I
    .end local v2    # "result":I
    :cond_3
    return-void
.end method

.method public static audioWriteShortBuffer([S)V
    .locals 5
    .param p0, "buffer"    # [S

    .line 278
    sget-object v0, Lorg/libsdl/app/SDLAudioManager;->mAudioTrack:Landroid/media/AudioTrack;

    const-string v1, "SDLAudio"

    if-nez v0, :cond_0

    .line 279
    const-string v0, "Attempted to make audio call with uninitialized audio!"

    invoke-static {v1, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 280
    return-void

    .line 283
    :cond_0
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    array-length v2, p0

    if-ge v0, v2, :cond_3

    .line 284
    sget-object v2, Lorg/libsdl/app/SDLAudioManager;->mAudioTrack:Landroid/media/AudioTrack;

    array-length v3, p0

    sub-int/2addr v3, v0

    invoke-virtual {v2, p0, v0, v3}, Landroid/media/AudioTrack;->write([SII)I

    move-result v2

    .line 285
    .local v2, "result":I
    if-lez v2, :cond_1

    .line 286
    add-int/2addr v0, v2

    goto :goto_2

    .line 287
    :cond_1
    if-nez v2, :cond_2

    .line 289
    const-wide/16 v3, 0x1

    :try_start_0
    invoke-static {v3, v4}, Ljava/lang/Thread;->sleep(J)V
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0

    .line 292
    :goto_1
    goto :goto_2

    .line 290
    :catch_0
    move-exception v3

    goto :goto_1

    .line 297
    .end local v2    # "result":I
    :goto_2
    goto :goto_0

    .line 294
    .restart local v2    # "result":I
    :cond_2
    const-string v3, "SDL audio: error return from write(short)"

    invoke-static {v1, v3}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 295
    return-void

    .line 298
    .end local v0    # "i":I
    .end local v2    # "result":I
    :cond_3
    return-void
.end method

.method public static captureClose()V
    .locals 1

    .line 367
    sget-object v0, Lorg/libsdl/app/SDLAudioManager;->mAudioRecord:Landroid/media/AudioRecord;

    if-eqz v0, :cond_0

    .line 368
    invoke-virtual {v0}, Landroid/media/AudioRecord;->stop()V

    .line 369
    sget-object v0, Lorg/libsdl/app/SDLAudioManager;->mAudioRecord:Landroid/media/AudioRecord;

    invoke-virtual {v0}, Landroid/media/AudioRecord;->release()V

    .line 370
    const/4 v0, 0x0

    sput-object v0, Lorg/libsdl/app/SDLAudioManager;->mAudioRecord:Landroid/media/AudioRecord;

    .line 372
    :cond_0
    return-void
.end method

.method public static captureOpen(IIII)[I
    .locals 1
    .param p0, "sampleRate"    # I
    .param p1, "audioFormat"    # I
    .param p2, "desiredChannels"    # I
    .param p3, "desiredFrames"    # I

    .line 330
    const/4 v0, 0x1

    invoke-static {v0, p0, p1, p2, p3}, Lorg/libsdl/app/SDLAudioManager;->open(ZIIII)[I

    move-result-object v0

    return-object v0
.end method

.method public static captureReadByteBuffer([BZ)I
    .locals 4
    .param p0, "buffer"    # [B
    .param p1, "blocking"    # Z

    .line 349
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/4 v1, 0x0

    const/16 v2, 0x17

    if-ge v0, v2, :cond_0

    .line 350
    sget-object v0, Lorg/libsdl/app/SDLAudioManager;->mAudioRecord:Landroid/media/AudioRecord;

    array-length v2, p0

    invoke-virtual {v0, p0, v1, v2}, Landroid/media/AudioRecord;->read([BII)I

    move-result v0

    return v0

    .line 352
    :cond_0
    sget-object v0, Lorg/libsdl/app/SDLAudioManager;->mAudioRecord:Landroid/media/AudioRecord;

    array-length v2, p0

    xor-int/lit8 v3, p1, 0x1

    invoke-virtual {v0, p0, v1, v2, v3}, Landroid/media/AudioRecord;->read([BIII)I

    move-result v0

    return v0
.end method

.method public static captureReadFloatBuffer([FZ)I
    .locals 4
    .param p0, "buffer"    # [F
    .param p1, "blocking"    # Z

    .line 335
    sget-object v0, Lorg/libsdl/app/SDLAudioManager;->mAudioRecord:Landroid/media/AudioRecord;

    array-length v1, p0

    xor-int/lit8 v2, p1, 0x1

    const/4 v3, 0x0

    invoke-virtual {v0, p0, v3, v1, v2}, Landroid/media/AudioRecord;->read([FIII)I

    move-result v0

    return v0
.end method

.method public static captureReadShortBuffer([SZ)I
    .locals 4
    .param p0, "buffer"    # [S
    .param p1, "blocking"    # Z

    .line 340
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/4 v1, 0x0

    const/16 v2, 0x17

    if-ge v0, v2, :cond_0

    .line 341
    sget-object v0, Lorg/libsdl/app/SDLAudioManager;->mAudioRecord:Landroid/media/AudioRecord;

    array-length v2, p0

    invoke-virtual {v0, p0, v1, v2}, Landroid/media/AudioRecord;->read([SII)I

    move-result v0

    return v0

    .line 343
    :cond_0
    sget-object v0, Lorg/libsdl/app/SDLAudioManager;->mAudioRecord:Landroid/media/AudioRecord;

    array-length v2, p0

    xor-int/lit8 v3, p1, 0x1

    invoke-virtual {v0, p0, v1, v2, v3}, Landroid/media/AudioRecord;->read([SIII)I

    move-result v0

    return v0
.end method

.method protected static getAudioFormatString(I)Ljava/lang/String;
    .locals 1
    .param p0, "audioFormat"    # I

    .line 26
    packed-switch p0, :pswitch_data_0

    .line 34
    invoke-static {p0}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 32
    :pswitch_0
    const-string v0, "float"

    return-object v0

    .line 28
    :pswitch_1
    const-string v0, "8-bit"

    return-object v0

    .line 30
    :pswitch_2
    const-string v0, "16-bit"

    return-object v0

    nop

    :pswitch_data_0
    .packed-switch 0x2
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public static initialize()V
    .locals 1

    .line 19
    const/4 v0, 0x0

    sput-object v0, Lorg/libsdl/app/SDLAudioManager;->mAudioTrack:Landroid/media/AudioTrack;

    .line 20
    sput-object v0, Lorg/libsdl/app/SDLAudioManager;->mAudioRecord:Landroid/media/AudioRecord;

    .line 21
    return-void
.end method

.method public static native nativeSetupJNI()I
.end method

.method protected static open(ZIIII)[I
    .locals 27
    .param p0, "isCapture"    # Z
    .param p1, "sampleRate"    # I
    .param p2, "audioFormat"    # I
    .param p3, "desiredChannels"    # I
    .param p4, "desiredFrames"    # I

    .line 43
    move/from16 v0, p1

    move/from16 v1, p3

    move/from16 v2, p4

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Opening "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v5, "capture"

    const-string v6, "playback"

    if-eqz p0, :cond_0

    move-object v7, v5

    goto :goto_0

    :cond_0
    move-object v7, v6

    :goto_0
    invoke-virtual {v3, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v7, ", requested "

    invoke-virtual {v3, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v7, " frames of "

    invoke-virtual {v3, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v8, " channel "

    invoke-virtual {v3, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-static/range {p2 .. p2}, Lorg/libsdl/app/SDLAudioManager;->getAudioFormatString(I)Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v3, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v9, " audio at "

    invoke-virtual {v3, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v10, " Hz"

    invoke-virtual {v3, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    const-string v11, "SDLAudio"

    invoke-static {v11, v3}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 46
    sget v3, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v12, 0x15

    const/4 v13, 0x2

    if-ge v3, v12, :cond_1

    .line 47
    if-le v1, v13, :cond_1

    .line 48
    const/4 v1, 0x2

    .line 53
    .end local p3    # "desiredChannels":I
    .local v1, "desiredChannels":I
    :cond_1
    sget v3, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v14, 0x16

    if-ge v3, v14, :cond_3

    .line 54
    const/16 v3, 0x1f40

    if-ge v0, v3, :cond_2

    .line 55
    const/16 v0, 0x1f40

    .end local p1    # "sampleRate":I
    .local v0, "sampleRate":I
    goto :goto_1

    .line 56
    .end local v0    # "sampleRate":I
    .restart local p1    # "sampleRate":I
    :cond_2
    const v3, 0xbb80

    if-le v0, v3, :cond_3

    .line 57
    const v0, 0xbb80

    .line 61
    .end local p1    # "sampleRate":I
    .restart local v0    # "sampleRate":I
    :cond_3
    :goto_1
    const/16 v3, 0x17

    const/4 v14, 0x4

    move/from16 v15, p2

    if-ne v15, v14, :cond_5

    .line 62
    if-eqz p0, :cond_4

    move v12, v3

    .line 63
    .local v12, "minSDKVersion":I
    :cond_4
    sget v13, Landroid/os/Build$VERSION;->SDK_INT:I

    if-ge v13, v12, :cond_5

    .line 64
    const/4 v13, 0x2

    .end local p2    # "audioFormat":I
    .local v13, "audioFormat":I
    goto :goto_2

    .line 67
    .end local v12    # "minSDKVersion":I
    .end local v13    # "audioFormat":I
    .restart local p2    # "audioFormat":I
    :cond_5
    move v13, v15

    .end local p2    # "audioFormat":I
    .restart local v13    # "audioFormat":I
    :goto_2
    packed-switch v13, :pswitch_data_0

    .line 79
    new-instance v12, Ljava/lang/StringBuilder;

    invoke-direct {v12}, Ljava/lang/StringBuilder;-><init>()V

    const-string v15, "Requested format "

    invoke-virtual {v12, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    invoke-virtual {v12, v13}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v12

    const-string v15, ", getting ENCODING_PCM_16BIT"

    invoke-virtual {v12, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    invoke-virtual {v12}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v12

    invoke-static {v11, v12}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 80
    const/4 v13, 0x2

    .line 81
    const/4 v12, 0x2

    .local v12, "sampleSize":I
    goto :goto_3

    .line 76
    .end local v12    # "sampleSize":I
    :pswitch_0
    const/4 v12, 0x4

    .line 77
    .restart local v12    # "sampleSize":I
    goto :goto_3

    .line 70
    .end local v12    # "sampleSize":I
    :pswitch_1
    const/4 v12, 0x1

    .line 71
    .restart local v12    # "sampleSize":I
    goto :goto_3

    .line 73
    .end local v12    # "sampleSize":I
    :pswitch_2
    const/4 v12, 0x2

    .line 74
    .restart local v12    # "sampleSize":I
    nop

    .line 85
    :goto_3
    const-string v15, " channels, getting stereo"

    const-string v14, "Requested "

    if-eqz p0, :cond_6

    .line 86
    packed-switch v1, :pswitch_data_1

    .line 94
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v11, v3}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 95
    const/4 v1, 0x2

    .line 96
    const/16 v3, 0xc

    .line 97
    .local v3, "channelConfig":I
    goto :goto_4

    .line 91
    .end local v3    # "channelConfig":I
    :pswitch_3
    const/16 v3, 0xc

    .line 92
    .restart local v3    # "channelConfig":I
    goto :goto_4

    .line 88
    .end local v3    # "channelConfig":I
    :pswitch_4
    const/16 v3, 0x10

    .line 89
    .restart local v3    # "channelConfig":I
    goto :goto_4

    .line 100
    .end local v3    # "channelConfig":I
    :cond_6
    packed-switch v1, :pswitch_data_2

    .line 132
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v11, v3}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 133
    const/4 v1, 0x2

    .line 134
    const/16 v3, 0xc

    .restart local v3    # "channelConfig":I
    goto :goto_4

    .line 123
    .end local v3    # "channelConfig":I
    :pswitch_5
    sget v15, Landroid/os/Build$VERSION;->SDK_INT:I

    if-lt v15, v3, :cond_7

    .line 124
    const/16 v3, 0x18fc

    .restart local v3    # "channelConfig":I
    goto :goto_4

    .line 126
    .end local v3    # "channelConfig":I
    :cond_7
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v14, " channels, getting 5.1 surround"

    invoke-virtual {v3, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v11, v3}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 127
    const/4 v1, 0x6

    .line 128
    const/16 v3, 0xfc

    .line 130
    .restart local v3    # "channelConfig":I
    goto :goto_4

    .line 120
    .end local v3    # "channelConfig":I
    :pswitch_6
    const/16 v3, 0x4fc

    .line 121
    .restart local v3    # "channelConfig":I
    goto :goto_4

    .line 117
    .end local v3    # "channelConfig":I
    :pswitch_7
    const/16 v3, 0xfc

    .line 118
    .restart local v3    # "channelConfig":I
    goto :goto_4

    .line 114
    .end local v3    # "channelConfig":I
    :pswitch_8
    const/16 v3, 0xdc

    .line 115
    .restart local v3    # "channelConfig":I
    goto :goto_4

    .line 111
    .end local v3    # "channelConfig":I
    :pswitch_9
    const/16 v3, 0xcc

    .line 112
    .restart local v3    # "channelConfig":I
    goto :goto_4

    .line 108
    .end local v3    # "channelConfig":I
    :pswitch_a
    const/16 v3, 0x1c

    .line 109
    .restart local v3    # "channelConfig":I
    goto :goto_4

    .line 105
    .end local v3    # "channelConfig":I
    :pswitch_b
    const/16 v3, 0xc

    .line 106
    .restart local v3    # "channelConfig":I
    goto :goto_4

    .line 102
    .end local v3    # "channelConfig":I
    :pswitch_c
    const/4 v3, 0x4

    .line 103
    .restart local v3    # "channelConfig":I
    nop

    .line 176
    :goto_4
    mul-int v21, v12, v1

    .line 182
    .local v21, "frameSize":I
    if-eqz p0, :cond_8

    .line 183
    invoke-static {v0, v3, v13}, Landroid/media/AudioRecord;->getMinBufferSize(III)I

    move-result v14

    move/from16 v22, v14

    .local v14, "minBufferSize":I
    goto :goto_5

    .line 185
    .end local v14    # "minBufferSize":I
    :cond_8
    invoke-static {v0, v3, v13}, Landroid/media/AudioTrack;->getMinBufferSize(III)I

    move-result v14

    move/from16 v22, v14

    .line 187
    .local v22, "minBufferSize":I
    :goto_5
    add-int v14, v22, v21

    const/4 v15, 0x1

    sub-int/2addr v14, v15

    div-int v14, v14, v21

    invoke-static {v2, v14}, Ljava/lang/Math;->max(II)I

    move-result v2

    .line 189
    .end local p4    # "desiredFrames":I
    .local v2, "desiredFrames":I
    const/4 v14, 0x4

    new-array v14, v14, [I

    .line 191
    .local v14, "results":[I
    const/16 v23, 0x0

    const/16 v24, 0x0

    if-eqz p0, :cond_b

    .line 192
    sget-object v16, Lorg/libsdl/app/SDLAudioManager;->mAudioRecord:Landroid/media/AudioRecord;

    if-nez v16, :cond_a

    .line 193
    new-instance v20, Landroid/media/AudioRecord;

    const/16 v16, 0x0

    mul-int v19, v2, v21

    move-object/from16 v25, v14

    .end local v14    # "results":[I
    .local v25, "results":[I
    move-object/from16 v14, v20

    move/from16 p1, v1

    move v1, v15

    .end local v1    # "desiredChannels":I
    .local p1, "desiredChannels":I
    move/from16 v15, v16

    move/from16 v16, v0

    move/from16 v17, v3

    move/from16 v18, v13

    invoke-direct/range {v14 .. v19}, Landroid/media/AudioRecord;-><init>(IIIII)V

    sput-object v20, Lorg/libsdl/app/SDLAudioManager;->mAudioRecord:Landroid/media/AudioRecord;

    .line 197
    invoke-virtual/range {v20 .. v20}, Landroid/media/AudioRecord;->getState()I

    move-result v14

    if-eq v14, v1, :cond_9

    .line 198
    const-string v1, "Failed during initialization of AudioRecord"

    invoke-static {v11, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 199
    sget-object v1, Lorg/libsdl/app/SDLAudioManager;->mAudioRecord:Landroid/media/AudioRecord;

    invoke-virtual {v1}, Landroid/media/AudioRecord;->release()V

    .line 200
    sput-object v24, Lorg/libsdl/app/SDLAudioManager;->mAudioRecord:Landroid/media/AudioRecord;

    .line 201
    return-object v24

    .line 204
    :cond_9
    sget-object v14, Lorg/libsdl/app/SDLAudioManager;->mAudioRecord:Landroid/media/AudioRecord;

    invoke-virtual {v14}, Landroid/media/AudioRecord;->startRecording()V

    goto :goto_6

    .line 192
    .end local v25    # "results":[I
    .end local p1    # "desiredChannels":I
    .restart local v1    # "desiredChannels":I
    .restart local v14    # "results":[I
    :cond_a
    move/from16 p1, v1

    move-object/from16 v25, v14

    move v1, v15

    .line 207
    .end local v1    # "desiredChannels":I
    .end local v14    # "results":[I
    .restart local v25    # "results":[I
    .restart local p1    # "desiredChannels":I
    :goto_6
    sget-object v14, Lorg/libsdl/app/SDLAudioManager;->mAudioRecord:Landroid/media/AudioRecord;

    invoke-virtual {v14}, Landroid/media/AudioRecord;->getSampleRate()I

    move-result v14

    aput v14, v25, v23

    .line 208
    sget-object v14, Lorg/libsdl/app/SDLAudioManager;->mAudioRecord:Landroid/media/AudioRecord;

    invoke-virtual {v14}, Landroid/media/AudioRecord;->getAudioFormat()I

    move-result v14

    aput v14, v25, v1

    .line 209
    sget-object v14, Lorg/libsdl/app/SDLAudioManager;->mAudioRecord:Landroid/media/AudioRecord;

    invoke-virtual {v14}, Landroid/media/AudioRecord;->getChannelCount()I

    move-result v14

    const/4 v15, 0x2

    aput v14, v25, v15

    goto :goto_7

    .line 212
    .end local v25    # "results":[I
    .end local p1    # "desiredChannels":I
    .restart local v1    # "desiredChannels":I
    .restart local v14    # "results":[I
    :cond_b
    move/from16 p1, v1

    move-object/from16 v25, v14

    move v1, v15

    .end local v1    # "desiredChannels":I
    .end local v14    # "results":[I
    .restart local v25    # "results":[I
    .restart local p1    # "desiredChannels":I
    sget-object v14, Lorg/libsdl/app/SDLAudioManager;->mAudioTrack:Landroid/media/AudioTrack;

    if-nez v14, :cond_d

    .line 213
    new-instance v26, Landroid/media/AudioTrack;

    const/4 v15, 0x3

    mul-int v19, v2, v21

    const/16 v20, 0x1

    move-object/from16 v14, v26

    move/from16 v16, v0

    move/from16 v17, v3

    move/from16 v18, v13

    invoke-direct/range {v14 .. v20}, Landroid/media/AudioTrack;-><init>(IIIIII)V

    sput-object v26, Lorg/libsdl/app/SDLAudioManager;->mAudioTrack:Landroid/media/AudioTrack;

    .line 218
    invoke-virtual/range {v26 .. v26}, Landroid/media/AudioTrack;->getState()I

    move-result v14

    if-eq v14, v1, :cond_c

    .line 221
    const-string v1, "Failed during initialization of Audio Track"

    invoke-static {v11, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 222
    sget-object v1, Lorg/libsdl/app/SDLAudioManager;->mAudioTrack:Landroid/media/AudioTrack;

    invoke-virtual {v1}, Landroid/media/AudioTrack;->release()V

    .line 223
    sput-object v24, Lorg/libsdl/app/SDLAudioManager;->mAudioTrack:Landroid/media/AudioTrack;

    .line 224
    return-object v24

    .line 227
    :cond_c
    sget-object v14, Lorg/libsdl/app/SDLAudioManager;->mAudioTrack:Landroid/media/AudioTrack;

    invoke-virtual {v14}, Landroid/media/AudioTrack;->play()V

    .line 230
    :cond_d
    sget-object v14, Lorg/libsdl/app/SDLAudioManager;->mAudioTrack:Landroid/media/AudioTrack;

    invoke-virtual {v14}, Landroid/media/AudioTrack;->getSampleRate()I

    move-result v14

    aput v14, v25, v23

    .line 231
    sget-object v14, Lorg/libsdl/app/SDLAudioManager;->mAudioTrack:Landroid/media/AudioTrack;

    invoke-virtual {v14}, Landroid/media/AudioTrack;->getAudioFormat()I

    move-result v14

    aput v14, v25, v1

    .line 232
    sget-object v14, Lorg/libsdl/app/SDLAudioManager;->mAudioTrack:Landroid/media/AudioTrack;

    invoke-virtual {v14}, Landroid/media/AudioTrack;->getChannelCount()I

    move-result v14

    const/4 v15, 0x2

    aput v14, v25, v15

    .line 234
    :goto_7
    const/4 v14, 0x3

    aput v2, v25, v14

    .line 236
    new-instance v15, Ljava/lang/StringBuilder;

    invoke-direct {v15}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v15, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    if-eqz p0, :cond_e

    goto :goto_8

    :cond_e
    move-object v5, v6

    :goto_8
    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, ", got "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    aget v5, v25, v14

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const/4 v5, 0x2

    aget v5, v25, v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    aget v1, v25, v1

    invoke-static {v1}, Lorg/libsdl/app/SDLAudioManager;->getAudioFormatString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    aget v4, v25, v23

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v11, v1}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 238
    return-object v25

    nop

    :pswitch_data_0
    .packed-switch 0x2
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch

    :pswitch_data_1
    .packed-switch 0x1
        :pswitch_4
        :pswitch_3
    .end packed-switch

    :pswitch_data_2
    .packed-switch 0x1
        :pswitch_c
        :pswitch_b
        :pswitch_a
        :pswitch_9
        :pswitch_8
        :pswitch_7
        :pswitch_6
        :pswitch_5
    .end packed-switch
.end method
