.class public Lorg/libsdl/app/SDLActivity$SDLCommandHandler;
.super Landroid/os/Handler;
.source "SDLActivity.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lorg/libsdl/app/SDLActivity;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xc
    name = "SDLCommandHandler"
.end annotation


# direct methods
.method protected constructor <init>()V
    .locals 0

    .line 752
    invoke-direct {p0}, Landroid/os/Handler;-><init>()V

    return-void
.end method


# virtual methods
.method public handleMessage(Landroid/os/Message;)V
    .locals 7
    .param p1, "msg"    # Landroid/os/Message;

    .line 755
    invoke-static {}, Lorg/libsdl/app/SDL;->getContext()Landroid/content/Context;

    move-result-object v0

    .line 756
    .local v0, "context":Landroid/content/Context;
    const-string v1, "SDL"

    if-nez v0, :cond_0

    .line 757
    const-string v2, "error handling message, getContext() returned null"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 758
    return-void

    .line 760
    :cond_0
    iget v2, p1, Landroid/os/Message;->arg1:I

    const-string v3, "error handling message, getContext() returned no Activity"

    const/4 v4, 0x0

    packed-switch v2, :pswitch_data_0

    .line 827
    :pswitch_0
    instance-of v2, v0, Lorg/libsdl/app/SDLActivity;

    if-eqz v2, :cond_7

    move-object v2, v0

    check-cast v2, Lorg/libsdl/app/SDLActivity;

    iget v3, p1, Landroid/os/Message;->arg1:I

    iget-object v4, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    invoke-virtual {v2, v3, v4}, Lorg/libsdl/app/SDLActivity;->onUnhandledMessage(ILjava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_7

    .line 828
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "error handling message, command is "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget v3, p1, Landroid/os/Message;->arg1:I

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_2

    .line 814
    :pswitch_1
    instance-of v1, v0, Landroid/app/Activity;

    if-eqz v1, :cond_7

    .line 815
    move-object v1, v0

    check-cast v1, Landroid/app/Activity;

    invoke-virtual {v1}, Landroid/app/Activity;->getWindow()Landroid/view/Window;

    move-result-object v1

    .line 816
    .local v1, "window":Landroid/view/Window;
    if-eqz v1, :cond_2

    .line 817
    iget-object v2, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    instance-of v2, v2, Ljava/lang/Integer;

    const/16 v3, 0x80

    if-eqz v2, :cond_1

    iget-object v2, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v2, Ljava/lang/Integer;

    invoke-virtual {v2}, Ljava/lang/Integer;->intValue()I

    move-result v2

    if-eqz v2, :cond_1

    .line 818
    invoke-virtual {v1, v3}, Landroid/view/Window;->addFlags(I)V

    goto :goto_0

    .line 820
    :cond_1
    invoke-virtual {v1, v3}, Landroid/view/Window;->clearFlags(I)V

    .line 823
    .end local v1    # "window":Landroid/view/Window;
    :cond_2
    :goto_0
    goto/16 :goto_2

    .line 798
    :pswitch_2
    sget-object v1, Lorg/libsdl/app/SDLActivity;->mTextEdit:Lorg/libsdl/app/DummyEdit;

    if-eqz v1, :cond_7

    .line 802
    sget-object v1, Lorg/libsdl/app/SDLActivity;->mTextEdit:Lorg/libsdl/app/DummyEdit;

    new-instance v2, Landroid/widget/RelativeLayout$LayoutParams;

    invoke-direct {v2, v4, v4}, Landroid/widget/RelativeLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v1, v2}, Lorg/libsdl/app/DummyEdit;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 804
    const-string v1, "input_method"

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/view/inputmethod/InputMethodManager;

    .line 805
    .local v1, "imm":Landroid/view/inputmethod/InputMethodManager;
    sget-object v2, Lorg/libsdl/app/SDLActivity;->mTextEdit:Lorg/libsdl/app/DummyEdit;

    invoke-virtual {v2}, Lorg/libsdl/app/DummyEdit;->getWindowToken()Landroid/os/IBinder;

    move-result-object v2

    invoke-virtual {v1, v2, v4}, Landroid/view/inputmethod/InputMethodManager;->hideSoftInputFromWindow(Landroid/os/IBinder;I)Z

    .line 807
    sput-boolean v4, Lorg/libsdl/app/SDLActivity;->mScreenKeyboardShown:Z

    .line 809
    sget-object v2, Lorg/libsdl/app/SDLActivity;->mSurface:Lorg/libsdl/app/SDLSurface;

    invoke-virtual {v2}, Lorg/libsdl/app/SDLSurface;->requestFocus()Z

    .line 810
    .end local v1    # "imm":Landroid/view/inputmethod/InputMethodManager;
    goto :goto_2

    .line 769
    :pswitch_3
    sget v2, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v5, 0x13

    if-lt v2, v5, :cond_7

    .line 770
    instance-of v2, v0, Landroid/app/Activity;

    if-eqz v2, :cond_5

    .line 771
    move-object v1, v0

    check-cast v1, Landroid/app/Activity;

    invoke-virtual {v1}, Landroid/app/Activity;->getWindow()Landroid/view/Window;

    move-result-object v1

    .line 772
    .local v1, "window":Landroid/view/Window;
    if-eqz v1, :cond_4

    .line 773
    iget-object v2, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    instance-of v2, v2, Ljava/lang/Integer;

    const/16 v3, 0x400

    const/16 v5, 0x800

    if-eqz v2, :cond_3

    iget-object v2, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v2, Ljava/lang/Integer;

    invoke-virtual {v2}, Ljava/lang/Integer;->intValue()I

    move-result v2

    if-eqz v2, :cond_3

    .line 774
    const/16 v2, 0x1706

    .line 780
    .local v2, "flags":I
    invoke-virtual {v1}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object v4

    invoke-virtual {v4, v2}, Landroid/view/View;->setSystemUiVisibility(I)V

    .line 781
    invoke-virtual {v1, v3}, Landroid/view/Window;->addFlags(I)V

    .line 782
    invoke-virtual {v1, v5}, Landroid/view/Window;->clearFlags(I)V

    .line 783
    const/4 v3, 0x1

    sput-boolean v3, Lorg/libsdl/app/SDLActivity;->mFullscreenModeActive:Z

    .line 784
    .end local v2    # "flags":I
    goto :goto_1

    .line 785
    :cond_3
    const/16 v2, 0x100

    .line 786
    .restart local v2    # "flags":I
    invoke-virtual {v1}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object v6

    invoke-virtual {v6, v2}, Landroid/view/View;->setSystemUiVisibility(I)V

    .line 787
    invoke-virtual {v1, v5}, Landroid/view/Window;->addFlags(I)V

    .line 788
    invoke-virtual {v1, v3}, Landroid/view/Window;->clearFlags(I)V

    .line 789
    sput-boolean v4, Lorg/libsdl/app/SDLActivity;->mFullscreenModeActive:Z

    .line 792
    .end local v1    # "window":Landroid/view/Window;
    .end local v2    # "flags":I
    :cond_4
    :goto_1
    goto :goto_2

    .line 793
    :cond_5
    invoke-static {v1, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_2

    .line 762
    :pswitch_4
    instance-of v2, v0, Landroid/app/Activity;

    if-eqz v2, :cond_6

    .line 763
    move-object v1, v0

    check-cast v1, Landroid/app/Activity;

    iget-object v2, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v2, Ljava/lang/String;

    invoke-virtual {v1, v2}, Landroid/app/Activity;->setTitle(Ljava/lang/CharSequence;)V

    goto :goto_2

    .line 765
    :cond_6
    invoke-static {v1, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 831
    :cond_7
    :goto_2
    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_0
        :pswitch_1
    .end packed-switch
.end method
