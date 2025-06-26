.class Lorg/libsdl/app/SDLGenericMotionListener_API12;
.super Ljava/lang/Object;
.source "SDLControllerManager.java"

# interfaces
.implements Landroid/view/View$OnGenericMotionListener;


# direct methods
.method constructor <init>()V
    .locals 0

    .line 554
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public getEventX(Landroid/view/MotionEvent;)F
    .locals 1
    .param p1, "event"    # Landroid/view/MotionEvent;

    .line 612
    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Landroid/view/MotionEvent;->getX(I)F

    move-result v0

    return v0
.end method

.method public getEventY(Landroid/view/MotionEvent;)F
    .locals 1
    .param p1, "event"    # Landroid/view/MotionEvent;

    .line 616
    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Landroid/view/MotionEvent;->getY(I)F

    move-result v0

    return v0
.end method

.method public inRelativeMode()Z
    .locals 1

    .line 599
    const/4 v0, 0x0

    return v0
.end method

.method public onGenericMotion(Landroid/view/View;Landroid/view/MotionEvent;)Z
    .locals 5
    .param p1, "v"    # Landroid/view/View;
    .param p2, "event"    # Landroid/view/MotionEvent;

    .line 561
    invoke-virtual {p2}, Landroid/view/MotionEvent;->getSource()I

    move-result v0

    const/4 v1, 0x0

    sparse-switch v0, :sswitch_data_0

    goto :goto_0

    .line 563
    :sswitch_0
    invoke-static {p2}, Lorg/libsdl/app/SDLControllerManager;->handleJoystickMotionEvent(Landroid/view/MotionEvent;)Z

    move-result v0

    return v0

    .line 566
    :sswitch_1
    invoke-virtual {p2}, Landroid/view/MotionEvent;->getActionMasked()I

    move-result v0

    .line 567
    .local v0, "action":I
    const/4 v2, 0x1

    packed-switch v0, :pswitch_data_0

    .line 582
    goto :goto_0

    .line 569
    :pswitch_0
    const/16 v3, 0xa

    invoke-virtual {p2, v3, v1}, Landroid/view/MotionEvent;->getAxisValue(II)F

    move-result v3

    .line 570
    .local v3, "x":F
    const/16 v4, 0x9

    invoke-virtual {p2, v4, v1}, Landroid/view/MotionEvent;->getAxisValue(II)F

    move-result v4

    .line 571
    .local v4, "y":F
    invoke-static {v1, v0, v3, v4, v1}, Lorg/libsdl/app/SDLActivity;->onNativeMouse(IIFFZ)V

    .line 572
    return v2

    .line 575
    .end local v3    # "x":F
    .end local v4    # "y":F
    :pswitch_1
    invoke-virtual {p2, v1}, Landroid/view/MotionEvent;->getX(I)F

    move-result v3

    .line 576
    .restart local v3    # "x":F
    invoke-virtual {p2, v1}, Landroid/view/MotionEvent;->getY(I)F

    move-result v4

    .line 578
    .restart local v4    # "y":F
    invoke-static {v1, v0, v3, v4, v1}, Lorg/libsdl/app/SDLActivity;->onNativeMouse(IIFFZ)V

    .line 579
    return v2

    .line 591
    .end local v0    # "action":I
    .end local v3    # "x":F
    .end local v4    # "y":F
    :goto_0
    return v1

    :sswitch_data_0
    .sparse-switch
        0x2002 -> :sswitch_1
        0x1000010 -> :sswitch_0
    .end sparse-switch

    :pswitch_data_0
    .packed-switch 0x7
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public reclaimRelativeMouseModeIfNeeded()V
    .locals 0

    .line 609
    return-void
.end method

.method public setRelativeMouseEnabled(Z)Z
    .locals 1
    .param p1, "enabled"    # Z

    .line 603
    const/4 v0, 0x0

    return v0
.end method

.method public supportsRelativeMouse()Z
    .locals 1

    .line 595
    const/4 v0, 0x0

    return v0
.end method
