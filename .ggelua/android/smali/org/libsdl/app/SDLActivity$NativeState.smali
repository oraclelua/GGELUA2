.class public final enum Lorg/libsdl/app/SDLActivity$NativeState;
.super Ljava/lang/Enum;
.source "SDLActivity.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lorg/libsdl/app/SDLActivity;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x4019
    name = "NativeState"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lorg/libsdl/app/SDLActivity$NativeState;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lorg/libsdl/app/SDLActivity$NativeState;

.field public static final enum INIT:Lorg/libsdl/app/SDLActivity$NativeState;

.field public static final enum PAUSED:Lorg/libsdl/app/SDLActivity$NativeState;

.field public static final enum RESUMED:Lorg/libsdl/app/SDLActivity$NativeState;


# direct methods
.method static constructor <clinit>()V
    .locals 7

    .line 201
    new-instance v0, Lorg/libsdl/app/SDLActivity$NativeState;

    const-string v1, "INIT"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Lorg/libsdl/app/SDLActivity$NativeState;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lorg/libsdl/app/SDLActivity$NativeState;->INIT:Lorg/libsdl/app/SDLActivity$NativeState;

    new-instance v1, Lorg/libsdl/app/SDLActivity$NativeState;

    const-string v3, "RESUMED"

    const/4 v4, 0x1

    invoke-direct {v1, v3, v4}, Lorg/libsdl/app/SDLActivity$NativeState;-><init>(Ljava/lang/String;I)V

    sput-object v1, Lorg/libsdl/app/SDLActivity$NativeState;->RESUMED:Lorg/libsdl/app/SDLActivity$NativeState;

    new-instance v3, Lorg/libsdl/app/SDLActivity$NativeState;

    const-string v5, "PAUSED"

    const/4 v6, 0x2

    invoke-direct {v3, v5, v6}, Lorg/libsdl/app/SDLActivity$NativeState;-><init>(Ljava/lang/String;I)V

    sput-object v3, Lorg/libsdl/app/SDLActivity$NativeState;->PAUSED:Lorg/libsdl/app/SDLActivity$NativeState;

    .line 200
    const/4 v5, 0x3

    new-array v5, v5, [Lorg/libsdl/app/SDLActivity$NativeState;

    aput-object v0, v5, v2

    aput-object v1, v5, v4

    aput-object v3, v5, v6

    sput-object v5, Lorg/libsdl/app/SDLActivity$NativeState;->$VALUES:[Lorg/libsdl/app/SDLActivity$NativeState;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 200
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lorg/libsdl/app/SDLActivity$NativeState;
    .locals 1
    .param p0, "name"    # Ljava/lang/String;

    .line 200
    const-class v0, Lorg/libsdl/app/SDLActivity$NativeState;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object v0

    check-cast v0, Lorg/libsdl/app/SDLActivity$NativeState;

    return-object v0
.end method

.method public static values()[Lorg/libsdl/app/SDLActivity$NativeState;
    .locals 1

    .line 200
    sget-object v0, Lorg/libsdl/app/SDLActivity$NativeState;->$VALUES:[Lorg/libsdl/app/SDLActivity$NativeState;

    invoke-virtual {v0}, [Lorg/libsdl/app/SDLActivity$NativeState;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lorg/libsdl/app/SDLActivity$NativeState;

    return-object v0
.end method
