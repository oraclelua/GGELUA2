.class Lorg/libsdl/app/SDLInputConnection;
.super Landroid/view/inputmethod/BaseInputConnection;
.source "SDLActivity.java"


# instance fields
.field protected mCommittedText:Ljava/lang/String;

.field protected mEditText:Landroid/widget/EditText;


# direct methods
.method public constructor <init>(Landroid/view/View;Z)V
    .locals 2
    .param p1, "targetView"    # Landroid/view/View;
    .param p2, "fullEditor"    # Z

    .line 1953
    invoke-direct {p0, p1, p2}, Landroid/view/inputmethod/BaseInputConnection;-><init>(Landroid/view/View;Z)V

    .line 1950
    const-string v0, ""

    iput-object v0, p0, Lorg/libsdl/app/SDLInputConnection;->mCommittedText:Ljava/lang/String;

    .line 1954
    new-instance v0, Landroid/widget/EditText;

    invoke-static {}, Lorg/libsdl/app/SDL;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/widget/EditText;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lorg/libsdl/app/SDLInputConnection;->mEditText:Landroid/widget/EditText;

    .line 1955
    return-void
.end method

.method public static native nativeCommitText(Ljava/lang/String;I)V
.end method

.method public static native nativeGenerateScancodeForUnichar(C)V
.end method


# virtual methods
.method public commitText(Ljava/lang/CharSequence;I)Z
    .locals 1
    .param p1, "text"    # Ljava/lang/CharSequence;
    .param p2, "newCursorPosition"    # I

    .line 1987
    invoke-super {p0, p1, p2}, Landroid/view/inputmethod/BaseInputConnection;->commitText(Ljava/lang/CharSequence;I)Z

    move-result v0

    if-nez v0, :cond_0

    .line 1988
    const/4 v0, 0x0

    return v0

    .line 1990
    :cond_0
    invoke-virtual {p0}, Lorg/libsdl/app/SDLInputConnection;->updateText()V

    .line 1991
    const/4 v0, 0x1

    return v0
.end method

.method public deleteSurroundingText(II)Z
    .locals 1
    .param p1, "beforeLength"    # I
    .param p2, "afterLength"    # I

    .line 2005
    invoke-super {p0, p1, p2}, Landroid/view/inputmethod/BaseInputConnection;->deleteSurroundingText(II)Z

    move-result v0

    if-nez v0, :cond_0

    .line 2006
    const/4 v0, 0x0

    return v0

    .line 2008
    :cond_0
    invoke-virtual {p0}, Lorg/libsdl/app/SDLInputConnection;->updateText()V

    .line 2009
    const/4 v0, 0x1

    return v0
.end method

.method public getEditable()Landroid/text/Editable;
    .locals 1

    .line 1959
    iget-object v0, p0, Lorg/libsdl/app/SDLInputConnection;->mEditText:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getEditableText()Landroid/text/Editable;

    move-result-object v0

    return-object v0
.end method

.method public sendKeyEvent(Landroid/view/KeyEvent;)Z
    .locals 2
    .param p1, "event"    # Landroid/view/KeyEvent;

    .line 1976
    invoke-virtual {p1}, Landroid/view/KeyEvent;->getKeyCode()I

    move-result v0

    const/16 v1, 0x42

    if-ne v0, v1, :cond_0

    .line 1977
    invoke-static {}, Lorg/libsdl/app/SDLActivity;->onNativeSoftReturnKey()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 1978
    const/4 v0, 0x1

    return v0

    .line 1982
    :cond_0
    invoke-super {p0, p1}, Landroid/view/inputmethod/BaseInputConnection;->sendKeyEvent(Landroid/view/KeyEvent;)Z

    move-result v0

    return v0
.end method

.method public setComposingText(Ljava/lang/CharSequence;I)Z
    .locals 1
    .param p1, "text"    # Ljava/lang/CharSequence;
    .param p2, "newCursorPosition"    # I

    .line 1996
    invoke-super {p0, p1, p2}, Landroid/view/inputmethod/BaseInputConnection;->setComposingText(Ljava/lang/CharSequence;I)Z

    move-result v0

    if-nez v0, :cond_0

    .line 1997
    const/4 v0, 0x0

    return v0

    .line 1999
    :cond_0
    invoke-virtual {p0}, Lorg/libsdl/app/SDLInputConnection;->updateText()V

    .line 2000
    const/4 v0, 0x1

    return v0
.end method

.method protected updateText()V
    .locals 8

    .line 2013
    invoke-virtual {p0}, Lorg/libsdl/app/SDLInputConnection;->getEditable()Landroid/text/Editable;

    move-result-object v0

    .line 2014
    .local v0, "content":Landroid/text/Editable;
    if-nez v0, :cond_0

    .line 2015
    return-void

    .line 2018
    :cond_0
    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v1

    .line 2019
    .local v1, "text":Ljava/lang/String;
    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v2

    iget-object v3, p0, Lorg/libsdl/app/SDLInputConnection;->mCommittedText:Ljava/lang/String;

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v3

    invoke-static {v2, v3}, Ljava/lang/Math;->min(II)I

    move-result v2

    .line 2023
    .local v2, "compareLength":I
    const/4 v3, 0x0

    .local v3, "matchLength":I
    :goto_0
    if-ge v3, v2, :cond_2

    .line 2024
    iget-object v4, p0, Lorg/libsdl/app/SDLInputConnection;->mCommittedText:Ljava/lang/String;

    invoke-virtual {v4, v3}, Ljava/lang/String;->codePointAt(I)I

    move-result v4

    .line 2025
    .local v4, "codePoint":I
    invoke-virtual {v1, v3}, Ljava/lang/String;->codePointAt(I)I

    move-result v5

    if-eq v4, v5, :cond_1

    .line 2026
    goto :goto_1

    .line 2028
    :cond_1
    invoke-static {v4}, Ljava/lang/Character;->charCount(I)I

    move-result v5

    add-int/2addr v3, v5

    .line 2029
    .end local v4    # "codePoint":I
    goto :goto_0

    .line 2031
    :cond_2
    :goto_1
    move v4, v3

    .local v4, "offset":I
    :goto_2
    iget-object v5, p0, Lorg/libsdl/app/SDLInputConnection;->mCommittedText:Ljava/lang/String;

    invoke-virtual {v5}, Ljava/lang/String;->length()I

    move-result v5

    if-ge v4, v5, :cond_3

    .line 2032
    iget-object v5, p0, Lorg/libsdl/app/SDLInputConnection;->mCommittedText:Ljava/lang/String;

    invoke-virtual {v5, v4}, Ljava/lang/String;->codePointAt(I)I

    move-result v5

    .line 2033
    .local v5, "codePoint":I
    const/16 v6, 0x8

    invoke-static {v6}, Lorg/libsdl/app/SDLInputConnection;->nativeGenerateScancodeForUnichar(C)V

    .line 2034
    invoke-static {v5}, Ljava/lang/Character;->charCount(I)I

    move-result v6

    add-int/2addr v4, v6

    .line 2035
    .end local v5    # "codePoint":I
    goto :goto_2

    .line 2037
    :cond_3
    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v5

    if-ge v3, v5, :cond_7

    .line 2038
    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v5

    invoke-virtual {v1, v3, v5}, Ljava/lang/String;->subSequence(II)Ljava/lang/CharSequence;

    move-result-object v5

    invoke-interface {v5}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v5

    .line 2039
    .local v5, "pendingText":Ljava/lang/String;
    const/4 v4, 0x0

    :goto_3
    invoke-virtual {v5}, Ljava/lang/String;->length()I

    move-result v6

    if-ge v4, v6, :cond_6

    .line 2040
    invoke-virtual {v5, v4}, Ljava/lang/String;->codePointAt(I)I

    move-result v6

    .line 2041
    .local v6, "codePoint":I
    const/16 v7, 0xa

    if-ne v6, v7, :cond_4

    .line 2042
    invoke-static {}, Lorg/libsdl/app/SDLActivity;->onNativeSoftReturnKey()Z

    move-result v7

    if-eqz v7, :cond_4

    .line 2043
    return-void

    .line 2047
    :cond_4
    const/16 v7, 0x80

    if-ge v6, v7, :cond_5

    .line 2048
    int-to-char v7, v6

    invoke-static {v7}, Lorg/libsdl/app/SDLInputConnection;->nativeGenerateScancodeForUnichar(C)V

    .line 2050
    :cond_5
    invoke-static {v6}, Ljava/lang/Character;->charCount(I)I

    move-result v7

    add-int/2addr v4, v7

    .line 2051
    .end local v6    # "codePoint":I
    goto :goto_3

    .line 2052
    :cond_6
    const/4 v6, 0x0

    invoke-static {v5, v6}, Lorg/libsdl/app/SDLInputConnection;->nativeCommitText(Ljava/lang/String;I)V

    .line 2054
    .end local v5    # "pendingText":Ljava/lang/String;
    :cond_7
    iput-object v1, p0, Lorg/libsdl/app/SDLInputConnection;->mCommittedText:Ljava/lang/String;

    .line 2055
    return-void
.end method
