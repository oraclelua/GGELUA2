.class Lorg/libsdl/app/SDLActivity$ShowTextInputTask;
.super Ljava/lang/Object;
.source "SDLActivity.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lorg/libsdl/app/SDLActivity;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = "ShowTextInputTask"
.end annotation


# static fields
.field static final HEIGHT_PADDING:I = 0xf


# instance fields
.field public h:I

.field public w:I

.field public x:I

.field public y:I


# direct methods
.method public constructor <init>(IIII)V
    .locals 1
    .param p1, "x"    # I
    .param p2, "y"    # I
    .param p3, "w"    # I
    .param p4, "h"    # I

    .line 1249
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 1250
    iput p1, p0, Lorg/libsdl/app/SDLActivity$ShowTextInputTask;->x:I

    .line 1251
    iput p2, p0, Lorg/libsdl/app/SDLActivity$ShowTextInputTask;->y:I

    .line 1252
    iput p3, p0, Lorg/libsdl/app/SDLActivity$ShowTextInputTask;->w:I

    .line 1253
    iput p4, p0, Lorg/libsdl/app/SDLActivity$ShowTextInputTask;->h:I

    .line 1256
    if-gtz p3, :cond_0

    .line 1257
    const/4 v0, 0x1

    iput v0, p0, Lorg/libsdl/app/SDLActivity$ShowTextInputTask;->w:I

    .line 1259
    :cond_0
    add-int/lit8 v0, p4, 0xf

    if-gtz v0, :cond_1

    .line 1260
    const/16 v0, -0xe

    iput v0, p0, Lorg/libsdl/app/SDLActivity$ShowTextInputTask;->h:I

    .line 1262
    :cond_1
    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    .line 1266
    new-instance v0, Landroid/widget/RelativeLayout$LayoutParams;

    iget v1, p0, Lorg/libsdl/app/SDLActivity$ShowTextInputTask;->w:I

    iget v2, p0, Lorg/libsdl/app/SDLActivity$ShowTextInputTask;->h:I

    add-int/lit8 v2, v2, 0xf

    invoke-direct {v0, v1, v2}, Landroid/widget/RelativeLayout$LayoutParams;-><init>(II)V

    .line 1267
    .local v0, "params":Landroid/widget/RelativeLayout$LayoutParams;
    iget v1, p0, Lorg/libsdl/app/SDLActivity$ShowTextInputTask;->x:I

    iput v1, v0, Landroid/widget/RelativeLayout$LayoutParams;->leftMargin:I

    .line 1268
    iget v1, p0, Lorg/libsdl/app/SDLActivity$ShowTextInputTask;->y:I

    iput v1, v0, Landroid/widget/RelativeLayout$LayoutParams;->topMargin:I

    .line 1270
    sget-object v1, Lorg/libsdl/app/SDLActivity;->mTextEdit:Lorg/libsdl/app/DummyEdit;

    if-nez v1, :cond_0

    .line 1271
    new-instance v1, Lorg/libsdl/app/DummyEdit;

    invoke-static {}, Lorg/libsdl/app/SDL;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-direct {v1, v2}, Lorg/libsdl/app/DummyEdit;-><init>(Landroid/content/Context;)V

    sput-object v1, Lorg/libsdl/app/SDLActivity;->mTextEdit:Lorg/libsdl/app/DummyEdit;

    .line 1273
    sget-object v1, Lorg/libsdl/app/SDLActivity;->mLayout:Landroid/view/ViewGroup;

    sget-object v2, Lorg/libsdl/app/SDLActivity;->mTextEdit:Lorg/libsdl/app/DummyEdit;

    invoke-virtual {v1, v2, v0}, Landroid/view/ViewGroup;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    goto :goto_0

    .line 1275
    :cond_0
    sget-object v1, Lorg/libsdl/app/SDLActivity;->mTextEdit:Lorg/libsdl/app/DummyEdit;

    invoke-virtual {v1, v0}, Lorg/libsdl/app/DummyEdit;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 1278
    :goto_0
    sget-object v1, Lorg/libsdl/app/SDLActivity;->mTextEdit:Lorg/libsdl/app/DummyEdit;

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Lorg/libsdl/app/DummyEdit;->setVisibility(I)V

    .line 1279
    sget-object v1, Lorg/libsdl/app/SDLActivity;->mTextEdit:Lorg/libsdl/app/DummyEdit;

    invoke-virtual {v1}, Lorg/libsdl/app/DummyEdit;->requestFocus()Z

    .line 1281
    invoke-static {}, Lorg/libsdl/app/SDL;->getContext()Landroid/content/Context;

    move-result-object v1

    const-string v3, "input_method"

    invoke-virtual {v1, v3}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/view/inputmethod/InputMethodManager;

    .line 1282
    .local v1, "imm":Landroid/view/inputmethod/InputMethodManager;
    sget-object v3, Lorg/libsdl/app/SDLActivity;->mTextEdit:Lorg/libsdl/app/DummyEdit;

    invoke-virtual {v1, v3, v2}, Landroid/view/inputmethod/InputMethodManager;->showSoftInput(Landroid/view/View;I)Z

    .line 1284
    const/4 v2, 0x1

    sput-boolean v2, Lorg/libsdl/app/SDLActivity;->mScreenKeyboardShown:Z

    .line 1285
    return-void
.end method
