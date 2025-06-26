.class Lorg/libsdl/app/SDLClipboardHandler;
.super Ljava/lang/Object;
.source "SDLActivity.java"

# interfaces
.implements Landroid/content/ClipboardManager$OnPrimaryClipChangedListener;


# instance fields
.field protected mClipMgr:Landroid/content/ClipboardManager;


# direct methods
.method constructor <init>()V
    .locals 2

    .line 2067
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 2068
    invoke-static {}, Lorg/libsdl/app/SDL;->getContext()Landroid/content/Context;

    move-result-object v0

    const-string v1, "clipboard"

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/content/ClipboardManager;

    iput-object v0, p0, Lorg/libsdl/app/SDLClipboardHandler;->mClipMgr:Landroid/content/ClipboardManager;

    .line 2069
    invoke-virtual {v0, p0}, Landroid/content/ClipboardManager;->addPrimaryClipChangedListener(Landroid/content/ClipboardManager$OnPrimaryClipChangedListener;)V

    .line 2070
    return-void
.end method


# virtual methods
.method public clipboardGetText()Ljava/lang/String;
    .locals 4

    .line 2077
    iget-object v0, p0, Lorg/libsdl/app/SDLClipboardHandler;->mClipMgr:Landroid/content/ClipboardManager;

    invoke-virtual {v0}, Landroid/content/ClipboardManager;->getPrimaryClip()Landroid/content/ClipData;

    move-result-object v0

    .line 2078
    .local v0, "clip":Landroid/content/ClipData;
    if-eqz v0, :cond_0

    .line 2079
    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/content/ClipData;->getItemAt(I)Landroid/content/ClipData$Item;

    move-result-object v1

    .line 2080
    .local v1, "item":Landroid/content/ClipData$Item;
    if-eqz v1, :cond_0

    .line 2081
    invoke-virtual {v1}, Landroid/content/ClipData$Item;->getText()Ljava/lang/CharSequence;

    move-result-object v2

    .line 2082
    .local v2, "text":Ljava/lang/CharSequence;
    if-eqz v2, :cond_0

    .line 2083
    invoke-interface {v2}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v3

    return-object v3

    .line 2087
    .end local v1    # "item":Landroid/content/ClipData$Item;
    .end local v2    # "text":Ljava/lang/CharSequence;
    :cond_0
    const/4 v1, 0x0

    return-object v1
.end method

.method public clipboardHasText()Z
    .locals 1

    .line 2073
    iget-object v0, p0, Lorg/libsdl/app/SDLClipboardHandler;->mClipMgr:Landroid/content/ClipboardManager;

    invoke-virtual {v0}, Landroid/content/ClipboardManager;->hasPrimaryClip()Z

    move-result v0

    return v0
.end method

.method public clipboardSetText(Ljava/lang/String;)V
    .locals 2
    .param p1, "string"    # Ljava/lang/String;

    .line 2091
    iget-object v0, p0, Lorg/libsdl/app/SDLClipboardHandler;->mClipMgr:Landroid/content/ClipboardManager;

    invoke-virtual {v0, p0}, Landroid/content/ClipboardManager;->removePrimaryClipChangedListener(Landroid/content/ClipboardManager$OnPrimaryClipChangedListener;)V

    .line 2092
    const/4 v0, 0x0

    invoke-static {v0, p1}, Landroid/content/ClipData;->newPlainText(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Landroid/content/ClipData;

    move-result-object v0

    .line 2093
    .local v0, "clip":Landroid/content/ClipData;
    iget-object v1, p0, Lorg/libsdl/app/SDLClipboardHandler;->mClipMgr:Landroid/content/ClipboardManager;

    invoke-virtual {v1, v0}, Landroid/content/ClipboardManager;->setPrimaryClip(Landroid/content/ClipData;)V

    .line 2094
    iget-object v1, p0, Lorg/libsdl/app/SDLClipboardHandler;->mClipMgr:Landroid/content/ClipboardManager;

    invoke-virtual {v1, p0}, Landroid/content/ClipboardManager;->addPrimaryClipChangedListener(Landroid/content/ClipboardManager$OnPrimaryClipChangedListener;)V

    .line 2095
    return-void
.end method

.method public onPrimaryClipChanged()V
    .locals 0

    .line 2099
    invoke-static {}, Lorg/libsdl/app/SDLActivity;->onNativeClipboardChanged()V

    .line 2100
    return-void
.end method
