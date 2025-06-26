.class Lorg/libsdl/app/SDLGenericMotionListener_API26;
.super Lorg/libsdl/app/SDLGenericMotionListener_API24;
.source "SDLControllerManager.java"


# instance fields
.field private mRelativeModeEnabled:Z


# direct methods
.method constructor <init>()V
    .locals 0

    .line 681
    invoke-direct {p0}, Lorg/libsdl/app/SDLGenericMotionListener_API24;-><init>()V

    return-void
.end method


# virtual methods
.method public getEventX(Landroid/view/MotionEvent;)F
    .locals 1
    .param p1, "event"    # Landroid/view/MotionEvent;

    .line 780
    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Landroid/view/MotionEvent;->getX(I)F

    move-result v0

    return v0
.end method

.method public getEventY(Landroid/view/MotionEvent;)F
    .locals 1
    .param p1, "event"    # Landroid/view/MotionEvent;

    .line 786
    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Landroid/view/MotionEvent;->getY(I)F

    move-result v0

    return v0
.end method

.method public inRelativeMode()Z
    .locals 1

    .line 751
    iget-boolean v0, p0, Lorg/libsdl/app/SDLGenericMotionListener_API26;->mRelativeModeEnabled:Z

    return v0
.end method

.method public onGenericMotion(Landroid/view/View;Landroid/view/MotionEvent;)Z
    .locals 5
    .param p1, "v"    # Landroid/view/View;
    .param p2, "event"    # Landroid/view/MotionEvent;

    .line 690
    invoke-virtual {p2}, Landroid/view/MotionEvent;->getSource()I

    move-result v0

    const/16 v1, 0x9

    const/16 v2, 0xa

    const/4 v3, 0x1

    const/4 v4, 0x0

    sparse-switch v0, :sswitch_data_0

    goto :goto_0

    .line 692
    :sswitch_0
    invoke-static {p2}, Lorg/libsdl/app/SDLControllerManager;->handleJoystickMotionEvent(Landroid/view/MotionEvent;)Z

    move-result v0

    return v0

    .line 717
    :sswitch_1
    invoke-virtual {p2}, Landroid/view/MotionEvent;->getActionMasked()I

    move-result v0

    .line 718
    .local v0, "action":I
    packed-switch v0, :pswitch_data_0

    .line 732
    goto :goto_0

    .line 720
    :pswitch_0
    invoke-virtual {p2, v2, v4}, Landroid/view/MotionEvent;->getAxisValue(II)F

    move-result v2

    .line 721
    .local v2, "x":F
    invoke-virtual {p2, v1, v4}, Landroid/view/MotionEvent;->getAxisValue(II)F

    move-result v1

    .line 722
    .local v1, "y":F
    invoke-static {v4, v0, v2, v1, v4}, Lorg/libsdl/app/SDLActivity;->onNativeMouse(IIFFZ)V

    .line 723
    return v3

    .line 726
    .end local v1    # "y":F
    .end local v2    # "x":F
    :pswitch_1
    invoke-virtual {p2, v4}, Landroid/view/MotionEvent;->getX(I)F

    move-result v1

    .line 727
    .local v1, "x":F
    invoke-virtual {p2, v4}, Landroid/view/MotionEvent;->getY(I)F

    move-result v2

    .line 728
    .local v2, "y":F
    invoke-static {v4, v0, v1, v2, v3}, Lorg/libsdl/app/SDLActivity;->onNativeMouse(IIFFZ)V

    .line 729
    return v3

    .line 697
    .end local v0    # "action":I
    .end local v1    # "x":F
    .end local v2    # "y":F
    :sswitch_2
    invoke-virtual {p2}, Landroid/view/MotionEvent;->getActionMasked()I

    move-result v0

    .line 698
    .restart local v0    # "action":I
    packed-switch v0, :pswitch_data_1

    .line 712
    goto :goto_0

    .line 700
    :pswitch_2
    invoke-virtual {p2, v2, v4}, Landroid/view/MotionEvent;->getAxisValue(II)F

    move-result v2

    .line 701
    .local v2, "x":F
    invoke-virtual {p2, v1, v4}, Landroid/view/MotionEvent;->getAxisValue(II)F

    move-result v1

    .line 702
    .local v1, "y":F
    invoke-static {v4, v0, v2, v1, v4}, Lorg/libsdl/app/SDLActivity;->onNativeMouse(IIFFZ)V

    .line 703
    return v3

    .line 706
    .end local v1    # "y":F
    .end local v2    # "x":F
    :pswitch_3
    invoke-virtual {p2, v4}, Landroid/view/MotionEvent;->getX(I)F

    move-result v1

    .line 707
    .local v1, "x":F
    invoke-virtual {p2, v4}, Landroid/view/MotionEvent;->getY(I)F

    move-result v2

    .line 708
    .local v2, "y":F
    invoke-static {v4, v0, v1, v2, v4}, Lorg/libsdl/app/SDLActivity;->onNativeMouse(IIFFZ)V

    .line 709
    return v3

    .line 741
    .end local v0    # "action":I
    .end local v1    # "x":F
    .end local v2    # "y":F
    :goto_0
    return v4

    :sswitch_data_0
    .sparse-switch
        0x2002 -> :sswitch_2
        0x3002 -> :sswitch_2
        0x20004 -> :sswitch_1
        0x1000010 -> :sswitch_0
    .end sparse-switch

    :pswitch_data_0
    .packed-switch 0x7
        :pswitch_1
        :pswitch_0
    .end packed-switch

    :pswitch_data_1
    .packed-switch 0x7
        :pswitch_3
        :pswitch_2
    .end packed-switch
.end method

.method public reclaimRelativeMouseModeIfNeeded()V
    .locals 1

    .line 772
    iget-boolean v0, p0, Lorg/libsdl/app/SDLGenericMotionListener_API26;->mRelativeModeEnabled:Z

    if-eqz v0, :cond_0

    invoke-static {}, Lorg/libsdl/app/SDLActivity;->isDeXMode()Z

    move-result v0

    if-nez v0, :cond_0

    .line 773
    invoke-static {}, Lorg/libsdl/app/SDLActivity;->getContentView()Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/View;->requestPointerCapture()V

    .line 775
    :cond_0
    return-void
.end method

.method public setRelativeMouseEnabled(Z)Z
    .locals 2
    .param p1, "enabled"    # Z

    .line 756
    invoke-static {}, Lorg/libsdl/app/SDLActivity;->isDeXMode()Z

    move-result v0

    if-eqz v0, :cond_1

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1b

    if-lt v0, v1, :cond_0

    goto :goto_0

    .line 765
    :cond_0
    const/4 v0, 0x0

    return v0

    .line 757
    :cond_1
    :goto_0
    if-eqz p1, :cond_2

    .line 758
    invoke-static {}, Lorg/libsdl/app/SDLActivity;->getContentView()Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/View;->requestPointerCapture()V

    goto :goto_1

    .line 760
    :cond_2
    invoke-static {}, Lorg/libsdl/app/SDLActivity;->getContentView()Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/View;->releasePointerCapture()V

    .line 762
    :goto_1
    iput-boolean p1, p0, Lorg/libsdl/app/SDLGenericMotionListener_API26;->mRelativeModeEnabled:Z

    .line 763
    const/4 v0, 0x1

    return v0
.end method

.method public supportsRelativeMouse()Z
    .locals 2

    .line 746
    invoke-static {}, Lorg/libsdl/app/SDLActivity;->isDeXMode()Z

    move-result v0

    if-eqz v0, :cond_1

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1b

    if-lt v0, v1, :cond_0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    goto :goto_1

    :cond_1
    :goto_0
    const/4 v0, 0x1

    :goto_1
    return v0
.end method
