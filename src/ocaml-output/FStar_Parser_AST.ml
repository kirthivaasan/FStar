
open Prims
# 28 "FStar.Parser.AST.fst"
type level =
| Un
| Expr
| Type
| Kind
| Formula

# 34 "FStar.Parser.AST.fst"
let is_Un = (fun _discr_ -> (match (_discr_) with
| Un (_) -> begin
true
end
| _ -> begin
false
end))

# 34 "FStar.Parser.AST.fst"
let is_Expr = (fun _discr_ -> (match (_discr_) with
| Expr (_) -> begin
true
end
| _ -> begin
false
end))

# 34 "FStar.Parser.AST.fst"
let is_Type = (fun _discr_ -> (match (_discr_) with
| Type (_) -> begin
true
end
| _ -> begin
false
end))

# 34 "FStar.Parser.AST.fst"
let is_Kind = (fun _discr_ -> (match (_discr_) with
| Kind (_) -> begin
true
end
| _ -> begin
false
end))

# 34 "FStar.Parser.AST.fst"
let is_Formula = (fun _discr_ -> (match (_discr_) with
| Formula (_) -> begin
true
end
| _ -> begin
false
end))

# 34 "FStar.Parser.AST.fst"
type imp =
| FsTypApp
| Hash
| Nothing

# 36 "FStar.Parser.AST.fst"
let is_FsTypApp = (fun _discr_ -> (match (_discr_) with
| FsTypApp (_) -> begin
true
end
| _ -> begin
false
end))

# 37 "FStar.Parser.AST.fst"
let is_Hash = (fun _discr_ -> (match (_discr_) with
| Hash (_) -> begin
true
end
| _ -> begin
false
end))

# 38 "FStar.Parser.AST.fst"
let is_Nothing = (fun _discr_ -> (match (_discr_) with
| Nothing (_) -> begin
true
end
| _ -> begin
false
end))

# 38 "FStar.Parser.AST.fst"
type arg_qualifier =
| Implicit
| Equality

# 40 "FStar.Parser.AST.fst"
let is_Implicit = (fun _discr_ -> (match (_discr_) with
| Implicit (_) -> begin
true
end
| _ -> begin
false
end))

# 41 "FStar.Parser.AST.fst"
let is_Equality = (fun _discr_ -> (match (_discr_) with
| Equality (_) -> begin
true
end
| _ -> begin
false
end))

# 41 "FStar.Parser.AST.fst"
type aqual =
arg_qualifier Prims.option

# 42 "FStar.Parser.AST.fst"
type term' =
| Wild
| Const of FStar_Const.sconst
| Op of (Prims.string * term Prims.list)
| Tvar of FStar_Ident.ident
| Var of FStar_Ident.lid
| Name of FStar_Ident.lid
| Construct of (FStar_Ident.lid * (term * imp) Prims.list)
| Abs of (pattern Prims.list * term)
| App of (term * term * imp)
| Let of (Prims.bool * (pattern * term) Prims.list * term)
| Seq of (term * term)
| If of (term * term * term)
| Match of (term * branch Prims.list)
| TryWith of (term * branch Prims.list)
| Ascribed of (term * term)
| Record of (term Prims.option * (FStar_Ident.lid * term) Prims.list)
| Project of (term * FStar_Ident.lid)
| Product of (binder Prims.list * term)
| Sum of (binder Prims.list * term)
| QForall of (binder Prims.list * term Prims.list Prims.list * term)
| QExists of (binder Prims.list * term Prims.list Prims.list * term)
| Refine of (binder * term)
| NamedTyp of (FStar_Ident.ident * term)
| Paren of term
| Requires of (term * Prims.string Prims.option)
| Ensures of (term * Prims.string Prims.option)
| Labeled of (term * Prims.string * Prims.bool) 
 and term =
{tm : term'; range : FStar_Range.range; level : level} 
 and binder' =
| Variable of FStar_Ident.ident
| TVariable of FStar_Ident.ident
| Annotated of (FStar_Ident.ident * term)
| TAnnotated of (FStar_Ident.ident * term)
| NoName of term 
 and binder =
{b : binder'; brange : FStar_Range.range; blevel : level; aqual : aqual} 
 and pattern' =
| PatWild
| PatConst of FStar_Const.sconst
| PatApp of (pattern * pattern Prims.list)
| PatVar of (FStar_Ident.ident * Prims.bool)
| PatName of FStar_Ident.lid
| PatTvar of (FStar_Ident.ident * Prims.bool)
| PatList of pattern Prims.list
| PatTuple of (pattern Prims.list * Prims.bool)
| PatRecord of (FStar_Ident.lid * pattern) Prims.list
| PatAscribed of (pattern * term)
| PatOr of pattern Prims.list 
 and pattern =
{pat : pattern'; prange : FStar_Range.range} 
 and branch =
(pattern * term Prims.option * term)

# 45 "FStar.Parser.AST.fst"
let is_Wild = (fun _discr_ -> (match (_discr_) with
| Wild (_) -> begin
true
end
| _ -> begin
false
end))

# 46 "FStar.Parser.AST.fst"
let is_Const = (fun _discr_ -> (match (_discr_) with
| Const (_) -> begin
true
end
| _ -> begin
false
end))

# 47 "FStar.Parser.AST.fst"
let is_Op = (fun _discr_ -> (match (_discr_) with
| Op (_) -> begin
true
end
| _ -> begin
false
end))

# 48 "FStar.Parser.AST.fst"
let is_Tvar = (fun _discr_ -> (match (_discr_) with
| Tvar (_) -> begin
true
end
| _ -> begin
false
end))

# 49 "FStar.Parser.AST.fst"
let is_Var = (fun _discr_ -> (match (_discr_) with
| Var (_) -> begin
true
end
| _ -> begin
false
end))

# 50 "FStar.Parser.AST.fst"
let is_Name = (fun _discr_ -> (match (_discr_) with
| Name (_) -> begin
true
end
| _ -> begin
false
end))

# 51 "FStar.Parser.AST.fst"
let is_Construct = (fun _discr_ -> (match (_discr_) with
| Construct (_) -> begin
true
end
| _ -> begin
false
end))

# 52 "FStar.Parser.AST.fst"
let is_Abs = (fun _discr_ -> (match (_discr_) with
| Abs (_) -> begin
true
end
| _ -> begin
false
end))

# 53 "FStar.Parser.AST.fst"
let is_App = (fun _discr_ -> (match (_discr_) with
| App (_) -> begin
true
end
| _ -> begin
false
end))

# 54 "FStar.Parser.AST.fst"
let is_Let = (fun _discr_ -> (match (_discr_) with
| Let (_) -> begin
true
end
| _ -> begin
false
end))

# 55 "FStar.Parser.AST.fst"
let is_Seq = (fun _discr_ -> (match (_discr_) with
| Seq (_) -> begin
true
end
| _ -> begin
false
end))

# 56 "FStar.Parser.AST.fst"
let is_If = (fun _discr_ -> (match (_discr_) with
| If (_) -> begin
true
end
| _ -> begin
false
end))

# 57 "FStar.Parser.AST.fst"
let is_Match = (fun _discr_ -> (match (_discr_) with
| Match (_) -> begin
true
end
| _ -> begin
false
end))

# 58 "FStar.Parser.AST.fst"
let is_TryWith = (fun _discr_ -> (match (_discr_) with
| TryWith (_) -> begin
true
end
| _ -> begin
false
end))

# 59 "FStar.Parser.AST.fst"
let is_Ascribed = (fun _discr_ -> (match (_discr_) with
| Ascribed (_) -> begin
true
end
| _ -> begin
false
end))

# 60 "FStar.Parser.AST.fst"
let is_Record = (fun _discr_ -> (match (_discr_) with
| Record (_) -> begin
true
end
| _ -> begin
false
end))

# 61 "FStar.Parser.AST.fst"
let is_Project = (fun _discr_ -> (match (_discr_) with
| Project (_) -> begin
true
end
| _ -> begin
false
end))

# 62 "FStar.Parser.AST.fst"
let is_Product = (fun _discr_ -> (match (_discr_) with
| Product (_) -> begin
true
end
| _ -> begin
false
end))

# 63 "FStar.Parser.AST.fst"
let is_Sum = (fun _discr_ -> (match (_discr_) with
| Sum (_) -> begin
true
end
| _ -> begin
false
end))

# 64 "FStar.Parser.AST.fst"
let is_QForall = (fun _discr_ -> (match (_discr_) with
| QForall (_) -> begin
true
end
| _ -> begin
false
end))

# 65 "FStar.Parser.AST.fst"
let is_QExists = (fun _discr_ -> (match (_discr_) with
| QExists (_) -> begin
true
end
| _ -> begin
false
end))

# 66 "FStar.Parser.AST.fst"
let is_Refine = (fun _discr_ -> (match (_discr_) with
| Refine (_) -> begin
true
end
| _ -> begin
false
end))

# 67 "FStar.Parser.AST.fst"
let is_NamedTyp = (fun _discr_ -> (match (_discr_) with
| NamedTyp (_) -> begin
true
end
| _ -> begin
false
end))

# 68 "FStar.Parser.AST.fst"
let is_Paren = (fun _discr_ -> (match (_discr_) with
| Paren (_) -> begin
true
end
| _ -> begin
false
end))

# 69 "FStar.Parser.AST.fst"
let is_Requires = (fun _discr_ -> (match (_discr_) with
| Requires (_) -> begin
true
end
| _ -> begin
false
end))

# 70 "FStar.Parser.AST.fst"
let is_Ensures = (fun _discr_ -> (match (_discr_) with
| Ensures (_) -> begin
true
end
| _ -> begin
false
end))

# 71 "FStar.Parser.AST.fst"
let is_Labeled = (fun _discr_ -> (match (_discr_) with
| Labeled (_) -> begin
true
end
| _ -> begin
false
end))

# 73 "FStar.Parser.AST.fst"
let is_Mkterm : term  ->  Prims.bool = (Obj.magic ((fun _ -> (FStar_All.failwith "Not yet implemented:is_Mkterm"))))

# 76 "FStar.Parser.AST.fst"
let is_Variable = (fun _discr_ -> (match (_discr_) with
| Variable (_) -> begin
true
end
| _ -> begin
false
end))

# 77 "FStar.Parser.AST.fst"
let is_TVariable = (fun _discr_ -> (match (_discr_) with
| TVariable (_) -> begin
true
end
| _ -> begin
false
end))

# 78 "FStar.Parser.AST.fst"
let is_Annotated = (fun _discr_ -> (match (_discr_) with
| Annotated (_) -> begin
true
end
| _ -> begin
false
end))

# 79 "FStar.Parser.AST.fst"
let is_TAnnotated = (fun _discr_ -> (match (_discr_) with
| TAnnotated (_) -> begin
true
end
| _ -> begin
false
end))

# 80 "FStar.Parser.AST.fst"
let is_NoName = (fun _discr_ -> (match (_discr_) with
| NoName (_) -> begin
true
end
| _ -> begin
false
end))

# 81 "FStar.Parser.AST.fst"
let is_Mkbinder : binder  ->  Prims.bool = (Obj.magic ((fun _ -> (FStar_All.failwith "Not yet implemented:is_Mkbinder"))))

# 84 "FStar.Parser.AST.fst"
let is_PatWild = (fun _discr_ -> (match (_discr_) with
| PatWild (_) -> begin
true
end
| _ -> begin
false
end))

# 85 "FStar.Parser.AST.fst"
let is_PatConst = (fun _discr_ -> (match (_discr_) with
| PatConst (_) -> begin
true
end
| _ -> begin
false
end))

# 86 "FStar.Parser.AST.fst"
let is_PatApp = (fun _discr_ -> (match (_discr_) with
| PatApp (_) -> begin
true
end
| _ -> begin
false
end))

# 87 "FStar.Parser.AST.fst"
let is_PatVar = (fun _discr_ -> (match (_discr_) with
| PatVar (_) -> begin
true
end
| _ -> begin
false
end))

# 88 "FStar.Parser.AST.fst"
let is_PatName = (fun _discr_ -> (match (_discr_) with
| PatName (_) -> begin
true
end
| _ -> begin
false
end))

# 89 "FStar.Parser.AST.fst"
let is_PatTvar = (fun _discr_ -> (match (_discr_) with
| PatTvar (_) -> begin
true
end
| _ -> begin
false
end))

# 90 "FStar.Parser.AST.fst"
let is_PatList = (fun _discr_ -> (match (_discr_) with
| PatList (_) -> begin
true
end
| _ -> begin
false
end))

# 91 "FStar.Parser.AST.fst"
let is_PatTuple = (fun _discr_ -> (match (_discr_) with
| PatTuple (_) -> begin
true
end
| _ -> begin
false
end))

# 92 "FStar.Parser.AST.fst"
let is_PatRecord = (fun _discr_ -> (match (_discr_) with
| PatRecord (_) -> begin
true
end
| _ -> begin
false
end))

# 93 "FStar.Parser.AST.fst"
let is_PatAscribed = (fun _discr_ -> (match (_discr_) with
| PatAscribed (_) -> begin
true
end
| _ -> begin
false
end))

# 94 "FStar.Parser.AST.fst"
let is_PatOr = (fun _discr_ -> (match (_discr_) with
| PatOr (_) -> begin
true
end
| _ -> begin
false
end))

# 95 "FStar.Parser.AST.fst"
let is_Mkpattern : pattern  ->  Prims.bool = (Obj.magic ((fun _ -> (FStar_All.failwith "Not yet implemented:is_Mkpattern"))))

# 46 "FStar.Parser.AST.fst"
let ___Const____0 = (fun projectee -> (match (projectee) with
| Const (_47_13) -> begin
_47_13
end))

# 47 "FStar.Parser.AST.fst"
let ___Op____0 = (fun projectee -> (match (projectee) with
| Op (_47_16) -> begin
_47_16
end))

# 48 "FStar.Parser.AST.fst"
let ___Tvar____0 = (fun projectee -> (match (projectee) with
| Tvar (_47_19) -> begin
_47_19
end))

# 49 "FStar.Parser.AST.fst"
let ___Var____0 = (fun projectee -> (match (projectee) with
| Var (_47_22) -> begin
_47_22
end))

# 50 "FStar.Parser.AST.fst"
let ___Name____0 = (fun projectee -> (match (projectee) with
| Name (_47_25) -> begin
_47_25
end))

# 51 "FStar.Parser.AST.fst"
let ___Construct____0 = (fun projectee -> (match (projectee) with
| Construct (_47_28) -> begin
_47_28
end))

# 52 "FStar.Parser.AST.fst"
let ___Abs____0 = (fun projectee -> (match (projectee) with
| Abs (_47_31) -> begin
_47_31
end))

# 53 "FStar.Parser.AST.fst"
let ___App____0 = (fun projectee -> (match (projectee) with
| App (_47_34) -> begin
_47_34
end))

# 54 "FStar.Parser.AST.fst"
let ___Let____0 = (fun projectee -> (match (projectee) with
| Let (_47_37) -> begin
_47_37
end))

# 55 "FStar.Parser.AST.fst"
let ___Seq____0 = (fun projectee -> (match (projectee) with
| Seq (_47_40) -> begin
_47_40
end))

# 56 "FStar.Parser.AST.fst"
let ___If____0 = (fun projectee -> (match (projectee) with
| If (_47_43) -> begin
_47_43
end))

# 57 "FStar.Parser.AST.fst"
let ___Match____0 = (fun projectee -> (match (projectee) with
| Match (_47_46) -> begin
_47_46
end))

# 58 "FStar.Parser.AST.fst"
let ___TryWith____0 = (fun projectee -> (match (projectee) with
| TryWith (_47_49) -> begin
_47_49
end))

# 59 "FStar.Parser.AST.fst"
let ___Ascribed____0 = (fun projectee -> (match (projectee) with
| Ascribed (_47_52) -> begin
_47_52
end))

# 60 "FStar.Parser.AST.fst"
let ___Record____0 = (fun projectee -> (match (projectee) with
| Record (_47_55) -> begin
_47_55
end))

# 61 "FStar.Parser.AST.fst"
let ___Project____0 = (fun projectee -> (match (projectee) with
| Project (_47_58) -> begin
_47_58
end))

# 62 "FStar.Parser.AST.fst"
let ___Product____0 = (fun projectee -> (match (projectee) with
| Product (_47_61) -> begin
_47_61
end))

# 63 "FStar.Parser.AST.fst"
let ___Sum____0 = (fun projectee -> (match (projectee) with
| Sum (_47_64) -> begin
_47_64
end))

# 64 "FStar.Parser.AST.fst"
let ___QForall____0 = (fun projectee -> (match (projectee) with
| QForall (_47_67) -> begin
_47_67
end))

# 65 "FStar.Parser.AST.fst"
let ___QExists____0 = (fun projectee -> (match (projectee) with
| QExists (_47_70) -> begin
_47_70
end))

# 66 "FStar.Parser.AST.fst"
let ___Refine____0 = (fun projectee -> (match (projectee) with
| Refine (_47_73) -> begin
_47_73
end))

# 67 "FStar.Parser.AST.fst"
let ___NamedTyp____0 = (fun projectee -> (match (projectee) with
| NamedTyp (_47_76) -> begin
_47_76
end))

# 68 "FStar.Parser.AST.fst"
let ___Paren____0 = (fun projectee -> (match (projectee) with
| Paren (_47_79) -> begin
_47_79
end))

# 69 "FStar.Parser.AST.fst"
let ___Requires____0 = (fun projectee -> (match (projectee) with
| Requires (_47_82) -> begin
_47_82
end))

# 70 "FStar.Parser.AST.fst"
let ___Ensures____0 = (fun projectee -> (match (projectee) with
| Ensures (_47_85) -> begin
_47_85
end))

# 71 "FStar.Parser.AST.fst"
let ___Labeled____0 = (fun projectee -> (match (projectee) with
| Labeled (_47_88) -> begin
_47_88
end))

# 76 "FStar.Parser.AST.fst"
let ___Variable____0 = (fun projectee -> (match (projectee) with
| Variable (_47_92) -> begin
_47_92
end))

# 77 "FStar.Parser.AST.fst"
let ___TVariable____0 = (fun projectee -> (match (projectee) with
| TVariable (_47_95) -> begin
_47_95
end))

# 78 "FStar.Parser.AST.fst"
let ___Annotated____0 = (fun projectee -> (match (projectee) with
| Annotated (_47_98) -> begin
_47_98
end))

# 79 "FStar.Parser.AST.fst"
let ___TAnnotated____0 = (fun projectee -> (match (projectee) with
| TAnnotated (_47_101) -> begin
_47_101
end))

# 80 "FStar.Parser.AST.fst"
let ___NoName____0 = (fun projectee -> (match (projectee) with
| NoName (_47_104) -> begin
_47_104
end))

# 85 "FStar.Parser.AST.fst"
let ___PatConst____0 = (fun projectee -> (match (projectee) with
| PatConst (_47_108) -> begin
_47_108
end))

# 86 "FStar.Parser.AST.fst"
let ___PatApp____0 = (fun projectee -> (match (projectee) with
| PatApp (_47_111) -> begin
_47_111
end))

# 87 "FStar.Parser.AST.fst"
let ___PatVar____0 = (fun projectee -> (match (projectee) with
| PatVar (_47_114) -> begin
_47_114
end))

# 88 "FStar.Parser.AST.fst"
let ___PatName____0 = (fun projectee -> (match (projectee) with
| PatName (_47_117) -> begin
_47_117
end))

# 89 "FStar.Parser.AST.fst"
let ___PatTvar____0 = (fun projectee -> (match (projectee) with
| PatTvar (_47_120) -> begin
_47_120
end))

# 90 "FStar.Parser.AST.fst"
let ___PatList____0 = (fun projectee -> (match (projectee) with
| PatList (_47_123) -> begin
_47_123
end))

# 91 "FStar.Parser.AST.fst"
let ___PatTuple____0 = (fun projectee -> (match (projectee) with
| PatTuple (_47_126) -> begin
_47_126
end))

# 92 "FStar.Parser.AST.fst"
let ___PatRecord____0 = (fun projectee -> (match (projectee) with
| PatRecord (_47_129) -> begin
_47_129
end))

# 93 "FStar.Parser.AST.fst"
let ___PatAscribed____0 = (fun projectee -> (match (projectee) with
| PatAscribed (_47_132) -> begin
_47_132
end))

# 94 "FStar.Parser.AST.fst"
let ___PatOr____0 = (fun projectee -> (match (projectee) with
| PatOr (_47_135) -> begin
_47_135
end))

# 97 "FStar.Parser.AST.fst"
type knd =
term

# 99 "FStar.Parser.AST.fst"
type typ =
term

# 100 "FStar.Parser.AST.fst"
type expr =
term

# 101 "FStar.Parser.AST.fst"
type tycon =
| TyconAbstract of (FStar_Ident.ident * binder Prims.list * knd Prims.option)
| TyconAbbrev of (FStar_Ident.ident * binder Prims.list * knd Prims.option * term)
| TyconRecord of (FStar_Ident.ident * binder Prims.list * knd Prims.option * (FStar_Ident.ident * term) Prims.list)
| TyconVariant of (FStar_Ident.ident * binder Prims.list * knd Prims.option * (FStar_Ident.ident * term Prims.option * Prims.bool) Prims.list)

# 104 "FStar.Parser.AST.fst"
let is_TyconAbstract = (fun _discr_ -> (match (_discr_) with
| TyconAbstract (_) -> begin
true
end
| _ -> begin
false
end))

# 105 "FStar.Parser.AST.fst"
let is_TyconAbbrev = (fun _discr_ -> (match (_discr_) with
| TyconAbbrev (_) -> begin
true
end
| _ -> begin
false
end))

# 106 "FStar.Parser.AST.fst"
let is_TyconRecord = (fun _discr_ -> (match (_discr_) with
| TyconRecord (_) -> begin
true
end
| _ -> begin
false
end))

# 107 "FStar.Parser.AST.fst"
let is_TyconVariant = (fun _discr_ -> (match (_discr_) with
| TyconVariant (_) -> begin
true
end
| _ -> begin
false
end))

# 104 "FStar.Parser.AST.fst"
let ___TyconAbstract____0 = (fun projectee -> (match (projectee) with
| TyconAbstract (_47_139) -> begin
_47_139
end))

# 105 "FStar.Parser.AST.fst"
let ___TyconAbbrev____0 = (fun projectee -> (match (projectee) with
| TyconAbbrev (_47_142) -> begin
_47_142
end))

# 106 "FStar.Parser.AST.fst"
let ___TyconRecord____0 = (fun projectee -> (match (projectee) with
| TyconRecord (_47_145) -> begin
_47_145
end))

# 107 "FStar.Parser.AST.fst"
let ___TyconVariant____0 = (fun projectee -> (match (projectee) with
| TyconVariant (_47_148) -> begin
_47_148
end))

# 107 "FStar.Parser.AST.fst"
type qualifier =
| Private
| Abstract
| Assumption
| DefaultEffect
| TotalEffect
| Effect
| New
| Inline
| Unfoldable
| Irreducible
| Opaque
| Logic

# 110 "FStar.Parser.AST.fst"
let is_Private = (fun _discr_ -> (match (_discr_) with
| Private (_) -> begin
true
end
| _ -> begin
false
end))

# 111 "FStar.Parser.AST.fst"
let is_Abstract = (fun _discr_ -> (match (_discr_) with
| Abstract (_) -> begin
true
end
| _ -> begin
false
end))

# 112 "FStar.Parser.AST.fst"
let is_Assumption = (fun _discr_ -> (match (_discr_) with
| Assumption (_) -> begin
true
end
| _ -> begin
false
end))

# 113 "FStar.Parser.AST.fst"
let is_DefaultEffect = (fun _discr_ -> (match (_discr_) with
| DefaultEffect (_) -> begin
true
end
| _ -> begin
false
end))

# 114 "FStar.Parser.AST.fst"
let is_TotalEffect = (fun _discr_ -> (match (_discr_) with
| TotalEffect (_) -> begin
true
end
| _ -> begin
false
end))

# 115 "FStar.Parser.AST.fst"
let is_Effect = (fun _discr_ -> (match (_discr_) with
| Effect (_) -> begin
true
end
| _ -> begin
false
end))

# 116 "FStar.Parser.AST.fst"
let is_New = (fun _discr_ -> (match (_discr_) with
| New (_) -> begin
true
end
| _ -> begin
false
end))

# 117 "FStar.Parser.AST.fst"
let is_Inline = (fun _discr_ -> (match (_discr_) with
| Inline (_) -> begin
true
end
| _ -> begin
false
end))

# 118 "FStar.Parser.AST.fst"
let is_Unfoldable = (fun _discr_ -> (match (_discr_) with
| Unfoldable (_) -> begin
true
end
| _ -> begin
false
end))

# 119 "FStar.Parser.AST.fst"
let is_Irreducible = (fun _discr_ -> (match (_discr_) with
| Irreducible (_) -> begin
true
end
| _ -> begin
false
end))

# 121 "FStar.Parser.AST.fst"
let is_Opaque = (fun _discr_ -> (match (_discr_) with
| Opaque (_) -> begin
true
end
| _ -> begin
false
end))

# 122 "FStar.Parser.AST.fst"
let is_Logic = (fun _discr_ -> (match (_discr_) with
| Logic (_) -> begin
true
end
| _ -> begin
false
end))

# 122 "FStar.Parser.AST.fst"
type qualifiers =
qualifier Prims.list

# 126 "FStar.Parser.AST.fst"
type lift =
{msource : FStar_Ident.lid; mdest : FStar_Ident.lid; lift_op : term}

# 128 "FStar.Parser.AST.fst"
let is_Mklift : lift  ->  Prims.bool = (Obj.magic ((fun _ -> (FStar_All.failwith "Not yet implemented:is_Mklift"))))

# 132 "FStar.Parser.AST.fst"
type pragma =
| SetOptions of Prims.string
| ResetOptions of Prims.string Prims.option

# 135 "FStar.Parser.AST.fst"
let is_SetOptions = (fun _discr_ -> (match (_discr_) with
| SetOptions (_) -> begin
true
end
| _ -> begin
false
end))

# 136 "FStar.Parser.AST.fst"
let is_ResetOptions = (fun _discr_ -> (match (_discr_) with
| ResetOptions (_) -> begin
true
end
| _ -> begin
false
end))

# 135 "FStar.Parser.AST.fst"
let ___SetOptions____0 = (fun projectee -> (match (projectee) with
| SetOptions (_47_155) -> begin
_47_155
end))

# 136 "FStar.Parser.AST.fst"
let ___ResetOptions____0 = (fun projectee -> (match (projectee) with
| ResetOptions (_47_158) -> begin
_47_158
end))

# 138 "FStar.Parser.AST.fst"
type decl' =
| TopLevelModule of FStar_Ident.lid
| Open of FStar_Ident.lid
| ModuleAbbrev of (FStar_Ident.ident * FStar_Ident.lid)
| KindAbbrev of (FStar_Ident.ident * binder Prims.list * knd)
| ToplevelLet of (qualifiers * Prims.bool * (pattern * term) Prims.list)
| Main of term
| Assume of (qualifiers * FStar_Ident.ident * term)
| Tycon of (qualifiers * tycon Prims.list)
| Val of (qualifiers * FStar_Ident.ident * term)
| Exception of (FStar_Ident.ident * term Prims.option)
| NewEffect of (qualifiers * effect_decl)
| SubEffect of lift
| Pragma of pragma 
 and decl =
{d : decl'; drange : FStar_Range.range} 
 and effect_decl =
| DefineEffect of (FStar_Ident.ident * binder Prims.list * term * decl Prims.list)
| RedefineEffect of (FStar_Ident.ident * binder Prims.list * term)

# 139 "FStar.Parser.AST.fst"
let is_TopLevelModule = (fun _discr_ -> (match (_discr_) with
| TopLevelModule (_) -> begin
true
end
| _ -> begin
false
end))

# 140 "FStar.Parser.AST.fst"
let is_Open = (fun _discr_ -> (match (_discr_) with
| Open (_) -> begin
true
end
| _ -> begin
false
end))

# 141 "FStar.Parser.AST.fst"
let is_ModuleAbbrev = (fun _discr_ -> (match (_discr_) with
| ModuleAbbrev (_) -> begin
true
end
| _ -> begin
false
end))

# 142 "FStar.Parser.AST.fst"
let is_KindAbbrev = (fun _discr_ -> (match (_discr_) with
| KindAbbrev (_) -> begin
true
end
| _ -> begin
false
end))

# 143 "FStar.Parser.AST.fst"
let is_ToplevelLet = (fun _discr_ -> (match (_discr_) with
| ToplevelLet (_) -> begin
true
end
| _ -> begin
false
end))

# 144 "FStar.Parser.AST.fst"
let is_Main = (fun _discr_ -> (match (_discr_) with
| Main (_) -> begin
true
end
| _ -> begin
false
end))

# 145 "FStar.Parser.AST.fst"
let is_Assume = (fun _discr_ -> (match (_discr_) with
| Assume (_) -> begin
true
end
| _ -> begin
false
end))

# 146 "FStar.Parser.AST.fst"
let is_Tycon = (fun _discr_ -> (match (_discr_) with
| Tycon (_) -> begin
true
end
| _ -> begin
false
end))

# 147 "FStar.Parser.AST.fst"
let is_Val = (fun _discr_ -> (match (_discr_) with
| Val (_) -> begin
true
end
| _ -> begin
false
end))

# 148 "FStar.Parser.AST.fst"
let is_Exception = (fun _discr_ -> (match (_discr_) with
| Exception (_) -> begin
true
end
| _ -> begin
false
end))

# 149 "FStar.Parser.AST.fst"
let is_NewEffect = (fun _discr_ -> (match (_discr_) with
| NewEffect (_) -> begin
true
end
| _ -> begin
false
end))

# 150 "FStar.Parser.AST.fst"
let is_SubEffect = (fun _discr_ -> (match (_discr_) with
| SubEffect (_) -> begin
true
end
| _ -> begin
false
end))

# 151 "FStar.Parser.AST.fst"
let is_Pragma = (fun _discr_ -> (match (_discr_) with
| Pragma (_) -> begin
true
end
| _ -> begin
false
end))

# 152 "FStar.Parser.AST.fst"
let is_Mkdecl : decl  ->  Prims.bool = (Obj.magic ((fun _ -> (FStar_All.failwith "Not yet implemented:is_Mkdecl"))))

# 154 "FStar.Parser.AST.fst"
let is_DefineEffect = (fun _discr_ -> (match (_discr_) with
| DefineEffect (_) -> begin
true
end
| _ -> begin
false
end))

# 155 "FStar.Parser.AST.fst"
let is_RedefineEffect = (fun _discr_ -> (match (_discr_) with
| RedefineEffect (_) -> begin
true
end
| _ -> begin
false
end))

# 139 "FStar.Parser.AST.fst"
let ___TopLevelModule____0 = (fun projectee -> (match (projectee) with
| TopLevelModule (_47_163) -> begin
_47_163
end))

# 140 "FStar.Parser.AST.fst"
let ___Open____0 = (fun projectee -> (match (projectee) with
| Open (_47_166) -> begin
_47_166
end))

# 141 "FStar.Parser.AST.fst"
let ___ModuleAbbrev____0 = (fun projectee -> (match (projectee) with
| ModuleAbbrev (_47_169) -> begin
_47_169
end))

# 142 "FStar.Parser.AST.fst"
let ___KindAbbrev____0 = (fun projectee -> (match (projectee) with
| KindAbbrev (_47_172) -> begin
_47_172
end))

# 143 "FStar.Parser.AST.fst"
let ___ToplevelLet____0 = (fun projectee -> (match (projectee) with
| ToplevelLet (_47_175) -> begin
_47_175
end))

# 144 "FStar.Parser.AST.fst"
let ___Main____0 = (fun projectee -> (match (projectee) with
| Main (_47_178) -> begin
_47_178
end))

# 145 "FStar.Parser.AST.fst"
let ___Assume____0 = (fun projectee -> (match (projectee) with
| Assume (_47_181) -> begin
_47_181
end))

# 146 "FStar.Parser.AST.fst"
let ___Tycon____0 = (fun projectee -> (match (projectee) with
| Tycon (_47_184) -> begin
_47_184
end))

# 147 "FStar.Parser.AST.fst"
let ___Val____0 = (fun projectee -> (match (projectee) with
| Val (_47_187) -> begin
_47_187
end))

# 148 "FStar.Parser.AST.fst"
let ___Exception____0 = (fun projectee -> (match (projectee) with
| Exception (_47_190) -> begin
_47_190
end))

# 149 "FStar.Parser.AST.fst"
let ___NewEffect____0 = (fun projectee -> (match (projectee) with
| NewEffect (_47_193) -> begin
_47_193
end))

# 150 "FStar.Parser.AST.fst"
let ___SubEffect____0 = (fun projectee -> (match (projectee) with
| SubEffect (_47_196) -> begin
_47_196
end))

# 151 "FStar.Parser.AST.fst"
let ___Pragma____0 = (fun projectee -> (match (projectee) with
| Pragma (_47_199) -> begin
_47_199
end))

# 154 "FStar.Parser.AST.fst"
let ___DefineEffect____0 = (fun projectee -> (match (projectee) with
| DefineEffect (_47_203) -> begin
_47_203
end))

# 155 "FStar.Parser.AST.fst"
let ___RedefineEffect____0 = (fun projectee -> (match (projectee) with
| RedefineEffect (_47_206) -> begin
_47_206
end))

# 155 "FStar.Parser.AST.fst"
type modul =
| Module of (FStar_Ident.lid * decl Prims.list)
| Interface of (FStar_Ident.lid * decl Prims.list * Prims.bool)

# 158 "FStar.Parser.AST.fst"
let is_Module = (fun _discr_ -> (match (_discr_) with
| Module (_) -> begin
true
end
| _ -> begin
false
end))

# 159 "FStar.Parser.AST.fst"
let is_Interface = (fun _discr_ -> (match (_discr_) with
| Interface (_) -> begin
true
end
| _ -> begin
false
end))

# 158 "FStar.Parser.AST.fst"
let ___Module____0 = (fun projectee -> (match (projectee) with
| Module (_47_209) -> begin
_47_209
end))

# 159 "FStar.Parser.AST.fst"
let ___Interface____0 = (fun projectee -> (match (projectee) with
| Interface (_47_212) -> begin
_47_212
end))

# 159 "FStar.Parser.AST.fst"
type file =
modul Prims.list

# 160 "FStar.Parser.AST.fst"
type inputFragment =
(file, decl Prims.list) FStar_Util.either

# 161 "FStar.Parser.AST.fst"
let check_id : FStar_Ident.ident  ->  Prims.unit = (fun id -> if (FStar_ST.read FStar_Options.universes) then begin
(
# 166 "FStar.Parser.AST.fst"
let first_char = (FStar_String.substring id.FStar_Ident.idText 0 1)
in if ((FStar_String.lowercase first_char) = first_char) then begin
()
end else begin
(let _132_972 = (let _132_971 = (let _132_970 = (FStar_Util.format1 "Invalid identifer \'%s\'; expected a symbol that begins with a lower-case character" id.FStar_Ident.idText)
in (_132_970, id.FStar_Ident.idRange))
in FStar_Syntax_Syntax.Error (_132_971))
in (Prims.raise _132_972))
end)
end else begin
()
end)

# 170 "FStar.Parser.AST.fst"
let mk_decl : decl'  ->  FStar_Range.range  ->  decl = (fun d r -> {d = d; drange = r})

# 172 "FStar.Parser.AST.fst"
let mk_binder : binder'  ->  FStar_Range.range  ->  level  ->  aqual  ->  binder = (fun b r l i -> {b = b; brange = r; blevel = l; aqual = i})

# 173 "FStar.Parser.AST.fst"
let mk_term : term'  ->  FStar_Range.range  ->  level  ->  term = (fun t r l -> {tm = t; range = r; level = l})

# 174 "FStar.Parser.AST.fst"
let mk_pattern : pattern'  ->  FStar_Range.range  ->  pattern = (fun p r -> {pat = p; prange = r})

# 175 "FStar.Parser.AST.fst"
let un_curry_abs : pattern Prims.list  ->  term  ->  term' = (fun ps body -> (match (body.tm) with
| Abs (p', body') -> begin
Abs (((FStar_List.append ps p'), body'))
end
| _47_233 -> begin
Abs ((ps, body))
end))

# 178 "FStar.Parser.AST.fst"
let mk_function : branch Prims.list  ->  FStar_Range.range  ->  FStar_Range.range  ->  term = (fun branches r1 r2 -> (
# 180 "FStar.Parser.AST.fst"
let x = if (FStar_ST.read FStar_Options.universes) then begin
(
# 182 "FStar.Parser.AST.fst"
let i = (FStar_Syntax_Syntax.next_id ())
in (FStar_Ident.gen r1))
end else begin
(FStar_Absyn_Util.genident (Some (r1)))
end
in (let _132_1012 = (let _132_1011 = (let _132_1010 = (let _132_1009 = (let _132_1008 = (let _132_1007 = (let _132_1006 = (let _132_1005 = (FStar_Ident.lid_of_ids ((x)::[]))
in Var (_132_1005))
in (mk_term _132_1006 r1 Expr))
in (_132_1007, branches))
in Match (_132_1008))
in (mk_term _132_1009 r2 Expr))
in (((mk_pattern (PatVar ((x, false))) r1))::[], _132_1010))
in Abs (_132_1011))
in (mk_term _132_1012 r2 Expr))))

# 187 "FStar.Parser.AST.fst"
let un_function : pattern  ->  term  ->  (pattern * term) Prims.option = (fun p tm -> (match ((p.pat, tm.tm)) with
| (PatVar (_47_242), Abs (pats, body)) -> begin
Some (((mk_pattern (PatApp ((p, pats))) p.prange), body))
end
| _47_250 -> begin
None
end))

# 192 "FStar.Parser.AST.fst"
let lid_with_range : FStar_Ident.lident  ->  FStar_Range.range  ->  FStar_Ident.lident = (fun lid r -> (let _132_1021 = (FStar_Ident.path_of_lid lid)
in (FStar_Ident.lid_of_path _132_1021 r)))

# 194 "FStar.Parser.AST.fst"
let to_string_l = (fun sep f l -> (let _132_1028 = (FStar_List.map f l)
in (FStar_String.concat sep _132_1028)))

# 195 "FStar.Parser.AST.fst"
let imp_to_string : imp  ->  Prims.string = (fun _47_1 -> (match (_47_1) with
| Hash -> begin
"#"
end
| _47_259 -> begin
""
end))

# 198 "FStar.Parser.AST.fst"
let rec term_to_string : term  ->  Prims.string = (fun x -> (match (x.tm) with
| Wild -> begin
"_"
end
| Requires (t, _47_264) -> begin
(let _132_1035 = (term_to_string t)
in (FStar_Util.format1 "(requires %s)" _132_1035))
end
| Ensures (t, _47_269) -> begin
(let _132_1036 = (term_to_string t)
in (FStar_Util.format1 "(ensures %s)" _132_1036))
end
| Labeled (t, l, _47_275) -> begin
(let _132_1037 = (term_to_string t)
in (FStar_Util.format2 "(labeled %s %s)" l _132_1037))
end
| Const (c) -> begin
(FStar_Absyn_Print.const_to_string c)
end
| Op (s, xs) -> begin
(let _132_1040 = (let _132_1039 = (FStar_List.map (fun x -> (FStar_All.pipe_right x term_to_string)) xs)
in (FStar_String.concat ", " _132_1039))
in (FStar_Util.format2 "%s(%s)" s _132_1040))
end
| Tvar (id) -> begin
id.FStar_Ident.idText
end
| (Var (l)) | (Name (l)) -> begin
l.FStar_Ident.str
end
| Construct (l, args) -> begin
(let _132_1043 = (to_string_l " " (fun _47_296 -> (match (_47_296) with
| (a, imp) -> begin
(let _132_1042 = (term_to_string a)
in (FStar_Util.format2 "%s%s" (imp_to_string imp) _132_1042))
end)) args)
in (FStar_Util.format2 "(%s %s)" l.FStar_Ident.str _132_1043))
end
| Abs (pats, t) when (x.level = Expr) -> begin
(let _132_1045 = (to_string_l " " pat_to_string pats)
in (let _132_1044 = (FStar_All.pipe_right t term_to_string)
in (FStar_Util.format2 "(fun %s -> %s)" _132_1045 _132_1044)))
end
| Abs (pats, t) when (x.level = Type) -> begin
(let _132_1047 = (to_string_l " " pat_to_string pats)
in (let _132_1046 = (FStar_All.pipe_right t term_to_string)
in (FStar_Util.format2 "(fun %s => %s)" _132_1047 _132_1046)))
end
| App (t1, t2, imp) -> begin
(let _132_1049 = (FStar_All.pipe_right t1 term_to_string)
in (let _132_1048 = (FStar_All.pipe_right t2 term_to_string)
in (FStar_Util.format3 "%s %s%s" _132_1049 (imp_to_string imp) _132_1048)))
end
| Let (false, (pat, tm)::[], body) -> begin
(let _132_1052 = (FStar_All.pipe_right pat pat_to_string)
in (let _132_1051 = (FStar_All.pipe_right tm term_to_string)
in (let _132_1050 = (FStar_All.pipe_right body term_to_string)
in (FStar_Util.format3 "let %s = %s in %s" _132_1052 _132_1051 _132_1050))))
end
| Let (_47_319, lbs, body) -> begin
(let _132_1057 = (to_string_l " and " (fun _47_326 -> (match (_47_326) with
| (p, b) -> begin
(let _132_1055 = (FStar_All.pipe_right p pat_to_string)
in (let _132_1054 = (FStar_All.pipe_right b term_to_string)
in (FStar_Util.format2 "%s=%s" _132_1055 _132_1054)))
end)) lbs)
in (let _132_1056 = (FStar_All.pipe_right body term_to_string)
in (FStar_Util.format2 "let rec %s in %s" _132_1057 _132_1056)))
end
| Seq (t1, t2) -> begin
(let _132_1059 = (FStar_All.pipe_right t1 term_to_string)
in (let _132_1058 = (FStar_All.pipe_right t2 term_to_string)
in (FStar_Util.format2 "%s; %s" _132_1059 _132_1058)))
end
| If (t1, t2, t3) -> begin
(let _132_1062 = (FStar_All.pipe_right t1 term_to_string)
in (let _132_1061 = (FStar_All.pipe_right t2 term_to_string)
in (let _132_1060 = (FStar_All.pipe_right t3 term_to_string)
in (FStar_Util.format3 "if %s then %s else %s" _132_1062 _132_1061 _132_1060))))
end
| Match (t, branches) -> begin
(let _132_1069 = (FStar_All.pipe_right t term_to_string)
in (let _132_1068 = (to_string_l " | " (fun _47_343 -> (match (_47_343) with
| (p, w, e) -> begin
(let _132_1067 = (FStar_All.pipe_right p pat_to_string)
in (let _132_1066 = (match (w) with
| None -> begin
""
end
| Some (e) -> begin
(let _132_1064 = (term_to_string e)
in (FStar_Util.format1 "when %s" _132_1064))
end)
in (let _132_1065 = (FStar_All.pipe_right e term_to_string)
in (FStar_Util.format3 "%s %s -> %s" _132_1067 _132_1066 _132_1065))))
end)) branches)
in (FStar_Util.format2 "match %s with %s" _132_1069 _132_1068)))
end
| Ascribed (t1, t2) -> begin
(let _132_1071 = (FStar_All.pipe_right t1 term_to_string)
in (let _132_1070 = (FStar_All.pipe_right t2 term_to_string)
in (FStar_Util.format2 "(%s : %s)" _132_1071 _132_1070)))
end
| Record (Some (e), fields) -> begin
(let _132_1075 = (FStar_All.pipe_right e term_to_string)
in (let _132_1074 = (to_string_l " " (fun _47_358 -> (match (_47_358) with
| (l, e) -> begin
(let _132_1073 = (FStar_All.pipe_right e term_to_string)
in (FStar_Util.format2 "%s=%s" l.FStar_Ident.str _132_1073))
end)) fields)
in (FStar_Util.format2 "{%s with %s}" _132_1075 _132_1074)))
end
| Record (None, fields) -> begin
(let _132_1078 = (to_string_l " " (fun _47_365 -> (match (_47_365) with
| (l, e) -> begin
(let _132_1077 = (FStar_All.pipe_right e term_to_string)
in (FStar_Util.format2 "%s=%s" l.FStar_Ident.str _132_1077))
end)) fields)
in (FStar_Util.format1 "{%s}" _132_1078))
end
| Project (e, l) -> begin
(let _132_1079 = (FStar_All.pipe_right e term_to_string)
in (FStar_Util.format2 "%s.%s" _132_1079 l.FStar_Ident.str))
end
| Product ([], t) -> begin
(term_to_string t)
end
| Product (b::hd::tl, t) -> begin
(term_to_string (mk_term (Product (((b)::[], (mk_term (Product (((hd)::tl, t))) x.range x.level)))) x.range x.level))
end
| Product (b::[], t) when (x.level = Type) -> begin
(let _132_1081 = (FStar_All.pipe_right b binder_to_string)
in (let _132_1080 = (FStar_All.pipe_right t term_to_string)
in (FStar_Util.format2 "%s -> %s" _132_1081 _132_1080)))
end
| Product (b::[], t) when (x.level = Kind) -> begin
(let _132_1083 = (FStar_All.pipe_right b binder_to_string)
in (let _132_1082 = (FStar_All.pipe_right t term_to_string)
in (FStar_Util.format2 "%s => %s" _132_1083 _132_1082)))
end
| Sum (binders, t) -> begin
(let _132_1086 = (let _132_1084 = (FStar_All.pipe_right binders (FStar_List.map binder_to_string))
in (FStar_All.pipe_right _132_1084 (FStar_String.concat " * ")))
in (let _132_1085 = (FStar_All.pipe_right t term_to_string)
in (FStar_Util.format2 "%s * %s" _132_1086 _132_1085)))
end
| QForall (bs, pats, t) -> begin
(let _132_1089 = (to_string_l " " binder_to_string bs)
in (let _132_1088 = (to_string_l " \\/ " (to_string_l "; " term_to_string) pats)
in (let _132_1087 = (FStar_All.pipe_right t term_to_string)
in (FStar_Util.format3 "forall %s.{:pattern %s} %s" _132_1089 _132_1088 _132_1087))))
end
| QExists (bs, pats, t) -> begin
(let _132_1092 = (to_string_l " " binder_to_string bs)
in (let _132_1091 = (to_string_l " \\/ " (to_string_l "; " term_to_string) pats)
in (let _132_1090 = (FStar_All.pipe_right t term_to_string)
in (FStar_Util.format3 "exists %s.{:pattern %s} %s" _132_1092 _132_1091 _132_1090))))
end
| Refine (b, t) -> begin
(let _132_1094 = (FStar_All.pipe_right b binder_to_string)
in (let _132_1093 = (FStar_All.pipe_right t term_to_string)
in (FStar_Util.format2 "%s:{%s}" _132_1094 _132_1093)))
end
| NamedTyp (x, t) -> begin
(let _132_1095 = (FStar_All.pipe_right t term_to_string)
in (FStar_Util.format2 "%s:%s" x.FStar_Ident.idText _132_1095))
end
| Paren (t) -> begin
(let _132_1096 = (FStar_All.pipe_right t term_to_string)
in (FStar_Util.format1 "(%s)" _132_1096))
end
| Product (bs, t) -> begin
(let _132_1099 = (let _132_1097 = (FStar_All.pipe_right bs (FStar_List.map binder_to_string))
in (FStar_All.pipe_right _132_1097 (FStar_String.concat ",")))
in (let _132_1098 = (FStar_All.pipe_right t term_to_string)
in (FStar_Util.format2 "Unidentified product: [%s] %s" _132_1099 _132_1098)))
end
| t -> begin
(FStar_All.failwith "Missing case in term_to_string")
end))
and binder_to_string : binder  ->  Prims.string = (fun x -> (
# 270 "FStar.Parser.AST.fst"
let s = (match (x.b) with
| Variable (i) -> begin
i.FStar_Ident.idText
end
| TVariable (i) -> begin
(FStar_Util.format1 "%s:_" i.FStar_Ident.idText)
end
| (TAnnotated (i, t)) | (Annotated (i, t)) -> begin
(let _132_1101 = (FStar_All.pipe_right t term_to_string)
in (FStar_Util.format2 "%s:%s" i.FStar_Ident.idText _132_1101))
end
| NoName (t) -> begin
(FStar_All.pipe_right t term_to_string)
end)
in (match (x.aqual) with
| Some (Implicit) -> begin
(FStar_Util.format1 "#%s" s)
end
| Some (Equality) -> begin
(FStar_Util.format1 "=%s" s)
end
| _47_440 -> begin
s
end)))
and pat_to_string : pattern  ->  Prims.string = (fun x -> (match (x.pat) with
| PatWild -> begin
"_"
end
| PatConst (c) -> begin
(FStar_Absyn_Print.const_to_string c)
end
| PatApp (p, ps) -> begin
(let _132_1104 = (FStar_All.pipe_right p pat_to_string)
in (let _132_1103 = (to_string_l " " pat_to_string ps)
in (FStar_Util.format2 "(%s %s)" _132_1104 _132_1103)))
end
| (PatTvar (i, true)) | (PatVar (i, true)) -> begin
(FStar_Util.format1 "#%s" i.FStar_Ident.idText)
end
| (PatTvar (i, false)) | (PatVar (i, false)) -> begin
i.FStar_Ident.idText
end
| PatName (l) -> begin
l.FStar_Ident.str
end
| PatList (l) -> begin
(let _132_1105 = (to_string_l "; " pat_to_string l)
in (FStar_Util.format1 "[%s]" _132_1105))
end
| PatTuple (l, false) -> begin
(let _132_1106 = (to_string_l ", " pat_to_string l)
in (FStar_Util.format1 "(%s)" _132_1106))
end
| PatTuple (l, true) -> begin
(let _132_1107 = (to_string_l ", " pat_to_string l)
in (FStar_Util.format1 "(|%s|)" _132_1107))
end
| PatRecord (l) -> begin
(let _132_1110 = (to_string_l "; " (fun _47_479 -> (match (_47_479) with
| (f, e) -> begin
(let _132_1109 = (FStar_All.pipe_right e pat_to_string)
in (FStar_Util.format2 "%s=%s" f.FStar_Ident.str _132_1109))
end)) l)
in (FStar_Util.format1 "{%s}" _132_1110))
end
| PatOr (l) -> begin
(to_string_l "|\n " pat_to_string l)
end
| PatAscribed (p, t) -> begin
(let _132_1112 = (FStar_All.pipe_right p pat_to_string)
in (let _132_1111 = (FStar_All.pipe_right t term_to_string)
in (FStar_Util.format2 "(%s:%s)" _132_1112 _132_1111)))
end))

# 295 "FStar.Parser.AST.fst"
let error = (fun msg tm r -> (
# 298 "FStar.Parser.AST.fst"
let tm = (FStar_All.pipe_right tm term_to_string)
in (
# 299 "FStar.Parser.AST.fst"
let tm = if ((FStar_String.length tm) >= 80) then begin
(let _132_1116 = (FStar_Util.substring tm 0 77)
in (Prims.strcat _132_1116 "..."))
end else begin
tm
end
in if (FStar_ST.read FStar_Options.universes) then begin
(Prims.raise (FStar_Syntax_Syntax.Error (((Prims.strcat (Prims.strcat msg "\n") tm), r))))
end else begin
(Prims.raise (FStar_Absyn_Syntax.Error (((Prims.strcat (Prims.strcat msg "\n") tm), r))))
end)))

# 302 "FStar.Parser.AST.fst"
let consPat : FStar_Range.range  ->  pattern  ->  pattern  ->  pattern' = (fun r hd tl -> PatApp (((mk_pattern (PatName (FStar_Absyn_Const.cons_lid)) r), (hd)::(tl)::[])))

# 304 "FStar.Parser.AST.fst"
let consTerm : FStar_Range.range  ->  term  ->  term  ->  term = (fun r hd tl -> (mk_term (Construct ((FStar_Absyn_Const.cons_lid, ((hd, Nothing))::((tl, Nothing))::[]))) r Expr))

# 305 "FStar.Parser.AST.fst"
let lexConsTerm : FStar_Range.range  ->  term  ->  term  ->  term = (fun r hd tl -> (mk_term (Construct ((FStar_Absyn_Const.lexcons_lid, ((hd, Nothing))::((tl, Nothing))::[]))) r Expr))

# 306 "FStar.Parser.AST.fst"
let mkConsList : FStar_Range.range  ->  term Prims.list  ->  term = (fun r elts -> (
# 309 "FStar.Parser.AST.fst"
let nil = (mk_term (Construct ((FStar_Absyn_Const.nil_lid, []))) r Expr)
in (FStar_List.fold_right (fun e tl -> (consTerm r e tl)) elts nil)))

# 310 "FStar.Parser.AST.fst"
let mkLexList : FStar_Range.range  ->  term Prims.list  ->  term = (fun r elts -> (
# 313 "FStar.Parser.AST.fst"
let nil = (mk_term (Construct ((FStar_Absyn_Const.lextop_lid, []))) r Expr)
in (FStar_List.fold_right (fun e tl -> (lexConsTerm r e tl)) elts nil)))

# 314 "FStar.Parser.AST.fst"
let mkApp : term  ->  (term * imp) Prims.list  ->  FStar_Range.range  ->  term = (fun t args r -> (match (args) with
| [] -> begin
t
end
| _47_515 -> begin
(match (t.tm) with
| Name (s) -> begin
(mk_term (Construct ((s, args))) r Un)
end
| _47_519 -> begin
(FStar_List.fold_left (fun t _47_523 -> (match (_47_523) with
| (a, imp) -> begin
(mk_term (App ((t, a, imp))) r Un)
end)) t args)
end)
end))

# 320 "FStar.Parser.AST.fst"
let mkRefSet : FStar_Range.range  ->  term Prims.list  ->  term = (fun r elts -> (
# 323 "FStar.Parser.AST.fst"
let empty = (let _132_1160 = (let _132_1159 = (FStar_Ident.set_lid_range FStar_Absyn_Const.set_empty r)
in Var (_132_1159))
in (mk_term _132_1160 r Expr))
in (
# 324 "FStar.Parser.AST.fst"
let ref_constr = (let _132_1162 = (let _132_1161 = (FStar_Ident.set_lid_range FStar_Absyn_Const.heap_ref r)
in Var (_132_1161))
in (mk_term _132_1162 r Expr))
in (
# 325 "FStar.Parser.AST.fst"
let singleton = (let _132_1164 = (let _132_1163 = (FStar_Ident.set_lid_range FStar_Absyn_Const.set_singleton r)
in Var (_132_1163))
in (mk_term _132_1164 r Expr))
in (
# 326 "FStar.Parser.AST.fst"
let union = (let _132_1166 = (let _132_1165 = (FStar_Ident.set_lid_range FStar_Absyn_Const.set_union r)
in Var (_132_1165))
in (mk_term _132_1166 r Expr))
in (FStar_List.fold_right (fun e tl -> (
# 328 "FStar.Parser.AST.fst"
let e = (mkApp ref_constr (((e, Nothing))::[]) r)
in (
# 329 "FStar.Parser.AST.fst"
let single_e = (mkApp singleton (((e, Nothing))::[]) r)
in (mkApp union (((single_e, Nothing))::((tl, Nothing))::[]) r)))) elts empty))))))

# 330 "FStar.Parser.AST.fst"
let mkExplicitApp : term  ->  term Prims.list  ->  FStar_Range.range  ->  term = (fun t args r -> (match (args) with
| [] -> begin
t
end
| _47_539 -> begin
(match (t.tm) with
| Name (s) -> begin
(let _132_1178 = (let _132_1177 = (let _132_1176 = (FStar_List.map (fun a -> (a, Nothing)) args)
in (s, _132_1176))
in Construct (_132_1177))
in (mk_term _132_1178 r Un))
end
| _47_544 -> begin
(FStar_List.fold_left (fun t a -> (mk_term (App ((t, a, Nothing))) r Un)) t args)
end)
end))

# 336 "FStar.Parser.AST.fst"
let mkAdmitMagic : FStar_Range.range  ->  term = (fun r -> (
# 339 "FStar.Parser.AST.fst"
let unit_const = (mk_term (Const (FStar_Const.Const_unit)) r Expr)
in (
# 340 "FStar.Parser.AST.fst"
let admit = (
# 341 "FStar.Parser.AST.fst"
let admit_name = (let _132_1184 = (let _132_1183 = (FStar_Ident.set_lid_range FStar_Absyn_Const.admit_lid r)
in Var (_132_1183))
in (mk_term _132_1184 r Expr))
in (mkExplicitApp admit_name ((unit_const)::[]) r))
in (
# 343 "FStar.Parser.AST.fst"
let magic = (
# 344 "FStar.Parser.AST.fst"
let magic_name = (let _132_1186 = (let _132_1185 = (FStar_Ident.set_lid_range FStar_Absyn_Const.magic_lid r)
in Var (_132_1185))
in (mk_term _132_1186 r Expr))
in (mkExplicitApp magic_name ((unit_const)::[]) r))
in (
# 346 "FStar.Parser.AST.fst"
let admit_magic = (mk_term (Seq ((admit, magic))) r Expr)
in admit_magic)))))

# 349 "FStar.Parser.AST.fst"
let mkWildAdmitMagic = (fun r -> (let _132_1188 = (mkAdmitMagic r)
in ((mk_pattern PatWild r), None, _132_1188)))

# 349 "FStar.Parser.AST.fst"
let focusBranches = (fun branches r -> (
# 352 "FStar.Parser.AST.fst"
let should_filter = (FStar_Util.for_some Prims.fst branches)
in if should_filter then begin
(
# 354 "FStar.Parser.AST.fst"
let _47_558 = (FStar_Tc_Errors.warn r "Focusing on only some cases")
in (
# 355 "FStar.Parser.AST.fst"
let focussed = (let _132_1191 = (FStar_List.filter Prims.fst branches)
in (FStar_All.pipe_right _132_1191 (FStar_List.map Prims.snd)))
in (let _132_1193 = (let _132_1192 = (mkWildAdmitMagic r)
in (_132_1192)::[])
in (FStar_List.append focussed _132_1193))))
end else begin
(FStar_All.pipe_right branches (FStar_List.map Prims.snd))
end))

# 357 "FStar.Parser.AST.fst"
let focusLetBindings = (fun lbs r -> (
# 360 "FStar.Parser.AST.fst"
let should_filter = (FStar_Util.for_some Prims.fst lbs)
in if should_filter then begin
(
# 362 "FStar.Parser.AST.fst"
let _47_564 = (FStar_Tc_Errors.warn r "Focusing on only some cases in this (mutually) recursive definition")
in (FStar_List.map (fun _47_568 -> (match (_47_568) with
| (f, lb) -> begin
if f then begin
lb
end else begin
(let _132_1197 = (mkAdmitMagic r)
in ((Prims.fst lb), _132_1197))
end
end)) lbs))
end else begin
(FStar_All.pipe_right lbs (FStar_List.map Prims.snd))
end))

# 368 "FStar.Parser.AST.fst"
let mkFsTypApp : term  ->  term Prims.list  ->  FStar_Range.range  ->  term = (fun t args r -> (let _132_1205 = (FStar_List.map (fun a -> (a, FsTypApp)) args)
in (mkApp t _132_1205 r)))

# 369 "FStar.Parser.AST.fst"
let mkTuple : term Prims.list  ->  FStar_Range.range  ->  term = (fun args r -> (
# 372 "FStar.Parser.AST.fst"
let cons = if (FStar_ST.read FStar_Options.universes) then begin
(FStar_Syntax_Util.mk_tuple_data_lid (FStar_List.length args) r)
end else begin
(FStar_Absyn_Util.mk_tuple_data_lid (FStar_List.length args) r)
end
in (let _132_1211 = (FStar_List.map (fun x -> (x, Nothing)) args)
in (mkApp (mk_term (Name (cons)) r Expr) _132_1211 r))))

# 376 "FStar.Parser.AST.fst"
let mkDTuple : term Prims.list  ->  FStar_Range.range  ->  term = (fun args r -> (
# 379 "FStar.Parser.AST.fst"
let cons = if (FStar_ST.read FStar_Options.universes) then begin
(FStar_Syntax_Util.mk_dtuple_data_lid (FStar_List.length args) r)
end else begin
(FStar_Absyn_Util.mk_dtuple_data_lid (FStar_List.length args) r)
end
in (let _132_1217 = (FStar_List.map (fun x -> (x, Nothing)) args)
in (mkApp (mk_term (Name (cons)) r Expr) _132_1217 r))))

# 383 "FStar.Parser.AST.fst"
let mkRefinedBinder : FStar_Ident.ident  ->  term  ->  term Prims.option  ->  FStar_Range.range  ->  aqual  ->  binder = (fun id t refopt m implicit -> (
# 386 "FStar.Parser.AST.fst"
let b = (mk_binder (Annotated ((id, t))) m Type implicit)
in (match (refopt) with
| None -> begin
b
end
| Some (t) -> begin
(mk_binder (Annotated ((id, (mk_term (Refine ((b, t))) m Type)))) m Type implicit)
end)))

# 389 "FStar.Parser.AST.fst"
let rec extract_named_refinement : term  ->  (FStar_Ident.ident * term * term Prims.option) Prims.option = (fun t1 -> (match (t1.tm) with
| NamedTyp (x, t) -> begin
Some ((x, t, None))
end
| Refine ({b = Annotated (x, t); brange = _47_600; blevel = _47_598; aqual = _47_596}, t') -> begin
Some ((x, t, Some (t')))
end
| Paren (t) -> begin
(extract_named_refinement t)
end
| _47_612 -> begin
None
end))




