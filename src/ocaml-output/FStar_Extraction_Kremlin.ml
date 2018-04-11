open Prims
type decl =
  | DGlobal of
  (flag Prims.list,(Prims.string Prims.list,Prims.string)
                     FStar_Pervasives_Native.tuple2,Prims.int,typ,expr)
  FStar_Pervasives_Native.tuple5 
  | DFunction of
  (cc FStar_Pervasives_Native.option,flag Prims.list,Prims.int,typ,(Prims.string
                                                                    Prims.list,
                                                                    Prims.string)
                                                                    FStar_Pervasives_Native.tuple2,
  binder Prims.list,expr) FStar_Pervasives_Native.tuple7 
  | DTypeAlias of
  ((Prims.string Prims.list,Prims.string) FStar_Pervasives_Native.tuple2,
  flag Prims.list,Prims.int,typ) FStar_Pervasives_Native.tuple4 
  | DTypeFlat of
  ((Prims.string Prims.list,Prims.string) FStar_Pervasives_Native.tuple2,
  flag Prims.list,Prims.int,(Prims.string,(typ,Prims.bool)
                                            FStar_Pervasives_Native.tuple2)
                              FStar_Pervasives_Native.tuple2 Prims.list)
  FStar_Pervasives_Native.tuple4 
  | DExternal of
  (cc FStar_Pervasives_Native.option,flag Prims.list,(Prims.string Prims.list,
                                                       Prims.string)
                                                       FStar_Pervasives_Native.tuple2,
  typ) FStar_Pervasives_Native.tuple4 
  | DTypeVariant of
  ((Prims.string Prims.list,Prims.string) FStar_Pervasives_Native.tuple2,
  flag Prims.list,Prims.int,(Prims.string,(Prims.string,(typ,Prims.bool)
                                                          FStar_Pervasives_Native.tuple2)
                                            FStar_Pervasives_Native.tuple2
                                            Prims.list)
                              FStar_Pervasives_Native.tuple2 Prims.list)
  FStar_Pervasives_Native.tuple4 [@@deriving show]
and cc =
  | StdCall 
  | CDecl 
  | FastCall [@@deriving show]
and flag =
  | Private 
  | WipeBody 
  | CInline 
  | Substitute 
  | GCType 
  | Comment of Prims.string 
  | MustDisappear 
  | Const of Prims.string 
  | Prologue of Prims.string 
  | Epilogue of Prims.string [@@deriving show]
and lifetime =
  | Eternal 
  | Stack 
  | ManuallyManaged [@@deriving show]
and expr =
  | EBound of Prims.int 
  | EQualified of (Prims.string Prims.list,Prims.string)
  FStar_Pervasives_Native.tuple2 
  | EConstant of (width,Prims.string) FStar_Pervasives_Native.tuple2 
  | EUnit 
  | EApp of (expr,expr Prims.list) FStar_Pervasives_Native.tuple2 
  | ETypApp of (expr,typ Prims.list) FStar_Pervasives_Native.tuple2 
  | ELet of (binder,expr,expr) FStar_Pervasives_Native.tuple3 
  | EIfThenElse of (expr,expr,expr) FStar_Pervasives_Native.tuple3 
  | ESequence of expr Prims.list 
  | EAssign of (expr,expr) FStar_Pervasives_Native.tuple2 
  | EBufCreate of (lifetime,expr,expr) FStar_Pervasives_Native.tuple3 
  | EBufRead of (expr,expr) FStar_Pervasives_Native.tuple2 
  | EBufWrite of (expr,expr,expr) FStar_Pervasives_Native.tuple3 
  | EBufSub of (expr,expr) FStar_Pervasives_Native.tuple2 
  | EBufBlit of (expr,expr,expr,expr,expr) FStar_Pervasives_Native.tuple5 
  | EMatch of (expr,(pattern,expr) FStar_Pervasives_Native.tuple2 Prims.list)
  FStar_Pervasives_Native.tuple2 
  | EOp of (op,width) FStar_Pervasives_Native.tuple2 
  | ECast of (expr,typ) FStar_Pervasives_Native.tuple2 
  | EPushFrame 
  | EPopFrame 
  | EBool of Prims.bool 
  | EAny 
  | EAbort 
  | EReturn of expr 
  | EFlat of
  (typ,(Prims.string,expr) FStar_Pervasives_Native.tuple2 Prims.list)
  FStar_Pervasives_Native.tuple2 
  | EField of (typ,expr,Prims.string) FStar_Pervasives_Native.tuple3 
  | EWhile of (expr,expr) FStar_Pervasives_Native.tuple2 
  | EBufCreateL of (lifetime,expr Prims.list) FStar_Pervasives_Native.tuple2
  
  | ETuple of expr Prims.list 
  | ECons of (typ,Prims.string,expr Prims.list)
  FStar_Pervasives_Native.tuple3 
  | EBufFill of (expr,expr,expr) FStar_Pervasives_Native.tuple3 
  | EString of Prims.string 
  | EFun of (binder Prims.list,expr,typ) FStar_Pervasives_Native.tuple3 
  | EAbortS of Prims.string 
  | EBufFree of expr [@@deriving show]
and op =
  | Add 
  | AddW 
  | Sub 
  | SubW 
  | Div 
  | DivW 
  | Mult 
  | MultW 
  | Mod 
  | BOr 
  | BAnd 
  | BXor 
  | BShiftL 
  | BShiftR 
  | BNot 
  | Eq 
  | Neq 
  | Lt 
  | Lte 
  | Gt 
  | Gte 
  | And 
  | Or 
  | Xor 
  | Not [@@deriving show]
and pattern =
  | PUnit 
  | PBool of Prims.bool 
  | PVar of binder 
  | PCons of (Prims.string,pattern Prims.list) FStar_Pervasives_Native.tuple2
  
  | PTuple of pattern Prims.list 
  | PRecord of (Prims.string,pattern) FStar_Pervasives_Native.tuple2
  Prims.list 
  | PConstant of (width,Prims.string) FStar_Pervasives_Native.tuple2 
[@@deriving show]
and width =
  | UInt8 
  | UInt16 
  | UInt32 
  | UInt64 
  | Int8 
  | Int16 
  | Int32 
  | Int64 
  | Bool 
  | CInt [@@deriving show]
and binder = {
  name: Prims.string ;
  typ: typ }[@@deriving show]
and typ =
  | TInt of width 
  | TBuf of typ 
  | TUnit 
  | TQualified of (Prims.string Prims.list,Prims.string)
  FStar_Pervasives_Native.tuple2 
  | TBool 
  | TAny 
  | TArrow of (typ,typ) FStar_Pervasives_Native.tuple2 
  | TBound of Prims.int 
  | TApp of
  ((Prims.string Prims.list,Prims.string) FStar_Pervasives_Native.tuple2,
  typ Prims.list) FStar_Pervasives_Native.tuple2 
  | TTuple of typ Prims.list [@@deriving show]
let (uu___is_DGlobal : decl -> Prims.bool) =
  fun projectee  ->
    match projectee with | DGlobal _0 -> true | uu____561 -> false
  
let (__proj__DGlobal__item___0 :
  decl ->
    (flag Prims.list,(Prims.string Prims.list,Prims.string)
                       FStar_Pervasives_Native.tuple2,Prims.int,typ,expr)
      FStar_Pervasives_Native.tuple5)
  = fun projectee  -> match projectee with | DGlobal _0 -> _0 
let (uu___is_DFunction : decl -> Prims.bool) =
  fun projectee  ->
    match projectee with | DFunction _0 -> true | uu____655 -> false
  
let (__proj__DFunction__item___0 :
  decl ->
    (cc FStar_Pervasives_Native.option,flag Prims.list,Prims.int,typ,
      (Prims.string Prims.list,Prims.string) FStar_Pervasives_Native.tuple2,
      binder Prims.list,expr) FStar_Pervasives_Native.tuple7)
  = fun projectee  -> match projectee with | DFunction _0 -> _0 
let (uu___is_DTypeAlias : decl -> Prims.bool) =
  fun projectee  ->
    match projectee with | DTypeAlias _0 -> true | uu____763 -> false
  
let (__proj__DTypeAlias__item___0 :
  decl ->
    ((Prims.string Prims.list,Prims.string) FStar_Pervasives_Native.tuple2,
      flag Prims.list,Prims.int,typ) FStar_Pervasives_Native.tuple4)
  = fun projectee  -> match projectee with | DTypeAlias _0 -> _0 
let (uu___is_DTypeFlat : decl -> Prims.bool) =
  fun projectee  ->
    match projectee with | DTypeFlat _0 -> true | uu____851 -> false
  
let (__proj__DTypeFlat__item___0 :
  decl ->
    ((Prims.string Prims.list,Prims.string) FStar_Pervasives_Native.tuple2,
      flag Prims.list,Prims.int,(Prims.string,(typ,Prims.bool)
                                                FStar_Pervasives_Native.tuple2)
                                  FStar_Pervasives_Native.tuple2 Prims.list)
      FStar_Pervasives_Native.tuple4)
  = fun projectee  -> match projectee with | DTypeFlat _0 -> _0 
let (uu___is_DExternal : decl -> Prims.bool) =
  fun projectee  ->
    match projectee with | DExternal _0 -> true | uu____961 -> false
  
let (__proj__DExternal__item___0 :
  decl ->
    (cc FStar_Pervasives_Native.option,flag Prims.list,(Prims.string
                                                          Prims.list,
                                                         Prims.string)
                                                         FStar_Pervasives_Native.tuple2,
      typ) FStar_Pervasives_Native.tuple4)
  = fun projectee  -> match projectee with | DExternal _0 -> _0 
let (uu___is_DTypeVariant : decl -> Prims.bool) =
  fun projectee  ->
    match projectee with | DTypeVariant _0 -> true | uu____1061 -> false
  
let (__proj__DTypeVariant__item___0 :
  decl ->
    ((Prims.string Prims.list,Prims.string) FStar_Pervasives_Native.tuple2,
      flag Prims.list,Prims.int,(Prims.string,(Prims.string,(typ,Prims.bool)
                                                              FStar_Pervasives_Native.tuple2)
                                                FStar_Pervasives_Native.tuple2
                                                Prims.list)
                                  FStar_Pervasives_Native.tuple2 Prims.list)
      FStar_Pervasives_Native.tuple4)
  = fun projectee  -> match projectee with | DTypeVariant _0 -> _0 
let (uu___is_StdCall : cc -> Prims.bool) =
  fun projectee  ->
    match projectee with | StdCall  -> true | uu____1170 -> false
  
let (uu___is_CDecl : cc -> Prims.bool) =
  fun projectee  ->
    match projectee with | CDecl  -> true | uu____1176 -> false
  
let (uu___is_FastCall : cc -> Prims.bool) =
  fun projectee  ->
    match projectee with | FastCall  -> true | uu____1182 -> false
  
let (uu___is_Private : flag -> Prims.bool) =
  fun projectee  ->
    match projectee with | Private  -> true | uu____1188 -> false
  
let (uu___is_WipeBody : flag -> Prims.bool) =
  fun projectee  ->
    match projectee with | WipeBody  -> true | uu____1194 -> false
  
let (uu___is_CInline : flag -> Prims.bool) =
  fun projectee  ->
    match projectee with | CInline  -> true | uu____1200 -> false
  
let (uu___is_Substitute : flag -> Prims.bool) =
  fun projectee  ->
    match projectee with | Substitute  -> true | uu____1206 -> false
  
let (uu___is_GCType : flag -> Prims.bool) =
  fun projectee  ->
    match projectee with | GCType  -> true | uu____1212 -> false
  
let (uu___is_Comment : flag -> Prims.bool) =
  fun projectee  ->
    match projectee with | Comment _0 -> true | uu____1219 -> false
  
let (__proj__Comment__item___0 : flag -> Prims.string) =
  fun projectee  -> match projectee with | Comment _0 -> _0 
let (uu___is_MustDisappear : flag -> Prims.bool) =
  fun projectee  ->
    match projectee with | MustDisappear  -> true | uu____1232 -> false
  
let (uu___is_Const : flag -> Prims.bool) =
  fun projectee  ->
    match projectee with | Const _0 -> true | uu____1239 -> false
  
let (__proj__Const__item___0 : flag -> Prims.string) =
  fun projectee  -> match projectee with | Const _0 -> _0 
let (uu___is_Prologue : flag -> Prims.bool) =
  fun projectee  ->
    match projectee with | Prologue _0 -> true | uu____1253 -> false
  
let (__proj__Prologue__item___0 : flag -> Prims.string) =
  fun projectee  -> match projectee with | Prologue _0 -> _0 
let (uu___is_Epilogue : flag -> Prims.bool) =
  fun projectee  ->
    match projectee with | Epilogue _0 -> true | uu____1267 -> false
  
let (__proj__Epilogue__item___0 : flag -> Prims.string) =
  fun projectee  -> match projectee with | Epilogue _0 -> _0 
let (uu___is_Eternal : lifetime -> Prims.bool) =
  fun projectee  ->
    match projectee with | Eternal  -> true | uu____1280 -> false
  
let (uu___is_Stack : lifetime -> Prims.bool) =
  fun projectee  ->
    match projectee with | Stack  -> true | uu____1286 -> false
  
let (uu___is_ManuallyManaged : lifetime -> Prims.bool) =
  fun projectee  ->
    match projectee with | ManuallyManaged  -> true | uu____1292 -> false
  
let (uu___is_EBound : expr -> Prims.bool) =
  fun projectee  ->
    match projectee with | EBound _0 -> true | uu____1299 -> false
  
let (__proj__EBound__item___0 : expr -> Prims.int) =
  fun projectee  -> match projectee with | EBound _0 -> _0 
let (uu___is_EQualified : expr -> Prims.bool) =
  fun projectee  ->
    match projectee with | EQualified _0 -> true | uu____1319 -> false
  
let (__proj__EQualified__item___0 :
  expr ->
    (Prims.string Prims.list,Prims.string) FStar_Pervasives_Native.tuple2)
  = fun projectee  -> match projectee with | EQualified _0 -> _0 
let (uu___is_EConstant : expr -> Prims.bool) =
  fun projectee  ->
    match projectee with | EConstant _0 -> true | uu____1355 -> false
  
let (__proj__EConstant__item___0 :
  expr -> (width,Prims.string) FStar_Pervasives_Native.tuple2) =
  fun projectee  -> match projectee with | EConstant _0 -> _0 
let (uu___is_EUnit : expr -> Prims.bool) =
  fun projectee  ->
    match projectee with | EUnit  -> true | uu____1380 -> false
  
let (uu___is_EApp : expr -> Prims.bool) =
  fun projectee  ->
    match projectee with | EApp _0 -> true | uu____1393 -> false
  
let (__proj__EApp__item___0 :
  expr -> (expr,expr Prims.list) FStar_Pervasives_Native.tuple2) =
  fun projectee  -> match projectee with | EApp _0 -> _0 
let (uu___is_ETypApp : expr -> Prims.bool) =
  fun projectee  ->
    match projectee with | ETypApp _0 -> true | uu____1431 -> false
  
let (__proj__ETypApp__item___0 :
  expr -> (expr,typ Prims.list) FStar_Pervasives_Native.tuple2) =
  fun projectee  -> match projectee with | ETypApp _0 -> _0 
let (uu___is_ELet : expr -> Prims.bool) =
  fun projectee  ->
    match projectee with | ELet _0 -> true | uu____1469 -> false
  
let (__proj__ELet__item___0 :
  expr -> (binder,expr,expr) FStar_Pervasives_Native.tuple3) =
  fun projectee  -> match projectee with | ELet _0 -> _0 
let (uu___is_EIfThenElse : expr -> Prims.bool) =
  fun projectee  ->
    match projectee with | EIfThenElse _0 -> true | uu____1507 -> false
  
let (__proj__EIfThenElse__item___0 :
  expr -> (expr,expr,expr) FStar_Pervasives_Native.tuple3) =
  fun projectee  -> match projectee with | EIfThenElse _0 -> _0 
let (uu___is_ESequence : expr -> Prims.bool) =
  fun projectee  ->
    match projectee with | ESequence _0 -> true | uu____1541 -> false
  
let (__proj__ESequence__item___0 : expr -> expr Prims.list) =
  fun projectee  -> match projectee with | ESequence _0 -> _0 
let (uu___is_EAssign : expr -> Prims.bool) =
  fun projectee  ->
    match projectee with | EAssign _0 -> true | uu____1565 -> false
  
let (__proj__EAssign__item___0 :
  expr -> (expr,expr) FStar_Pervasives_Native.tuple2) =
  fun projectee  -> match projectee with | EAssign _0 -> _0 
let (uu___is_EBufCreate : expr -> Prims.bool) =
  fun projectee  ->
    match projectee with | EBufCreate _0 -> true | uu____1597 -> false
  
let (__proj__EBufCreate__item___0 :
  expr -> (lifetime,expr,expr) FStar_Pervasives_Native.tuple3) =
  fun projectee  -> match projectee with | EBufCreate _0 -> _0 
let (uu___is_EBufRead : expr -> Prims.bool) =
  fun projectee  ->
    match projectee with | EBufRead _0 -> true | uu____1633 -> false
  
let (__proj__EBufRead__item___0 :
  expr -> (expr,expr) FStar_Pervasives_Native.tuple2) =
  fun projectee  -> match projectee with | EBufRead _0 -> _0 
let (uu___is_EBufWrite : expr -> Prims.bool) =
  fun projectee  ->
    match projectee with | EBufWrite _0 -> true | uu____1665 -> false
  
let (__proj__EBufWrite__item___0 :
  expr -> (expr,expr,expr) FStar_Pervasives_Native.tuple3) =
  fun projectee  -> match projectee with | EBufWrite _0 -> _0 
let (uu___is_EBufSub : expr -> Prims.bool) =
  fun projectee  ->
    match projectee with | EBufSub _0 -> true | uu____1701 -> false
  
let (__proj__EBufSub__item___0 :
  expr -> (expr,expr) FStar_Pervasives_Native.tuple2) =
  fun projectee  -> match projectee with | EBufSub _0 -> _0 
let (uu___is_EBufBlit : expr -> Prims.bool) =
  fun projectee  ->
    match projectee with | EBufBlit _0 -> true | uu____1737 -> false
  
let (__proj__EBufBlit__item___0 :
  expr -> (expr,expr,expr,expr,expr) FStar_Pervasives_Native.tuple5) =
  fun projectee  -> match projectee with | EBufBlit _0 -> _0 
let (uu___is_EMatch : expr -> Prims.bool) =
  fun projectee  ->
    match projectee with | EMatch _0 -> true | uu____1791 -> false
  
let (__proj__EMatch__item___0 :
  expr ->
    (expr,(pattern,expr) FStar_Pervasives_Native.tuple2 Prims.list)
      FStar_Pervasives_Native.tuple2)
  = fun projectee  -> match projectee with | EMatch _0 -> _0 
let (uu___is_EOp : expr -> Prims.bool) =
  fun projectee  ->
    match projectee with | EOp _0 -> true | uu____1839 -> false
  
let (__proj__EOp__item___0 :
  expr -> (op,width) FStar_Pervasives_Native.tuple2) =
  fun projectee  -> match projectee with | EOp _0 -> _0 
let (uu___is_ECast : expr -> Prims.bool) =
  fun projectee  ->
    match projectee with | ECast _0 -> true | uu____1869 -> false
  
let (__proj__ECast__item___0 :
  expr -> (expr,typ) FStar_Pervasives_Native.tuple2) =
  fun projectee  -> match projectee with | ECast _0 -> _0 
let (uu___is_EPushFrame : expr -> Prims.bool) =
  fun projectee  ->
    match projectee with | EPushFrame  -> true | uu____1894 -> false
  
let (uu___is_EPopFrame : expr -> Prims.bool) =
  fun projectee  ->
    match projectee with | EPopFrame  -> true | uu____1900 -> false
  
let (uu___is_EBool : expr -> Prims.bool) =
  fun projectee  ->
    match projectee with | EBool _0 -> true | uu____1907 -> false
  
let (__proj__EBool__item___0 : expr -> Prims.bool) =
  fun projectee  -> match projectee with | EBool _0 -> _0 
let (uu___is_EAny : expr -> Prims.bool) =
  fun projectee  ->
    match projectee with | EAny  -> true | uu____1920 -> false
  
let (uu___is_EAbort : expr -> Prims.bool) =
  fun projectee  ->
    match projectee with | EAbort  -> true | uu____1926 -> false
  
let (uu___is_EReturn : expr -> Prims.bool) =
  fun projectee  ->
    match projectee with | EReturn _0 -> true | uu____1933 -> false
  
let (__proj__EReturn__item___0 : expr -> expr) =
  fun projectee  -> match projectee with | EReturn _0 -> _0 
let (uu___is_EFlat : expr -> Prims.bool) =
  fun projectee  ->
    match projectee with | EFlat _0 -> true | uu____1957 -> false
  
let (__proj__EFlat__item___0 :
  expr ->
    (typ,(Prims.string,expr) FStar_Pervasives_Native.tuple2 Prims.list)
      FStar_Pervasives_Native.tuple2)
  = fun projectee  -> match projectee with | EFlat _0 -> _0 
let (uu___is_EField : expr -> Prims.bool) =
  fun projectee  ->
    match projectee with | EField _0 -> true | uu____2007 -> false
  
let (__proj__EField__item___0 :
  expr -> (typ,expr,Prims.string) FStar_Pervasives_Native.tuple3) =
  fun projectee  -> match projectee with | EField _0 -> _0 
let (uu___is_EWhile : expr -> Prims.bool) =
  fun projectee  ->
    match projectee with | EWhile _0 -> true | uu____2043 -> false
  
let (__proj__EWhile__item___0 :
  expr -> (expr,expr) FStar_Pervasives_Native.tuple2) =
  fun projectee  -> match projectee with | EWhile _0 -> _0 
let (uu___is_EBufCreateL : expr -> Prims.bool) =
  fun projectee  ->
    match projectee with | EBufCreateL _0 -> true | uu____2075 -> false
  
let (__proj__EBufCreateL__item___0 :
  expr -> (lifetime,expr Prims.list) FStar_Pervasives_Native.tuple2) =
  fun projectee  -> match projectee with | EBufCreateL _0 -> _0 
let (uu___is_ETuple : expr -> Prims.bool) =
  fun projectee  ->
    match projectee with | ETuple _0 -> true | uu____2109 -> false
  
let (__proj__ETuple__item___0 : expr -> expr Prims.list) =
  fun projectee  -> match projectee with | ETuple _0 -> _0 
let (uu___is_ECons : expr -> Prims.bool) =
  fun projectee  ->
    match projectee with | ECons _0 -> true | uu____2137 -> false
  
let (__proj__ECons__item___0 :
  expr -> (typ,Prims.string,expr Prims.list) FStar_Pervasives_Native.tuple3)
  = fun projectee  -> match projectee with | ECons _0 -> _0 
let (uu___is_EBufFill : expr -> Prims.bool) =
  fun projectee  ->
    match projectee with | EBufFill _0 -> true | uu____2181 -> false
  
let (__proj__EBufFill__item___0 :
  expr -> (expr,expr,expr) FStar_Pervasives_Native.tuple3) =
  fun projectee  -> match projectee with | EBufFill _0 -> _0 
let (uu___is_EString : expr -> Prims.bool) =
  fun projectee  ->
    match projectee with | EString _0 -> true | uu____2213 -> false
  
let (__proj__EString__item___0 : expr -> Prims.string) =
  fun projectee  -> match projectee with | EString _0 -> _0 
let (uu___is_EFun : expr -> Prims.bool) =
  fun projectee  ->
    match projectee with | EFun _0 -> true | uu____2235 -> false
  
let (__proj__EFun__item___0 :
  expr -> (binder Prims.list,expr,typ) FStar_Pervasives_Native.tuple3) =
  fun projectee  -> match projectee with | EFun _0 -> _0 
let (uu___is_EAbortS : expr -> Prims.bool) =
  fun projectee  ->
    match projectee with | EAbortS _0 -> true | uu____2273 -> false
  
let (__proj__EAbortS__item___0 : expr -> Prims.string) =
  fun projectee  -> match projectee with | EAbortS _0 -> _0 
let (uu___is_EBufFree : expr -> Prims.bool) =
  fun projectee  ->
    match projectee with | EBufFree _0 -> true | uu____2287 -> false
  
let (__proj__EBufFree__item___0 : expr -> expr) =
  fun projectee  -> match projectee with | EBufFree _0 -> _0 
let (uu___is_Add : op -> Prims.bool) =
  fun projectee  -> match projectee with | Add  -> true | uu____2300 -> false 
let (uu___is_AddW : op -> Prims.bool) =
  fun projectee  ->
    match projectee with | AddW  -> true | uu____2306 -> false
  
let (uu___is_Sub : op -> Prims.bool) =
  fun projectee  -> match projectee with | Sub  -> true | uu____2312 -> false 
let (uu___is_SubW : op -> Prims.bool) =
  fun projectee  ->
    match projectee with | SubW  -> true | uu____2318 -> false
  
let (uu___is_Div : op -> Prims.bool) =
  fun projectee  -> match projectee with | Div  -> true | uu____2324 -> false 
let (uu___is_DivW : op -> Prims.bool) =
  fun projectee  ->
    match projectee with | DivW  -> true | uu____2330 -> false
  
let (uu___is_Mult : op -> Prims.bool) =
  fun projectee  ->
    match projectee with | Mult  -> true | uu____2336 -> false
  
let (uu___is_MultW : op -> Prims.bool) =
  fun projectee  ->
    match projectee with | MultW  -> true | uu____2342 -> false
  
let (uu___is_Mod : op -> Prims.bool) =
  fun projectee  -> match projectee with | Mod  -> true | uu____2348 -> false 
let (uu___is_BOr : op -> Prims.bool) =
  fun projectee  -> match projectee with | BOr  -> true | uu____2354 -> false 
let (uu___is_BAnd : op -> Prims.bool) =
  fun projectee  ->
    match projectee with | BAnd  -> true | uu____2360 -> false
  
let (uu___is_BXor : op -> Prims.bool) =
  fun projectee  ->
    match projectee with | BXor  -> true | uu____2366 -> false
  
let (uu___is_BShiftL : op -> Prims.bool) =
  fun projectee  ->
    match projectee with | BShiftL  -> true | uu____2372 -> false
  
let (uu___is_BShiftR : op -> Prims.bool) =
  fun projectee  ->
    match projectee with | BShiftR  -> true | uu____2378 -> false
  
let (uu___is_BNot : op -> Prims.bool) =
  fun projectee  ->
    match projectee with | BNot  -> true | uu____2384 -> false
  
let (uu___is_Eq : op -> Prims.bool) =
  fun projectee  -> match projectee with | Eq  -> true | uu____2390 -> false 
let (uu___is_Neq : op -> Prims.bool) =
  fun projectee  -> match projectee with | Neq  -> true | uu____2396 -> false 
let (uu___is_Lt : op -> Prims.bool) =
  fun projectee  -> match projectee with | Lt  -> true | uu____2402 -> false 
let (uu___is_Lte : op -> Prims.bool) =
  fun projectee  -> match projectee with | Lte  -> true | uu____2408 -> false 
let (uu___is_Gt : op -> Prims.bool) =
  fun projectee  -> match projectee with | Gt  -> true | uu____2414 -> false 
let (uu___is_Gte : op -> Prims.bool) =
  fun projectee  -> match projectee with | Gte  -> true | uu____2420 -> false 
let (uu___is_And : op -> Prims.bool) =
  fun projectee  -> match projectee with | And  -> true | uu____2426 -> false 
let (uu___is_Or : op -> Prims.bool) =
  fun projectee  -> match projectee with | Or  -> true | uu____2432 -> false 
let (uu___is_Xor : op -> Prims.bool) =
  fun projectee  -> match projectee with | Xor  -> true | uu____2438 -> false 
let (uu___is_Not : op -> Prims.bool) =
  fun projectee  -> match projectee with | Not  -> true | uu____2444 -> false 
let (uu___is_PUnit : pattern -> Prims.bool) =
  fun projectee  ->
    match projectee with | PUnit  -> true | uu____2450 -> false
  
let (uu___is_PBool : pattern -> Prims.bool) =
  fun projectee  ->
    match projectee with | PBool _0 -> true | uu____2457 -> false
  
let (__proj__PBool__item___0 : pattern -> Prims.bool) =
  fun projectee  -> match projectee with | PBool _0 -> _0 
let (uu___is_PVar : pattern -> Prims.bool) =
  fun projectee  ->
    match projectee with | PVar _0 -> true | uu____2471 -> false
  
let (__proj__PVar__item___0 : pattern -> binder) =
  fun projectee  -> match projectee with | PVar _0 -> _0 
let (uu___is_PCons : pattern -> Prims.bool) =
  fun projectee  ->
    match projectee with | PCons _0 -> true | uu____2491 -> false
  
let (__proj__PCons__item___0 :
  pattern -> (Prims.string,pattern Prims.list) FStar_Pervasives_Native.tuple2)
  = fun projectee  -> match projectee with | PCons _0 -> _0 
let (uu___is_PTuple : pattern -> Prims.bool) =
  fun projectee  ->
    match projectee with | PTuple _0 -> true | uu____2525 -> false
  
let (__proj__PTuple__item___0 : pattern -> pattern Prims.list) =
  fun projectee  -> match projectee with | PTuple _0 -> _0 
let (uu___is_PRecord : pattern -> Prims.bool) =
  fun projectee  ->
    match projectee with | PRecord _0 -> true | uu____2551 -> false
  
let (__proj__PRecord__item___0 :
  pattern -> (Prims.string,pattern) FStar_Pervasives_Native.tuple2 Prims.list)
  = fun projectee  -> match projectee with | PRecord _0 -> _0 
let (uu___is_PConstant : pattern -> Prims.bool) =
  fun projectee  ->
    match projectee with | PConstant _0 -> true | uu____2587 -> false
  
let (__proj__PConstant__item___0 :
  pattern -> (width,Prims.string) FStar_Pervasives_Native.tuple2) =
  fun projectee  -> match projectee with | PConstant _0 -> _0 
let (uu___is_UInt8 : width -> Prims.bool) =
  fun projectee  ->
    match projectee with | UInt8  -> true | uu____2612 -> false
  
let (uu___is_UInt16 : width -> Prims.bool) =
  fun projectee  ->
    match projectee with | UInt16  -> true | uu____2618 -> false
  
let (uu___is_UInt32 : width -> Prims.bool) =
  fun projectee  ->
    match projectee with | UInt32  -> true | uu____2624 -> false
  
let (uu___is_UInt64 : width -> Prims.bool) =
  fun projectee  ->
    match projectee with | UInt64  -> true | uu____2630 -> false
  
let (uu___is_Int8 : width -> Prims.bool) =
  fun projectee  ->
    match projectee with | Int8  -> true | uu____2636 -> false
  
let (uu___is_Int16 : width -> Prims.bool) =
  fun projectee  ->
    match projectee with | Int16  -> true | uu____2642 -> false
  
let (uu___is_Int32 : width -> Prims.bool) =
  fun projectee  ->
    match projectee with | Int32  -> true | uu____2648 -> false
  
let (uu___is_Int64 : width -> Prims.bool) =
  fun projectee  ->
    match projectee with | Int64  -> true | uu____2654 -> false
  
let (uu___is_Bool : width -> Prims.bool) =
  fun projectee  ->
    match projectee with | Bool  -> true | uu____2660 -> false
  
let (uu___is_CInt : width -> Prims.bool) =
  fun projectee  ->
    match projectee with | CInt  -> true | uu____2666 -> false
  
let (__proj__Mkbinder__item__name : binder -> Prims.string) =
  fun projectee  ->
    match projectee with
    | { name = __fname__name; typ = __fname__typ;_} -> __fname__name
  
let (__proj__Mkbinder__item__typ : binder -> typ) =
  fun projectee  ->
    match projectee with
    | { name = __fname__name; typ = __fname__typ;_} -> __fname__typ
  
let (uu___is_TInt : typ -> Prims.bool) =
  fun projectee  ->
    match projectee with | TInt _0 -> true | uu____2687 -> false
  
let (__proj__TInt__item___0 : typ -> width) =
  fun projectee  -> match projectee with | TInt _0 -> _0 
let (uu___is_TBuf : typ -> Prims.bool) =
  fun projectee  ->
    match projectee with | TBuf _0 -> true | uu____2701 -> false
  
let (__proj__TBuf__item___0 : typ -> typ) =
  fun projectee  -> match projectee with | TBuf _0 -> _0 
let (uu___is_TUnit : typ -> Prims.bool) =
  fun projectee  ->
    match projectee with | TUnit  -> true | uu____2714 -> false
  
let (uu___is_TQualified : typ -> Prims.bool) =
  fun projectee  ->
    match projectee with | TQualified _0 -> true | uu____2727 -> false
  
let (__proj__TQualified__item___0 :
  typ ->
    (Prims.string Prims.list,Prims.string) FStar_Pervasives_Native.tuple2)
  = fun projectee  -> match projectee with | TQualified _0 -> _0 
let (uu___is_TBool : typ -> Prims.bool) =
  fun projectee  ->
    match projectee with | TBool  -> true | uu____2758 -> false
  
let (uu___is_TAny : typ -> Prims.bool) =
  fun projectee  ->
    match projectee with | TAny  -> true | uu____2764 -> false
  
let (uu___is_TArrow : typ -> Prims.bool) =
  fun projectee  ->
    match projectee with | TArrow _0 -> true | uu____2775 -> false
  
let (__proj__TArrow__item___0 :
  typ -> (typ,typ) FStar_Pervasives_Native.tuple2) =
  fun projectee  -> match projectee with | TArrow _0 -> _0 
let (uu___is_TBound : typ -> Prims.bool) =
  fun projectee  ->
    match projectee with | TBound _0 -> true | uu____2801 -> false
  
let (__proj__TBound__item___0 : typ -> Prims.int) =
  fun projectee  -> match projectee with | TBound _0 -> _0 
let (uu___is_TApp : typ -> Prims.bool) =
  fun projectee  ->
    match projectee with | TApp _0 -> true | uu____2827 -> false
  
let (__proj__TApp__item___0 :
  typ ->
    ((Prims.string Prims.list,Prims.string) FStar_Pervasives_Native.tuple2,
      typ Prims.list) FStar_Pervasives_Native.tuple2)
  = fun projectee  -> match projectee with | TApp _0 -> _0 
let (uu___is_TTuple : typ -> Prims.bool) =
  fun projectee  ->
    match projectee with | TTuple _0 -> true | uu____2879 -> false
  
let (__proj__TTuple__item___0 : typ -> typ Prims.list) =
  fun projectee  -> match projectee with | TTuple _0 -> _0 
type program = decl Prims.list[@@deriving show]
type ident = Prims.string[@@deriving show]
type fields_t =
  (Prims.string,(typ,Prims.bool) FStar_Pervasives_Native.tuple2)
    FStar_Pervasives_Native.tuple2 Prims.list[@@deriving show]
type branches_t =
  (Prims.string,(Prims.string,(typ,Prims.bool) FStar_Pervasives_Native.tuple2)
                  FStar_Pervasives_Native.tuple2 Prims.list)
    FStar_Pervasives_Native.tuple2 Prims.list[@@deriving show]
type fsdoc = Prims.string[@@deriving show]
type branch = (pattern,expr) FStar_Pervasives_Native.tuple2[@@deriving show]
type branches = (pattern,expr) FStar_Pervasives_Native.tuple2 Prims.list
[@@deriving show]
type constant = (width,Prims.string) FStar_Pervasives_Native.tuple2[@@deriving
                                                                    show]
type var = Prims.int[@@deriving show]
type lident =
  (Prims.string Prims.list,Prims.string) FStar_Pervasives_Native.tuple2
[@@deriving show]
type version = Prims.int[@@deriving show]
let (current_version : version) = (Prims.parse_int "27") 
type file = (Prims.string,program) FStar_Pervasives_Native.tuple2[@@deriving
                                                                   show]
type binary_format = (version,file Prims.list) FStar_Pervasives_Native.tuple2
[@@deriving show]
let fst3 :
  'Auu____2959 'Auu____2960 'Auu____2961 .
    ('Auu____2959,'Auu____2960,'Auu____2961) FStar_Pervasives_Native.tuple3
      -> 'Auu____2959
  = fun uu____2972  -> match uu____2972 with | (x,uu____2980,uu____2981) -> x 
let snd3 :
  'Auu____2990 'Auu____2991 'Auu____2992 .
    ('Auu____2990,'Auu____2991,'Auu____2992) FStar_Pervasives_Native.tuple3
      -> 'Auu____2991
  = fun uu____3003  -> match uu____3003 with | (uu____3010,x,uu____3012) -> x 
let thd3 :
  'Auu____3021 'Auu____3022 'Auu____3023 .
    ('Auu____3021,'Auu____3022,'Auu____3023) FStar_Pervasives_Native.tuple3
      -> 'Auu____3023
  = fun uu____3034  -> match uu____3034 with | (uu____3041,uu____3042,x) -> x 
let (mk_width : Prims.string -> width FStar_Pervasives_Native.option) =
  fun uu___35_3050  ->
    match uu___35_3050 with
    | "UInt8" -> FStar_Pervasives_Native.Some UInt8
    | "UInt16" -> FStar_Pervasives_Native.Some UInt16
    | "UInt32" -> FStar_Pervasives_Native.Some UInt32
    | "UInt64" -> FStar_Pervasives_Native.Some UInt64
    | "Int8" -> FStar_Pervasives_Native.Some Int8
    | "Int16" -> FStar_Pervasives_Native.Some Int16
    | "Int32" -> FStar_Pervasives_Native.Some Int32
    | "Int64" -> FStar_Pervasives_Native.Some Int64
    | uu____3053 -> FStar_Pervasives_Native.None
  
let (mk_bool_op : Prims.string -> op FStar_Pervasives_Native.option) =
  fun uu___36_3060  ->
    match uu___36_3060 with
    | "op_Negation" -> FStar_Pervasives_Native.Some Not
    | "op_AmpAmp" -> FStar_Pervasives_Native.Some And
    | "op_BarBar" -> FStar_Pervasives_Native.Some Or
    | "op_Equality" -> FStar_Pervasives_Native.Some Eq
    | "op_disEquality" -> FStar_Pervasives_Native.Some Neq
    | uu____3063 -> FStar_Pervasives_Native.None
  
let (is_bool_op : Prims.string -> Prims.bool) =
  fun op  -> (mk_bool_op op) <> FStar_Pervasives_Native.None 
let (mk_op : Prims.string -> op FStar_Pervasives_Native.option) =
  fun uu___37_3077  ->
    match uu___37_3077 with
    | "add" -> FStar_Pervasives_Native.Some Add
    | "op_Plus_Hat" -> FStar_Pervasives_Native.Some Add
    | "add_mod" -> FStar_Pervasives_Native.Some AddW
    | "op_Plus_Percent_Hat" -> FStar_Pervasives_Native.Some AddW
    | "sub" -> FStar_Pervasives_Native.Some Sub
    | "op_Subtraction_Hat" -> FStar_Pervasives_Native.Some Sub
    | "sub_mod" -> FStar_Pervasives_Native.Some SubW
    | "op_Subtraction_Percent_Hat" -> FStar_Pervasives_Native.Some SubW
    | "mul" -> FStar_Pervasives_Native.Some Mult
    | "op_Star_Hat" -> FStar_Pervasives_Native.Some Mult
    | "mul_mod" -> FStar_Pervasives_Native.Some MultW
    | "op_Star_Percent_Hat" -> FStar_Pervasives_Native.Some MultW
    | "div" -> FStar_Pervasives_Native.Some Div
    | "op_Slash_Hat" -> FStar_Pervasives_Native.Some Div
    | "div_mod" -> FStar_Pervasives_Native.Some DivW
    | "op_Slash_Percent_Hat" -> FStar_Pervasives_Native.Some DivW
    | "rem" -> FStar_Pervasives_Native.Some Mod
    | "op_Percent_Hat" -> FStar_Pervasives_Native.Some Mod
    | "logor" -> FStar_Pervasives_Native.Some BOr
    | "op_Bar_Hat" -> FStar_Pervasives_Native.Some BOr
    | "logxor" -> FStar_Pervasives_Native.Some BXor
    | "op_Hat_Hat" -> FStar_Pervasives_Native.Some BXor
    | "logand" -> FStar_Pervasives_Native.Some BAnd
    | "op_Amp_Hat" -> FStar_Pervasives_Native.Some BAnd
    | "lognot" -> FStar_Pervasives_Native.Some BNot
    | "shift_right" -> FStar_Pervasives_Native.Some BShiftR
    | "op_Greater_Greater_Hat" -> FStar_Pervasives_Native.Some BShiftR
    | "shift_left" -> FStar_Pervasives_Native.Some BShiftL
    | "op_Less_Less_Hat" -> FStar_Pervasives_Native.Some BShiftL
    | "eq" -> FStar_Pervasives_Native.Some Eq
    | "op_Equals_Hat" -> FStar_Pervasives_Native.Some Eq
    | "op_Greater_Hat" -> FStar_Pervasives_Native.Some Gt
    | "gt" -> FStar_Pervasives_Native.Some Gt
    | "op_Greater_Equals_Hat" -> FStar_Pervasives_Native.Some Gte
    | "gte" -> FStar_Pervasives_Native.Some Gte
    | "op_Less_Hat" -> FStar_Pervasives_Native.Some Lt
    | "lt" -> FStar_Pervasives_Native.Some Lt
    | "op_Less_Equals_Hat" -> FStar_Pervasives_Native.Some Lte
    | "lte" -> FStar_Pervasives_Native.Some Lte
    | uu____3080 -> FStar_Pervasives_Native.None
  
let (is_op : Prims.string -> Prims.bool) =
  fun op  -> (mk_op op) <> FStar_Pervasives_Native.None 
let (is_machine_int : Prims.string -> Prims.bool) =
  fun m  -> (mk_width m) <> FStar_Pervasives_Native.None 
type env =
  {
  names: name Prims.list ;
  names_t: Prims.string Prims.list ;
  module_name: Prims.string Prims.list }[@@deriving show]
and name = {
  pretty: Prims.string }[@@deriving show]
let (__proj__Mkenv__item__names : env -> name Prims.list) =
  fun projectee  ->
    match projectee with
    | { names = __fname__names; names_t = __fname__names_t;
        module_name = __fname__module_name;_} -> __fname__names
  
let (__proj__Mkenv__item__names_t : env -> Prims.string Prims.list) =
  fun projectee  ->
    match projectee with
    | { names = __fname__names; names_t = __fname__names_t;
        module_name = __fname__module_name;_} -> __fname__names_t
  
let (__proj__Mkenv__item__module_name : env -> Prims.string Prims.list) =
  fun projectee  ->
    match projectee with
    | { names = __fname__names; names_t = __fname__names_t;
        module_name = __fname__module_name;_} -> __fname__module_name
  
let (__proj__Mkname__item__pretty : name -> Prims.string) =
  fun projectee  ->
    match projectee with | { pretty = __fname__pretty;_} -> __fname__pretty
  
let (empty : Prims.string Prims.list -> env) =
  fun module_name  -> { names = []; names_t = []; module_name } 
let (extend : env -> Prims.string -> env) =
  fun env  ->
    fun x  ->
      let uu___42_3196 = env  in
      {
        names = ({ pretty = x } :: (env.names));
        names_t = (uu___42_3196.names_t);
        module_name = (uu___42_3196.module_name)
      }
  
let (extend_t : env -> Prims.string -> env) =
  fun env  ->
    fun x  ->
      let uu___43_3207 = env  in
      {
        names = (uu___43_3207.names);
        names_t = (x :: (env.names_t));
        module_name = (uu___43_3207.module_name)
      }
  
let (find_name : env -> Prims.string -> name) =
  fun env  ->
    fun x  ->
      let uu____3218 =
        FStar_List.tryFind (fun name  -> name.pretty = x) env.names  in
      match uu____3218 with
      | FStar_Pervasives_Native.Some name -> name
      | FStar_Pervasives_Native.None  ->
          failwith "internal error: name not found"
  
let (find : env -> Prims.string -> Prims.int) =
  fun env  ->
    fun x  ->
      try FStar_List.index (fun name  -> name.pretty = x) env.names
      with
      | uu____3242 ->
          let uu____3243 =
            FStar_Util.format1 "Internal error: name not found %s\n" x  in
          failwith uu____3243
  
let (find_t : env -> Prims.string -> Prims.int) =
  fun env  ->
    fun x  ->
      try FStar_List.index (fun name  -> name = x) env.names_t
      with
      | uu____3262 ->
          let uu____3263 =
            FStar_Util.format1 "Internal error: name not found %s\n" x  in
          failwith uu____3263
  
let add_binders :
  'Auu____3270 .
    env ->
      (Prims.string,'Auu____3270) FStar_Pervasives_Native.tuple2 Prims.list
        -> env
  =
  fun env  ->
    fun binders  ->
      FStar_List.fold_left
        (fun env1  ->
           fun uu____3302  ->
             match uu____3302 with | (name,uu____3308) -> extend env1 name)
        env binders
  
let rec (translate : FStar_Extraction_ML_Syntax.mllib -> file Prims.list) =
  fun uu____3513  ->
    match uu____3513 with
    | FStar_Extraction_ML_Syntax.MLLib modules ->
        FStar_List.filter_map
          (fun m  ->
             let m_name =
               let uu____3561 = m  in
               match uu____3561 with
               | (path,uu____3575,uu____3576) ->
                   FStar_Extraction_ML_Syntax.string_of_mlpath path
                in
             try
               FStar_Util.print1 "Attempting to translate module %s\n" m_name;
               (let uu____3598 = translate_module m  in
                FStar_Pervasives_Native.Some uu____3598)
             with
             | e ->
                 ((let uu____3607 = FStar_Util.print_exn e  in
                   FStar_Util.print2
                     "Unable to translate module: %s because:\n  %s\n" m_name
                     uu____3607);
                  FStar_Pervasives_Native.None)) modules

and (translate_module :
  (FStar_Extraction_ML_Syntax.mlpath,(FStar_Extraction_ML_Syntax.mlsig,
                                       FStar_Extraction_ML_Syntax.mlmodule)
                                       FStar_Pervasives_Native.tuple2
                                       FStar_Pervasives_Native.option,
    FStar_Extraction_ML_Syntax.mllib) FStar_Pervasives_Native.tuple3 -> 
    file)
  =
  fun uu____3608  ->
    match uu____3608 with
    | (module_name,modul,uu____3623) ->
        let module_name1 =
          FStar_List.append (FStar_Pervasives_Native.fst module_name)
            [FStar_Pervasives_Native.snd module_name]
           in
        let program =
          match modul with
          | FStar_Pervasives_Native.Some (_signature,decls) ->
              FStar_List.collect (translate_decl (empty module_name1)) decls
          | uu____3654 ->
              failwith "Unexpected standalone interface or nested modules"
           in
        ((FStar_String.concat "_" module_name1), program)

and (translate_flags :
  FStar_Extraction_ML_Syntax.meta Prims.list -> flag Prims.list) =
  fun flags1  ->
    FStar_List.choose
      (fun uu___38_3669  ->
         match uu___38_3669 with
         | FStar_Extraction_ML_Syntax.Private  ->
             FStar_Pervasives_Native.Some Private
         | FStar_Extraction_ML_Syntax.NoExtract  ->
             FStar_Pervasives_Native.Some WipeBody
         | FStar_Extraction_ML_Syntax.CInline  ->
             FStar_Pervasives_Native.Some CInline
         | FStar_Extraction_ML_Syntax.Substitute  ->
             FStar_Pervasives_Native.Some Substitute
         | FStar_Extraction_ML_Syntax.GCType  ->
             FStar_Pervasives_Native.Some GCType
         | FStar_Extraction_ML_Syntax.Comment s ->
             FStar_Pervasives_Native.Some (Comment s)
         | FStar_Extraction_ML_Syntax.StackInline  ->
             FStar_Pervasives_Native.Some MustDisappear
         | FStar_Extraction_ML_Syntax.CConst s ->
             FStar_Pervasives_Native.Some (Const s)
         | FStar_Extraction_ML_Syntax.CPrologue s ->
             FStar_Pervasives_Native.Some (Prologue s)
         | FStar_Extraction_ML_Syntax.CEpilogue s ->
             FStar_Pervasives_Native.Some (Epilogue s)
         | uu____3676 -> FStar_Pervasives_Native.None) flags1

and (translate_decl :
  env -> FStar_Extraction_ML_Syntax.mlmodule1 -> decl Prims.list) =
  fun env  ->
    fun d  ->
      match d with
      | FStar_Extraction_ML_Syntax.MLM_Let (flavor,lbs) ->
          FStar_List.choose (translate_let env flavor) lbs
      | FStar_Extraction_ML_Syntax.MLM_Loc uu____3687 -> []
      | FStar_Extraction_ML_Syntax.MLM_Ty tys ->
          FStar_List.choose (translate_type_decl env) tys
      | FStar_Extraction_ML_Syntax.MLM_Top uu____3689 ->
          failwith "todo: translate_decl [MLM_Top]"
      | FStar_Extraction_ML_Syntax.MLM_Exn (m,uu____3693) ->
          (FStar_Util.print1_warning
             "Skipping the translation of exception: %s\n" m;
           [])

and (translate_let :
  env ->
    FStar_Extraction_ML_Syntax.mlletflavor ->
      FStar_Extraction_ML_Syntax.mllb -> decl FStar_Pervasives_Native.option)
  =
  fun env  ->
    fun flavor  ->
      fun lb  ->
        match lb with
        | { FStar_Extraction_ML_Syntax.mllb_name = name;
            FStar_Extraction_ML_Syntax.mllb_tysc =
              FStar_Pervasives_Native.Some (tvars,t0);
            FStar_Extraction_ML_Syntax.mllb_add_unit = uu____3715;
            FStar_Extraction_ML_Syntax.mllb_def =
              {
                FStar_Extraction_ML_Syntax.expr =
                  FStar_Extraction_ML_Syntax.MLE_Fun (args,body);
                FStar_Extraction_ML_Syntax.mlty = uu____3718;
                FStar_Extraction_ML_Syntax.loc = uu____3719;_};
            FStar_Extraction_ML_Syntax.mllb_meta = meta;
            FStar_Extraction_ML_Syntax.print_typ = uu____3721;_} ->
            if FStar_List.mem FStar_Extraction_ML_Syntax.NoExtract meta
            then FStar_Pervasives_Native.None
            else
              (let assumed =
                 FStar_Util.for_some
                   (fun uu___39_3743  ->
                      match uu___39_3743 with
                      | FStar_Extraction_ML_Syntax.Assumed  -> true
                      | uu____3744 -> false) meta
                  in
               let env1 =
                 if flavor = FStar_Extraction_ML_Syntax.Rec
                 then extend env name
                 else env  in
               let env2 =
                 FStar_List.fold_left
                   (fun env2  -> fun name1  -> extend_t env2 name1) env1
                   tvars
                  in
               let rec find_return_type eff i uu___40_3771 =
                 match uu___40_3771 with
                 | FStar_Extraction_ML_Syntax.MLTY_Fun (uu____3776,eff1,t)
                     when i > (Prims.parse_int "0") ->
                     find_return_type eff1 (i - (Prims.parse_int "1")) t
                 | t -> (eff, t)  in
               let uu____3780 =
                 find_return_type FStar_Extraction_ML_Syntax.E_PURE
                   (FStar_List.length args) t0
                  in
               match uu____3780 with
               | (eff,t) ->
                   let t1 = translate_type env2 t  in
                   let binders = translate_binders env2 args  in
                   let env3 = add_binders env2 args  in
                   let name1 = ((env3.module_name), name)  in
                   let meta1 =
                     match (eff, t1) with
                     | (FStar_Extraction_ML_Syntax.E_GHOST ,uu____3812) ->
                         let uu____3813 = translate_flags meta  in
                         MustDisappear :: uu____3813
                     | (FStar_Extraction_ML_Syntax.E_PURE ,TUnit ) ->
                         let uu____3816 = translate_flags meta  in
                         MustDisappear :: uu____3816
                     | uu____3819 -> translate_flags meta  in
                   if assumed
                   then
                     (if (FStar_List.length tvars) = (Prims.parse_int "0")
                      then
                        let uu____3828 =
                          let uu____3829 =
                            let uu____3848 = translate_type env3 t0  in
                            (FStar_Pervasives_Native.None, meta1, name1,
                              uu____3848)
                             in
                          DExternal uu____3829  in
                        FStar_Pervasives_Native.Some uu____3828
                      else
                        ((let uu____3861 =
                            FStar_Extraction_ML_Syntax.string_of_mlpath name1
                             in
                          FStar_Util.print1_warning
                            "No writing anything for %s (polymorphic assume)\n"
                            uu____3861);
                         FStar_Pervasives_Native.None))
                   else
                     (try
                        let body1 = translate_expr env3 body  in
                        FStar_Pervasives_Native.Some
                          (DFunction
                             (FStar_Pervasives_Native.None, meta1,
                               (FStar_List.length tvars), t1, name1, binders,
                               body1))
                      with
                      | e ->
                          let msg = FStar_Util.print_exn e  in
                          ((let uu____3894 =
                              let uu____3899 =
                                let uu____3900 =
                                  FStar_Extraction_ML_Syntax.string_of_mlpath
                                    name1
                                   in
                                FStar_Util.format2
                                  "Writing a stub for %s (%s)\n" uu____3900
                                  msg
                                 in
                              (FStar_Errors.Warning_FunctionNotExtacted,
                                uu____3899)
                               in
                            FStar_Errors.log_issue FStar_Range.dummyRange
                              uu____3894);
                           (let msg1 =
                              Prims.strcat
                                "This function was not extracted:\n" msg
                               in
                            FStar_Pervasives_Native.Some
                              (DFunction
                                 (FStar_Pervasives_Native.None, meta1,
                                   (FStar_List.length tvars), t1, name1,
                                   binders, (EAbortS msg1)))))))
        | { FStar_Extraction_ML_Syntax.mllb_name = name;
            FStar_Extraction_ML_Syntax.mllb_tysc =
              FStar_Pervasives_Native.Some (tvars,t0);
            FStar_Extraction_ML_Syntax.mllb_add_unit = uu____3917;
            FStar_Extraction_ML_Syntax.mllb_def =
              {
                FStar_Extraction_ML_Syntax.expr =
                  FStar_Extraction_ML_Syntax.MLE_Coerce
                  ({
                     FStar_Extraction_ML_Syntax.expr =
                       FStar_Extraction_ML_Syntax.MLE_Fun (args,body);
                     FStar_Extraction_ML_Syntax.mlty = uu____3920;
                     FStar_Extraction_ML_Syntax.loc = uu____3921;_},uu____3922,uu____3923);
                FStar_Extraction_ML_Syntax.mlty = uu____3924;
                FStar_Extraction_ML_Syntax.loc = uu____3925;_};
            FStar_Extraction_ML_Syntax.mllb_meta = meta;
            FStar_Extraction_ML_Syntax.print_typ = uu____3927;_} ->
            if FStar_List.mem FStar_Extraction_ML_Syntax.NoExtract meta
            then FStar_Pervasives_Native.None
            else
              (let assumed =
                 FStar_Util.for_some
                   (fun uu___39_3949  ->
                      match uu___39_3949 with
                      | FStar_Extraction_ML_Syntax.Assumed  -> true
                      | uu____3950 -> false) meta
                  in
               let env1 =
                 if flavor = FStar_Extraction_ML_Syntax.Rec
                 then extend env name
                 else env  in
               let env2 =
                 FStar_List.fold_left
                   (fun env2  -> fun name1  -> extend_t env2 name1) env1
                   tvars
                  in
               let rec find_return_type eff i uu___40_3977 =
                 match uu___40_3977 with
                 | FStar_Extraction_ML_Syntax.MLTY_Fun (uu____3982,eff1,t)
                     when i > (Prims.parse_int "0") ->
                     find_return_type eff1 (i - (Prims.parse_int "1")) t
                 | t -> (eff, t)  in
               let uu____3986 =
                 find_return_type FStar_Extraction_ML_Syntax.E_PURE
                   (FStar_List.length args) t0
                  in
               match uu____3986 with
               | (eff,t) ->
                   let t1 = translate_type env2 t  in
                   let binders = translate_binders env2 args  in
                   let env3 = add_binders env2 args  in
                   let name1 = ((env3.module_name), name)  in
                   let meta1 =
                     match (eff, t1) with
                     | (FStar_Extraction_ML_Syntax.E_GHOST ,uu____4018) ->
                         let uu____4019 = translate_flags meta  in
                         MustDisappear :: uu____4019
                     | (FStar_Extraction_ML_Syntax.E_PURE ,TUnit ) ->
                         let uu____4022 = translate_flags meta  in
                         MustDisappear :: uu____4022
                     | uu____4025 -> translate_flags meta  in
                   if assumed
                   then
                     (if (FStar_List.length tvars) = (Prims.parse_int "0")
                      then
                        let uu____4034 =
                          let uu____4035 =
                            let uu____4054 = translate_type env3 t0  in
                            (FStar_Pervasives_Native.None, meta1, name1,
                              uu____4054)
                             in
                          DExternal uu____4035  in
                        FStar_Pervasives_Native.Some uu____4034
                      else
                        ((let uu____4067 =
                            FStar_Extraction_ML_Syntax.string_of_mlpath name1
                             in
                          FStar_Util.print1_warning
                            "No writing anything for %s (polymorphic assume)\n"
                            uu____4067);
                         FStar_Pervasives_Native.None))
                   else
                     (try
                        let body1 = translate_expr env3 body  in
                        FStar_Pervasives_Native.Some
                          (DFunction
                             (FStar_Pervasives_Native.None, meta1,
                               (FStar_List.length tvars), t1, name1, binders,
                               body1))
                      with
                      | e ->
                          let msg = FStar_Util.print_exn e  in
                          ((let uu____4100 =
                              let uu____4105 =
                                let uu____4106 =
                                  FStar_Extraction_ML_Syntax.string_of_mlpath
                                    name1
                                   in
                                FStar_Util.format2
                                  "Writing a stub for %s (%s)\n" uu____4106
                                  msg
                                 in
                              (FStar_Errors.Warning_FunctionNotExtacted,
                                uu____4105)
                               in
                            FStar_Errors.log_issue FStar_Range.dummyRange
                              uu____4100);
                           (let msg1 =
                              Prims.strcat
                                "This function was not extracted:\n" msg
                               in
                            FStar_Pervasives_Native.Some
                              (DFunction
                                 (FStar_Pervasives_Native.None, meta1,
                                   (FStar_List.length tvars), t1, name1,
                                   binders, (EAbortS msg1)))))))
        | { FStar_Extraction_ML_Syntax.mllb_name = name;
            FStar_Extraction_ML_Syntax.mllb_tysc =
              FStar_Pervasives_Native.Some (tvars,t);
            FStar_Extraction_ML_Syntax.mllb_add_unit = uu____4123;
            FStar_Extraction_ML_Syntax.mllb_def = expr;
            FStar_Extraction_ML_Syntax.mllb_meta = meta;
            FStar_Extraction_ML_Syntax.print_typ = uu____4126;_} ->
            if FStar_List.mem FStar_Extraction_ML_Syntax.NoExtract meta
            then FStar_Pervasives_Native.None
            else
              (let meta1 = translate_flags meta  in
               let env1 =
                 FStar_List.fold_left
                   (fun env1  -> fun name1  -> extend_t env1 name1) env tvars
                  in
               let t1 = translate_type env1 t  in
               let name1 = ((env1.module_name), name)  in
               try
                 let expr1 = translate_expr env1 expr  in
                 FStar_Pervasives_Native.Some
                   (DGlobal
                      (meta1, name1, (FStar_List.length tvars), t1, expr1))
               with
               | e ->
                   ((let uu____4176 =
                       let uu____4181 =
                         let uu____4182 =
                           FStar_Extraction_ML_Syntax.string_of_mlpath name1
                            in
                         let uu____4183 = FStar_Util.print_exn e  in
                         FStar_Util.format2
                           "Not translating definition for %s (%s)\n"
                           uu____4182 uu____4183
                          in
                       (FStar_Errors.Warning_DefinitionNotTranslated,
                         uu____4181)
                        in
                     FStar_Errors.log_issue FStar_Range.dummyRange uu____4176);
                    FStar_Pervasives_Native.Some
                      (DGlobal
                         (meta1, name1, (FStar_List.length tvars), t1, EAny))))
        | { FStar_Extraction_ML_Syntax.mllb_name = name;
            FStar_Extraction_ML_Syntax.mllb_tysc = ts;
            FStar_Extraction_ML_Syntax.mllb_add_unit = uu____4194;
            FStar_Extraction_ML_Syntax.mllb_def = uu____4195;
            FStar_Extraction_ML_Syntax.mllb_meta = uu____4196;
            FStar_Extraction_ML_Syntax.print_typ = uu____4197;_} ->
            ((let uu____4201 =
                let uu____4206 =
                  FStar_Util.format1 "Not translating definition for %s\n"
                    name
                   in
                (FStar_Errors.Warning_DefinitionNotTranslated, uu____4206)
                 in
              FStar_Errors.log_issue FStar_Range.dummyRange uu____4201);
             (match ts with
              | FStar_Pervasives_Native.Some (idents,t) ->
                  let uu____4214 =
                    FStar_Extraction_ML_Code.string_of_mlty ([], "") t  in
                  FStar_Util.print2 "Type scheme is: forall %s. %s\n"
                    (FStar_String.concat ", " idents) uu____4214
              | FStar_Pervasives_Native.None  -> ());
             FStar_Pervasives_Native.None)

and (translate_type_decl :
  env ->
    FStar_Extraction_ML_Syntax.one_mltydecl ->
      decl FStar_Pervasives_Native.option)
  =
  fun env  ->
    fun ty  ->
      match ty with
      | (assumed,name,_mangled_name,args,flags1,FStar_Pervasives_Native.Some
         (FStar_Extraction_ML_Syntax.MLTD_Abbrev t)) ->
          let name1 = ((env.module_name), name)  in
          let env1 =
            FStar_List.fold_left
              (fun env1  -> fun name2  -> extend_t env1 name2) env args
             in
          if assumed
          then
            let name2 = FStar_Extraction_ML_Syntax.string_of_mlpath name1  in
            (FStar_Util.print1_warning
               "Not translating type definition (assumed) for %s\n" name2;
             FStar_Pervasives_Native.None)
          else
            (let uu____4252 =
               let uu____4253 =
                 let uu____4270 = translate_flags flags1  in
                 let uu____4273 = translate_type env1 t  in
                 (name1, uu____4270, (FStar_List.length args), uu____4273)
                  in
               DTypeAlias uu____4253  in
             FStar_Pervasives_Native.Some uu____4252)
      | (uu____4282,name,_mangled_name,args,flags1,FStar_Pervasives_Native.Some
         (FStar_Extraction_ML_Syntax.MLTD_Record fields)) ->
          let name1 = ((env.module_name), name)  in
          let env1 =
            FStar_List.fold_left
              (fun env1  -> fun name2  -> extend_t env1 name2) env args
             in
          let uu____4314 =
            let uu____4315 =
              let uu____4342 = translate_flags flags1  in
              let uu____4345 =
                FStar_List.map
                  (fun uu____4372  ->
                     match uu____4372 with
                     | (f,t) ->
                         let uu____4387 =
                           let uu____4392 = translate_type env1 t  in
                           (uu____4392, false)  in
                         (f, uu____4387)) fields
                 in
              (name1, uu____4342, (FStar_List.length args), uu____4345)  in
            DTypeFlat uu____4315  in
          FStar_Pervasives_Native.Some uu____4314
      | (uu____4415,name,_mangled_name,args,flags1,FStar_Pervasives_Native.Some
         (FStar_Extraction_ML_Syntax.MLTD_DType branches)) ->
          let name1 = ((env.module_name), name)  in
          let flags2 = translate_flags flags1  in
          let env1 = FStar_List.fold_left extend_t env args  in
          let uu____4452 =
            let uu____4453 =
              let uu____4486 =
                FStar_List.map
                  (fun uu____4531  ->
                     match uu____4531 with
                     | (cons1,ts) ->
                         let uu____4570 =
                           FStar_List.map
                             (fun uu____4597  ->
                                match uu____4597 with
                                | (name2,t) ->
                                    let uu____4612 =
                                      let uu____4617 = translate_type env1 t
                                         in
                                      (uu____4617, false)  in
                                    (name2, uu____4612)) ts
                            in
                         (cons1, uu____4570)) branches
                 in
              (name1, flags2, (FStar_List.length args), uu____4486)  in
            DTypeVariant uu____4453  in
          FStar_Pervasives_Native.Some uu____4452
      | (uu____4656,name,_mangled_name,uu____4659,uu____4660,uu____4661) ->
          ((let uu____4671 =
              let uu____4676 =
                FStar_Util.format1 "Not translating type definition for %s\n"
                  name
                 in
              (FStar_Errors.Warning_DefinitionNotTranslated, uu____4676)  in
            FStar_Errors.log_issue FStar_Range.dummyRange uu____4671);
           FStar_Pervasives_Native.None)

and (translate_type : env -> FStar_Extraction_ML_Syntax.mlty -> typ) =
  fun env  ->
    fun t  ->
      match t with
      | FStar_Extraction_ML_Syntax.MLTY_Tuple [] -> TAny
      | FStar_Extraction_ML_Syntax.MLTY_Top  -> TAny
      | FStar_Extraction_ML_Syntax.MLTY_Var name ->
          let uu____4680 = find_t env name  in TBound uu____4680
      | FStar_Extraction_ML_Syntax.MLTY_Fun (t1,uu____4682,t2) ->
          let uu____4684 =
            let uu____4689 = translate_type env t1  in
            let uu____4690 = translate_type env t2  in
            (uu____4689, uu____4690)  in
          TArrow uu____4684
      | FStar_Extraction_ML_Syntax.MLTY_Named ([],p) when
          let uu____4694 = FStar_Extraction_ML_Syntax.string_of_mlpath p  in
          uu____4694 = "Prims.unit" -> TUnit
      | FStar_Extraction_ML_Syntax.MLTY_Named ([],p) when
          let uu____4698 = FStar_Extraction_ML_Syntax.string_of_mlpath p  in
          uu____4698 = "Prims.bool" -> TBool
      | FStar_Extraction_ML_Syntax.MLTY_Named ([],("FStar"::m::[],"t")) when
          is_machine_int m ->
          let uu____4710 = FStar_Util.must (mk_width m)  in TInt uu____4710
      | FStar_Extraction_ML_Syntax.MLTY_Named ([],("FStar"::m::[],"t'")) when
          is_machine_int m ->
          let uu____4722 = FStar_Util.must (mk_width m)  in TInt uu____4722
      | FStar_Extraction_ML_Syntax.MLTY_Named (arg::[],p) when
          let uu____4727 = FStar_Extraction_ML_Syntax.string_of_mlpath p  in
          uu____4727 = "FStar.Monotonic.HyperStack.mem" -> TUnit
      | FStar_Extraction_ML_Syntax.MLTY_Named
          (uu____4728::arg::uu____4730::[],p) when
          (((let uu____4736 = FStar_Extraction_ML_Syntax.string_of_mlpath p
                in
             uu____4736 = "FStar.Monotonic.HyperStack.s_mref") ||
              (let uu____4738 = FStar_Extraction_ML_Syntax.string_of_mlpath p
                  in
               uu____4738 = "FStar.Monotonic.HyperHeap.mrref"))
             ||
             (let uu____4740 = FStar_Extraction_ML_Syntax.string_of_mlpath p
                 in
              uu____4740 = "FStar.HyperStack.ST.m_rref"))
            ||
            (let uu____4742 = FStar_Extraction_ML_Syntax.string_of_mlpath p
                in
             uu____4742 = "FStar.HyperStack.ST.s_mref")
          -> let uu____4743 = translate_type env arg  in TBuf uu____4743
      | FStar_Extraction_ML_Syntax.MLTY_Named (arg::uu____4745::[],p) when
          ((((((((((let uu____4751 =
                      FStar_Extraction_ML_Syntax.string_of_mlpath p  in
                    uu____4751 = "FStar.Monotonic.HyperStack.mreference") ||
                     (let uu____4753 =
                        FStar_Extraction_ML_Syntax.string_of_mlpath p  in
                      uu____4753 = "FStar.Monotonic.HyperStack.mstackref"))
                    ||
                    (let uu____4755 =
                       FStar_Extraction_ML_Syntax.string_of_mlpath p  in
                     uu____4755 = "FStar.Monotonic.HyperStack.mref"))
                   ||
                   (let uu____4757 =
                      FStar_Extraction_ML_Syntax.string_of_mlpath p  in
                    uu____4757 = "FStar.Monotonic.HyperStack.mmmstackref"))
                  ||
                  (let uu____4759 =
                     FStar_Extraction_ML_Syntax.string_of_mlpath p  in
                   uu____4759 = "FStar.Monotonic.HyperStack.mmmref"))
                 ||
                 (let uu____4761 =
                    FStar_Extraction_ML_Syntax.string_of_mlpath p  in
                  uu____4761 = "FStar.Monotonic.Heap.mref"))
                ||
                (let uu____4763 =
                   FStar_Extraction_ML_Syntax.string_of_mlpath p  in
                 uu____4763 = "FStar.HyperStack.ST.mreference"))
               ||
               (let uu____4765 =
                  FStar_Extraction_ML_Syntax.string_of_mlpath p  in
                uu____4765 = "FStar.HyperStack.ST.mstackref"))
              ||
              (let uu____4767 = FStar_Extraction_ML_Syntax.string_of_mlpath p
                  in
               uu____4767 = "FStar.HyperStack.ST.mref"))
             ||
             (let uu____4769 = FStar_Extraction_ML_Syntax.string_of_mlpath p
                 in
              uu____4769 = "FStar.HyperStack.ST.mmmstackref"))
            ||
            (let uu____4771 = FStar_Extraction_ML_Syntax.string_of_mlpath p
                in
             uu____4771 = "FStar.HyperStack.ST.mmmref")
          -> let uu____4772 = translate_type env arg  in TBuf uu____4772
      | FStar_Extraction_ML_Syntax.MLTY_Named (arg::[],p) when
          ((((((((((let uu____4779 =
                      FStar_Extraction_ML_Syntax.string_of_mlpath p  in
                    uu____4779 = "FStar.Buffer.buffer") ||
                     (let uu____4781 =
                        FStar_Extraction_ML_Syntax.string_of_mlpath p  in
                      uu____4781 = "FStar.HyperStack.reference"))
                    ||
                    (let uu____4783 =
                       FStar_Extraction_ML_Syntax.string_of_mlpath p  in
                     uu____4783 = "FStar.HyperStack.stackref"))
                   ||
                   (let uu____4785 =
                      FStar_Extraction_ML_Syntax.string_of_mlpath p  in
                    uu____4785 = "FStar.HyperStack.ref"))
                  ||
                  (let uu____4787 =
                     FStar_Extraction_ML_Syntax.string_of_mlpath p  in
                   uu____4787 = "FStar.HyperStack.mmstackref"))
                 ||
                 (let uu____4789 =
                    FStar_Extraction_ML_Syntax.string_of_mlpath p  in
                  uu____4789 = "FStar.HyperStack.mmref"))
                ||
                (let uu____4791 =
                   FStar_Extraction_ML_Syntax.string_of_mlpath p  in
                 uu____4791 = "FStar.HyperStack.ST.reference"))
               ||
               (let uu____4793 =
                  FStar_Extraction_ML_Syntax.string_of_mlpath p  in
                uu____4793 = "FStar.HyperStack.ST.stackref"))
              ||
              (let uu____4795 = FStar_Extraction_ML_Syntax.string_of_mlpath p
                  in
               uu____4795 = "FStar.HyperStack.ST.ref"))
             ||
             (let uu____4797 = FStar_Extraction_ML_Syntax.string_of_mlpath p
                 in
              uu____4797 = "FStar.HyperStack.ST.mmstackref"))
            ||
            (let uu____4799 = FStar_Extraction_ML_Syntax.string_of_mlpath p
                in
             uu____4799 = "FStar.HyperStack.ST.mmref")
          -> let uu____4800 = translate_type env arg  in TBuf uu____4800
      | FStar_Extraction_ML_Syntax.MLTY_Named (uu____4801::arg::[],p) when
          (let uu____4808 = FStar_Extraction_ML_Syntax.string_of_mlpath p  in
           uu____4808 = "FStar.HyperStack.s_ref") ||
            (let uu____4810 = FStar_Extraction_ML_Syntax.string_of_mlpath p
                in
             uu____4810 = "FStar.HyperStack.ST.s_ref")
          -> let uu____4811 = translate_type env arg  in TBuf uu____4811
      | FStar_Extraction_ML_Syntax.MLTY_Named (uu____4812::[],p) when
          let uu____4816 = FStar_Extraction_ML_Syntax.string_of_mlpath p  in
          uu____4816 = "FStar.Ghost.erased" -> TAny
      | FStar_Extraction_ML_Syntax.MLTY_Named ([],(path,type_name)) ->
          TQualified (path, type_name)
      | FStar_Extraction_ML_Syntax.MLTY_Named (args,(ns,t1)) when
          ((ns = ["Prims"]) || (ns = ["FStar"; "Pervasives"; "Native"])) &&
            (FStar_Util.starts_with t1 "tuple")
          ->
          let uu____4854 = FStar_List.map (translate_type env) args  in
          TTuple uu____4854
      | FStar_Extraction_ML_Syntax.MLTY_Named (args,lid) ->
          if (FStar_List.length args) > (Prims.parse_int "0")
          then
            let uu____4863 =
              let uu____4876 = FStar_List.map (translate_type env) args  in
              (lid, uu____4876)  in
            TApp uu____4863
          else TQualified lid
      | FStar_Extraction_ML_Syntax.MLTY_Tuple ts ->
          let uu____4885 = FStar_List.map (translate_type env) ts  in
          TTuple uu____4885

and (translate_binders :
  env ->
    (FStar_Extraction_ML_Syntax.mlident,FStar_Extraction_ML_Syntax.mlty)
      FStar_Pervasives_Native.tuple2 Prims.list -> binder Prims.list)
  = fun env  -> fun args  -> FStar_List.map (translate_binder env) args

and (translate_binder :
  env ->
    (FStar_Extraction_ML_Syntax.mlident,FStar_Extraction_ML_Syntax.mlty)
      FStar_Pervasives_Native.tuple2 -> binder)
  =
  fun env  ->
    fun uu____4901  ->
      match uu____4901 with
      | (name,typ) ->
          let uu____4908 = translate_type env typ  in
          { name; typ = uu____4908 }

and (translate_expr : env -> FStar_Extraction_ML_Syntax.mlexpr -> expr) =
  fun env  ->
    fun e  ->
      match e.FStar_Extraction_ML_Syntax.expr with
      | FStar_Extraction_ML_Syntax.MLE_Tuple [] -> EUnit
      | FStar_Extraction_ML_Syntax.MLE_Const c -> translate_constant c
      | FStar_Extraction_ML_Syntax.MLE_Var name ->
          let uu____4913 = find env name  in EBound uu____4913
      | FStar_Extraction_ML_Syntax.MLE_Name ("FStar"::m::[],op) when
          (is_machine_int m) && (is_op op) ->
          let uu____4918 =
            let uu____4923 = FStar_Util.must (mk_op op)  in
            let uu____4924 = FStar_Util.must (mk_width m)  in
            (uu____4923, uu____4924)  in
          EOp uu____4918
      | FStar_Extraction_ML_Syntax.MLE_Name ("Prims"::[],op) when
          is_bool_op op ->
          let uu____4928 =
            let uu____4933 = FStar_Util.must (mk_bool_op op)  in
            (uu____4933, Bool)  in
          EOp uu____4928
      | FStar_Extraction_ML_Syntax.MLE_Name n1 -> EQualified n1
      | FStar_Extraction_ML_Syntax.MLE_Let
          ((flavor,{ FStar_Extraction_ML_Syntax.mllb_name = name;
                     FStar_Extraction_ML_Syntax.mllb_tysc =
                       FStar_Pervasives_Native.Some ([],typ);
                     FStar_Extraction_ML_Syntax.mllb_add_unit = add_unit;
                     FStar_Extraction_ML_Syntax.mllb_def = body;
                     FStar_Extraction_ML_Syntax.mllb_meta = flags1;
                     FStar_Extraction_ML_Syntax.print_typ = print7;_}::[]),continuation)
          ->
          let binder =
            let uu____4960 = translate_type env typ  in
            { name; typ = uu____4960 }  in
          let body1 = translate_expr env body  in
          let env1 = extend env name  in
          let continuation1 = translate_expr env1 continuation  in
          ELet (binder, body1, continuation1)
      | FStar_Extraction_ML_Syntax.MLE_Match (expr,branches) ->
          let uu____4986 =
            let uu____4997 = translate_expr env expr  in
            let uu____4998 = translate_branches env branches  in
            (uu____4997, uu____4998)  in
          EMatch uu____4986
      | FStar_Extraction_ML_Syntax.MLE_App
          ({
             FStar_Extraction_ML_Syntax.expr =
               FStar_Extraction_ML_Syntax.MLE_TApp
               ({
                  FStar_Extraction_ML_Syntax.expr =
                    FStar_Extraction_ML_Syntax.MLE_Name p;
                  FStar_Extraction_ML_Syntax.mlty = uu____5012;
                  FStar_Extraction_ML_Syntax.loc = uu____5013;_},t::[]);
             FStar_Extraction_ML_Syntax.mlty = uu____5015;
             FStar_Extraction_ML_Syntax.loc = uu____5016;_},arg::[])
          when
          let uu____5022 = FStar_Extraction_ML_Syntax.string_of_mlpath p  in
          uu____5022 = "FStar.Dyn.undyn" ->
          let uu____5023 =
            let uu____5028 = translate_expr env arg  in
            let uu____5029 = translate_type env t  in
            (uu____5028, uu____5029)  in
          ECast uu____5023
      | FStar_Extraction_ML_Syntax.MLE_App
          ({
             FStar_Extraction_ML_Syntax.expr =
               FStar_Extraction_ML_Syntax.MLE_TApp
               ({
                  FStar_Extraction_ML_Syntax.expr =
                    FStar_Extraction_ML_Syntax.MLE_Name p;
                  FStar_Extraction_ML_Syntax.mlty = uu____5031;
                  FStar_Extraction_ML_Syntax.loc = uu____5032;_},uu____5033);
             FStar_Extraction_ML_Syntax.mlty = uu____5034;
             FStar_Extraction_ML_Syntax.loc = uu____5035;_},uu____5036)
          when
          let uu____5045 = FStar_Extraction_ML_Syntax.string_of_mlpath p  in
          uu____5045 = "Prims.admit" -> EAbort
      | FStar_Extraction_ML_Syntax.MLE_App
          ({
             FStar_Extraction_ML_Syntax.expr =
               FStar_Extraction_ML_Syntax.MLE_TApp
               ({
                  FStar_Extraction_ML_Syntax.expr =
                    FStar_Extraction_ML_Syntax.MLE_Name p;
                  FStar_Extraction_ML_Syntax.mlty = uu____5047;
                  FStar_Extraction_ML_Syntax.loc = uu____5048;_},uu____5049);
             FStar_Extraction_ML_Syntax.mlty = uu____5050;
             FStar_Extraction_ML_Syntax.loc = uu____5051;_},arg::[])
          when
          ((let uu____5061 = FStar_Extraction_ML_Syntax.string_of_mlpath p
               in
            uu____5061 = "FStar.HyperStack.All.failwith") ||
             (let uu____5063 = FStar_Extraction_ML_Syntax.string_of_mlpath p
                 in
              uu____5063 = "FStar.Error.unexpected"))
            ||
            (let uu____5065 = FStar_Extraction_ML_Syntax.string_of_mlpath p
                in
             uu____5065 = "FStar.Error.unreachable")
          ->
          (match arg with
           | {
               FStar_Extraction_ML_Syntax.expr =
                 FStar_Extraction_ML_Syntax.MLE_Const
                 (FStar_Extraction_ML_Syntax.MLC_String msg);
               FStar_Extraction_ML_Syntax.mlty = uu____5067;
               FStar_Extraction_ML_Syntax.loc = uu____5068;_} -> EAbortS msg
           | uu____5069 ->
               let print7 =
                 let uu____5071 =
                   let uu____5072 =
                     let uu____5073 =
                       FStar_Ident.lid_of_str
                         "FStar.HyperStack.IO.print_string"
                        in
                     FStar_Extraction_ML_Syntax.mlpath_of_lident uu____5073
                      in
                   FStar_Extraction_ML_Syntax.MLE_Name uu____5072  in
                 FStar_Extraction_ML_Syntax.with_ty
                   FStar_Extraction_ML_Syntax.MLTY_Top uu____5071
                  in
               let print8 =
                 FStar_Extraction_ML_Syntax.with_ty
                   FStar_Extraction_ML_Syntax.MLTY_Top
                   (FStar_Extraction_ML_Syntax.MLE_App (print7, [arg]))
                  in
               let t = translate_expr env print8  in ESequence [t; EAbort])
      | FStar_Extraction_ML_Syntax.MLE_App
          ({
             FStar_Extraction_ML_Syntax.expr =
               FStar_Extraction_ML_Syntax.MLE_TApp
               ({
                  FStar_Extraction_ML_Syntax.expr =
                    FStar_Extraction_ML_Syntax.MLE_Name p;
                  FStar_Extraction_ML_Syntax.mlty = uu____5079;
                  FStar_Extraction_ML_Syntax.loc = uu____5080;_},uu____5081);
             FStar_Extraction_ML_Syntax.mlty = uu____5082;
             FStar_Extraction_ML_Syntax.loc = uu____5083;_},e1::e2::[])
          when
          (let uu____5094 = FStar_Extraction_ML_Syntax.string_of_mlpath p  in
           uu____5094 = "FStar.Buffer.index") ||
            (let uu____5096 = FStar_Extraction_ML_Syntax.string_of_mlpath p
                in
             uu____5096 = "FStar.Buffer.op_Array_Access")
          ->
          let uu____5097 =
            let uu____5102 = translate_expr env e1  in
            let uu____5103 = translate_expr env e2  in
            (uu____5102, uu____5103)  in
          EBufRead uu____5097
      | FStar_Extraction_ML_Syntax.MLE_App
          ({
             FStar_Extraction_ML_Syntax.expr =
               FStar_Extraction_ML_Syntax.MLE_TApp
               ({
                  FStar_Extraction_ML_Syntax.expr =
                    FStar_Extraction_ML_Syntax.MLE_Name p;
                  FStar_Extraction_ML_Syntax.mlty = uu____5105;
                  FStar_Extraction_ML_Syntax.loc = uu____5106;_},uu____5107);
             FStar_Extraction_ML_Syntax.mlty = uu____5108;
             FStar_Extraction_ML_Syntax.loc = uu____5109;_},e1::[])
          when
          let uu____5117 = FStar_Extraction_ML_Syntax.string_of_mlpath p  in
          uu____5117 = "FStar.HyperStack.ST.op_Bang" ->
          let uu____5118 =
            let uu____5123 = translate_expr env e1  in
            (uu____5123, (EConstant (UInt32, "0")))  in
          EBufRead uu____5118
      | FStar_Extraction_ML_Syntax.MLE_App
          ({
             FStar_Extraction_ML_Syntax.expr =
               FStar_Extraction_ML_Syntax.MLE_TApp
               ({
                  FStar_Extraction_ML_Syntax.expr =
                    FStar_Extraction_ML_Syntax.MLE_Name p;
                  FStar_Extraction_ML_Syntax.mlty = uu____5125;
                  FStar_Extraction_ML_Syntax.loc = uu____5126;_},uu____5127);
             FStar_Extraction_ML_Syntax.mlty = uu____5128;
             FStar_Extraction_ML_Syntax.loc = uu____5129;_},e1::e2::[])
          when
          let uu____5138 = FStar_Extraction_ML_Syntax.string_of_mlpath p  in
          uu____5138 = "FStar.Buffer.create" ->
          let uu____5139 =
            let uu____5146 = translate_expr env e1  in
            let uu____5147 = translate_expr env e2  in
            (Stack, uu____5146, uu____5147)  in
          EBufCreate uu____5139
      | FStar_Extraction_ML_Syntax.MLE_App
          ({
             FStar_Extraction_ML_Syntax.expr =
               FStar_Extraction_ML_Syntax.MLE_TApp
               ({
                  FStar_Extraction_ML_Syntax.expr =
                    FStar_Extraction_ML_Syntax.MLE_Name p;
                  FStar_Extraction_ML_Syntax.mlty = uu____5149;
                  FStar_Extraction_ML_Syntax.loc = uu____5150;_},uu____5151);
             FStar_Extraction_ML_Syntax.mlty = uu____5152;
             FStar_Extraction_ML_Syntax.loc = uu____5153;_},init1::[])
          when
          let uu____5161 = FStar_Extraction_ML_Syntax.string_of_mlpath p  in
          uu____5161 = "FStar.HyperStack.ST.salloc" ->
          let uu____5162 =
            let uu____5169 = translate_expr env init1  in
            (Stack, uu____5169, (EConstant (UInt32, "1")))  in
          EBufCreate uu____5162
      | FStar_Extraction_ML_Syntax.MLE_App
          ({
             FStar_Extraction_ML_Syntax.expr =
               FStar_Extraction_ML_Syntax.MLE_TApp
               ({
                  FStar_Extraction_ML_Syntax.expr =
                    FStar_Extraction_ML_Syntax.MLE_Name p;
                  FStar_Extraction_ML_Syntax.mlty = uu____5171;
                  FStar_Extraction_ML_Syntax.loc = uu____5172;_},uu____5173);
             FStar_Extraction_ML_Syntax.mlty = uu____5174;
             FStar_Extraction_ML_Syntax.loc = uu____5175;_},e2::[])
          when
          let uu____5183 = FStar_Extraction_ML_Syntax.string_of_mlpath p  in
          uu____5183 = "FStar.Buffer.createL" ->
          let rec list_elements acc e21 =
            match e21.FStar_Extraction_ML_Syntax.expr with
            | FStar_Extraction_ML_Syntax.MLE_CTor
                (("Prims"::[],"Cons"),hd1::tl1::[]) ->
                list_elements (hd1 :: acc) tl1
            | FStar_Extraction_ML_Syntax.MLE_CTor (("Prims"::[],"Nil"),[]) ->
                FStar_List.rev acc
            | uu____5225 ->
                failwith
                  "Argument of FStar.Buffer.createL is not a list literal!"
             in
          let list_elements1 = list_elements []  in
          let uu____5235 =
            let uu____5242 =
              let uu____5245 = list_elements1 e2  in
              FStar_List.map (translate_expr env) uu____5245  in
            (Stack, uu____5242)  in
          EBufCreateL uu____5235
      | FStar_Extraction_ML_Syntax.MLE_App
          ({
             FStar_Extraction_ML_Syntax.expr =
               FStar_Extraction_ML_Syntax.MLE_TApp
               ({
                  FStar_Extraction_ML_Syntax.expr =
                    FStar_Extraction_ML_Syntax.MLE_Name p;
                  FStar_Extraction_ML_Syntax.mlty = uu____5251;
                  FStar_Extraction_ML_Syntax.loc = uu____5252;_},uu____5253);
             FStar_Extraction_ML_Syntax.mlty = uu____5254;
             FStar_Extraction_ML_Syntax.loc = uu____5255;_},_rid::init1::[])
          when
          let uu____5264 = FStar_Extraction_ML_Syntax.string_of_mlpath p  in
          uu____5264 = "FStar.HyperStack.ST.ralloc" ->
          let uu____5265 =
            let uu____5272 = translate_expr env init1  in
            (Eternal, uu____5272, (EConstant (UInt32, "1")))  in
          EBufCreate uu____5265
      | FStar_Extraction_ML_Syntax.MLE_App
          ({
             FStar_Extraction_ML_Syntax.expr =
               FStar_Extraction_ML_Syntax.MLE_TApp
               ({
                  FStar_Extraction_ML_Syntax.expr =
                    FStar_Extraction_ML_Syntax.MLE_Name p;
                  FStar_Extraction_ML_Syntax.mlty = uu____5274;
                  FStar_Extraction_ML_Syntax.loc = uu____5275;_},uu____5276);
             FStar_Extraction_ML_Syntax.mlty = uu____5277;
             FStar_Extraction_ML_Syntax.loc = uu____5278;_},_e0::e1::e2::[])
          when
          let uu____5288 = FStar_Extraction_ML_Syntax.string_of_mlpath p  in
          uu____5288 = "FStar.Buffer.rcreate" ->
          let uu____5289 =
            let uu____5296 = translate_expr env e1  in
            let uu____5297 = translate_expr env e2  in
            (Eternal, uu____5296, uu____5297)  in
          EBufCreate uu____5289
      | FStar_Extraction_ML_Syntax.MLE_App
          ({
             FStar_Extraction_ML_Syntax.expr =
               FStar_Extraction_ML_Syntax.MLE_TApp
               ({
                  FStar_Extraction_ML_Syntax.expr =
                    FStar_Extraction_ML_Syntax.MLE_Name p;
                  FStar_Extraction_ML_Syntax.mlty = uu____5299;
                  FStar_Extraction_ML_Syntax.loc = uu____5300;_},uu____5301);
             FStar_Extraction_ML_Syntax.mlty = uu____5302;
             FStar_Extraction_ML_Syntax.loc = uu____5303;_},_rid::init1::[])
          when
          let uu____5312 = FStar_Extraction_ML_Syntax.string_of_mlpath p  in
          uu____5312 = "FStar.HyperStack.ST.ralloc_mm" ->
          let uu____5313 =
            let uu____5320 = translate_expr env init1  in
            (ManuallyManaged, uu____5320, (EConstant (UInt32, "1")))  in
          EBufCreate uu____5313
      | FStar_Extraction_ML_Syntax.MLE_App
          ({
             FStar_Extraction_ML_Syntax.expr =
               FStar_Extraction_ML_Syntax.MLE_TApp
               ({
                  FStar_Extraction_ML_Syntax.expr =
                    FStar_Extraction_ML_Syntax.MLE_Name p;
                  FStar_Extraction_ML_Syntax.mlty = uu____5322;
                  FStar_Extraction_ML_Syntax.loc = uu____5323;_},uu____5324);
             FStar_Extraction_ML_Syntax.mlty = uu____5325;
             FStar_Extraction_ML_Syntax.loc = uu____5326;_},_e0::e1::e2::[])
          when
          let uu____5336 = FStar_Extraction_ML_Syntax.string_of_mlpath p  in
          uu____5336 = "FStar.Buffer.rcreate_mm" ->
          let uu____5337 =
            let uu____5344 = translate_expr env e1  in
            let uu____5345 = translate_expr env e2  in
            (ManuallyManaged, uu____5344, uu____5345)  in
          EBufCreate uu____5337
      | FStar_Extraction_ML_Syntax.MLE_App
          ({
             FStar_Extraction_ML_Syntax.expr =
               FStar_Extraction_ML_Syntax.MLE_TApp
               ({
                  FStar_Extraction_ML_Syntax.expr =
                    FStar_Extraction_ML_Syntax.MLE_Name p;
                  FStar_Extraction_ML_Syntax.mlty = uu____5347;
                  FStar_Extraction_ML_Syntax.loc = uu____5348;_},uu____5349);
             FStar_Extraction_ML_Syntax.mlty = uu____5350;
             FStar_Extraction_ML_Syntax.loc = uu____5351;_},e2::[])
          when
          let uu____5359 = FStar_Extraction_ML_Syntax.string_of_mlpath p  in
          uu____5359 = "FStar.HyperStack.ST.rfree" ->
          let uu____5360 = translate_expr env e2  in EBufFree uu____5360
      | FStar_Extraction_ML_Syntax.MLE_App
          ({
             FStar_Extraction_ML_Syntax.expr =
               FStar_Extraction_ML_Syntax.MLE_TApp
               ({
                  FStar_Extraction_ML_Syntax.expr =
                    FStar_Extraction_ML_Syntax.MLE_Name p;
                  FStar_Extraction_ML_Syntax.mlty = uu____5362;
                  FStar_Extraction_ML_Syntax.loc = uu____5363;_},uu____5364);
             FStar_Extraction_ML_Syntax.mlty = uu____5365;
             FStar_Extraction_ML_Syntax.loc = uu____5366;_},e2::[])
          when
          let uu____5374 = FStar_Extraction_ML_Syntax.string_of_mlpath p  in
          uu____5374 = "FStar.Buffer.rfree" ->
          let uu____5375 = translate_expr env e2  in EBufFree uu____5375
      | FStar_Extraction_ML_Syntax.MLE_App
          ({
             FStar_Extraction_ML_Syntax.expr =
               FStar_Extraction_ML_Syntax.MLE_TApp
               ({
                  FStar_Extraction_ML_Syntax.expr =
                    FStar_Extraction_ML_Syntax.MLE_Name p;
                  FStar_Extraction_ML_Syntax.mlty = uu____5377;
                  FStar_Extraction_ML_Syntax.loc = uu____5378;_},uu____5379);
             FStar_Extraction_ML_Syntax.mlty = uu____5380;
             FStar_Extraction_ML_Syntax.loc = uu____5381;_},e1::e2::_e3::[])
          when
          let uu____5391 = FStar_Extraction_ML_Syntax.string_of_mlpath p  in
          uu____5391 = "FStar.Buffer.sub" ->
          let uu____5392 =
            let uu____5397 = translate_expr env e1  in
            let uu____5398 = translate_expr env e2  in
            (uu____5397, uu____5398)  in
          EBufSub uu____5392
      | FStar_Extraction_ML_Syntax.MLE_App
          ({
             FStar_Extraction_ML_Syntax.expr =
               FStar_Extraction_ML_Syntax.MLE_TApp
               ({
                  FStar_Extraction_ML_Syntax.expr =
                    FStar_Extraction_ML_Syntax.MLE_Name p;
                  FStar_Extraction_ML_Syntax.mlty = uu____5400;
                  FStar_Extraction_ML_Syntax.loc = uu____5401;_},uu____5402);
             FStar_Extraction_ML_Syntax.mlty = uu____5403;
             FStar_Extraction_ML_Syntax.loc = uu____5404;_},e1::e2::[])
          when
          let uu____5413 = FStar_Extraction_ML_Syntax.string_of_mlpath p  in
          uu____5413 = "FStar.Buffer.join" -> translate_expr env e1
      | FStar_Extraction_ML_Syntax.MLE_App
          ({
             FStar_Extraction_ML_Syntax.expr =
               FStar_Extraction_ML_Syntax.MLE_TApp
               ({
                  FStar_Extraction_ML_Syntax.expr =
                    FStar_Extraction_ML_Syntax.MLE_Name p;
                  FStar_Extraction_ML_Syntax.mlty = uu____5415;
                  FStar_Extraction_ML_Syntax.loc = uu____5416;_},uu____5417);
             FStar_Extraction_ML_Syntax.mlty = uu____5418;
             FStar_Extraction_ML_Syntax.loc = uu____5419;_},e1::e2::[])
          when
          let uu____5428 = FStar_Extraction_ML_Syntax.string_of_mlpath p  in
          uu____5428 = "FStar.Buffer.offset" ->
          let uu____5429 =
            let uu____5434 = translate_expr env e1  in
            let uu____5435 = translate_expr env e2  in
            (uu____5434, uu____5435)  in
          EBufSub uu____5429
      | FStar_Extraction_ML_Syntax.MLE_App
          ({
             FStar_Extraction_ML_Syntax.expr =
               FStar_Extraction_ML_Syntax.MLE_TApp
               ({
                  FStar_Extraction_ML_Syntax.expr =
                    FStar_Extraction_ML_Syntax.MLE_Name p;
                  FStar_Extraction_ML_Syntax.mlty = uu____5437;
                  FStar_Extraction_ML_Syntax.loc = uu____5438;_},uu____5439);
             FStar_Extraction_ML_Syntax.mlty = uu____5440;
             FStar_Extraction_ML_Syntax.loc = uu____5441;_},e1::e2::e3::[])
          when
          (let uu____5453 = FStar_Extraction_ML_Syntax.string_of_mlpath p  in
           uu____5453 = "FStar.Buffer.upd") ||
            (let uu____5455 = FStar_Extraction_ML_Syntax.string_of_mlpath p
                in
             uu____5455 = "FStar.Buffer.op_Array_Assignment")
          ->
          let uu____5456 =
            let uu____5463 = translate_expr env e1  in
            let uu____5464 = translate_expr env e2  in
            let uu____5465 = translate_expr env e3  in
            (uu____5463, uu____5464, uu____5465)  in
          EBufWrite uu____5456
      | FStar_Extraction_ML_Syntax.MLE_App
          ({
             FStar_Extraction_ML_Syntax.expr =
               FStar_Extraction_ML_Syntax.MLE_TApp
               ({
                  FStar_Extraction_ML_Syntax.expr =
                    FStar_Extraction_ML_Syntax.MLE_Name p;
                  FStar_Extraction_ML_Syntax.mlty = uu____5467;
                  FStar_Extraction_ML_Syntax.loc = uu____5468;_},uu____5469);
             FStar_Extraction_ML_Syntax.mlty = uu____5470;
             FStar_Extraction_ML_Syntax.loc = uu____5471;_},e1::e2::[])
          when
          let uu____5480 = FStar_Extraction_ML_Syntax.string_of_mlpath p  in
          uu____5480 = "FStar.HyperStack.ST.op_Colon_Equals" ->
          let uu____5481 =
            let uu____5488 = translate_expr env e1  in
            let uu____5489 = translate_expr env e2  in
            (uu____5488, (EConstant (UInt32, "0")), uu____5489)  in
          EBufWrite uu____5481
      | FStar_Extraction_ML_Syntax.MLE_App
          ({
             FStar_Extraction_ML_Syntax.expr =
               FStar_Extraction_ML_Syntax.MLE_Name p;
             FStar_Extraction_ML_Syntax.mlty = uu____5491;
             FStar_Extraction_ML_Syntax.loc = uu____5492;_},uu____5493::[])
          when
          let uu____5496 = FStar_Extraction_ML_Syntax.string_of_mlpath p  in
          uu____5496 = "FStar.HyperStack.ST.push_frame" -> EPushFrame
      | FStar_Extraction_ML_Syntax.MLE_App
          ({
             FStar_Extraction_ML_Syntax.expr =
               FStar_Extraction_ML_Syntax.MLE_Name p;
             FStar_Extraction_ML_Syntax.mlty = uu____5498;
             FStar_Extraction_ML_Syntax.loc = uu____5499;_},uu____5500::[])
          when
          let uu____5503 = FStar_Extraction_ML_Syntax.string_of_mlpath p  in
          uu____5503 = "FStar.HyperStack.ST.pop_frame" -> EPopFrame
      | FStar_Extraction_ML_Syntax.MLE_App
          ({
             FStar_Extraction_ML_Syntax.expr =
               FStar_Extraction_ML_Syntax.MLE_TApp
               ({
                  FStar_Extraction_ML_Syntax.expr =
                    FStar_Extraction_ML_Syntax.MLE_Name p;
                  FStar_Extraction_ML_Syntax.mlty = uu____5505;
                  FStar_Extraction_ML_Syntax.loc = uu____5506;_},uu____5507);
             FStar_Extraction_ML_Syntax.mlty = uu____5508;
             FStar_Extraction_ML_Syntax.loc = uu____5509;_},e1::e2::e3::e4::e5::[])
          when
          let uu____5521 = FStar_Extraction_ML_Syntax.string_of_mlpath p  in
          uu____5521 = "FStar.Buffer.blit" ->
          let uu____5522 =
            let uu____5533 = translate_expr env e1  in
            let uu____5534 = translate_expr env e2  in
            let uu____5535 = translate_expr env e3  in
            let uu____5536 = translate_expr env e4  in
            let uu____5537 = translate_expr env e5  in
            (uu____5533, uu____5534, uu____5535, uu____5536, uu____5537)  in
          EBufBlit uu____5522
      | FStar_Extraction_ML_Syntax.MLE_App
          ({
             FStar_Extraction_ML_Syntax.expr =
               FStar_Extraction_ML_Syntax.MLE_TApp
               ({
                  FStar_Extraction_ML_Syntax.expr =
                    FStar_Extraction_ML_Syntax.MLE_Name p;
                  FStar_Extraction_ML_Syntax.mlty = uu____5539;
                  FStar_Extraction_ML_Syntax.loc = uu____5540;_},uu____5541);
             FStar_Extraction_ML_Syntax.mlty = uu____5542;
             FStar_Extraction_ML_Syntax.loc = uu____5543;_},e1::e2::e3::[])
          when
          let uu____5553 = FStar_Extraction_ML_Syntax.string_of_mlpath p  in
          uu____5553 = "FStar.Buffer.fill" ->
          let uu____5554 =
            let uu____5561 = translate_expr env e1  in
            let uu____5562 = translate_expr env e2  in
            let uu____5563 = translate_expr env e3  in
            (uu____5561, uu____5562, uu____5563)  in
          EBufFill uu____5554
      | FStar_Extraction_ML_Syntax.MLE_App
          ({
             FStar_Extraction_ML_Syntax.expr =
               FStar_Extraction_ML_Syntax.MLE_Name p;
             FStar_Extraction_ML_Syntax.mlty = uu____5565;
             FStar_Extraction_ML_Syntax.loc = uu____5566;_},uu____5567::[])
          when
          let uu____5570 = FStar_Extraction_ML_Syntax.string_of_mlpath p  in
          uu____5570 = "FStar.HyperStack.ST.get" -> EUnit
      | FStar_Extraction_ML_Syntax.MLE_App
          ({
             FStar_Extraction_ML_Syntax.expr =
               FStar_Extraction_ML_Syntax.MLE_Name p;
             FStar_Extraction_ML_Syntax.mlty = uu____5572;
             FStar_Extraction_ML_Syntax.loc = uu____5573;_},e1::[])
          when
          let uu____5577 = FStar_Extraction_ML_Syntax.string_of_mlpath p  in
          uu____5577 = "Obj.repr" ->
          let uu____5578 =
            let uu____5583 = translate_expr env e1  in (uu____5583, TAny)  in
          ECast uu____5578
      | FStar_Extraction_ML_Syntax.MLE_App
          ({
             FStar_Extraction_ML_Syntax.expr =
               FStar_Extraction_ML_Syntax.MLE_Name ("FStar"::m::[],op);
             FStar_Extraction_ML_Syntax.mlty = uu____5586;
             FStar_Extraction_ML_Syntax.loc = uu____5587;_},args)
          when (is_machine_int m) && (is_op op) ->
          let uu____5595 = FStar_Util.must (mk_width m)  in
          let uu____5596 = FStar_Util.must (mk_op op)  in
          mk_op_app env uu____5595 uu____5596 args
      | FStar_Extraction_ML_Syntax.MLE_App
          ({
             FStar_Extraction_ML_Syntax.expr =
               FStar_Extraction_ML_Syntax.MLE_Name ("Prims"::[],op);
             FStar_Extraction_ML_Syntax.mlty = uu____5598;
             FStar_Extraction_ML_Syntax.loc = uu____5599;_},args)
          when is_bool_op op ->
          let uu____5607 = FStar_Util.must (mk_bool_op op)  in
          mk_op_app env Bool uu____5607 args
      | FStar_Extraction_ML_Syntax.MLE_App
          ({
             FStar_Extraction_ML_Syntax.expr =
               FStar_Extraction_ML_Syntax.MLE_Name
               ("FStar"::m::[],"int_to_t");
             FStar_Extraction_ML_Syntax.mlty = uu____5609;
             FStar_Extraction_ML_Syntax.loc = uu____5610;_},{
                                                              FStar_Extraction_ML_Syntax.expr
                                                                =
                                                                FStar_Extraction_ML_Syntax.MLE_Const
                                                                (FStar_Extraction_ML_Syntax.MLC_Int
                                                                (c,FStar_Pervasives_Native.None
                                                                 ));
                                                              FStar_Extraction_ML_Syntax.mlty
                                                                = uu____5612;
                                                              FStar_Extraction_ML_Syntax.loc
                                                                = uu____5613;_}::[])
          when is_machine_int m ->
          let uu____5628 =
            let uu____5633 = FStar_Util.must (mk_width m)  in (uu____5633, c)
             in
          EConstant uu____5628
      | FStar_Extraction_ML_Syntax.MLE_App
          ({
             FStar_Extraction_ML_Syntax.expr =
               FStar_Extraction_ML_Syntax.MLE_Name
               ("FStar"::m::[],"uint_to_t");
             FStar_Extraction_ML_Syntax.mlty = uu____5635;
             FStar_Extraction_ML_Syntax.loc = uu____5636;_},{
                                                              FStar_Extraction_ML_Syntax.expr
                                                                =
                                                                FStar_Extraction_ML_Syntax.MLE_Const
                                                                (FStar_Extraction_ML_Syntax.MLC_Int
                                                                (c,FStar_Pervasives_Native.None
                                                                 ));
                                                              FStar_Extraction_ML_Syntax.mlty
                                                                = uu____5638;
                                                              FStar_Extraction_ML_Syntax.loc
                                                                = uu____5639;_}::[])
          when is_machine_int m ->
          let uu____5654 =
            let uu____5659 = FStar_Util.must (mk_width m)  in (uu____5659, c)
             in
          EConstant uu____5654
      | FStar_Extraction_ML_Syntax.MLE_App
          ({
             FStar_Extraction_ML_Syntax.expr =
               FStar_Extraction_ML_Syntax.MLE_Name
               ("C"::[],"string_of_literal");
             FStar_Extraction_ML_Syntax.mlty = uu____5660;
             FStar_Extraction_ML_Syntax.loc = uu____5661;_},{
                                                              FStar_Extraction_ML_Syntax.expr
                                                                = e1;
                                                              FStar_Extraction_ML_Syntax.mlty
                                                                = uu____5663;
                                                              FStar_Extraction_ML_Syntax.loc
                                                                = uu____5664;_}::[])
          ->
          (match e1 with
           | FStar_Extraction_ML_Syntax.MLE_Const
               (FStar_Extraction_ML_Syntax.MLC_String s) -> EString s
           | uu____5670 ->
               failwith
                 "Cannot extract string_of_literal applied to a non-literal")
      | FStar_Extraction_ML_Syntax.MLE_App
          ({
             FStar_Extraction_ML_Syntax.expr =
               FStar_Extraction_ML_Syntax.MLE_Name
               ("C"::"String"::[],"of_literal");
             FStar_Extraction_ML_Syntax.mlty = uu____5671;
             FStar_Extraction_ML_Syntax.loc = uu____5672;_},{
                                                              FStar_Extraction_ML_Syntax.expr
                                                                = e1;
                                                              FStar_Extraction_ML_Syntax.mlty
                                                                = uu____5674;
                                                              FStar_Extraction_ML_Syntax.loc
                                                                = uu____5675;_}::[])
          ->
          (match e1 with
           | FStar_Extraction_ML_Syntax.MLE_Const
               (FStar_Extraction_ML_Syntax.MLC_String s) -> EString s
           | uu____5681 ->
               failwith
                 "Cannot extract string_of_literal applied to a non-literal")
      | FStar_Extraction_ML_Syntax.MLE_App
          ({
             FStar_Extraction_ML_Syntax.expr =
               FStar_Extraction_ML_Syntax.MLE_Name
               ("FStar"::"Int"::"Cast"::[],c);
             FStar_Extraction_ML_Syntax.mlty = uu____5683;
             FStar_Extraction_ML_Syntax.loc = uu____5684;_},arg::[])
          ->
          let is_known_type =
            (((((((FStar_Util.starts_with c "uint8") ||
                    (FStar_Util.starts_with c "uint16"))
                   || (FStar_Util.starts_with c "uint32"))
                  || (FStar_Util.starts_with c "uint64"))
                 || (FStar_Util.starts_with c "int8"))
                || (FStar_Util.starts_with c "int16"))
               || (FStar_Util.starts_with c "int32"))
              || (FStar_Util.starts_with c "int64")
             in
          if (FStar_Util.ends_with c "uint64") && is_known_type
          then
            let uu____5691 =
              let uu____5696 = translate_expr env arg  in
              (uu____5696, (TInt UInt64))  in
            ECast uu____5691
          else
            if (FStar_Util.ends_with c "uint32") && is_known_type
            then
              (let uu____5698 =
                 let uu____5703 = translate_expr env arg  in
                 (uu____5703, (TInt UInt32))  in
               ECast uu____5698)
            else
              if (FStar_Util.ends_with c "uint16") && is_known_type
              then
                (let uu____5705 =
                   let uu____5710 = translate_expr env arg  in
                   (uu____5710, (TInt UInt16))  in
                 ECast uu____5705)
              else
                if (FStar_Util.ends_with c "uint8") && is_known_type
                then
                  (let uu____5712 =
                     let uu____5717 = translate_expr env arg  in
                     (uu____5717, (TInt UInt8))  in
                   ECast uu____5712)
                else
                  if (FStar_Util.ends_with c "int64") && is_known_type
                  then
                    (let uu____5719 =
                       let uu____5724 = translate_expr env arg  in
                       (uu____5724, (TInt Int64))  in
                     ECast uu____5719)
                  else
                    if (FStar_Util.ends_with c "int32") && is_known_type
                    then
                      (let uu____5726 =
                         let uu____5731 = translate_expr env arg  in
                         (uu____5731, (TInt Int32))  in
                       ECast uu____5726)
                    else
                      if (FStar_Util.ends_with c "int16") && is_known_type
                      then
                        (let uu____5733 =
                           let uu____5738 = translate_expr env arg  in
                           (uu____5738, (TInt Int16))  in
                         ECast uu____5733)
                      else
                        if (FStar_Util.ends_with c "int8") && is_known_type
                        then
                          (let uu____5740 =
                             let uu____5745 = translate_expr env arg  in
                             (uu____5745, (TInt Int8))  in
                           ECast uu____5740)
                        else
                          (let uu____5747 =
                             let uu____5754 =
                               let uu____5757 = translate_expr env arg  in
                               [uu____5757]  in
                             ((EQualified (["FStar"; "Int"; "Cast"], c)),
                               uu____5754)
                              in
                           EApp uu____5747)
      | FStar_Extraction_ML_Syntax.MLE_App (head1,args) ->
          let uu____5768 =
            let uu____5775 = translate_expr env head1  in
            let uu____5776 = FStar_List.map (translate_expr env) args  in
            (uu____5775, uu____5776)  in
          EApp uu____5768
      | FStar_Extraction_ML_Syntax.MLE_TApp (head1,ty_args) ->
          let uu____5787 =
            let uu____5794 = translate_expr env head1  in
            let uu____5795 = FStar_List.map (translate_type env) ty_args  in
            (uu____5794, uu____5795)  in
          ETypApp uu____5787
      | FStar_Extraction_ML_Syntax.MLE_Coerce (e1,t_from,t_to) ->
          let uu____5803 =
            let uu____5808 = translate_expr env e1  in
            let uu____5809 = translate_type env t_to  in
            (uu____5808, uu____5809)  in
          ECast uu____5803
      | FStar_Extraction_ML_Syntax.MLE_Record (uu____5810,fields) ->
          let uu____5828 =
            let uu____5839 = assert_lid env e.FStar_Extraction_ML_Syntax.mlty
               in
            let uu____5840 =
              FStar_List.map
                (fun uu____5859  ->
                   match uu____5859 with
                   | (field,expr) ->
                       let uu____5870 = translate_expr env expr  in
                       (field, uu____5870)) fields
               in
            (uu____5839, uu____5840)  in
          EFlat uu____5828
      | FStar_Extraction_ML_Syntax.MLE_Proj (e1,path) ->
          let uu____5879 =
            let uu____5886 =
              assert_lid env e1.FStar_Extraction_ML_Syntax.mlty  in
            let uu____5887 = translate_expr env e1  in
            (uu____5886, uu____5887, (FStar_Pervasives_Native.snd path))  in
          EField uu____5879
      | FStar_Extraction_ML_Syntax.MLE_Let uu____5890 ->
          failwith "todo: translate_expr [MLE_Let]"
      | FStar_Extraction_ML_Syntax.MLE_App (head1,uu____5902) ->
          let uu____5907 =
            let uu____5908 =
              FStar_Extraction_ML_Code.string_of_mlexpr ([], "") head1  in
            FStar_Util.format1 "todo: translate_expr [MLE_App] (head is: %s)"
              uu____5908
             in
          failwith uu____5907
      | FStar_Extraction_ML_Syntax.MLE_Seq seqs ->
          let uu____5914 = FStar_List.map (translate_expr env) seqs  in
          ESequence uu____5914
      | FStar_Extraction_ML_Syntax.MLE_Tuple es ->
          let uu____5920 = FStar_List.map (translate_expr env) es  in
          ETuple uu____5920
      | FStar_Extraction_ML_Syntax.MLE_CTor ((uu____5923,cons1),es) ->
          let uu____5940 =
            let uu____5949 = assert_lid env e.FStar_Extraction_ML_Syntax.mlty
               in
            let uu____5950 = FStar_List.map (translate_expr env) es  in
            (uu____5949, cons1, uu____5950)  in
          ECons uu____5940
      | FStar_Extraction_ML_Syntax.MLE_Fun (args,body) ->
          let binders = translate_binders env args  in
          let env1 = add_binders env args  in
          let uu____5973 =
            let uu____5982 = translate_expr env1 body  in
            let uu____5983 =
              translate_type env1 body.FStar_Extraction_ML_Syntax.mlty  in
            (binders, uu____5982, uu____5983)  in
          EFun uu____5973
      | FStar_Extraction_ML_Syntax.MLE_If (e1,e2,e3) ->
          let uu____5993 =
            let uu____6000 = translate_expr env e1  in
            let uu____6001 = translate_expr env e2  in
            let uu____6002 =
              match e3 with
              | FStar_Pervasives_Native.None  -> EUnit
              | FStar_Pervasives_Native.Some e31 -> translate_expr env e31
               in
            (uu____6000, uu____6001, uu____6002)  in
          EIfThenElse uu____5993
      | FStar_Extraction_ML_Syntax.MLE_Raise uu____6004 ->
          failwith "todo: translate_expr [MLE_Raise]"
      | FStar_Extraction_ML_Syntax.MLE_Try uu____6011 ->
          failwith "todo: translate_expr [MLE_Try]"
      | FStar_Extraction_ML_Syntax.MLE_Coerce uu____6026 ->
          failwith "todo: translate_expr [MLE_Coerce]"

and (assert_lid : env -> FStar_Extraction_ML_Syntax.mlty -> typ) =
  fun env  ->
    fun t  ->
      match t with
      | FStar_Extraction_ML_Syntax.MLTY_Named (ts,lid) ->
          if (FStar_List.length ts) > (Prims.parse_int "0")
          then
            let uu____6041 =
              let uu____6054 = FStar_List.map (translate_type env) ts  in
              (lid, uu____6054)  in
            TApp uu____6041
          else TQualified lid
      | uu____6060 -> failwith "invalid argument: assert_lid"

and (translate_branches :
  env ->
    (FStar_Extraction_ML_Syntax.mlpattern,FStar_Extraction_ML_Syntax.mlexpr
                                            FStar_Pervasives_Native.option,
      FStar_Extraction_ML_Syntax.mlexpr) FStar_Pervasives_Native.tuple3
      Prims.list -> (pattern,expr) FStar_Pervasives_Native.tuple2 Prims.list)
  =
  fun env  -> fun branches  -> FStar_List.map (translate_branch env) branches

and (translate_branch :
  env ->
    (FStar_Extraction_ML_Syntax.mlpattern,FStar_Extraction_ML_Syntax.mlexpr
                                            FStar_Pervasives_Native.option,
      FStar_Extraction_ML_Syntax.mlexpr) FStar_Pervasives_Native.tuple3 ->
      (pattern,expr) FStar_Pervasives_Native.tuple2)
  =
  fun env  ->
    fun uu____6086  ->
      match uu____6086 with
      | (pat,guard,expr) ->
          if guard = FStar_Pervasives_Native.None
          then
            let uu____6112 = translate_pat env pat  in
            (match uu____6112 with
             | (env1,pat1) ->
                 let uu____6123 = translate_expr env1 expr  in
                 (pat1, uu____6123))
          else failwith "todo: translate_branch"

and (translate_width :
  (FStar_Const.signedness,FStar_Const.width) FStar_Pervasives_Native.tuple2
    FStar_Pervasives_Native.option -> width)
  =
  fun uu___41_6129  ->
    match uu___41_6129 with
    | FStar_Pervasives_Native.None  -> CInt
    | FStar_Pervasives_Native.Some (FStar_Const.Signed ,FStar_Const.Int8 ) ->
        Int8
    | FStar_Pervasives_Native.Some (FStar_Const.Signed ,FStar_Const.Int16 )
        -> Int16
    | FStar_Pervasives_Native.Some (FStar_Const.Signed ,FStar_Const.Int32 )
        -> Int32
    | FStar_Pervasives_Native.Some (FStar_Const.Signed ,FStar_Const.Int64 )
        -> Int64
    | FStar_Pervasives_Native.Some (FStar_Const.Unsigned ,FStar_Const.Int8 )
        -> UInt8
    | FStar_Pervasives_Native.Some (FStar_Const.Unsigned ,FStar_Const.Int16 )
        -> UInt16
    | FStar_Pervasives_Native.Some (FStar_Const.Unsigned ,FStar_Const.Int32 )
        -> UInt32
    | FStar_Pervasives_Native.Some (FStar_Const.Unsigned ,FStar_Const.Int64 )
        -> UInt64

and (translate_pat :
  env ->
    FStar_Extraction_ML_Syntax.mlpattern ->
      (env,pattern) FStar_Pervasives_Native.tuple2)
  =
  fun env  ->
    fun p  ->
      match p with
      | FStar_Extraction_ML_Syntax.MLP_Const
          (FStar_Extraction_ML_Syntax.MLC_Unit ) -> (env, PUnit)
      | FStar_Extraction_ML_Syntax.MLP_Const
          (FStar_Extraction_ML_Syntax.MLC_Bool b) -> (env, (PBool b))
      | FStar_Extraction_ML_Syntax.MLP_Const
          (FStar_Extraction_ML_Syntax.MLC_Int (s,sw)) ->
          let uu____6193 =
            let uu____6194 =
              let uu____6199 = translate_width sw  in (uu____6199, s)  in
            PConstant uu____6194  in
          (env, uu____6193)
      | FStar_Extraction_ML_Syntax.MLP_Var name ->
          let env1 = extend env name  in (env1, (PVar { name; typ = TAny }))
      | FStar_Extraction_ML_Syntax.MLP_Wild  ->
          let env1 = extend env "_"  in
          (env1, (PVar { name = "_"; typ = TAny }))
      | FStar_Extraction_ML_Syntax.MLP_CTor ((uu____6203,cons1),ps) ->
          let uu____6220 =
            FStar_List.fold_left
              (fun uu____6240  ->
                 fun p1  ->
                   match uu____6240 with
                   | (env1,acc) ->
                       let uu____6260 = translate_pat env1 p1  in
                       (match uu____6260 with
                        | (env2,p2) -> (env2, (p2 :: acc)))) (env, []) ps
             in
          (match uu____6220 with
           | (env1,ps1) -> (env1, (PCons (cons1, (FStar_List.rev ps1)))))
      | FStar_Extraction_ML_Syntax.MLP_Record (uu____6289,ps) ->
          let uu____6307 =
            FStar_List.fold_left
              (fun uu____6341  ->
                 fun uu____6342  ->
                   match (uu____6341, uu____6342) with
                   | ((env1,acc),(field,p1)) ->
                       let uu____6411 = translate_pat env1 p1  in
                       (match uu____6411 with
                        | (env2,p2) -> (env2, ((field, p2) :: acc))))
              (env, []) ps
             in
          (match uu____6307 with
           | (env1,ps1) -> (env1, (PRecord (FStar_List.rev ps1))))
      | FStar_Extraction_ML_Syntax.MLP_Tuple ps ->
          let uu____6473 =
            FStar_List.fold_left
              (fun uu____6493  ->
                 fun p1  ->
                   match uu____6493 with
                   | (env1,acc) ->
                       let uu____6513 = translate_pat env1 p1  in
                       (match uu____6513 with
                        | (env2,p2) -> (env2, (p2 :: acc)))) (env, []) ps
             in
          (match uu____6473 with
           | (env1,ps1) -> (env1, (PTuple (FStar_List.rev ps1))))
      | FStar_Extraction_ML_Syntax.MLP_Const uu____6540 ->
          failwith "todo: translate_pat [MLP_Const]"
      | FStar_Extraction_ML_Syntax.MLP_Branch uu____6545 ->
          failwith "todo: translate_pat [MLP_Branch]"

and (translate_constant : FStar_Extraction_ML_Syntax.mlconstant -> expr) =
  fun c  ->
    match c with
    | FStar_Extraction_ML_Syntax.MLC_Unit  -> EUnit
    | FStar_Extraction_ML_Syntax.MLC_Bool b -> EBool b
    | FStar_Extraction_ML_Syntax.MLC_String s ->
        ((let uu____6556 =
            let uu____6557 = FStar_String.list_of_string s  in
            FStar_All.pipe_right uu____6557
              (FStar_Util.for_some
                 (fun c1  ->
                    c1 = (FStar_Char.char_of_int (Prims.parse_int "0"))))
             in
          if uu____6556
          then
            let uu____6569 =
              FStar_Util.format1
                "Refusing to translate a string literal that contains a null character: %s"
                s
               in
            failwith uu____6569
          else ());
         EString s)
    | FStar_Extraction_ML_Syntax.MLC_Char c1 ->
        let i = FStar_Util.int_of_char c1  in
        let s = FStar_Util.string_of_int i  in
        let c2 = EConstant (UInt32, s)  in
        let char_of_int1 = EQualified (["FStar"; "Char"], "char_of_int")  in
        EApp (char_of_int1, [c2])
    | FStar_Extraction_ML_Syntax.MLC_Int
        (s,FStar_Pervasives_Native.Some uu____6581) ->
        failwith
          "impossible: machine integer not desugared to a function call"
    | FStar_Extraction_ML_Syntax.MLC_Float uu____6596 ->
        failwith "todo: translate_expr [MLC_Float]"
    | FStar_Extraction_ML_Syntax.MLC_Bytes uu____6597 ->
        failwith "todo: translate_expr [MLC_Bytes]"
    | FStar_Extraction_ML_Syntax.MLC_Int (s,FStar_Pervasives_Native.None ) ->
        EConstant (CInt, s)

and (mk_op_app :
  env -> width -> op -> FStar_Extraction_ML_Syntax.mlexpr Prims.list -> expr)
  =
  fun env  ->
    fun w  ->
      fun op  ->
        fun args  ->
          let uu____6617 =
            let uu____6624 = FStar_List.map (translate_expr env) args  in
            ((EOp (op, w)), uu____6624)  in
          EApp uu____6617
