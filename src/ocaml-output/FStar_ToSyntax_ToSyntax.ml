open Prims
let (desugar_disjunctive_pattern :
  FStar_Syntax_Syntax.pat' FStar_Syntax_Syntax.withinfo_t Prims.list ->
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax
      FStar_Pervasives_Native.option ->
      FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
        FStar_Syntax_Syntax.branch Prims.list)
  =
  fun pats  ->
    fun when_opt  ->
      fun branch1  ->
        FStar_All.pipe_right pats
          (FStar_List.map
             (fun pat  -> FStar_Syntax_Util.branch (pat, when_opt, branch1)))
  
let (trans_aqual :
  FStar_Parser_AST.arg_qualifier FStar_Pervasives_Native.option ->
    FStar_Syntax_Syntax.arg_qualifier FStar_Pervasives_Native.option)
  =
  fun uu___84_66  ->
    match uu___84_66 with
    | FStar_Pervasives_Native.Some (FStar_Parser_AST.Implicit ) ->
        FStar_Pervasives_Native.Some FStar_Syntax_Syntax.imp_tag
    | FStar_Pervasives_Native.Some (FStar_Parser_AST.Equality ) ->
        FStar_Pervasives_Native.Some FStar_Syntax_Syntax.Equality
    | uu____71 -> FStar_Pervasives_Native.None
  
let (trans_qual :
  FStar_Range.range ->
    FStar_Ident.lident FStar_Pervasives_Native.option ->
      FStar_Parser_AST.qualifier -> FStar_Syntax_Syntax.qualifier)
  =
  fun r  ->
    fun maybe_effect_id  ->
      fun uu___85_90  ->
        match uu___85_90 with
        | FStar_Parser_AST.Private  -> FStar_Syntax_Syntax.Private
        | FStar_Parser_AST.Assumption  -> FStar_Syntax_Syntax.Assumption
        | FStar_Parser_AST.Unfold_for_unification_and_vcgen  ->
            FStar_Syntax_Syntax.Unfold_for_unification_and_vcgen
        | FStar_Parser_AST.Inline_for_extraction  ->
            FStar_Syntax_Syntax.Inline_for_extraction
        | FStar_Parser_AST.NoExtract  -> FStar_Syntax_Syntax.NoExtract
        | FStar_Parser_AST.Irreducible  -> FStar_Syntax_Syntax.Irreducible
        | FStar_Parser_AST.Logic  -> FStar_Syntax_Syntax.Logic
        | FStar_Parser_AST.TotalEffect  -> FStar_Syntax_Syntax.TotalEffect
        | FStar_Parser_AST.Effect_qual  -> FStar_Syntax_Syntax.Effect
        | FStar_Parser_AST.New  -> FStar_Syntax_Syntax.New
        | FStar_Parser_AST.Abstract  -> FStar_Syntax_Syntax.Abstract
        | FStar_Parser_AST.Opaque  ->
            (FStar_Errors.log_issue r
               (FStar_Errors.Warning_DeprecatedOpaqueQualifier,
                 "The 'opaque' qualifier is deprecated since its use was strangely schizophrenic. There were two overloaded uses: (1) Given 'opaque val f : t', the behavior was to exclude the definition of 'f' to the SMT solver. This corresponds roughly to the new 'irreducible' qualifier. (2) Given 'opaque type t = t'', the behavior was to provide the definition of 't' to the SMT solver, but not to inline it, unless absolutely required for unification. This corresponds roughly to the behavior of 'unfoldable' (which is currently the default).");
             FStar_Syntax_Syntax.Visible_default)
        | FStar_Parser_AST.Reflectable  ->
            (match maybe_effect_id with
             | FStar_Pervasives_Native.None  ->
                 FStar_Errors.raise_error
                   (FStar_Errors.Fatal_ReflectOnlySupportedOnEffects,
                     "Qualifier reflect only supported on effects") r
             | FStar_Pervasives_Native.Some effect_id ->
                 FStar_Syntax_Syntax.Reflectable effect_id)
        | FStar_Parser_AST.Reifiable  -> FStar_Syntax_Syntax.Reifiable
        | FStar_Parser_AST.Noeq  -> FStar_Syntax_Syntax.Noeq
        | FStar_Parser_AST.Unopteq  -> FStar_Syntax_Syntax.Unopteq
        | FStar_Parser_AST.DefaultEffect  ->
            FStar_Errors.raise_error
              (FStar_Errors.Fatal_DefaultQualifierNotAllowedOnEffects,
                "The 'default' qualifier on effects is no longer supported")
              r
        | FStar_Parser_AST.Inline  ->
            FStar_Errors.raise_error
              (FStar_Errors.Fatal_UnsupportedQualifier,
                "Unsupported qualifier") r
        | FStar_Parser_AST.Visible  ->
            FStar_Errors.raise_error
              (FStar_Errors.Fatal_UnsupportedQualifier,
                "Unsupported qualifier") r
  
let (trans_pragma : FStar_Parser_AST.pragma -> FStar_Syntax_Syntax.pragma) =
  fun uu___86_99  ->
    match uu___86_99 with
    | FStar_Parser_AST.SetOptions s -> FStar_Syntax_Syntax.SetOptions s
    | FStar_Parser_AST.ResetOptions sopt ->
        FStar_Syntax_Syntax.ResetOptions sopt
    | FStar_Parser_AST.LightOff  -> FStar_Syntax_Syntax.LightOff
  
let (as_imp :
  FStar_Parser_AST.imp ->
    FStar_Syntax_Syntax.arg_qualifier FStar_Pervasives_Native.option)
  =
  fun uu___87_110  ->
    match uu___87_110 with
    | FStar_Parser_AST.Hash  ->
        FStar_Pervasives_Native.Some FStar_Syntax_Syntax.imp_tag
    | uu____113 -> FStar_Pervasives_Native.None
  
let arg_withimp_e :
  'Auu____120 .
    FStar_Parser_AST.imp ->
      'Auu____120 ->
        ('Auu____120,FStar_Syntax_Syntax.arg_qualifier
                       FStar_Pervasives_Native.option)
          FStar_Pervasives_Native.tuple2
  = fun imp  -> fun t  -> (t, (as_imp imp)) 
let arg_withimp_t :
  'Auu____145 .
    FStar_Parser_AST.imp ->
      'Auu____145 ->
        ('Auu____145,FStar_Syntax_Syntax.arg_qualifier
                       FStar_Pervasives_Native.option)
          FStar_Pervasives_Native.tuple2
  =
  fun imp  ->
    fun t  ->
      match imp with
      | FStar_Parser_AST.Hash  ->
          (t, (FStar_Pervasives_Native.Some FStar_Syntax_Syntax.imp_tag))
      | uu____164 -> (t, FStar_Pervasives_Native.None)
  
let (contains_binder : FStar_Parser_AST.binder Prims.list -> Prims.bool) =
  fun binders  ->
    FStar_All.pipe_right binders
      (FStar_Util.for_some
         (fun b  ->
            match b.FStar_Parser_AST.b with
            | FStar_Parser_AST.Annotated uu____181 -> true
            | uu____186 -> false))
  
let rec (unparen : FStar_Parser_AST.term -> FStar_Parser_AST.term) =
  fun t  ->
    match t.FStar_Parser_AST.tm with
    | FStar_Parser_AST.Paren t1 -> unparen t1
    | uu____193 -> t
  
let (tm_type_z : FStar_Range.range -> FStar_Parser_AST.term) =
  fun r  ->
    let uu____199 =
      let uu____200 = FStar_Ident.lid_of_path ["Type0"] r  in
      FStar_Parser_AST.Name uu____200  in
    FStar_Parser_AST.mk_term uu____199 r FStar_Parser_AST.Kind
  
let (tm_type : FStar_Range.range -> FStar_Parser_AST.term) =
  fun r  ->
    let uu____206 =
      let uu____207 = FStar_Ident.lid_of_path ["Type"] r  in
      FStar_Parser_AST.Name uu____207  in
    FStar_Parser_AST.mk_term uu____206 r FStar_Parser_AST.Kind
  
let rec (is_comp_type :
  FStar_Syntax_DsEnv.env -> FStar_Parser_AST.term -> Prims.bool) =
  fun env  ->
    fun t  ->
      let uu____218 =
        let uu____219 = unparen t  in uu____219.FStar_Parser_AST.tm  in
      match uu____218 with
      | FStar_Parser_AST.Name l ->
          let uu____221 = FStar_Syntax_DsEnv.try_lookup_effect_name env l  in
          FStar_All.pipe_right uu____221 FStar_Option.isSome
      | FStar_Parser_AST.Construct (l,uu____227) ->
          let uu____240 = FStar_Syntax_DsEnv.try_lookup_effect_name env l  in
          FStar_All.pipe_right uu____240 FStar_Option.isSome
      | FStar_Parser_AST.App (head1,uu____246,uu____247) ->
          is_comp_type env head1
      | FStar_Parser_AST.Paren t1 -> failwith "impossible"
      | FStar_Parser_AST.Ascribed (t1,uu____250,uu____251) ->
          is_comp_type env t1
      | FStar_Parser_AST.LetOpen (uu____256,t1) -> is_comp_type env t1
      | uu____258 -> false
  
let (unit_ty : FStar_Parser_AST.term) =
  FStar_Parser_AST.mk_term
    (FStar_Parser_AST.Name FStar_Parser_Const.unit_lid)
    FStar_Range.dummyRange FStar_Parser_AST.Type_level
  
let (compile_op_lid :
  Prims.int -> Prims.string -> FStar_Range.range -> FStar_Ident.lident) =
  fun n1  ->
    fun s  ->
      fun r  ->
        let uu____274 =
          let uu____277 =
            let uu____278 =
              let uu____283 = FStar_Parser_AST.compile_op n1 s r  in
              (uu____283, r)  in
            FStar_Ident.mk_ident uu____278  in
          [uu____277]  in
        FStar_All.pipe_right uu____274 FStar_Ident.lid_of_ids
  
let op_as_term :
  'Auu____296 .
    FStar_Syntax_DsEnv.env ->
      Prims.int ->
        'Auu____296 ->
          FStar_Ident.ident ->
            FStar_Syntax_Syntax.term FStar_Pervasives_Native.option
  =
  fun env  ->
    fun arity  ->
      fun rng  ->
        fun op  ->
          let r l dd =
            let uu____332 =
              let uu____333 =
                let uu____334 =
                  FStar_Ident.set_lid_range l op.FStar_Ident.idRange  in
                FStar_Syntax_Syntax.lid_as_fv uu____334 dd
                  FStar_Pervasives_Native.None
                 in
              FStar_All.pipe_right uu____333 FStar_Syntax_Syntax.fv_to_tm  in
            FStar_Pervasives_Native.Some uu____332  in
          let fallback uu____342 =
            let uu____343 = FStar_Ident.text_of_id op  in
            match uu____343 with
            | "=" ->
                r FStar_Parser_Const.op_Eq
                  FStar_Syntax_Syntax.Delta_equational
            | ":=" ->
                r FStar_Parser_Const.write_lid
                  FStar_Syntax_Syntax.Delta_equational
            | "<" ->
                r FStar_Parser_Const.op_LT
                  FStar_Syntax_Syntax.Delta_equational
            | "<=" ->
                r FStar_Parser_Const.op_LTE
                  FStar_Syntax_Syntax.Delta_equational
            | ">" ->
                r FStar_Parser_Const.op_GT
                  FStar_Syntax_Syntax.Delta_equational
            | ">=" ->
                r FStar_Parser_Const.op_GTE
                  FStar_Syntax_Syntax.Delta_equational
            | "&&" ->
                r FStar_Parser_Const.op_And
                  FStar_Syntax_Syntax.Delta_equational
            | "||" ->
                r FStar_Parser_Const.op_Or
                  FStar_Syntax_Syntax.Delta_equational
            | "+" ->
                r FStar_Parser_Const.op_Addition
                  FStar_Syntax_Syntax.Delta_equational
            | "-" when arity = (Prims.parse_int "1") ->
                r FStar_Parser_Const.op_Minus
                  FStar_Syntax_Syntax.Delta_equational
            | "-" ->
                r FStar_Parser_Const.op_Subtraction
                  FStar_Syntax_Syntax.Delta_equational
            | "/" ->
                r FStar_Parser_Const.op_Division
                  FStar_Syntax_Syntax.Delta_equational
            | "%" ->
                r FStar_Parser_Const.op_Modulus
                  FStar_Syntax_Syntax.Delta_equational
            | "!" ->
                r FStar_Parser_Const.read_lid
                  FStar_Syntax_Syntax.Delta_equational
            | "@" ->
                let uu____346 = FStar_Options.ml_ish ()  in
                if uu____346
                then
                  r FStar_Parser_Const.list_append_lid
                    FStar_Syntax_Syntax.Delta_equational
                else
                  r FStar_Parser_Const.list_tot_append_lid
                    FStar_Syntax_Syntax.Delta_equational
            | "^" ->
                r FStar_Parser_Const.strcat_lid
                  FStar_Syntax_Syntax.Delta_equational
            | "|>" ->
                r FStar_Parser_Const.pipe_right_lid
                  FStar_Syntax_Syntax.Delta_equational
            | "<|" ->
                r FStar_Parser_Const.pipe_left_lid
                  FStar_Syntax_Syntax.Delta_equational
            | "<>" ->
                r FStar_Parser_Const.op_notEq
                  FStar_Syntax_Syntax.Delta_equational
            | "~" ->
                r FStar_Parser_Const.not_lid
                  (FStar_Syntax_Syntax.Delta_defined_at_level
                     (Prims.parse_int "2"))
            | "==" ->
                r FStar_Parser_Const.eq2_lid
                  (FStar_Syntax_Syntax.Delta_defined_at_level
                     (Prims.parse_int "2"))
            | "<<" ->
                r FStar_Parser_Const.precedes_lid
                  FStar_Syntax_Syntax.Delta_constant
            | "/\\" ->
                r FStar_Parser_Const.and_lid
                  (FStar_Syntax_Syntax.Delta_defined_at_level
                     (Prims.parse_int "1"))
            | "\\/" ->
                r FStar_Parser_Const.or_lid
                  (FStar_Syntax_Syntax.Delta_defined_at_level
                     (Prims.parse_int "1"))
            | "==>" ->
                r FStar_Parser_Const.imp_lid
                  (FStar_Syntax_Syntax.Delta_defined_at_level
                     (Prims.parse_int "1"))
            | "<==>" ->
                r FStar_Parser_Const.iff_lid
                  (FStar_Syntax_Syntax.Delta_defined_at_level
                     (Prims.parse_int "2"))
            | uu____350 -> FStar_Pervasives_Native.None  in
          let uu____351 =
            let uu____358 =
              compile_op_lid arity op.FStar_Ident.idText
                op.FStar_Ident.idRange
               in
            FStar_Syntax_DsEnv.try_lookup_lid env uu____358  in
          match uu____351 with
          | FStar_Pervasives_Native.Some t ->
              FStar_Pervasives_Native.Some (FStar_Pervasives_Native.fst t)
          | uu____370 -> fallback ()
  
let (sort_ftv : FStar_Ident.ident Prims.list -> FStar_Ident.ident Prims.list)
  =
  fun ftv  ->
    let uu____388 =
      FStar_Util.remove_dups
        (fun x  -> fun y  -> x.FStar_Ident.idText = y.FStar_Ident.idText) ftv
       in
    FStar_All.pipe_left
      (FStar_Util.sort_with
         (fun x  ->
            fun y  ->
              FStar_String.compare x.FStar_Ident.idText y.FStar_Ident.idText))
      uu____388
  
let rec (free_type_vars_b :
  FStar_Syntax_DsEnv.env ->
    FStar_Parser_AST.binder ->
      (FStar_Syntax_DsEnv.env,FStar_Ident.ident Prims.list)
        FStar_Pervasives_Native.tuple2)
  =
  fun env  ->
    fun binder  ->
      match binder.FStar_Parser_AST.b with
      | FStar_Parser_AST.Variable uu____435 -> (env, [])
      | FStar_Parser_AST.TVariable x ->
          let uu____439 = FStar_Syntax_DsEnv.push_bv env x  in
          (match uu____439 with | (env1,uu____451) -> (env1, [x]))
      | FStar_Parser_AST.Annotated (uu____454,term) ->
          let uu____456 = free_type_vars env term  in (env, uu____456)
      | FStar_Parser_AST.TAnnotated (id1,uu____462) ->
          let uu____463 = FStar_Syntax_DsEnv.push_bv env id1  in
          (match uu____463 with | (env1,uu____475) -> (env1, []))
      | FStar_Parser_AST.NoName t ->
          let uu____479 = free_type_vars env t  in (env, uu____479)

and (free_type_vars :
  FStar_Syntax_DsEnv.env ->
    FStar_Parser_AST.term -> FStar_Ident.ident Prims.list)
  =
  fun env  ->
    fun t  ->
      let uu____486 =
        let uu____487 = unparen t  in uu____487.FStar_Parser_AST.tm  in
      match uu____486 with
      | FStar_Parser_AST.Labeled uu____490 ->
          failwith "Impossible --- labeled source term"
      | FStar_Parser_AST.Tvar a ->
          let uu____500 = FStar_Syntax_DsEnv.try_lookup_id env a  in
          (match uu____500 with
           | FStar_Pervasives_Native.None  -> [a]
           | uu____513 -> [])
      | FStar_Parser_AST.Wild  -> []
      | FStar_Parser_AST.Const uu____520 -> []
      | FStar_Parser_AST.Uvar uu____521 -> []
      | FStar_Parser_AST.Var uu____522 -> []
      | FStar_Parser_AST.Projector uu____523 -> []
      | FStar_Parser_AST.Discrim uu____528 -> []
      | FStar_Parser_AST.Name uu____529 -> []
      | FStar_Parser_AST.Requires (t1,uu____531) -> free_type_vars env t1
      | FStar_Parser_AST.Ensures (t1,uu____537) -> free_type_vars env t1
      | FStar_Parser_AST.NamedTyp (uu____542,t1) -> free_type_vars env t1
      | FStar_Parser_AST.Paren t1 -> failwith "impossible"
      | FStar_Parser_AST.Ascribed (t1,t',tacopt) ->
          let ts = t1 :: t' ::
            (match tacopt with
             | FStar_Pervasives_Native.None  -> []
             | FStar_Pervasives_Native.Some t2 -> [t2])
             in
          FStar_List.collect (free_type_vars env) ts
      | FStar_Parser_AST.Construct (uu____560,ts) ->
          FStar_List.collect
            (fun uu____581  ->
               match uu____581 with | (t1,uu____589) -> free_type_vars env t1)
            ts
      | FStar_Parser_AST.Op (uu____590,ts) ->
          FStar_List.collect (free_type_vars env) ts
      | FStar_Parser_AST.App (t1,t2,uu____598) ->
          let uu____599 = free_type_vars env t1  in
          let uu____602 = free_type_vars env t2  in
          FStar_List.append uu____599 uu____602
      | FStar_Parser_AST.Refine (b,t1) ->
          let uu____607 = free_type_vars_b env b  in
          (match uu____607 with
           | (env1,f) ->
               let uu____622 = free_type_vars env1 t1  in
               FStar_List.append f uu____622)
      | FStar_Parser_AST.Product (binders,body) ->
          let uu____631 =
            FStar_List.fold_left
              (fun uu____651  ->
                 fun binder  ->
                   match uu____651 with
                   | (env1,free) ->
                       let uu____671 = free_type_vars_b env1 binder  in
                       (match uu____671 with
                        | (env2,f) -> (env2, (FStar_List.append f free))))
              (env, []) binders
             in
          (match uu____631 with
           | (env1,free) ->
               let uu____702 = free_type_vars env1 body  in
               FStar_List.append free uu____702)
      | FStar_Parser_AST.Sum (binders,body) ->
          let uu____711 =
            FStar_List.fold_left
              (fun uu____731  ->
                 fun binder  ->
                   match uu____731 with
                   | (env1,free) ->
                       let uu____751 = free_type_vars_b env1 binder  in
                       (match uu____751 with
                        | (env2,f) -> (env2, (FStar_List.append f free))))
              (env, []) binders
             in
          (match uu____711 with
           | (env1,free) ->
               let uu____782 = free_type_vars env1 body  in
               FStar_List.append free uu____782)
      | FStar_Parser_AST.Project (t1,uu____786) -> free_type_vars env t1
      | FStar_Parser_AST.Attributes cattributes ->
          FStar_List.collect (free_type_vars env) cattributes
      | FStar_Parser_AST.Abs uu____790 -> []
      | FStar_Parser_AST.Let uu____797 -> []
      | FStar_Parser_AST.LetOpen uu____818 -> []
      | FStar_Parser_AST.If uu____823 -> []
      | FStar_Parser_AST.QForall uu____830 -> []
      | FStar_Parser_AST.QExists uu____843 -> []
      | FStar_Parser_AST.Record uu____856 -> []
      | FStar_Parser_AST.Match uu____869 -> []
      | FStar_Parser_AST.TryWith uu____884 -> []
      | FStar_Parser_AST.Bind uu____899 -> []
      | FStar_Parser_AST.Quote uu____906 -> []
      | FStar_Parser_AST.VQuote uu____911 -> []
      | FStar_Parser_AST.Antiquote uu____912 -> []
      | FStar_Parser_AST.Seq uu____917 -> []

let (head_and_args :
  FStar_Parser_AST.term ->
    (FStar_Parser_AST.term,(FStar_Parser_AST.term,FStar_Parser_AST.imp)
                             FStar_Pervasives_Native.tuple2 Prims.list)
      FStar_Pervasives_Native.tuple2)
  =
  fun t  ->
    let rec aux args t1 =
      let uu____970 =
        let uu____971 = unparen t1  in uu____971.FStar_Parser_AST.tm  in
      match uu____970 with
      | FStar_Parser_AST.App (t2,arg,imp) -> aux ((arg, imp) :: args) t2
      | FStar_Parser_AST.Construct (l,args') ->
          ({
             FStar_Parser_AST.tm = (FStar_Parser_AST.Name l);
             FStar_Parser_AST.range = (t1.FStar_Parser_AST.range);
             FStar_Parser_AST.level = (t1.FStar_Parser_AST.level)
           }, (FStar_List.append args' args))
      | uu____1013 -> (t1, args)  in
    aux [] t
  
let (close :
  FStar_Syntax_DsEnv.env -> FStar_Parser_AST.term -> FStar_Parser_AST.term) =
  fun env  ->
    fun t  ->
      let ftv =
        let uu____1037 = free_type_vars env t  in
        FStar_All.pipe_left sort_ftv uu____1037  in
      if (FStar_List.length ftv) = (Prims.parse_int "0")
      then t
      else
        (let binders =
           FStar_All.pipe_right ftv
             (FStar_List.map
                (fun x  ->
                   let uu____1055 =
                     let uu____1056 =
                       let uu____1061 = tm_type x.FStar_Ident.idRange  in
                       (x, uu____1061)  in
                     FStar_Parser_AST.TAnnotated uu____1056  in
                   FStar_Parser_AST.mk_binder uu____1055
                     x.FStar_Ident.idRange FStar_Parser_AST.Type_level
                     (FStar_Pervasives_Native.Some FStar_Parser_AST.Implicit)))
            in
         let result =
           FStar_Parser_AST.mk_term (FStar_Parser_AST.Product (binders, t))
             t.FStar_Parser_AST.range t.FStar_Parser_AST.level
            in
         result)
  
let (close_fun :
  FStar_Syntax_DsEnv.env -> FStar_Parser_AST.term -> FStar_Parser_AST.term) =
  fun env  ->
    fun t  ->
      let ftv =
        let uu____1078 = free_type_vars env t  in
        FStar_All.pipe_left sort_ftv uu____1078  in
      if (FStar_List.length ftv) = (Prims.parse_int "0")
      then t
      else
        (let binders =
           FStar_All.pipe_right ftv
             (FStar_List.map
                (fun x  ->
                   let uu____1096 =
                     let uu____1097 =
                       let uu____1102 = tm_type x.FStar_Ident.idRange  in
                       (x, uu____1102)  in
                     FStar_Parser_AST.TAnnotated uu____1097  in
                   FStar_Parser_AST.mk_binder uu____1096
                     x.FStar_Ident.idRange FStar_Parser_AST.Type_level
                     (FStar_Pervasives_Native.Some FStar_Parser_AST.Implicit)))
            in
         let t1 =
           let uu____1104 =
             let uu____1105 = unparen t  in uu____1105.FStar_Parser_AST.tm
              in
           match uu____1104 with
           | FStar_Parser_AST.Product uu____1106 -> t
           | uu____1113 ->
               FStar_Parser_AST.mk_term
                 (FStar_Parser_AST.App
                    ((FStar_Parser_AST.mk_term
                        (FStar_Parser_AST.Name
                           FStar_Parser_Const.effect_Tot_lid)
                        t.FStar_Parser_AST.range t.FStar_Parser_AST.level),
                      t, FStar_Parser_AST.Nothing)) t.FStar_Parser_AST.range
                 t.FStar_Parser_AST.level
            in
         let result =
           FStar_Parser_AST.mk_term (FStar_Parser_AST.Product (binders, t1))
             t1.FStar_Parser_AST.range t1.FStar_Parser_AST.level
            in
         result)
  
let rec (uncurry :
  FStar_Parser_AST.binder Prims.list ->
    FStar_Parser_AST.term ->
      (FStar_Parser_AST.binder Prims.list,FStar_Parser_AST.term)
        FStar_Pervasives_Native.tuple2)
  =
  fun bs  ->
    fun t  ->
      match t.FStar_Parser_AST.tm with
      | FStar_Parser_AST.Product (binders,t1) ->
          uncurry (FStar_List.append bs binders) t1
      | uu____1149 -> (bs, t)
  
let rec (is_var_pattern : FStar_Parser_AST.pattern -> Prims.bool) =
  fun p  ->
    match p.FStar_Parser_AST.pat with
    | FStar_Parser_AST.PatWild  -> true
    | FStar_Parser_AST.PatTvar (uu____1157,uu____1158) -> true
    | FStar_Parser_AST.PatVar (uu____1163,uu____1164) -> true
    | FStar_Parser_AST.PatAscribed (p1,uu____1170) -> is_var_pattern p1
    | uu____1183 -> false
  
let rec (is_app_pattern : FStar_Parser_AST.pattern -> Prims.bool) =
  fun p  ->
    match p.FStar_Parser_AST.pat with
    | FStar_Parser_AST.PatAscribed (p1,uu____1190) -> is_app_pattern p1
    | FStar_Parser_AST.PatApp
        ({ FStar_Parser_AST.pat = FStar_Parser_AST.PatVar uu____1203;
           FStar_Parser_AST.prange = uu____1204;_},uu____1205)
        -> true
    | uu____1216 -> false
  
let (replace_unit_pattern :
  FStar_Parser_AST.pattern -> FStar_Parser_AST.pattern) =
  fun p  ->
    match p.FStar_Parser_AST.pat with
    | FStar_Parser_AST.PatConst (FStar_Const.Const_unit ) ->
        FStar_Parser_AST.mk_pattern
          (FStar_Parser_AST.PatAscribed
             ((FStar_Parser_AST.mk_pattern FStar_Parser_AST.PatWild
                 p.FStar_Parser_AST.prange),
               (unit_ty, FStar_Pervasives_Native.None)))
          p.FStar_Parser_AST.prange
    | uu____1230 -> p
  
let rec (destruct_app_pattern :
  FStar_Syntax_DsEnv.env ->
    Prims.bool ->
      FStar_Parser_AST.pattern ->
        ((FStar_Ident.ident,FStar_Ident.lident) FStar_Util.either,FStar_Parser_AST.pattern
                                                                    Prims.list,
          (FStar_Parser_AST.term,FStar_Parser_AST.term
                                   FStar_Pervasives_Native.option)
            FStar_Pervasives_Native.tuple2 FStar_Pervasives_Native.option)
          FStar_Pervasives_Native.tuple3)
  =
  fun env  ->
    fun is_top_level1  ->
      fun p  ->
        match p.FStar_Parser_AST.pat with
        | FStar_Parser_AST.PatAscribed (p1,t) ->
            let uu____1300 = destruct_app_pattern env is_top_level1 p1  in
            (match uu____1300 with
             | (name,args,uu____1343) ->
                 (name, args, (FStar_Pervasives_Native.Some t)))
        | FStar_Parser_AST.PatApp
            ({
               FStar_Parser_AST.pat = FStar_Parser_AST.PatVar
                 (id1,uu____1393);
               FStar_Parser_AST.prange = uu____1394;_},args)
            when is_top_level1 ->
            let uu____1404 =
              let uu____1409 = FStar_Syntax_DsEnv.qualify env id1  in
              FStar_Util.Inr uu____1409  in
            (uu____1404, args, FStar_Pervasives_Native.None)
        | FStar_Parser_AST.PatApp
            ({
               FStar_Parser_AST.pat = FStar_Parser_AST.PatVar
                 (id1,uu____1431);
               FStar_Parser_AST.prange = uu____1432;_},args)
            -> ((FStar_Util.Inl id1), args, FStar_Pervasives_Native.None)
        | uu____1462 -> failwith "Not an app pattern"
  
let rec (gather_pattern_bound_vars_maybe_top :
  FStar_Ident.ident FStar_Util.set ->
    FStar_Parser_AST.pattern -> FStar_Ident.ident FStar_Util.set)
  =
  fun acc  ->
    fun p  ->
      let gather_pattern_bound_vars_from_list =
        FStar_List.fold_left gather_pattern_bound_vars_maybe_top acc  in
      match p.FStar_Parser_AST.pat with
      | FStar_Parser_AST.PatWild  -> acc
      | FStar_Parser_AST.PatConst uu____1512 -> acc
      | FStar_Parser_AST.PatVar
          (uu____1513,FStar_Pervasives_Native.Some (FStar_Parser_AST.Implicit
           ))
          -> acc
      | FStar_Parser_AST.PatName uu____1516 -> acc
      | FStar_Parser_AST.PatTvar uu____1517 -> acc
      | FStar_Parser_AST.PatOp uu____1524 -> acc
      | FStar_Parser_AST.PatApp (phead,pats) ->
          gather_pattern_bound_vars_from_list (phead :: pats)
      | FStar_Parser_AST.PatVar (x,uu____1532) -> FStar_Util.set_add x acc
      | FStar_Parser_AST.PatList pats ->
          gather_pattern_bound_vars_from_list pats
      | FStar_Parser_AST.PatTuple (pats,uu____1541) ->
          gather_pattern_bound_vars_from_list pats
      | FStar_Parser_AST.PatOr pats ->
          gather_pattern_bound_vars_from_list pats
      | FStar_Parser_AST.PatRecord guarded_pats ->
          let uu____1556 =
            FStar_List.map FStar_Pervasives_Native.snd guarded_pats  in
          gather_pattern_bound_vars_from_list uu____1556
      | FStar_Parser_AST.PatAscribed (pat,uu____1564) ->
          gather_pattern_bound_vars_maybe_top acc pat
  
let (gather_pattern_bound_vars :
  FStar_Parser_AST.pattern -> FStar_Ident.ident FStar_Util.set) =
  let acc =
    FStar_Util.new_set
      (fun id1  ->
         fun id2  ->
           if id1.FStar_Ident.idText = id2.FStar_Ident.idText
           then (Prims.parse_int "0")
           else (Prims.parse_int "1"))
     in
  fun p  -> gather_pattern_bound_vars_maybe_top acc p 
type bnd =
  | LocalBinder of (FStar_Syntax_Syntax.bv,FStar_Syntax_Syntax.aqual)
  FStar_Pervasives_Native.tuple2 
  | LetBinder of
  (FStar_Ident.lident,(FStar_Syntax_Syntax.term,FStar_Syntax_Syntax.term
                                                  FStar_Pervasives_Native.option)
                        FStar_Pervasives_Native.tuple2)
  FStar_Pervasives_Native.tuple2 [@@deriving show]
let (uu___is_LocalBinder : bnd -> Prims.bool) =
  fun projectee  ->
    match projectee with | LocalBinder _0 -> true | uu____1624 -> false
  
let (__proj__LocalBinder__item___0 :
  bnd ->
    (FStar_Syntax_Syntax.bv,FStar_Syntax_Syntax.aqual)
      FStar_Pervasives_Native.tuple2)
  = fun projectee  -> match projectee with | LocalBinder _0 -> _0 
let (uu___is_LetBinder : bnd -> Prims.bool) =
  fun projectee  ->
    match projectee with | LetBinder _0 -> true | uu____1660 -> false
  
let (__proj__LetBinder__item___0 :
  bnd ->
    (FStar_Ident.lident,(FStar_Syntax_Syntax.term,FStar_Syntax_Syntax.term
                                                    FStar_Pervasives_Native.option)
                          FStar_Pervasives_Native.tuple2)
      FStar_Pervasives_Native.tuple2)
  = fun projectee  -> match projectee with | LetBinder _0 -> _0 
let (binder_of_bnd :
  bnd ->
    (FStar_Syntax_Syntax.bv,FStar_Syntax_Syntax.aqual)
      FStar_Pervasives_Native.tuple2)
  =
  fun uu___88_1706  ->
    match uu___88_1706 with
    | LocalBinder (a,aq) -> (a, aq)
    | uu____1713 -> failwith "Impossible"
  
let (as_binder :
  FStar_Syntax_DsEnv.env ->
    FStar_Parser_AST.arg_qualifier FStar_Pervasives_Native.option ->
      (FStar_Ident.ident FStar_Pervasives_Native.option,FStar_Syntax_Syntax.term)
        FStar_Pervasives_Native.tuple2 ->
        (FStar_Syntax_Syntax.binder,FStar_Syntax_DsEnv.env)
          FStar_Pervasives_Native.tuple2)
  =
  fun env  ->
    fun imp  ->
      fun uu___89_1744  ->
        match uu___89_1744 with
        | (FStar_Pervasives_Native.None ,k) ->
            let uu____1760 = FStar_Syntax_Syntax.null_binder k  in
            (uu____1760, env)
        | (FStar_Pervasives_Native.Some a,k) ->
            let uu____1765 = FStar_Syntax_DsEnv.push_bv env a  in
            (match uu____1765 with
             | (env1,a1) ->
                 (((let uu___113_1785 = a1  in
                    {
                      FStar_Syntax_Syntax.ppname =
                        (uu___113_1785.FStar_Syntax_Syntax.ppname);
                      FStar_Syntax_Syntax.index =
                        (uu___113_1785.FStar_Syntax_Syntax.index);
                      FStar_Syntax_Syntax.sort = k
                    }), (trans_aqual imp)), env1))
  
type env_t = FStar_Syntax_DsEnv.env[@@deriving show]
type lenv_t = FStar_Syntax_Syntax.bv Prims.list[@@deriving show]
let (mk_lb :
  (FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax Prims.list,(FStar_Syntax_Syntax.bv,
                                                                    FStar_Syntax_Syntax.fv)
                                                                    FStar_Util.either,
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax,FStar_Syntax_Syntax.term'
                                                           FStar_Syntax_Syntax.syntax,
    FStar_Range.range) FStar_Pervasives_Native.tuple5 ->
    FStar_Syntax_Syntax.letbinding)
  =
  fun uu____1814  ->
    match uu____1814 with
    | (attrs,n1,t,e,pos) ->
        {
          FStar_Syntax_Syntax.lbname = n1;
          FStar_Syntax_Syntax.lbunivs = [];
          FStar_Syntax_Syntax.lbtyp = t;
          FStar_Syntax_Syntax.lbeff = FStar_Parser_Const.effect_ALL_lid;
          FStar_Syntax_Syntax.lbdef = e;
          FStar_Syntax_Syntax.lbattrs = attrs;
          FStar_Syntax_Syntax.lbpos = pos
        }
  
let (no_annot_abs :
  FStar_Syntax_Syntax.binders ->
    FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term)
  =
  fun bs  ->
    fun t  -> FStar_Syntax_Util.abs bs t FStar_Pervasives_Native.None
  
let (mk_ref_read :
  FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  fun tm  ->
    let tm' =
      let uu____1888 =
        let uu____1903 =
          let uu____1904 =
            FStar_Syntax_Syntax.lid_as_fv FStar_Parser_Const.sread_lid
              FStar_Syntax_Syntax.Delta_constant FStar_Pervasives_Native.None
             in
          FStar_Syntax_Syntax.fv_to_tm uu____1904  in
        let uu____1905 =
          let uu____1914 =
            let uu____1921 = FStar_Syntax_Syntax.as_implicit false  in
            (tm, uu____1921)  in
          [uu____1914]  in
        (uu____1903, uu____1905)  in
      FStar_Syntax_Syntax.Tm_app uu____1888  in
    FStar_Syntax_Syntax.mk tm' FStar_Pervasives_Native.None
      tm.FStar_Syntax_Syntax.pos
  
let (mk_ref_alloc :
  FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  fun tm  ->
    let tm' =
      let uu____1956 =
        let uu____1971 =
          let uu____1972 =
            FStar_Syntax_Syntax.lid_as_fv FStar_Parser_Const.salloc_lid
              FStar_Syntax_Syntax.Delta_constant FStar_Pervasives_Native.None
             in
          FStar_Syntax_Syntax.fv_to_tm uu____1972  in
        let uu____1973 =
          let uu____1982 =
            let uu____1989 = FStar_Syntax_Syntax.as_implicit false  in
            (tm, uu____1989)  in
          [uu____1982]  in
        (uu____1971, uu____1973)  in
      FStar_Syntax_Syntax.Tm_app uu____1956  in
    FStar_Syntax_Syntax.mk tm' FStar_Pervasives_Native.None
      tm.FStar_Syntax_Syntax.pos
  
let (mk_ref_assign :
  FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax ->
      FStar_Range.range ->
        FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  fun t1  ->
    fun t2  ->
      fun pos  ->
        let tm =
          let uu____2038 =
            let uu____2053 =
              let uu____2054 =
                FStar_Syntax_Syntax.lid_as_fv FStar_Parser_Const.swrite_lid
                  FStar_Syntax_Syntax.Delta_constant
                  FStar_Pervasives_Native.None
                 in
              FStar_Syntax_Syntax.fv_to_tm uu____2054  in
            let uu____2055 =
              let uu____2064 =
                let uu____2071 = FStar_Syntax_Syntax.as_implicit false  in
                (t1, uu____2071)  in
              let uu____2074 =
                let uu____2083 =
                  let uu____2090 = FStar_Syntax_Syntax.as_implicit false  in
                  (t2, uu____2090)  in
                [uu____2083]  in
              uu____2064 :: uu____2074  in
            (uu____2053, uu____2055)  in
          FStar_Syntax_Syntax.Tm_app uu____2038  in
        FStar_Syntax_Syntax.mk tm FStar_Pervasives_Native.None pos
  
let (is_special_effect_combinator : Prims.string -> Prims.bool) =
  fun uu___90_2123  ->
    match uu___90_2123 with
    | "repr" -> true
    | "post" -> true
    | "pre" -> true
    | "wp" -> true
    | uu____2124 -> false
  
let rec (sum_to_universe :
  FStar_Syntax_Syntax.universe -> Prims.int -> FStar_Syntax_Syntax.universe)
  =
  fun u  ->
    fun n1  ->
      if n1 = (Prims.parse_int "0")
      then u
      else
        (let uu____2136 = sum_to_universe u (n1 - (Prims.parse_int "1"))  in
         FStar_Syntax_Syntax.U_succ uu____2136)
  
let (int_to_universe : Prims.int -> FStar_Syntax_Syntax.universe) =
  fun n1  -> sum_to_universe FStar_Syntax_Syntax.U_zero n1 
let rec (desugar_maybe_non_constant_universe :
  FStar_Parser_AST.term ->
    (Prims.int,FStar_Syntax_Syntax.universe) FStar_Util.either)
  =
  fun t  ->
    let uu____2155 =
      let uu____2156 = unparen t  in uu____2156.FStar_Parser_AST.tm  in
    match uu____2155 with
    | FStar_Parser_AST.Wild  ->
        let uu____2161 =
          let uu____2162 = FStar_Syntax_Unionfind.univ_fresh ()  in
          FStar_Syntax_Syntax.U_unif uu____2162  in
        FStar_Util.Inr uu____2161
    | FStar_Parser_AST.Uvar u ->
        FStar_Util.Inr (FStar_Syntax_Syntax.U_name u)
    | FStar_Parser_AST.Const (FStar_Const.Const_int (repr,uu____2173)) ->
        let n1 = FStar_Util.int_of_string repr  in
        (if n1 < (Prims.parse_int "0")
         then
           FStar_Errors.raise_error
             (FStar_Errors.Fatal_NegativeUniverseConstFatal_NotSupported,
               (Prims.strcat
                  "Negative universe constant  are not supported : " repr))
             t.FStar_Parser_AST.range
         else ();
         FStar_Util.Inl n1)
    | FStar_Parser_AST.Op (op_plus,t1::t2::[]) ->
        let u1 = desugar_maybe_non_constant_universe t1  in
        let u2 = desugar_maybe_non_constant_universe t2  in
        (match (u1, u2) with
         | (FStar_Util.Inl n1,FStar_Util.Inl n2) -> FStar_Util.Inl (n1 + n2)
         | (FStar_Util.Inl n1,FStar_Util.Inr u) ->
             let uu____2238 = sum_to_universe u n1  in
             FStar_Util.Inr uu____2238
         | (FStar_Util.Inr u,FStar_Util.Inl n1) ->
             let uu____2249 = sum_to_universe u n1  in
             FStar_Util.Inr uu____2249
         | (FStar_Util.Inr u11,FStar_Util.Inr u21) ->
             let uu____2260 =
               let uu____2265 =
                 let uu____2266 = FStar_Parser_AST.term_to_string t  in
                 Prims.strcat
                   "This universe might contain a sum of two universe variables "
                   uu____2266
                  in
               (FStar_Errors.Fatal_UniverseMightContainSumOfTwoUnivVars,
                 uu____2265)
                in
             FStar_Errors.raise_error uu____2260 t.FStar_Parser_AST.range)
    | FStar_Parser_AST.App uu____2271 ->
        let rec aux t1 univargs =
          let uu____2305 =
            let uu____2306 = unparen t1  in uu____2306.FStar_Parser_AST.tm
             in
          match uu____2305 with
          | FStar_Parser_AST.App (t2,targ,uu____2313) ->
              let uarg = desugar_maybe_non_constant_universe targ  in
              aux t2 (uarg :: univargs)
          | FStar_Parser_AST.Var max_lid1 ->
              if
                FStar_List.existsb
                  (fun uu___91_2336  ->
                     match uu___91_2336 with
                     | FStar_Util.Inr uu____2341 -> true
                     | uu____2342 -> false) univargs
              then
                let uu____2347 =
                  let uu____2348 =
                    FStar_List.map
                      (fun uu___92_2357  ->
                         match uu___92_2357 with
                         | FStar_Util.Inl n1 -> int_to_universe n1
                         | FStar_Util.Inr u -> u) univargs
                     in
                  FStar_Syntax_Syntax.U_max uu____2348  in
                FStar_Util.Inr uu____2347
              else
                (let nargs =
                   FStar_List.map
                     (fun uu___93_2374  ->
                        match uu___93_2374 with
                        | FStar_Util.Inl n1 -> n1
                        | FStar_Util.Inr uu____2380 -> failwith "impossible")
                     univargs
                    in
                 let uu____2381 =
                   FStar_List.fold_left
                     (fun m  -> fun n1  -> if m > n1 then m else n1)
                     (Prims.parse_int "0") nargs
                    in
                 FStar_Util.Inl uu____2381)
          | uu____2387 ->
              let uu____2388 =
                let uu____2393 =
                  let uu____2394 =
                    let uu____2395 = FStar_Parser_AST.term_to_string t1  in
                    Prims.strcat uu____2395 " in universe context"  in
                  Prims.strcat "Unexpected term " uu____2394  in
                (FStar_Errors.Fatal_UnexpectedTermInUniverse, uu____2393)  in
              FStar_Errors.raise_error uu____2388 t1.FStar_Parser_AST.range
           in
        aux t []
    | uu____2404 ->
        let uu____2405 =
          let uu____2410 =
            let uu____2411 =
              let uu____2412 = FStar_Parser_AST.term_to_string t  in
              Prims.strcat uu____2412 " in universe context"  in
            Prims.strcat "Unexpected term " uu____2411  in
          (FStar_Errors.Fatal_UnexpectedTermInUniverse, uu____2410)  in
        FStar_Errors.raise_error uu____2405 t.FStar_Parser_AST.range
  
let rec (desugar_universe :
  FStar_Parser_AST.term -> FStar_Syntax_Syntax.universe) =
  fun t  ->
    let u = desugar_maybe_non_constant_universe t  in
    match u with
    | FStar_Util.Inl n1 -> int_to_universe n1
    | FStar_Util.Inr u1 -> u1
  
let (check_no_aq : FStar_Syntax_Syntax.antiquotations -> unit) =
  fun aq  ->
    match aq with
    | [] -> ()
    | (bv,b,e)::uu____2445 ->
        let uu____2468 =
          let uu____2473 =
            let uu____2474 = FStar_Syntax_Print.term_to_string e  in
            FStar_Util.format2 "Unexpected antiquotation: %s(%s)"
              (if b then "`@" else "`#") uu____2474
             in
          (FStar_Errors.Fatal_UnexpectedAntiquotation, uu____2473)  in
        FStar_Errors.raise_error uu____2468 e.FStar_Syntax_Syntax.pos
  
let check_fields :
  'Auu____2484 .
    FStar_Syntax_DsEnv.env ->
      (FStar_Ident.lident,'Auu____2484) FStar_Pervasives_Native.tuple2
        Prims.list -> FStar_Range.range -> FStar_Syntax_DsEnv.record_or_dc
  =
  fun env  ->
    fun fields  ->
      fun rg  ->
        let uu____2512 = FStar_List.hd fields  in
        match uu____2512 with
        | (f,uu____2522) ->
            (FStar_Syntax_DsEnv.fail_if_qualified_by_curmodule env f;
             (let record =
                FStar_Syntax_DsEnv.fail_or env
                  (FStar_Syntax_DsEnv.try_lookup_record_by_field_name env) f
                 in
              let check_field uu____2534 =
                match uu____2534 with
                | (f',uu____2540) ->
                    (FStar_Syntax_DsEnv.fail_if_qualified_by_curmodule env f';
                     (let uu____2542 =
                        FStar_Syntax_DsEnv.belongs_to_record env f' record
                         in
                      if uu____2542
                      then ()
                      else
                        (let msg =
                           FStar_Util.format3
                             "Field %s belongs to record type %s, whereas field %s does not"
                             f.FStar_Ident.str
                             (record.FStar_Syntax_DsEnv.typename).FStar_Ident.str
                             f'.FStar_Ident.str
                            in
                         FStar_Errors.raise_error
                           (FStar_Errors.Fatal_FieldsNotBelongToSameRecordType,
                             msg) rg)))
                 in
              (let uu____2546 = FStar_List.tl fields  in
               FStar_List.iter check_field uu____2546);
              (match () with | () -> record)))
  
let rec (desugar_data_pat :
  FStar_Syntax_DsEnv.env ->
    FStar_Parser_AST.pattern ->
      Prims.bool ->
        (env_t,bnd,FStar_Syntax_Syntax.pat Prims.list)
          FStar_Pervasives_Native.tuple3)
  =
  fun env  ->
    fun p  ->
      fun is_mut  ->
        let check_linear_pattern_variables pats r =
          let rec pat_vars p1 =
            match p1.FStar_Syntax_Syntax.v with
            | FStar_Syntax_Syntax.Pat_dot_term uu____2901 ->
                FStar_Syntax_Syntax.no_names
            | FStar_Syntax_Syntax.Pat_wild uu____2908 ->
                FStar_Syntax_Syntax.no_names
            | FStar_Syntax_Syntax.Pat_constant uu____2909 ->
                FStar_Syntax_Syntax.no_names
            | FStar_Syntax_Syntax.Pat_var x ->
                FStar_Util.set_add x FStar_Syntax_Syntax.no_names
            | FStar_Syntax_Syntax.Pat_cons (uu____2911,pats1) ->
                let aux out uu____2949 =
                  match uu____2949 with
                  | (p2,uu____2961) ->
                      let intersection =
                        let uu____2969 = pat_vars p2  in
                        FStar_Util.set_intersect uu____2969 out  in
                      let uu____2972 = FStar_Util.set_is_empty intersection
                         in
                      if uu____2972
                      then
                        let uu____2975 = pat_vars p2  in
                        FStar_Util.set_union out uu____2975
                      else
                        (let duplicate_bv =
                           let uu____2980 =
                             FStar_Util.set_elements intersection  in
                           FStar_List.hd uu____2980  in
                         let uu____2983 =
                           let uu____2988 =
                             FStar_Util.format1
                               "Non-linear patterns are not permitted. %s appears more than once in this pattern."
                               (duplicate_bv.FStar_Syntax_Syntax.ppname).FStar_Ident.idText
                              in
                           (FStar_Errors.Fatal_NonLinearPatternNotPermitted,
                             uu____2988)
                            in
                         FStar_Errors.raise_error uu____2983 r)
                   in
                FStar_List.fold_left aux FStar_Syntax_Syntax.no_names pats1
             in
          match pats with
          | [] -> ()
          | p1::[] ->
              let uu____3008 = pat_vars p1  in
              FStar_All.pipe_right uu____3008 (fun a238  -> ())
          | p1::ps ->
              let pvars = pat_vars p1  in
              let aux p2 =
                let uu____3030 =
                  let uu____3031 = pat_vars p2  in
                  FStar_Util.set_eq pvars uu____3031  in
                if uu____3030
                then ()
                else
                  (let nonlinear_vars =
                     let uu____3038 = pat_vars p2  in
                     FStar_Util.set_symmetric_difference pvars uu____3038  in
                   let first_nonlinear_var =
                     let uu____3042 = FStar_Util.set_elements nonlinear_vars
                        in
                     FStar_List.hd uu____3042  in
                   let uu____3045 =
                     let uu____3050 =
                       FStar_Util.format1
                         "Patterns in this match are incoherent, variable %s is bound in some but not all patterns."
                         (first_nonlinear_var.FStar_Syntax_Syntax.ppname).FStar_Ident.idText
                        in
                     (FStar_Errors.Fatal_IncoherentPatterns, uu____3050)  in
                   FStar_Errors.raise_error uu____3045 r)
                 in
              FStar_List.iter aux ps
           in
        (match (is_mut, (p.FStar_Parser_AST.pat)) with
         | (false ,uu____3054) -> ()
         | (true ,FStar_Parser_AST.PatVar uu____3055) -> ()
         | (true ,uu____3062) ->
             FStar_Errors.raise_error
               (FStar_Errors.Fatal_LetMutableForVariablesOnly,
                 "let-mutable is for variables only")
               p.FStar_Parser_AST.prange);
        (let resolvex l e x =
           let uu____3085 =
             FStar_All.pipe_right l
               (FStar_Util.find_opt
                  (fun y  ->
                     (y.FStar_Syntax_Syntax.ppname).FStar_Ident.idText =
                       x.FStar_Ident.idText))
              in
           match uu____3085 with
           | FStar_Pervasives_Native.Some y -> (l, e, y)
           | uu____3099 ->
               let uu____3102 =
                 if is_mut
                 then FStar_Syntax_DsEnv.push_bv_mutable e x
                 else FStar_Syntax_DsEnv.push_bv e x  in
               (match uu____3102 with | (e1,x1) -> ((x1 :: l), e1, x1))
            in
         let rec aux' top loc env1 p1 =
           let pos q =
             FStar_Syntax_Syntax.withinfo q p1.FStar_Parser_AST.prange  in
           let pos_r r q = FStar_Syntax_Syntax.withinfo q r  in
           let orig = p1  in
           match p1.FStar_Parser_AST.pat with
           | FStar_Parser_AST.PatOr uu____3214 -> failwith "impossible"
           | FStar_Parser_AST.PatOp op ->
               let uu____3230 =
                 let uu____3231 =
                   let uu____3232 =
                     let uu____3239 =
                       let uu____3240 =
                         let uu____3245 =
                           FStar_Parser_AST.compile_op (Prims.parse_int "0")
                             op.FStar_Ident.idText op.FStar_Ident.idRange
                            in
                         (uu____3245, (op.FStar_Ident.idRange))  in
                       FStar_Ident.mk_ident uu____3240  in
                     (uu____3239, FStar_Pervasives_Native.None)  in
                   FStar_Parser_AST.PatVar uu____3232  in
                 {
                   FStar_Parser_AST.pat = uu____3231;
                   FStar_Parser_AST.prange = (p1.FStar_Parser_AST.prange)
                 }  in
               aux loc env1 uu____3230
           | FStar_Parser_AST.PatAscribed (p2,(t,tacopt)) ->
               ((match tacopt with
                 | FStar_Pervasives_Native.None  -> ()
                 | FStar_Pervasives_Native.Some uu____3262 ->
                     FStar_Errors.raise_error
                       (FStar_Errors.Fatal_TypeWithinPatternsAllowedOnVariablesOnly,
                         "Type ascriptions within patterns are cannot be associated with a tactic")
                       orig.FStar_Parser_AST.prange);
                (let uu____3263 = aux loc env1 p2  in
                 match uu____3263 with
                 | (loc1,env',binder,p3,imp) ->
                     let annot_pat_var p4 t1 =
                       match p4.FStar_Syntax_Syntax.v with
                       | FStar_Syntax_Syntax.Pat_var x ->
                           let uu___114_3321 = p4  in
                           {
                             FStar_Syntax_Syntax.v =
                               (FStar_Syntax_Syntax.Pat_var
                                  (let uu___115_3326 = x  in
                                   {
                                     FStar_Syntax_Syntax.ppname =
                                       (uu___115_3326.FStar_Syntax_Syntax.ppname);
                                     FStar_Syntax_Syntax.index =
                                       (uu___115_3326.FStar_Syntax_Syntax.index);
                                     FStar_Syntax_Syntax.sort = t1
                                   }));
                             FStar_Syntax_Syntax.p =
                               (uu___114_3321.FStar_Syntax_Syntax.p)
                           }
                       | FStar_Syntax_Syntax.Pat_wild x ->
                           let uu___116_3328 = p4  in
                           {
                             FStar_Syntax_Syntax.v =
                               (FStar_Syntax_Syntax.Pat_wild
                                  (let uu___117_3333 = x  in
                                   {
                                     FStar_Syntax_Syntax.ppname =
                                       (uu___117_3333.FStar_Syntax_Syntax.ppname);
                                     FStar_Syntax_Syntax.index =
                                       (uu___117_3333.FStar_Syntax_Syntax.index);
                                     FStar_Syntax_Syntax.sort = t1
                                   }));
                             FStar_Syntax_Syntax.p =
                               (uu___116_3328.FStar_Syntax_Syntax.p)
                           }
                       | uu____3334 when top -> p4
                       | uu____3335 ->
                           FStar_Errors.raise_error
                             (FStar_Errors.Fatal_TypeWithinPatternsAllowedOnVariablesOnly,
                               "Type ascriptions within patterns are only allowed on variables")
                             orig.FStar_Parser_AST.prange
                        in
                     let uu____3338 =
                       match binder with
                       | LetBinder uu____3351 -> failwith "impossible"
                       | LocalBinder (x,aq) ->
                           let t1 =
                             let uu____3371 = close_fun env1 t  in
                             desugar_term env1 uu____3371  in
                           (if
                              (match (x.FStar_Syntax_Syntax.sort).FStar_Syntax_Syntax.n
                               with
                               | FStar_Syntax_Syntax.Tm_unknown  -> false
                               | uu____3373 -> true)
                            then
                              (let uu____3374 =
                                 let uu____3379 =
                                   let uu____3380 =
                                     FStar_Syntax_Print.bv_to_string x  in
                                   let uu____3381 =
                                     FStar_Syntax_Print.term_to_string
                                       x.FStar_Syntax_Syntax.sort
                                      in
                                   let uu____3382 =
                                     FStar_Syntax_Print.term_to_string t1  in
                                   FStar_Util.format3
                                     "Multiple ascriptions for %s in pattern, type %s was shadowed by %s\n"
                                     uu____3380 uu____3381 uu____3382
                                    in
                                 (FStar_Errors.Warning_MultipleAscriptions,
                                   uu____3379)
                                  in
                               FStar_Errors.log_issue
                                 orig.FStar_Parser_AST.prange uu____3374)
                            else ();
                            (let uu____3384 = annot_pat_var p3 t1  in
                             (uu____3384,
                               (LocalBinder
                                  ((let uu___118_3390 = x  in
                                    {
                                      FStar_Syntax_Syntax.ppname =
                                        (uu___118_3390.FStar_Syntax_Syntax.ppname);
                                      FStar_Syntax_Syntax.index =
                                        (uu___118_3390.FStar_Syntax_Syntax.index);
                                      FStar_Syntax_Syntax.sort = t1
                                    }), aq)))))
                        in
                     (match uu____3338 with
                      | (p4,binder1) -> (loc1, env', binder1, p4, imp))))
           | FStar_Parser_AST.PatWild  ->
               let x =
                 FStar_Syntax_Syntax.new_bv
                   (FStar_Pervasives_Native.Some (p1.FStar_Parser_AST.prange))
                   FStar_Syntax_Syntax.tun
                  in
               let uu____3412 =
                 FStar_All.pipe_left pos (FStar_Syntax_Syntax.Pat_wild x)  in
               (loc, env1, (LocalBinder (x, FStar_Pervasives_Native.None)),
                 uu____3412, false)
           | FStar_Parser_AST.PatConst c ->
               let x =
                 FStar_Syntax_Syntax.new_bv
                   (FStar_Pervasives_Native.Some (p1.FStar_Parser_AST.prange))
                   FStar_Syntax_Syntax.tun
                  in
               let uu____3423 =
                 FStar_All.pipe_left pos (FStar_Syntax_Syntax.Pat_constant c)
                  in
               (loc, env1, (LocalBinder (x, FStar_Pervasives_Native.None)),
                 uu____3423, false)
           | FStar_Parser_AST.PatTvar (x,aq) ->
               let imp =
                 aq =
                   (FStar_Pervasives_Native.Some FStar_Parser_AST.Implicit)
                  in
               let aq1 = trans_aqual aq  in
               let uu____3444 = resolvex loc env1 x  in
               (match uu____3444 with
                | (loc1,env2,xbv) ->
                    let uu____3466 =
                      FStar_All.pipe_left pos
                        (FStar_Syntax_Syntax.Pat_var xbv)
                       in
                    (loc1, env2, (LocalBinder (xbv, aq1)), uu____3466, imp))
           | FStar_Parser_AST.PatVar (x,aq) ->
               let imp =
                 aq =
                   (FStar_Pervasives_Native.Some FStar_Parser_AST.Implicit)
                  in
               let aq1 = trans_aqual aq  in
               let uu____3487 = resolvex loc env1 x  in
               (match uu____3487 with
                | (loc1,env2,xbv) ->
                    let uu____3509 =
                      FStar_All.pipe_left pos
                        (FStar_Syntax_Syntax.Pat_var xbv)
                       in
                    (loc1, env2, (LocalBinder (xbv, aq1)), uu____3509, imp))
           | FStar_Parser_AST.PatName l ->
               let l1 =
                 FStar_Syntax_DsEnv.fail_or env1
                   (FStar_Syntax_DsEnv.try_lookup_datacon env1) l
                  in
               let x =
                 FStar_Syntax_Syntax.new_bv
                   (FStar_Pervasives_Native.Some (p1.FStar_Parser_AST.prange))
                   FStar_Syntax_Syntax.tun
                  in
               let uu____3521 =
                 FStar_All.pipe_left pos
                   (FStar_Syntax_Syntax.Pat_cons (l1, []))
                  in
               (loc, env1, (LocalBinder (x, FStar_Pervasives_Native.None)),
                 uu____3521, false)
           | FStar_Parser_AST.PatApp
               ({ FStar_Parser_AST.pat = FStar_Parser_AST.PatName l;
                  FStar_Parser_AST.prange = uu____3545;_},args)
               ->
               let uu____3551 =
                 FStar_List.fold_right
                   (fun arg  ->
                      fun uu____3592  ->
                        match uu____3592 with
                        | (loc1,env2,args1) ->
                            let uu____3640 = aux loc1 env2 arg  in
                            (match uu____3640 with
                             | (loc2,env3,uu____3669,arg1,imp) ->
                                 (loc2, env3, ((arg1, imp) :: args1)))) args
                   (loc, env1, [])
                  in
               (match uu____3551 with
                | (loc1,env2,args1) ->
                    let l1 =
                      FStar_Syntax_DsEnv.fail_or env2
                        (FStar_Syntax_DsEnv.try_lookup_datacon env2) l
                       in
                    let x =
                      FStar_Syntax_Syntax.new_bv
                        (FStar_Pervasives_Native.Some
                           (p1.FStar_Parser_AST.prange))
                        FStar_Syntax_Syntax.tun
                       in
                    let uu____3739 =
                      FStar_All.pipe_left pos
                        (FStar_Syntax_Syntax.Pat_cons (l1, args1))
                       in
                    (loc1, env2,
                      (LocalBinder (x, FStar_Pervasives_Native.None)),
                      uu____3739, false))
           | FStar_Parser_AST.PatApp uu____3756 ->
               FStar_Errors.raise_error
                 (FStar_Errors.Fatal_UnexpectedPattern, "Unexpected pattern")
                 p1.FStar_Parser_AST.prange
           | FStar_Parser_AST.PatList pats ->
               let uu____3778 =
                 FStar_List.fold_right
                   (fun pat  ->
                      fun uu____3811  ->
                        match uu____3811 with
                        | (loc1,env2,pats1) ->
                            let uu____3843 = aux loc1 env2 pat  in
                            (match uu____3843 with
                             | (loc2,env3,uu____3868,pat1,uu____3870) ->
                                 (loc2, env3, (pat1 :: pats1)))) pats
                   (loc, env1, [])
                  in
               (match uu____3778 with
                | (loc1,env2,pats1) ->
                    let pat =
                      let uu____3913 =
                        let uu____3916 =
                          let uu____3923 =
                            FStar_Range.end_range p1.FStar_Parser_AST.prange
                             in
                          pos_r uu____3923  in
                        let uu____3924 =
                          let uu____3925 =
                            let uu____3938 =
                              FStar_Syntax_Syntax.lid_as_fv
                                FStar_Parser_Const.nil_lid
                                FStar_Syntax_Syntax.Delta_constant
                                (FStar_Pervasives_Native.Some
                                   FStar_Syntax_Syntax.Data_ctor)
                               in
                            (uu____3938, [])  in
                          FStar_Syntax_Syntax.Pat_cons uu____3925  in
                        FStar_All.pipe_left uu____3916 uu____3924  in
                      FStar_List.fold_right
                        (fun hd1  ->
                           fun tl1  ->
                             let r =
                               FStar_Range.union_ranges
                                 hd1.FStar_Syntax_Syntax.p
                                 tl1.FStar_Syntax_Syntax.p
                                in
                             let uu____3970 =
                               let uu____3971 =
                                 let uu____3984 =
                                   FStar_Syntax_Syntax.lid_as_fv
                                     FStar_Parser_Const.cons_lid
                                     FStar_Syntax_Syntax.Delta_constant
                                     (FStar_Pervasives_Native.Some
                                        FStar_Syntax_Syntax.Data_ctor)
                                    in
                                 (uu____3984, [(hd1, false); (tl1, false)])
                                  in
                               FStar_Syntax_Syntax.Pat_cons uu____3971  in
                             FStar_All.pipe_left (pos_r r) uu____3970) pats1
                        uu____3913
                       in
                    let x =
                      FStar_Syntax_Syntax.new_bv
                        (FStar_Pervasives_Native.Some
                           (p1.FStar_Parser_AST.prange))
                        FStar_Syntax_Syntax.tun
                       in
                    (loc1, env2,
                      (LocalBinder (x, FStar_Pervasives_Native.None)), pat,
                      false))
           | FStar_Parser_AST.PatTuple (args,dep1) ->
               let uu____4028 =
                 FStar_List.fold_left
                   (fun uu____4068  ->
                      fun p2  ->
                        match uu____4068 with
                        | (loc1,env2,pats) ->
                            let uu____4117 = aux loc1 env2 p2  in
                            (match uu____4117 with
                             | (loc2,env3,uu____4146,pat,uu____4148) ->
                                 (loc2, env3, ((pat, false) :: pats))))
                   (loc, env1, []) args
                  in
               (match uu____4028 with
                | (loc1,env2,args1) ->
                    let args2 = FStar_List.rev args1  in
                    let l =
                      if dep1
                      then
                        FStar_Parser_Const.mk_dtuple_data_lid
                          (FStar_List.length args2)
                          p1.FStar_Parser_AST.prange
                      else
                        FStar_Parser_Const.mk_tuple_data_lid
                          (FStar_List.length args2)
                          p1.FStar_Parser_AST.prange
                       in
                    let uu____4243 =
                      FStar_Syntax_DsEnv.fail_or env2
                        (FStar_Syntax_DsEnv.try_lookup_lid env2) l
                       in
                    (match uu____4243 with
                     | (constr,uu____4265) ->
                         let l1 =
                           match constr.FStar_Syntax_Syntax.n with
                           | FStar_Syntax_Syntax.Tm_fvar fv -> fv
                           | uu____4268 -> failwith "impossible"  in
                         let x =
                           FStar_Syntax_Syntax.new_bv
                             (FStar_Pervasives_Native.Some
                                (p1.FStar_Parser_AST.prange))
                             FStar_Syntax_Syntax.tun
                            in
                         let uu____4270 =
                           FStar_All.pipe_left pos
                             (FStar_Syntax_Syntax.Pat_cons (l1, args2))
                            in
                         (loc1, env2,
                           (LocalBinder (x, FStar_Pervasives_Native.None)),
                           uu____4270, false)))
           | FStar_Parser_AST.PatRecord [] ->
               FStar_Errors.raise_error
                 (FStar_Errors.Fatal_UnexpectedPattern, "Unexpected pattern")
                 p1.FStar_Parser_AST.prange
           | FStar_Parser_AST.PatRecord fields ->
               let record =
                 check_fields env1 fields p1.FStar_Parser_AST.prange  in
               let fields1 =
                 FStar_All.pipe_right fields
                   (FStar_List.map
                      (fun uu____4341  ->
                         match uu____4341 with
                         | (f,p2) -> ((f.FStar_Ident.ident), p2)))
                  in
               let args =
                 FStar_All.pipe_right record.FStar_Syntax_DsEnv.fields
                   (FStar_List.map
                      (fun uu____4371  ->
                         match uu____4371 with
                         | (f,uu____4377) ->
                             let uu____4378 =
                               FStar_All.pipe_right fields1
                                 (FStar_List.tryFind
                                    (fun uu____4404  ->
                                       match uu____4404 with
                                       | (g,uu____4410) ->
                                           f.FStar_Ident.idText =
                                             g.FStar_Ident.idText))
                                in
                             (match uu____4378 with
                              | FStar_Pervasives_Native.None  ->
                                  FStar_Parser_AST.mk_pattern
                                    FStar_Parser_AST.PatWild
                                    p1.FStar_Parser_AST.prange
                              | FStar_Pervasives_Native.Some (uu____4415,p2)
                                  -> p2)))
                  in
               let app =
                 let uu____4422 =
                   let uu____4423 =
                     let uu____4430 =
                       let uu____4431 =
                         let uu____4432 =
                           FStar_Ident.lid_of_ids
                             (FStar_List.append
                                (record.FStar_Syntax_DsEnv.typename).FStar_Ident.ns
                                [record.FStar_Syntax_DsEnv.constrname])
                            in
                         FStar_Parser_AST.PatName uu____4432  in
                       FStar_Parser_AST.mk_pattern uu____4431
                         p1.FStar_Parser_AST.prange
                        in
                     (uu____4430, args)  in
                   FStar_Parser_AST.PatApp uu____4423  in
                 FStar_Parser_AST.mk_pattern uu____4422
                   p1.FStar_Parser_AST.prange
                  in
               let uu____4435 = aux loc env1 app  in
               (match uu____4435 with
                | (env2,e,b,p2,uu____4464) ->
                    let p3 =
                      match p2.FStar_Syntax_Syntax.v with
                      | FStar_Syntax_Syntax.Pat_cons (fv,args1) ->
                          let uu____4492 =
                            let uu____4493 =
                              let uu____4506 =
                                let uu___119_4507 = fv  in
                                let uu____4508 =
                                  let uu____4511 =
                                    let uu____4512 =
                                      let uu____4519 =
                                        FStar_All.pipe_right
                                          record.FStar_Syntax_DsEnv.fields
                                          (FStar_List.map
                                             FStar_Pervasives_Native.fst)
                                         in
                                      ((record.FStar_Syntax_DsEnv.typename),
                                        uu____4519)
                                       in
                                    FStar_Syntax_Syntax.Record_ctor
                                      uu____4512
                                     in
                                  FStar_Pervasives_Native.Some uu____4511  in
                                {
                                  FStar_Syntax_Syntax.fv_name =
                                    (uu___119_4507.FStar_Syntax_Syntax.fv_name);
                                  FStar_Syntax_Syntax.fv_delta =
                                    (uu___119_4507.FStar_Syntax_Syntax.fv_delta);
                                  FStar_Syntax_Syntax.fv_qual = uu____4508
                                }  in
                              (uu____4506, args1)  in
                            FStar_Syntax_Syntax.Pat_cons uu____4493  in
                          FStar_All.pipe_left pos uu____4492
                      | uu____4546 -> p2  in
                    (env2, e, b, p3, false))
         
         and aux loc env1 p1 = aux' false loc env1 p1
          in
         let aux_maybe_or env1 p1 =
           let loc = []  in
           match p1.FStar_Parser_AST.pat with
           | FStar_Parser_AST.PatOr [] -> failwith "impossible"
           | FStar_Parser_AST.PatOr (p2::ps) ->
               let uu____4600 = aux' true loc env1 p2  in
               (match uu____4600 with
                | (loc1,env2,var,p3,uu____4627) ->
                    let uu____4632 =
                      FStar_List.fold_left
                        (fun uu____4664  ->
                           fun p4  ->
                             match uu____4664 with
                             | (loc2,env3,ps1) ->
                                 let uu____4697 = aux' true loc2 env3 p4  in
                                 (match uu____4697 with
                                  | (loc3,env4,uu____4722,p5,uu____4724) ->
                                      (loc3, env4, (p5 :: ps1))))
                        (loc1, env2, []) ps
                       in
                    (match uu____4632 with
                     | (loc2,env3,ps1) ->
                         let pats = p3 :: (FStar_List.rev ps1)  in
                         (env3, var, pats)))
           | uu____4775 ->
               let uu____4776 = aux' true loc env1 p1  in
               (match uu____4776 with
                | (loc1,env2,vars,pat,b) -> (env2, vars, [pat]))
            in
         let uu____4816 = aux_maybe_or env p  in
         match uu____4816 with
         | (env1,b,pats) ->
             (check_linear_pattern_variables pats p.FStar_Parser_AST.prange;
              (env1, b, pats)))

and (desugar_binding_pat_maybe_top :
  Prims.bool ->
    FStar_Syntax_DsEnv.env ->
      FStar_Parser_AST.pattern ->
        Prims.bool ->
          (env_t,bnd,FStar_Syntax_Syntax.pat Prims.list)
            FStar_Pervasives_Native.tuple3)
  =
  fun top  ->
    fun env  ->
      fun p  ->
        fun is_mut  ->
          let mklet x =
            let uu____4877 =
              let uu____4878 =
                let uu____4889 = FStar_Syntax_DsEnv.qualify env x  in
                (uu____4889,
                  (FStar_Syntax_Syntax.tun, FStar_Pervasives_Native.None))
                 in
              LetBinder uu____4878  in
            (env, uu____4877, [])  in
          if top
          then
            match p.FStar_Parser_AST.pat with
            | FStar_Parser_AST.PatOp x ->
                let uu____4917 =
                  let uu____4918 =
                    let uu____4923 =
                      FStar_Parser_AST.compile_op (Prims.parse_int "0")
                        x.FStar_Ident.idText x.FStar_Ident.idRange
                       in
                    (uu____4923, (x.FStar_Ident.idRange))  in
                  FStar_Ident.mk_ident uu____4918  in
                mklet uu____4917
            | FStar_Parser_AST.PatVar (x,uu____4925) -> mklet x
            | FStar_Parser_AST.PatAscribed
                ({
                   FStar_Parser_AST.pat = FStar_Parser_AST.PatVar
                     (x,uu____4931);
                   FStar_Parser_AST.prange = uu____4932;_},(t,tacopt))
                ->
                let tacopt1 = FStar_Util.map_opt tacopt (desugar_term env)
                   in
                let uu____4952 =
                  let uu____4953 =
                    let uu____4964 = FStar_Syntax_DsEnv.qualify env x  in
                    let uu____4965 =
                      let uu____4972 = desugar_term env t  in
                      (uu____4972, tacopt1)  in
                    (uu____4964, uu____4965)  in
                  LetBinder uu____4953  in
                (env, uu____4952, [])
            | uu____4983 ->
                FStar_Errors.raise_error
                  (FStar_Errors.Fatal_UnexpectedPattern,
                    "Unexpected pattern at the top-level")
                  p.FStar_Parser_AST.prange
          else
            (let uu____4993 = desugar_data_pat env p is_mut  in
             match uu____4993 with
             | (env1,binder,p1) ->
                 let p2 =
                   match p1 with
                   | {
                       FStar_Syntax_Syntax.v = FStar_Syntax_Syntax.Pat_var
                         uu____5022;
                       FStar_Syntax_Syntax.p = uu____5023;_}::[] -> []
                   | {
                       FStar_Syntax_Syntax.v = FStar_Syntax_Syntax.Pat_wild
                         uu____5028;
                       FStar_Syntax_Syntax.p = uu____5029;_}::[] -> []
                   | uu____5034 -> p1  in
                 (env1, binder, p2))

and (desugar_binding_pat :
  FStar_Syntax_DsEnv.env ->
    FStar_Parser_AST.pattern ->
      (env_t,bnd,FStar_Syntax_Syntax.pat Prims.list)
        FStar_Pervasives_Native.tuple3)
  = fun env  -> fun p  -> desugar_binding_pat_maybe_top false env p false

and (desugar_match_pat_maybe_top :
  Prims.bool ->
    FStar_Syntax_DsEnv.env ->
      FStar_Parser_AST.pattern ->
        (env_t,FStar_Syntax_Syntax.pat Prims.list)
          FStar_Pervasives_Native.tuple2)
  =
  fun uu____5041  ->
    fun env  ->
      fun pat  ->
        let uu____5044 = desugar_data_pat env pat false  in
        match uu____5044 with | (env1,uu____5060,pat1) -> (env1, pat1)

and (desugar_match_pat :
  FStar_Syntax_DsEnv.env ->
    FStar_Parser_AST.pattern ->
      (env_t,FStar_Syntax_Syntax.pat Prims.list)
        FStar_Pervasives_Native.tuple2)
  = fun env  -> fun p  -> desugar_match_pat_maybe_top false env p

and (desugar_term_aq :
  FStar_Syntax_DsEnv.env ->
    FStar_Parser_AST.term ->
      (FStar_Syntax_Syntax.term,FStar_Syntax_Syntax.antiquotations)
        FStar_Pervasives_Native.tuple2)
  =
  fun env  ->
    fun e  ->
      let env1 = FStar_Syntax_DsEnv.set_expect_typ env false  in
      desugar_term_maybe_top false env1 e

and (desugar_term :
  FStar_Syntax_DsEnv.env -> FStar_Parser_AST.term -> FStar_Syntax_Syntax.term)
  =
  fun env  ->
    fun e  ->
      let uu____5079 = desugar_term_aq env e  in
      match uu____5079 with | (t,aq) -> (check_no_aq aq; t)

and (desugar_typ_aq :
  FStar_Syntax_DsEnv.env ->
    FStar_Parser_AST.term ->
      (FStar_Syntax_Syntax.term,FStar_Syntax_Syntax.antiquotations)
        FStar_Pervasives_Native.tuple2)
  =
  fun env  ->
    fun e  ->
      let env1 = FStar_Syntax_DsEnv.set_expect_typ env true  in
      desugar_term_maybe_top false env1 e

and (desugar_typ :
  FStar_Syntax_DsEnv.env -> FStar_Parser_AST.term -> FStar_Syntax_Syntax.term)
  =
  fun env  ->
    fun e  ->
      let uu____5096 = desugar_typ_aq env e  in
      match uu____5096 with | (t,aq) -> (check_no_aq aq; t)

and (desugar_machine_integer :
  FStar_Syntax_DsEnv.env ->
    Prims.string ->
      (FStar_Const.signedness,FStar_Const.width)
        FStar_Pervasives_Native.tuple2 ->
        FStar_Range.range -> FStar_Syntax_Syntax.term)
  =
  fun env  ->
    fun repr  ->
      fun uu____5106  ->
        fun range  ->
          match uu____5106 with
          | (signedness,width) ->
              let tnm =
                Prims.strcat "FStar."
                  (Prims.strcat
                     (match signedness with
                      | FStar_Const.Unsigned  -> "U"
                      | FStar_Const.Signed  -> "")
                     (Prims.strcat "Int"
                        (match width with
                         | FStar_Const.Int8  -> "8"
                         | FStar_Const.Int16  -> "16"
                         | FStar_Const.Int32  -> "32"
                         | FStar_Const.Int64  -> "64")))
                 in
              ((let uu____5116 =
                  let uu____5117 =
                    FStar_Const.within_bounds repr signedness width  in
                  Prims.op_Negation uu____5117  in
                if uu____5116
                then
                  let uu____5118 =
                    let uu____5123 =
                      FStar_Util.format2
                        "%s is not in the expected range for %s" repr tnm
                       in
                    (FStar_Errors.Error_OutOfRange, uu____5123)  in
                  FStar_Errors.log_issue range uu____5118
                else ());
               (let private_intro_nm =
                  Prims.strcat tnm
                    (Prims.strcat ".__"
                       (Prims.strcat
                          (match signedness with
                           | FStar_Const.Unsigned  -> "u"
                           | FStar_Const.Signed  -> "") "int_to_t"))
                   in
                let intro_nm =
                  Prims.strcat tnm
                    (Prims.strcat "."
                       (Prims.strcat
                          (match signedness with
                           | FStar_Const.Unsigned  -> "u"
                           | FStar_Const.Signed  -> "") "int_to_t"))
                   in
                let lid =
                  let uu____5128 = FStar_Ident.path_of_text intro_nm  in
                  FStar_Ident.lid_of_path uu____5128 range  in
                let lid1 =
                  let uu____5132 = FStar_Syntax_DsEnv.try_lookup_lid env lid
                     in
                  match uu____5132 with
                  | FStar_Pervasives_Native.Some (intro_term,uu____5142) ->
                      (match intro_term.FStar_Syntax_Syntax.n with
                       | FStar_Syntax_Syntax.Tm_fvar fv ->
                           let private_lid =
                             let uu____5151 =
                               FStar_Ident.path_of_text private_intro_nm  in
                             FStar_Ident.lid_of_path uu____5151 range  in
                           let private_fv =
                             let uu____5153 =
                               FStar_Syntax_Util.incr_delta_depth
                                 fv.FStar_Syntax_Syntax.fv_delta
                                in
                             FStar_Syntax_Syntax.lid_as_fv private_lid
                               uu____5153 fv.FStar_Syntax_Syntax.fv_qual
                              in
                           let uu___120_5154 = intro_term  in
                           {
                             FStar_Syntax_Syntax.n =
                               (FStar_Syntax_Syntax.Tm_fvar private_fv);
                             FStar_Syntax_Syntax.pos =
                               (uu___120_5154.FStar_Syntax_Syntax.pos);
                             FStar_Syntax_Syntax.vars =
                               (uu___120_5154.FStar_Syntax_Syntax.vars)
                           }
                       | uu____5155 ->
                           failwith
                             (Prims.strcat "Unexpected non-fvar for "
                                intro_nm))
                  | FStar_Pervasives_Native.None  ->
                      let uu____5162 =
                        let uu____5167 =
                          FStar_Util.format1
                            "Unexpected numeric literal.  Restart F* to load %s."
                            tnm
                           in
                        (FStar_Errors.Fatal_UnexpectedNumericLiteral,
                          uu____5167)
                         in
                      FStar_Errors.raise_error uu____5162 range
                   in
                let repr1 =
                  FStar_Syntax_Syntax.mk
                    (FStar_Syntax_Syntax.Tm_constant
                       (FStar_Const.Const_int
                          (repr, FStar_Pervasives_Native.None)))
                    FStar_Pervasives_Native.None range
                   in
                let uu____5183 =
                  let uu____5190 =
                    let uu____5191 =
                      let uu____5206 =
                        let uu____5215 =
                          let uu____5222 =
                            FStar_Syntax_Syntax.as_implicit false  in
                          (repr1, uu____5222)  in
                        [uu____5215]  in
                      (lid1, uu____5206)  in
                    FStar_Syntax_Syntax.Tm_app uu____5191  in
                  FStar_Syntax_Syntax.mk uu____5190  in
                uu____5183 FStar_Pervasives_Native.None range))

and (desugar_name :
  (FStar_Syntax_Syntax.term' -> FStar_Syntax_Syntax.term) ->
    (FStar_Syntax_Syntax.term ->
       FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
      -> env_t -> Prims.bool -> FStar_Ident.lid -> FStar_Syntax_Syntax.term)
  =
  fun mk1  ->
    fun setpos  ->
      fun env  ->
        fun resolve  ->
          fun l  ->
            let uu____5261 =
              FStar_Syntax_DsEnv.fail_or env
                ((if resolve
                  then FStar_Syntax_DsEnv.try_lookup_lid_with_attributes
                  else
                    FStar_Syntax_DsEnv.try_lookup_lid_with_attributes_no_resolve)
                   env) l
               in
            match uu____5261 with
            | (tm,mut,attrs) ->
                let warn_if_deprecated attrs1 =
                  FStar_List.iter
                    (fun a  ->
                       match a.FStar_Syntax_Syntax.n with
                       | FStar_Syntax_Syntax.Tm_app
                           ({
                              FStar_Syntax_Syntax.n =
                                FStar_Syntax_Syntax.Tm_fvar fv;
                              FStar_Syntax_Syntax.pos = uu____5310;
                              FStar_Syntax_Syntax.vars = uu____5311;_},args)
                           when
                           FStar_Ident.lid_equals
                             (fv.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v
                             FStar_Parser_Const.deprecated_attr
                           ->
                           let msg =
                             let uu____5334 =
                               FStar_Syntax_Print.term_to_string tm  in
                             Prims.strcat uu____5334 " is deprecated"  in
                           let msg1 =
                             if
                               (FStar_List.length args) >
                                 (Prims.parse_int "0")
                             then
                               let uu____5342 =
                                 let uu____5343 =
                                   let uu____5346 = FStar_List.hd args  in
                                   FStar_Pervasives_Native.fst uu____5346  in
                                 uu____5343.FStar_Syntax_Syntax.n  in
                               match uu____5342 with
                               | FStar_Syntax_Syntax.Tm_constant
                                   (FStar_Const.Const_string (s,uu____5362))
                                   when
                                   Prims.op_Negation
                                     ((FStar_Util.trim_string s) = "")
                                   ->
                                   Prims.strcat msg
                                     (Prims.strcat ", use "
                                        (Prims.strcat s " instead"))
                               | uu____5363 -> msg
                             else msg  in
                           let uu____5365 = FStar_Ident.range_of_lid l  in
                           FStar_Errors.log_issue uu____5365
                             (FStar_Errors.Warning_DeprecatedDefinition,
                               msg1)
                       | FStar_Syntax_Syntax.Tm_fvar fv when
                           FStar_Ident.lid_equals
                             (fv.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v
                             FStar_Parser_Const.deprecated_attr
                           ->
                           let msg =
                             let uu____5368 =
                               FStar_Syntax_Print.term_to_string tm  in
                             Prims.strcat uu____5368 " is deprecated"  in
                           let uu____5369 = FStar_Ident.range_of_lid l  in
                           FStar_Errors.log_issue uu____5369
                             (FStar_Errors.Warning_DeprecatedDefinition, msg)
                       | uu____5370 -> ()) attrs1
                   in
                (warn_if_deprecated attrs;
                 (let tm1 = setpos tm  in
                  if mut
                  then
                    let uu____5375 =
                      let uu____5376 =
                        let uu____5383 = mk_ref_read tm1  in
                        (uu____5383,
                          (FStar_Syntax_Syntax.Meta_desugared
                             FStar_Syntax_Syntax.Mutable_rval))
                         in
                      FStar_Syntax_Syntax.Tm_meta uu____5376  in
                    FStar_All.pipe_left mk1 uu____5375
                  else tm1))

and (desugar_attributes :
  env_t ->
    FStar_Parser_AST.term Prims.list -> FStar_Syntax_Syntax.cflags Prims.list)
  =
  fun env  ->
    fun cattributes  ->
      let desugar_attribute t =
        let uu____5401 =
          let uu____5402 = unparen t  in uu____5402.FStar_Parser_AST.tm  in
        match uu____5401 with
        | FStar_Parser_AST.Var
            { FStar_Ident.ns = uu____5403; FStar_Ident.ident = uu____5404;
              FStar_Ident.nsstr = uu____5405; FStar_Ident.str = "cps";_}
            -> FStar_Syntax_Syntax.CPS
        | uu____5408 ->
            let uu____5409 =
              let uu____5414 =
                let uu____5415 = FStar_Parser_AST.term_to_string t  in
                Prims.strcat "Unknown attribute " uu____5415  in
              (FStar_Errors.Fatal_UnknownAttribute, uu____5414)  in
            FStar_Errors.raise_error uu____5409 t.FStar_Parser_AST.range
         in
      FStar_List.map desugar_attribute cattributes

and (desugar_term_maybe_top :
  Prims.bool ->
    env_t ->
      FStar_Parser_AST.term ->
        (FStar_Syntax_Syntax.term,FStar_Syntax_Syntax.antiquotations)
          FStar_Pervasives_Native.tuple2)
  =
  fun top_level  ->
    fun env  ->
      fun top  ->
        let mk1 e =
          FStar_Syntax_Syntax.mk e FStar_Pervasives_Native.None
            top.FStar_Parser_AST.range
           in
        let noaqs = []  in
        let join_aqs aqs = FStar_List.flatten aqs  in
        let setpos e =
          let uu___121_5510 = e  in
          {
            FStar_Syntax_Syntax.n = (uu___121_5510.FStar_Syntax_Syntax.n);
            FStar_Syntax_Syntax.pos = (top.FStar_Parser_AST.range);
            FStar_Syntax_Syntax.vars =
              (uu___121_5510.FStar_Syntax_Syntax.vars)
          }  in
        let uu____5513 =
          let uu____5514 = unparen top  in uu____5514.FStar_Parser_AST.tm  in
        match uu____5513 with
        | FStar_Parser_AST.Wild  -> ((setpos FStar_Syntax_Syntax.tun), noaqs)
        | FStar_Parser_AST.Labeled uu____5531 ->
            let uu____5538 = desugar_formula env top  in (uu____5538, noaqs)
        | FStar_Parser_AST.Requires (t,lopt) ->
            let uu____5555 = desugar_formula env t  in (uu____5555, noaqs)
        | FStar_Parser_AST.Ensures (t,lopt) ->
            let uu____5572 = desugar_formula env t  in (uu____5572, noaqs)
        | FStar_Parser_AST.Attributes ts ->
            failwith
              "Attributes should not be desugared by desugar_term_maybe_top"
        | FStar_Parser_AST.Const (FStar_Const.Const_int
            (i,FStar_Pervasives_Native.Some size)) ->
            let uu____5606 =
              desugar_machine_integer env i size top.FStar_Parser_AST.range
               in
            (uu____5606, noaqs)
        | FStar_Parser_AST.Const c ->
            let uu____5618 = mk1 (FStar_Syntax_Syntax.Tm_constant c)  in
            (uu____5618, noaqs)
        | FStar_Parser_AST.Op
            ({ FStar_Ident.idText = "=!="; FStar_Ident.idRange = r;_},args)
            ->
            let e =
              let uu____5640 =
                let uu____5641 =
                  let uu____5648 = FStar_Ident.mk_ident ("==", r)  in
                  (uu____5648, args)  in
                FStar_Parser_AST.Op uu____5641  in
              FStar_Parser_AST.mk_term uu____5640 top.FStar_Parser_AST.range
                top.FStar_Parser_AST.level
               in
            let uu____5651 =
              let uu____5652 =
                let uu____5653 =
                  let uu____5660 = FStar_Ident.mk_ident ("~", r)  in
                  (uu____5660, [e])  in
                FStar_Parser_AST.Op uu____5653  in
              FStar_Parser_AST.mk_term uu____5652 top.FStar_Parser_AST.range
                top.FStar_Parser_AST.level
               in
            desugar_term_aq env uu____5651
        | FStar_Parser_AST.Op (op_star,uu____5664::uu____5665::[]) when
            (let uu____5670 = FStar_Ident.text_of_id op_star  in
             uu____5670 = "*") &&
              (let uu____5672 =
                 op_as_term env (Prims.parse_int "2")
                   top.FStar_Parser_AST.range op_star
                  in
               FStar_All.pipe_right uu____5672 FStar_Option.isNone)
            ->
            let rec flatten1 t =
              match t.FStar_Parser_AST.tm with
              | FStar_Parser_AST.Op
                  ({ FStar_Ident.idText = "*";
                     FStar_Ident.idRange = uu____5687;_},t1::t2::[])
                  ->
                  let uu____5692 = flatten1 t1  in
                  FStar_List.append uu____5692 [t2]
              | uu____5695 -> [t]  in
            let uu____5696 =
              let uu____5705 =
                let uu____5712 =
                  let uu____5715 = unparen top  in flatten1 uu____5715  in
                FStar_All.pipe_right uu____5712
                  (FStar_List.map
                     (fun t  ->
                        let uu____5734 = desugar_typ_aq env t  in
                        match uu____5734 with
                        | (t',aq) ->
                            let uu____5745 = FStar_Syntax_Syntax.as_arg t'
                               in
                            (uu____5745, aq)))
                 in
              FStar_All.pipe_right uu____5705 FStar_List.unzip  in
            (match uu____5696 with
             | (targs,aqs) ->
                 let uu____5774 =
                   let uu____5779 =
                     FStar_Parser_Const.mk_tuple_lid
                       (FStar_List.length targs) top.FStar_Parser_AST.range
                      in
                   FStar_Syntax_DsEnv.fail_or env
                     (FStar_Syntax_DsEnv.try_lookup_lid env) uu____5779
                    in
                 (match uu____5774 with
                  | (tup,uu____5789) ->
                      let uu____5790 =
                        mk1 (FStar_Syntax_Syntax.Tm_app (tup, targs))  in
                      (uu____5790, (join_aqs aqs))))
        | FStar_Parser_AST.Tvar a ->
            let uu____5808 =
              let uu____5811 =
                let uu____5814 =
                  FStar_Syntax_DsEnv.fail_or2
                    (FStar_Syntax_DsEnv.try_lookup_id env) a
                   in
                FStar_Pervasives_Native.fst uu____5814  in
              FStar_All.pipe_left setpos uu____5811  in
            (uu____5808, noaqs)
        | FStar_Parser_AST.Uvar u ->
            let uu____5840 =
              let uu____5845 =
                let uu____5846 =
                  let uu____5847 = FStar_Ident.text_of_id u  in
                  Prims.strcat uu____5847 " in non-universe context"  in
                Prims.strcat "Unexpected universe variable " uu____5846  in
              (FStar_Errors.Fatal_UnexpectedUniverseVariable, uu____5845)  in
            FStar_Errors.raise_error uu____5840 top.FStar_Parser_AST.range
        | FStar_Parser_AST.Op (s,args) ->
            let uu____5858 =
              op_as_term env (FStar_List.length args)
                top.FStar_Parser_AST.range s
               in
            (match uu____5858 with
             | FStar_Pervasives_Native.None  ->
                 let uu____5865 =
                   let uu____5870 =
                     let uu____5871 = FStar_Ident.text_of_id s  in
                     Prims.strcat "Unexpected or unbound operator: "
                       uu____5871
                      in
                   (FStar_Errors.Fatal_UnepxectedOrUnboundOperator,
                     uu____5870)
                    in
                 FStar_Errors.raise_error uu____5865
                   top.FStar_Parser_AST.range
             | FStar_Pervasives_Native.Some op ->
                 if (FStar_List.length args) > (Prims.parse_int "0")
                 then
                   let uu____5881 =
                     let uu____5896 =
                       FStar_All.pipe_right args
                         (FStar_List.map
                            (fun t  ->
                               let uu____5938 = desugar_term_aq env t  in
                               match uu____5938 with
                               | (t',s1) ->
                                   ((t', FStar_Pervasives_Native.None), s1)))
                        in
                     FStar_All.pipe_right uu____5896 FStar_List.unzip  in
                   (match uu____5881 with
                    | (args1,aqs) ->
                        let uu____6021 =
                          mk1 (FStar_Syntax_Syntax.Tm_app (op, args1))  in
                        (uu____6021, (join_aqs aqs)))
                 else (op, noaqs))
        | FStar_Parser_AST.Construct (n1,(a,uu____6057)::[]) when
            n1.FStar_Ident.str = "SMTPat" ->
            let uu____6072 =
              let uu___122_6073 = top  in
              let uu____6074 =
                let uu____6075 =
                  let uu____6082 =
                    let uu___123_6083 = top  in
                    let uu____6084 =
                      let uu____6085 =
                        FStar_Ident.lid_of_path ["Prims"; "smt_pat"]
                          top.FStar_Parser_AST.range
                         in
                      FStar_Parser_AST.Var uu____6085  in
                    {
                      FStar_Parser_AST.tm = uu____6084;
                      FStar_Parser_AST.range =
                        (uu___123_6083.FStar_Parser_AST.range);
                      FStar_Parser_AST.level =
                        (uu___123_6083.FStar_Parser_AST.level)
                    }  in
                  (uu____6082, a, FStar_Parser_AST.Nothing)  in
                FStar_Parser_AST.App uu____6075  in
              {
                FStar_Parser_AST.tm = uu____6074;
                FStar_Parser_AST.range =
                  (uu___122_6073.FStar_Parser_AST.range);
                FStar_Parser_AST.level =
                  (uu___122_6073.FStar_Parser_AST.level)
              }  in
            desugar_term_maybe_top top_level env uu____6072
        | FStar_Parser_AST.Construct (n1,(a,uu____6088)::[]) when
            n1.FStar_Ident.str = "SMTPatT" ->
            (FStar_Errors.log_issue top.FStar_Parser_AST.range
               (FStar_Errors.Warning_SMTPatTDeprecated,
                 "SMTPatT is deprecated; please just use SMTPat");
             (let uu____6104 =
                let uu___124_6105 = top  in
                let uu____6106 =
                  let uu____6107 =
                    let uu____6114 =
                      let uu___125_6115 = top  in
                      let uu____6116 =
                        let uu____6117 =
                          FStar_Ident.lid_of_path ["Prims"; "smt_pat"]
                            top.FStar_Parser_AST.range
                           in
                        FStar_Parser_AST.Var uu____6117  in
                      {
                        FStar_Parser_AST.tm = uu____6116;
                        FStar_Parser_AST.range =
                          (uu___125_6115.FStar_Parser_AST.range);
                        FStar_Parser_AST.level =
                          (uu___125_6115.FStar_Parser_AST.level)
                      }  in
                    (uu____6114, a, FStar_Parser_AST.Nothing)  in
                  FStar_Parser_AST.App uu____6107  in
                {
                  FStar_Parser_AST.tm = uu____6106;
                  FStar_Parser_AST.range =
                    (uu___124_6105.FStar_Parser_AST.range);
                  FStar_Parser_AST.level =
                    (uu___124_6105.FStar_Parser_AST.level)
                }  in
              desugar_term_maybe_top top_level env uu____6104))
        | FStar_Parser_AST.Construct (n1,(a,uu____6120)::[]) when
            n1.FStar_Ident.str = "SMTPatOr" ->
            let uu____6135 =
              let uu___126_6136 = top  in
              let uu____6137 =
                let uu____6138 =
                  let uu____6145 =
                    let uu___127_6146 = top  in
                    let uu____6147 =
                      let uu____6148 =
                        FStar_Ident.lid_of_path ["Prims"; "smt_pat_or"]
                          top.FStar_Parser_AST.range
                         in
                      FStar_Parser_AST.Var uu____6148  in
                    {
                      FStar_Parser_AST.tm = uu____6147;
                      FStar_Parser_AST.range =
                        (uu___127_6146.FStar_Parser_AST.range);
                      FStar_Parser_AST.level =
                        (uu___127_6146.FStar_Parser_AST.level)
                    }  in
                  (uu____6145, a, FStar_Parser_AST.Nothing)  in
                FStar_Parser_AST.App uu____6138  in
              {
                FStar_Parser_AST.tm = uu____6137;
                FStar_Parser_AST.range =
                  (uu___126_6136.FStar_Parser_AST.range);
                FStar_Parser_AST.level =
                  (uu___126_6136.FStar_Parser_AST.level)
              }  in
            desugar_term_maybe_top top_level env uu____6135
        | FStar_Parser_AST.Name
            { FStar_Ident.ns = uu____6149; FStar_Ident.ident = uu____6150;
              FStar_Ident.nsstr = uu____6151; FStar_Ident.str = "Type0";_}
            ->
            let uu____6154 =
              mk1 (FStar_Syntax_Syntax.Tm_type FStar_Syntax_Syntax.U_zero)
               in
            (uu____6154, noaqs)
        | FStar_Parser_AST.Name
            { FStar_Ident.ns = uu____6169; FStar_Ident.ident = uu____6170;
              FStar_Ident.nsstr = uu____6171; FStar_Ident.str = "Type";_}
            ->
            let uu____6174 =
              mk1 (FStar_Syntax_Syntax.Tm_type FStar_Syntax_Syntax.U_unknown)
               in
            (uu____6174, noaqs)
        | FStar_Parser_AST.Construct
            ({ FStar_Ident.ns = uu____6189; FStar_Ident.ident = uu____6190;
               FStar_Ident.nsstr = uu____6191; FStar_Ident.str = "Type";_},
             (t,FStar_Parser_AST.UnivApp )::[])
            ->
            let uu____6209 =
              let uu____6212 =
                let uu____6213 = desugar_universe t  in
                FStar_Syntax_Syntax.Tm_type uu____6213  in
              mk1 uu____6212  in
            (uu____6209, noaqs)
        | FStar_Parser_AST.Name
            { FStar_Ident.ns = uu____6226; FStar_Ident.ident = uu____6227;
              FStar_Ident.nsstr = uu____6228; FStar_Ident.str = "Effect";_}
            ->
            let uu____6231 =
              mk1 (FStar_Syntax_Syntax.Tm_constant FStar_Const.Const_effect)
               in
            (uu____6231, noaqs)
        | FStar_Parser_AST.Name
            { FStar_Ident.ns = uu____6246; FStar_Ident.ident = uu____6247;
              FStar_Ident.nsstr = uu____6248; FStar_Ident.str = "True";_}
            ->
            let uu____6251 =
              let uu____6252 =
                FStar_Ident.set_lid_range FStar_Parser_Const.true_lid
                  top.FStar_Parser_AST.range
                 in
              FStar_Syntax_Syntax.fvar uu____6252
                FStar_Syntax_Syntax.Delta_constant
                FStar_Pervasives_Native.None
               in
            (uu____6251, noaqs)
        | FStar_Parser_AST.Name
            { FStar_Ident.ns = uu____6263; FStar_Ident.ident = uu____6264;
              FStar_Ident.nsstr = uu____6265; FStar_Ident.str = "False";_}
            ->
            let uu____6268 =
              let uu____6269 =
                FStar_Ident.set_lid_range FStar_Parser_Const.false_lid
                  top.FStar_Parser_AST.range
                 in
              FStar_Syntax_Syntax.fvar uu____6269
                FStar_Syntax_Syntax.Delta_constant
                FStar_Pervasives_Native.None
               in
            (uu____6268, noaqs)
        | FStar_Parser_AST.Projector
            (eff_name,{ FStar_Ident.idText = txt;
                        FStar_Ident.idRange = uu____6282;_})
            when
            (is_special_effect_combinator txt) &&
              (FStar_Syntax_DsEnv.is_effect_name env eff_name)
            ->
            (FStar_Syntax_DsEnv.fail_if_qualified_by_curmodule env eff_name;
             (let uu____6284 =
                FStar_Syntax_DsEnv.try_lookup_effect_defn env eff_name  in
              match uu____6284 with
              | FStar_Pervasives_Native.Some ed ->
                  let lid = FStar_Syntax_Util.dm4f_lid ed txt  in
                  let uu____6293 =
                    FStar_Syntax_Syntax.fvar lid
                      (FStar_Syntax_Syntax.Delta_defined_at_level
                         (Prims.parse_int "1")) FStar_Pervasives_Native.None
                     in
                  (uu____6293, noaqs)
              | FStar_Pervasives_Native.None  ->
                  let uu____6304 =
                    let uu____6305 = FStar_Ident.text_of_lid eff_name  in
                    FStar_Util.format2
                      "Member %s of effect %s is not accessible (using an effect abbreviation instead of the original effect ?)"
                      uu____6305 txt
                     in
                  failwith uu____6304))
        | FStar_Parser_AST.Var l ->
            (FStar_Syntax_DsEnv.fail_if_qualified_by_curmodule env l;
             (let uu____6312 = desugar_name mk1 setpos env true l  in
              (uu____6312, noaqs)))
        | FStar_Parser_AST.Name l ->
            (FStar_Syntax_DsEnv.fail_if_qualified_by_curmodule env l;
             (let uu____6325 = desugar_name mk1 setpos env true l  in
              (uu____6325, noaqs)))
        | FStar_Parser_AST.Projector (l,i) ->
            (FStar_Syntax_DsEnv.fail_if_qualified_by_curmodule env l;
             (let name =
                let uu____6346 = FStar_Syntax_DsEnv.try_lookup_datacon env l
                   in
                match uu____6346 with
                | FStar_Pervasives_Native.Some uu____6355 ->
                    FStar_Pervasives_Native.Some (true, l)
                | FStar_Pervasives_Native.None  ->
                    let uu____6360 =
                      FStar_Syntax_DsEnv.try_lookup_root_effect_name env l
                       in
                    (match uu____6360 with
                     | FStar_Pervasives_Native.Some new_name ->
                         FStar_Pervasives_Native.Some (false, new_name)
                     | uu____6374 -> FStar_Pervasives_Native.None)
                 in
              match name with
              | FStar_Pervasives_Native.Some (resolve,new_name) ->
                  let uu____6391 =
                    let uu____6392 =
                      FStar_Syntax_Util.mk_field_projector_name_from_ident
                        new_name i
                       in
                    desugar_name mk1 setpos env resolve uu____6392  in
                  (uu____6391, noaqs)
              | uu____6403 ->
                  let uu____6410 =
                    let uu____6415 =
                      FStar_Util.format1
                        "Data constructor or effect %s not found"
                        l.FStar_Ident.str
                       in
                    (FStar_Errors.Fatal_EffectNotFound, uu____6415)  in
                  FStar_Errors.raise_error uu____6410
                    top.FStar_Parser_AST.range))
        | FStar_Parser_AST.Discrim lid ->
            (FStar_Syntax_DsEnv.fail_if_qualified_by_curmodule env lid;
             (let uu____6422 = FStar_Syntax_DsEnv.try_lookup_datacon env lid
                 in
              match uu____6422 with
              | FStar_Pervasives_Native.None  ->
                  let uu____6429 =
                    let uu____6434 =
                      FStar_Util.format1 "Data constructor %s not found"
                        lid.FStar_Ident.str
                       in
                    (FStar_Errors.Fatal_DataContructorNotFound, uu____6434)
                     in
                  FStar_Errors.raise_error uu____6429
                    top.FStar_Parser_AST.range
              | uu____6439 ->
                  let lid' = FStar_Syntax_Util.mk_discriminator lid  in
                  let uu____6443 = desugar_name mk1 setpos env true lid'  in
                  (uu____6443, noaqs)))
        | FStar_Parser_AST.Construct (l,args) ->
            (FStar_Syntax_DsEnv.fail_if_qualified_by_curmodule env l;
             (let uu____6469 = FStar_Syntax_DsEnv.try_lookup_datacon env l
                 in
              match uu____6469 with
              | FStar_Pervasives_Native.Some head1 ->
                  let head2 = mk1 (FStar_Syntax_Syntax.Tm_fvar head1)  in
                  (match args with
                   | [] -> (head2, noaqs)
                   | uu____6500 ->
                       let uu____6507 =
                         FStar_Util.take
                           (fun uu____6531  ->
                              match uu____6531 with
                              | (uu____6536,imp) ->
                                  imp = FStar_Parser_AST.UnivApp) args
                          in
                       (match uu____6507 with
                        | (universes,args1) ->
                            let universes1 =
                              FStar_List.map
                                (fun x  ->
                                   desugar_universe
                                     (FStar_Pervasives_Native.fst x))
                                universes
                               in
                            let uu____6581 =
                              let uu____6596 =
                                FStar_List.map
                                  (fun uu____6629  ->
                                     match uu____6629 with
                                     | (t,imp) ->
                                         let uu____6646 =
                                           desugar_term_aq env t  in
                                         (match uu____6646 with
                                          | (te,aq) ->
                                              ((arg_withimp_e imp te), aq)))
                                  args1
                                 in
                              FStar_All.pipe_right uu____6596
                                FStar_List.unzip
                               in
                            (match uu____6581 with
                             | (args2,aqs) ->
                                 let head3 =
                                   if universes1 = []
                                   then head2
                                   else
                                     mk1
                                       (FStar_Syntax_Syntax.Tm_uinst
                                          (head2, universes1))
                                    in
                                 let uu____6739 =
                                   mk1
                                     (FStar_Syntax_Syntax.Tm_app
                                        (head3, args2))
                                    in
                                 (uu____6739, (join_aqs aqs)))))
              | FStar_Pervasives_Native.None  ->
                  let err =
                    let uu____6769 =
                      FStar_Syntax_DsEnv.try_lookup_effect_name env l  in
                    match uu____6769 with
                    | FStar_Pervasives_Native.None  ->
                        (FStar_Errors.Fatal_ConstructorNotFound,
                          (Prims.strcat "Constructor "
                             (Prims.strcat l.FStar_Ident.str " not found")))
                    | FStar_Pervasives_Native.Some uu____6776 ->
                        (FStar_Errors.Fatal_UnexpectedEffect,
                          (Prims.strcat "Effect "
                             (Prims.strcat l.FStar_Ident.str
                                " used at an unexpected position")))
                     in
                  FStar_Errors.raise_error err top.FStar_Parser_AST.range))
        | FStar_Parser_AST.Sum (binders,t) ->
            let uu____6787 =
              FStar_List.fold_left
                (fun uu____6832  ->
                   fun b  ->
                     match uu____6832 with
                     | (env1,tparams,typs) ->
                         let uu____6889 = desugar_binder env1 b  in
                         (match uu____6889 with
                          | (xopt,t1) ->
                              let uu____6918 =
                                match xopt with
                                | FStar_Pervasives_Native.None  ->
                                    let uu____6927 =
                                      FStar_Syntax_Syntax.new_bv
                                        (FStar_Pervasives_Native.Some
                                           (top.FStar_Parser_AST.range))
                                        FStar_Syntax_Syntax.tun
                                       in
                                    (env1, uu____6927)
                                | FStar_Pervasives_Native.Some x ->
                                    FStar_Syntax_DsEnv.push_bv env1 x
                                 in
                              (match uu____6918 with
                               | (env2,x) ->
                                   let uu____6947 =
                                     let uu____6950 =
                                       let uu____6953 =
                                         let uu____6954 =
                                           no_annot_abs tparams t1  in
                                         FStar_All.pipe_left
                                           FStar_Syntax_Syntax.as_arg
                                           uu____6954
                                          in
                                       [uu____6953]  in
                                     FStar_List.append typs uu____6950  in
                                   (env2,
                                     (FStar_List.append tparams
                                        [(((let uu___128_6980 = x  in
                                            {
                                              FStar_Syntax_Syntax.ppname =
                                                (uu___128_6980.FStar_Syntax_Syntax.ppname);
                                              FStar_Syntax_Syntax.index =
                                                (uu___128_6980.FStar_Syntax_Syntax.index);
                                              FStar_Syntax_Syntax.sort = t1
                                            })),
                                           FStar_Pervasives_Native.None)]),
                                     uu____6947)))) (env, [], [])
                (FStar_List.append binders
                   [FStar_Parser_AST.mk_binder (FStar_Parser_AST.NoName t)
                      t.FStar_Parser_AST.range FStar_Parser_AST.Type_level
                      FStar_Pervasives_Native.None])
               in
            (match uu____6787 with
             | (env1,uu____7008,targs) ->
                 let uu____7030 =
                   let uu____7035 =
                     FStar_Parser_Const.mk_dtuple_lid
                       (FStar_List.length targs) top.FStar_Parser_AST.range
                      in
                   FStar_Syntax_DsEnv.fail_or env1
                     (FStar_Syntax_DsEnv.try_lookup_lid env1) uu____7035
                    in
                 (match uu____7030 with
                  | (tup,uu____7045) ->
                      let uu____7046 =
                        FStar_All.pipe_left mk1
                          (FStar_Syntax_Syntax.Tm_app (tup, targs))
                         in
                      (uu____7046, noaqs)))
        | FStar_Parser_AST.Product (binders,t) ->
            let uu____7071 = uncurry binders t  in
            (match uu____7071 with
             | (bs,t1) ->
                 let rec aux env1 bs1 uu___94_7113 =
                   match uu___94_7113 with
                   | [] ->
                       let cod =
                         desugar_comp top.FStar_Parser_AST.range env1 t1  in
                       let uu____7127 =
                         FStar_Syntax_Util.arrow (FStar_List.rev bs1) cod  in
                       FStar_All.pipe_left setpos uu____7127
                   | hd1::tl1 ->
                       let bb = desugar_binder env1 hd1  in
                       let uu____7149 =
                         as_binder env1 hd1.FStar_Parser_AST.aqual bb  in
                       (match uu____7149 with
                        | (b,env2) -> aux env2 (b :: bs1) tl1)
                    in
                 let uu____7158 = aux env [] bs  in (uu____7158, noaqs))
        | FStar_Parser_AST.Refine (b,f) ->
            let uu____7179 = desugar_binder env b  in
            (match uu____7179 with
             | (FStar_Pervasives_Native.None ,uu____7190) ->
                 failwith "Missing binder in refinement"
             | b1 ->
                 let uu____7204 =
                   as_binder env FStar_Pervasives_Native.None b1  in
                 (match uu____7204 with
                  | ((x,uu____7214),env1) ->
                      let f1 = desugar_formula env1 f  in
                      let uu____7221 =
                        let uu____7224 = FStar_Syntax_Util.refine x f1  in
                        FStar_All.pipe_left setpos uu____7224  in
                      (uu____7221, noaqs)))
        | FStar_Parser_AST.Abs (binders,body) ->
            let binders1 =
              FStar_All.pipe_right binders
                (FStar_List.map replace_unit_pattern)
               in
            let uu____7256 =
              FStar_List.fold_left
                (fun uu____7276  ->
                   fun pat  ->
                     match uu____7276 with
                     | (env1,ftvs) ->
                         (match pat.FStar_Parser_AST.pat with
                          | FStar_Parser_AST.PatAscribed
                              (uu____7302,(t,FStar_Pervasives_Native.None ))
                              ->
                              let uu____7312 =
                                let uu____7315 = free_type_vars env1 t  in
                                FStar_List.append uu____7315 ftvs  in
                              (env1, uu____7312)
                          | FStar_Parser_AST.PatAscribed
                              (uu____7320,(t,FStar_Pervasives_Native.Some
                                           tac))
                              ->
                              let uu____7331 =
                                let uu____7334 = free_type_vars env1 t  in
                                let uu____7337 =
                                  let uu____7340 = free_type_vars env1 tac
                                     in
                                  FStar_List.append uu____7340 ftvs  in
                                FStar_List.append uu____7334 uu____7337  in
                              (env1, uu____7331)
                          | uu____7345 -> (env1, ftvs))) (env, []) binders1
               in
            (match uu____7256 with
             | (uu____7354,ftv) ->
                 let ftv1 = sort_ftv ftv  in
                 let binders2 =
                   let uu____7366 =
                     FStar_All.pipe_right ftv1
                       (FStar_List.map
                          (fun a  ->
                             FStar_Parser_AST.mk_pattern
                               (FStar_Parser_AST.PatTvar
                                  (a,
                                    (FStar_Pervasives_Native.Some
                                       FStar_Parser_AST.Implicit)))
                               top.FStar_Parser_AST.range))
                      in
                   FStar_List.append uu____7366 binders1  in
                 let rec aux env1 bs sc_pat_opt uu___95_7419 =
                   match uu___95_7419 with
                   | [] ->
                       let uu____7442 = desugar_term_aq env1 body  in
                       (match uu____7442 with
                        | (body1,aq) ->
                            let body2 =
                              match sc_pat_opt with
                              | FStar_Pervasives_Native.Some (sc,pat) ->
                                  let body2 =
                                    let uu____7473 =
                                      let uu____7474 =
                                        FStar_Syntax_Syntax.pat_bvs pat  in
                                      FStar_All.pipe_right uu____7474
                                        (FStar_List.map
                                           FStar_Syntax_Syntax.mk_binder)
                                       in
                                    FStar_Syntax_Subst.close uu____7473 body1
                                     in
                                  FStar_Syntax_Syntax.mk
                                    (FStar_Syntax_Syntax.Tm_match
                                       (sc,
                                         [(pat, FStar_Pervasives_Native.None,
                                            body2)]))
                                    FStar_Pervasives_Native.None
                                    body2.FStar_Syntax_Syntax.pos
                              | FStar_Pervasives_Native.None  -> body1  in
                            let uu____7527 =
                              let uu____7530 =
                                no_annot_abs (FStar_List.rev bs) body2  in
                              setpos uu____7530  in
                            (uu____7527, aq))
                   | p::rest ->
                       let uu____7543 = desugar_binding_pat env1 p  in
                       (match uu____7543 with
                        | (env2,b,pat) ->
                            let pat1 =
                              match pat with
                              | [] -> FStar_Pervasives_Native.None
                              | p1::[] -> FStar_Pervasives_Native.Some p1
                              | uu____7571 ->
                                  FStar_Errors.raise_error
                                    (FStar_Errors.Fatal_UnsupportedDisjuctivePatterns,
                                      "Disjunctive patterns are not supported in abstractions")
                                    p.FStar_Parser_AST.prange
                               in
                            let uu____7576 =
                              match b with
                              | LetBinder uu____7609 -> failwith "Impossible"
                              | LocalBinder (x,aq) ->
                                  let sc_pat_opt1 =
                                    match (pat1, sc_pat_opt) with
                                    | (FStar_Pervasives_Native.None
                                       ,uu____7665) -> sc_pat_opt
                                    | (FStar_Pervasives_Native.Some
                                       p1,FStar_Pervasives_Native.None ) ->
                                        let uu____7701 =
                                          let uu____7706 =
                                            FStar_Syntax_Syntax.bv_to_name x
                                             in
                                          (uu____7706, p1)  in
                                        FStar_Pervasives_Native.Some
                                          uu____7701
                                    | (FStar_Pervasives_Native.Some
                                       p1,FStar_Pervasives_Native.Some
                                       (sc,p')) ->
                                        (match ((sc.FStar_Syntax_Syntax.n),
                                                 (p'.FStar_Syntax_Syntax.v))
                                         with
                                         | (FStar_Syntax_Syntax.Tm_name
                                            uu____7742,uu____7743) ->
                                             let tup2 =
                                               let uu____7745 =
                                                 FStar_Parser_Const.mk_tuple_data_lid
                                                   (Prims.parse_int "2")
                                                   top.FStar_Parser_AST.range
                                                  in
                                               FStar_Syntax_Syntax.lid_as_fv
                                                 uu____7745
                                                 FStar_Syntax_Syntax.Delta_constant
                                                 (FStar_Pervasives_Native.Some
                                                    FStar_Syntax_Syntax.Data_ctor)
                                                in
                                             let sc1 =
                                               let uu____7749 =
                                                 let uu____7756 =
                                                   let uu____7757 =
                                                     let uu____7772 =
                                                       mk1
                                                         (FStar_Syntax_Syntax.Tm_fvar
                                                            tup2)
                                                        in
                                                     let uu____7775 =
                                                       let uu____7778 =
                                                         FStar_Syntax_Syntax.as_arg
                                                           sc
                                                          in
                                                       let uu____7779 =
                                                         let uu____7782 =
                                                           let uu____7783 =
                                                             FStar_Syntax_Syntax.bv_to_name
                                                               x
                                                              in
                                                           FStar_All.pipe_left
                                                             FStar_Syntax_Syntax.as_arg
                                                             uu____7783
                                                            in
                                                         [uu____7782]  in
                                                       uu____7778 ::
                                                         uu____7779
                                                        in
                                                     (uu____7772, uu____7775)
                                                      in
                                                   FStar_Syntax_Syntax.Tm_app
                                                     uu____7757
                                                    in
                                                 FStar_Syntax_Syntax.mk
                                                   uu____7756
                                                  in
                                               uu____7749
                                                 FStar_Pervasives_Native.None
                                                 top.FStar_Parser_AST.range
                                                in
                                             let p2 =
                                               let uu____7794 =
                                                 FStar_Range.union_ranges
                                                   p'.FStar_Syntax_Syntax.p
                                                   p1.FStar_Syntax_Syntax.p
                                                  in
                                               FStar_Syntax_Syntax.withinfo
                                                 (FStar_Syntax_Syntax.Pat_cons
                                                    (tup2,
                                                      [(p', false);
                                                      (p1, false)]))
                                                 uu____7794
                                                in
                                             FStar_Pervasives_Native.Some
                                               (sc1, p2)
                                         | (FStar_Syntax_Syntax.Tm_app
                                            (uu____7825,args),FStar_Syntax_Syntax.Pat_cons
                                            (uu____7827,pats)) ->
                                             let tupn =
                                               let uu____7866 =
                                                 FStar_Parser_Const.mk_tuple_data_lid
                                                   ((Prims.parse_int "1") +
                                                      (FStar_List.length args))
                                                   top.FStar_Parser_AST.range
                                                  in
                                               FStar_Syntax_Syntax.lid_as_fv
                                                 uu____7866
                                                 FStar_Syntax_Syntax.Delta_constant
                                                 (FStar_Pervasives_Native.Some
                                                    FStar_Syntax_Syntax.Data_ctor)
                                                in
                                             let sc1 =
                                               let uu____7876 =
                                                 let uu____7877 =
                                                   let uu____7892 =
                                                     mk1
                                                       (FStar_Syntax_Syntax.Tm_fvar
                                                          tupn)
                                                      in
                                                   let uu____7895 =
                                                     let uu____7904 =
                                                       let uu____7913 =
                                                         let uu____7914 =
                                                           FStar_Syntax_Syntax.bv_to_name
                                                             x
                                                            in
                                                         FStar_All.pipe_left
                                                           FStar_Syntax_Syntax.as_arg
                                                           uu____7914
                                                          in
                                                       [uu____7913]  in
                                                     FStar_List.append args
                                                       uu____7904
                                                      in
                                                   (uu____7892, uu____7895)
                                                    in
                                                 FStar_Syntax_Syntax.Tm_app
                                                   uu____7877
                                                  in
                                               mk1 uu____7876  in
                                             let p2 =
                                               let uu____7934 =
                                                 FStar_Range.union_ranges
                                                   p'.FStar_Syntax_Syntax.p
                                                   p1.FStar_Syntax_Syntax.p
                                                  in
                                               FStar_Syntax_Syntax.withinfo
                                                 (FStar_Syntax_Syntax.Pat_cons
                                                    (tupn,
                                                      (FStar_List.append pats
                                                         [(p1, false)])))
                                                 uu____7934
                                                in
                                             FStar_Pervasives_Native.Some
                                               (sc1, p2)
                                         | uu____7969 ->
                                             failwith "Impossible")
                                     in
                                  ((x, aq), sc_pat_opt1)
                               in
                            (match uu____7576 with
                             | (b1,sc_pat_opt1) ->
                                 aux env2 (b1 :: bs) sc_pat_opt1 rest))
                    in
                 aux env [] FStar_Pervasives_Native.None binders2)
        | FStar_Parser_AST.App
            (uu____8040,uu____8041,FStar_Parser_AST.UnivApp ) ->
            let rec aux universes e =
              let uu____8063 =
                let uu____8064 = unparen e  in uu____8064.FStar_Parser_AST.tm
                 in
              match uu____8063 with
              | FStar_Parser_AST.App (e1,t,FStar_Parser_AST.UnivApp ) ->
                  let univ_arg = desugar_universe t  in
                  aux (univ_arg :: universes) e1
              | uu____8074 ->
                  let uu____8075 = desugar_term_aq env e  in
                  (match uu____8075 with
                   | (head1,aq) ->
                       let uu____8088 =
                         mk1
                           (FStar_Syntax_Syntax.Tm_uinst (head1, universes))
                          in
                       (uu____8088, aq))
               in
            aux [] top
        | FStar_Parser_AST.App uu____8095 ->
            let rec aux args aqs e =
              let uu____8154 =
                let uu____8155 = unparen e  in uu____8155.FStar_Parser_AST.tm
                 in
              match uu____8154 with
              | FStar_Parser_AST.App (e1,t,imp) when
                  imp <> FStar_Parser_AST.UnivApp ->
                  let uu____8175 = desugar_term_aq env t  in
                  (match uu____8175 with
                   | (t1,aq) ->
                       let arg = arg_withimp_e imp t1  in
                       aux (arg :: args) (aq :: aqs) e1)
              | uu____8211 ->
                  let uu____8212 = desugar_term_aq env e  in
                  (match uu____8212 with
                   | (head1,aq) ->
                       let uu____8235 =
                         mk1 (FStar_Syntax_Syntax.Tm_app (head1, args))  in
                       (uu____8235, (join_aqs (aq :: aqs))))
               in
            aux [] [] top
        | FStar_Parser_AST.Bind (x,t1,t2) ->
            let xpat =
              FStar_Parser_AST.mk_pattern
                (FStar_Parser_AST.PatVar (x, FStar_Pervasives_Native.None))
                x.FStar_Ident.idRange
               in
            let k =
              FStar_Parser_AST.mk_term (FStar_Parser_AST.Abs ([xpat], t2))
                t2.FStar_Parser_AST.range t2.FStar_Parser_AST.level
               in
            let bind_lid =
              FStar_Ident.lid_of_path ["bind"] x.FStar_Ident.idRange  in
            let bind1 =
              FStar_Parser_AST.mk_term (FStar_Parser_AST.Var bind_lid)
                x.FStar_Ident.idRange FStar_Parser_AST.Expr
               in
            let uu____8275 =
              FStar_Parser_AST.mkExplicitApp bind1 [t1; k]
                top.FStar_Parser_AST.range
               in
            desugar_term_aq env uu____8275
        | FStar_Parser_AST.Seq (t1,t2) ->
            let t =
              FStar_Parser_AST.mk_term
                (FStar_Parser_AST.Let
                   (FStar_Parser_AST.NoLetQualifier,
                     [(FStar_Pervasives_Native.None,
                        ((FStar_Parser_AST.mk_pattern
                            FStar_Parser_AST.PatWild
                            t1.FStar_Parser_AST.range), t1))], t2))
                top.FStar_Parser_AST.range FStar_Parser_AST.Expr
               in
            let uu____8327 = desugar_term_aq env t  in
            (match uu____8327 with
             | (tm,s) ->
                 let uu____8338 =
                   mk1
                     (FStar_Syntax_Syntax.Tm_meta
                        (tm,
                          (FStar_Syntax_Syntax.Meta_desugared
                             FStar_Syntax_Syntax.Sequence)))
                    in
                 (uu____8338, s))
        | FStar_Parser_AST.LetOpen (lid,e) ->
            let env1 = FStar_Syntax_DsEnv.push_namespace env lid  in
            let uu____8346 =
              let uu____8359 = FStar_Syntax_DsEnv.expect_typ env1  in
              if uu____8359 then desugar_typ_aq else desugar_term_aq  in
            uu____8346 env1 e
        | FStar_Parser_AST.Let (qual,lbs,body) ->
            let is_rec = qual = FStar_Parser_AST.Rec  in
            let ds_let_rec_or_app uu____8414 =
              let bindings = lbs  in
              let funs =
                FStar_All.pipe_right bindings
                  (FStar_List.map
                     (fun uu____8557  ->
                        match uu____8557 with
                        | (attr_opt,(p,def)) ->
                            let uu____8615 = is_app_pattern p  in
                            if uu____8615
                            then
                              let uu____8646 =
                                destruct_app_pattern env top_level p  in
                              (attr_opt, uu____8646, def)
                            else
                              (match FStar_Parser_AST.un_function p def with
                               | FStar_Pervasives_Native.Some (p1,def1) ->
                                   let uu____8728 =
                                     destruct_app_pattern env top_level p1
                                      in
                                   (attr_opt, uu____8728, def1)
                               | uu____8773 ->
                                   (match p.FStar_Parser_AST.pat with
                                    | FStar_Parser_AST.PatAscribed
                                        ({
                                           FStar_Parser_AST.pat =
                                             FStar_Parser_AST.PatVar
                                             (id1,uu____8811);
                                           FStar_Parser_AST.prange =
                                             uu____8812;_},t)
                                        ->
                                        if top_level
                                        then
                                          let uu____8860 =
                                            let uu____8881 =
                                              let uu____8886 =
                                                FStar_Syntax_DsEnv.qualify
                                                  env id1
                                                 in
                                              FStar_Util.Inr uu____8886  in
                                            (uu____8881, [],
                                              (FStar_Pervasives_Native.Some t))
                                             in
                                          (attr_opt, uu____8860, def)
                                        else
                                          (attr_opt,
                                            ((FStar_Util.Inl id1), [],
                                              (FStar_Pervasives_Native.Some t)),
                                            def)
                                    | FStar_Parser_AST.PatVar
                                        (id1,uu____8977) ->
                                        if top_level
                                        then
                                          let uu____9012 =
                                            let uu____9033 =
                                              let uu____9038 =
                                                FStar_Syntax_DsEnv.qualify
                                                  env id1
                                                 in
                                              FStar_Util.Inr uu____9038  in
                                            (uu____9033, [],
                                              FStar_Pervasives_Native.None)
                                             in
                                          (attr_opt, uu____9012, def)
                                        else
                                          (attr_opt,
                                            ((FStar_Util.Inl id1), [],
                                              FStar_Pervasives_Native.None),
                                            def)
                                    | uu____9128 ->
                                        FStar_Errors.raise_error
                                          (FStar_Errors.Fatal_UnexpectedLetBinding,
                                            "Unexpected let binding")
                                          p.FStar_Parser_AST.prange))))
                 in
              let uu____9159 =
                FStar_List.fold_left
                  (fun uu____9232  ->
                     fun uu____9233  ->
                       match (uu____9232, uu____9233) with
                       | ((env1,fnames,rec_bindings),(_attr_opt,(f,uu____9341,uu____9342),uu____9343))
                           ->
                           let uu____9460 =
                             match f with
                             | FStar_Util.Inl x ->
                                 let uu____9486 =
                                   FStar_Syntax_DsEnv.push_bv env1 x  in
                                 (match uu____9486 with
                                  | (env2,xx) ->
                                      let uu____9505 =
                                        let uu____9508 =
                                          FStar_Syntax_Syntax.mk_binder xx
                                           in
                                        uu____9508 :: rec_bindings  in
                                      (env2, (FStar_Util.Inl xx), uu____9505))
                             | FStar_Util.Inr l ->
                                 let uu____9516 =
                                   FStar_Syntax_DsEnv.push_top_level_rec_binding
                                     env1 l.FStar_Ident.ident
                                     FStar_Syntax_Syntax.Delta_equational
                                    in
                                 (uu____9516, (FStar_Util.Inr l),
                                   rec_bindings)
                              in
                           (match uu____9460 with
                            | (env2,lbname,rec_bindings1) ->
                                (env2, (lbname :: fnames), rec_bindings1)))
                  (env, [], []) funs
                 in
              match uu____9159 with
              | (env',fnames,rec_bindings) ->
                  let fnames1 = FStar_List.rev fnames  in
                  let rec_bindings1 = FStar_List.rev rec_bindings  in
                  let desugar_one_def env1 lbname uu____9664 =
                    match uu____9664 with
                    | (attrs_opt,(uu____9700,args,result_t),def) ->
                        let args1 =
                          FStar_All.pipe_right args
                            (FStar_List.map replace_unit_pattern)
                           in
                        let pos = def.FStar_Parser_AST.range  in
                        let def1 =
                          match result_t with
                          | FStar_Pervasives_Native.None  -> def
                          | FStar_Pervasives_Native.Some (t,tacopt) ->
                              let t1 =
                                let uu____9788 = is_comp_type env1 t  in
                                if uu____9788
                                then
                                  ((let uu____9790 =
                                      FStar_All.pipe_right args1
                                        (FStar_List.tryFind
                                           (fun x  ->
                                              let uu____9800 =
                                                is_var_pattern x  in
                                              Prims.op_Negation uu____9800))
                                       in
                                    match uu____9790 with
                                    | FStar_Pervasives_Native.None  -> ()
                                    | FStar_Pervasives_Native.Some p ->
                                        FStar_Errors.raise_error
                                          (FStar_Errors.Fatal_ComputationTypeNotAllowed,
                                            "Computation type annotations are only permitted on let-bindings without inlined patterns; replace this pattern with a variable")
                                          p.FStar_Parser_AST.prange);
                                   t)
                                else
                                  (let uu____9803 =
                                     ((FStar_Options.ml_ish ()) &&
                                        (let uu____9805 =
                                           FStar_Syntax_DsEnv.try_lookup_effect_name
                                             env1
                                             FStar_Parser_Const.effect_ML_lid
                                            in
                                         FStar_Option.isSome uu____9805))
                                       &&
                                       ((Prims.op_Negation is_rec) ||
                                          ((FStar_List.length args1) <>
                                             (Prims.parse_int "0")))
                                      in
                                   if uu____9803
                                   then FStar_Parser_AST.ml_comp t
                                   else FStar_Parser_AST.tot_comp t)
                                 in
                              let uu____9809 =
                                FStar_Range.union_ranges
                                  t1.FStar_Parser_AST.range
                                  def.FStar_Parser_AST.range
                                 in
                              FStar_Parser_AST.mk_term
                                (FStar_Parser_AST.Ascribed (def, t1, tacopt))
                                uu____9809 FStar_Parser_AST.Expr
                           in
                        let def2 =
                          match args1 with
                          | [] -> def1
                          | uu____9813 ->
                              FStar_Parser_AST.mk_term
                                (FStar_Parser_AST.un_curry_abs args1 def1)
                                top.FStar_Parser_AST.range
                                top.FStar_Parser_AST.level
                           in
                        let body1 = desugar_term env1 def2  in
                        let lbname1 =
                          match lbname with
                          | FStar_Util.Inl x -> FStar_Util.Inl x
                          | FStar_Util.Inr l ->
                              let uu____9828 =
                                let uu____9829 =
                                  FStar_Syntax_Util.incr_delta_qualifier
                                    body1
                                   in
                                FStar_Syntax_Syntax.lid_as_fv l uu____9829
                                  FStar_Pervasives_Native.None
                                 in
                              FStar_Util.Inr uu____9828
                           in
                        let body2 =
                          if is_rec
                          then FStar_Syntax_Subst.close rec_bindings1 body1
                          else body1  in
                        let attrs =
                          match attrs_opt with
                          | FStar_Pervasives_Native.None  -> []
                          | FStar_Pervasives_Native.Some l ->
                              FStar_List.map (desugar_term env1) l
                           in
                        mk_lb
                          (attrs, lbname1, FStar_Syntax_Syntax.tun, body2,
                            pos)
                     in
                  let lbs1 =
                    FStar_List.map2
                      (desugar_one_def (if is_rec then env' else env))
                      fnames1 funs
                     in
                  let uu____9888 = desugar_term_aq env' body  in
                  (match uu____9888 with
                   | (body1,aq) ->
                       let uu____9901 =
                         let uu____9904 =
                           let uu____9905 =
                             let uu____9918 =
                               FStar_Syntax_Subst.close rec_bindings1 body1
                                in
                             ((is_rec, lbs1), uu____9918)  in
                           FStar_Syntax_Syntax.Tm_let uu____9905  in
                         FStar_All.pipe_left mk1 uu____9904  in
                       (uu____9901, aq))
               in
            let ds_non_rec attrs_opt pat t1 t2 =
              let attrs =
                match attrs_opt with
                | FStar_Pervasives_Native.None  -> []
                | FStar_Pervasives_Native.Some l ->
                    FStar_List.map (desugar_term env) l
                 in
              let t11 = desugar_term env t1  in
              let is_mutable = qual = FStar_Parser_AST.Mutable  in
              let t12 = if is_mutable then mk_ref_alloc t11 else t11  in
              let uu____9986 =
                desugar_binding_pat_maybe_top top_level env pat is_mutable
                 in
              match uu____9986 with
              | (env1,binder,pat1) ->
                  let uu____10008 =
                    match binder with
                    | LetBinder (l,(t,_tacopt)) ->
                        let uu____10034 = desugar_term_aq env1 t2  in
                        (match uu____10034 with
                         | (body1,aq) ->
                             let fv =
                               let uu____10048 =
                                 FStar_Syntax_Util.incr_delta_qualifier t12
                                  in
                               FStar_Syntax_Syntax.lid_as_fv l uu____10048
                                 FStar_Pervasives_Native.None
                                in
                             let uu____10049 =
                               FStar_All.pipe_left mk1
                                 (FStar_Syntax_Syntax.Tm_let
                                    ((false,
                                       [mk_lb
                                          (attrs, (FStar_Util.Inr fv), t,
                                            t12,
                                            (t12.FStar_Syntax_Syntax.pos))]),
                                      body1))
                                in
                             (uu____10049, aq))
                    | LocalBinder (x,uu____10073) ->
                        let uu____10074 = desugar_term_aq env1 t2  in
                        (match uu____10074 with
                         | (body1,aq) ->
                             let body2 =
                               match pat1 with
                               | [] -> body1
                               | {
                                   FStar_Syntax_Syntax.v =
                                     FStar_Syntax_Syntax.Pat_wild uu____10088;
                                   FStar_Syntax_Syntax.p = uu____10089;_}::[]
                                   -> body1
                               | uu____10094 ->
                                   let uu____10097 =
                                     let uu____10104 =
                                       let uu____10105 =
                                         let uu____10128 =
                                           FStar_Syntax_Syntax.bv_to_name x
                                            in
                                         let uu____10129 =
                                           desugar_disjunctive_pattern pat1
                                             FStar_Pervasives_Native.None
                                             body1
                                            in
                                         (uu____10128, uu____10129)  in
                                       FStar_Syntax_Syntax.Tm_match
                                         uu____10105
                                        in
                                     FStar_Syntax_Syntax.mk uu____10104  in
                                   uu____10097 FStar_Pervasives_Native.None
                                     top.FStar_Parser_AST.range
                                in
                             let uu____10139 =
                               let uu____10142 =
                                 let uu____10143 =
                                   let uu____10156 =
                                     let uu____10157 =
                                       let uu____10158 =
                                         FStar_Syntax_Syntax.mk_binder x  in
                                       [uu____10158]  in
                                     FStar_Syntax_Subst.close uu____10157
                                       body2
                                      in
                                   ((false,
                                      [mk_lb
                                         (attrs, (FStar_Util.Inl x),
                                           (x.FStar_Syntax_Syntax.sort), t12,
                                           (t12.FStar_Syntax_Syntax.pos))]),
                                     uu____10156)
                                    in
                                 FStar_Syntax_Syntax.Tm_let uu____10143  in
                               FStar_All.pipe_left mk1 uu____10142  in
                             (uu____10139, aq))
                     in
                  (match uu____10008 with
                   | (tm,aq) ->
                       if is_mutable
                       then
                         let uu____10199 =
                           FStar_All.pipe_left mk1
                             (FStar_Syntax_Syntax.Tm_meta
                                (tm,
                                  (FStar_Syntax_Syntax.Meta_desugared
                                     FStar_Syntax_Syntax.Mutable_alloc)))
                            in
                         (uu____10199, aq)
                       else (tm, aq))
               in
            let uu____10211 = FStar_List.hd lbs  in
            (match uu____10211 with
             | (attrs,(head_pat,defn)) ->
                 let uu____10255 = is_rec || (is_app_pattern head_pat)  in
                 if uu____10255
                 then ds_let_rec_or_app ()
                 else ds_non_rec attrs head_pat defn body)
        | FStar_Parser_AST.If (t1,t2,t3) ->
            let x =
              FStar_Syntax_Syntax.new_bv
                (FStar_Pervasives_Native.Some (t3.FStar_Parser_AST.range))
                FStar_Syntax_Syntax.tun
               in
            let t_bool1 =
              let uu____10268 =
                let uu____10269 =
                  FStar_Syntax_Syntax.lid_as_fv FStar_Parser_Const.bool_lid
                    FStar_Syntax_Syntax.Delta_constant
                    FStar_Pervasives_Native.None
                   in
                FStar_Syntax_Syntax.Tm_fvar uu____10269  in
              mk1 uu____10268  in
            let uu____10270 = desugar_term_aq env t1  in
            (match uu____10270 with
             | (t1',aq1) ->
                 let uu____10281 = desugar_term_aq env t2  in
                 (match uu____10281 with
                  | (t2',aq2) ->
                      let uu____10292 = desugar_term_aq env t3  in
                      (match uu____10292 with
                       | (t3',aq3) ->
                           let uu____10303 =
                             let uu____10306 =
                               let uu____10307 =
                                 let uu____10330 =
                                   FStar_Syntax_Util.ascribe t1'
                                     ((FStar_Util.Inl t_bool1),
                                       FStar_Pervasives_Native.None)
                                    in
                                 let uu____10351 =
                                   let uu____10366 =
                                     let uu____10379 =
                                       FStar_Syntax_Syntax.withinfo
                                         (FStar_Syntax_Syntax.Pat_constant
                                            (FStar_Const.Const_bool true))
                                         t2.FStar_Parser_AST.range
                                        in
                                     (uu____10379,
                                       FStar_Pervasives_Native.None, t2')
                                      in
                                   let uu____10390 =
                                     let uu____10405 =
                                       let uu____10418 =
                                         FStar_Syntax_Syntax.withinfo
                                           (FStar_Syntax_Syntax.Pat_wild x)
                                           t3.FStar_Parser_AST.range
                                          in
                                       (uu____10418,
                                         FStar_Pervasives_Native.None, t3')
                                        in
                                     [uu____10405]  in
                                   uu____10366 :: uu____10390  in
                                 (uu____10330, uu____10351)  in
                               FStar_Syntax_Syntax.Tm_match uu____10307  in
                             mk1 uu____10306  in
                           (uu____10303, (join_aqs [aq1; aq2; aq3])))))
        | FStar_Parser_AST.TryWith (e,branches) ->
            let r = top.FStar_Parser_AST.range  in
            let handler = FStar_Parser_AST.mk_function branches r r  in
            let body =
              FStar_Parser_AST.mk_function
                [((FStar_Parser_AST.mk_pattern
                     (FStar_Parser_AST.PatConst FStar_Const.Const_unit) r),
                   FStar_Pervasives_Native.None, e)] r r
               in
            let a1 =
              FStar_Parser_AST.mk_term
                (FStar_Parser_AST.App
                   ((FStar_Parser_AST.mk_term
                       (FStar_Parser_AST.Var FStar_Parser_Const.try_with_lid)
                       r top.FStar_Parser_AST.level), body,
                     FStar_Parser_AST.Nothing)) r top.FStar_Parser_AST.level
               in
            let a2 =
              FStar_Parser_AST.mk_term
                (FStar_Parser_AST.App (a1, handler, FStar_Parser_AST.Nothing))
                r top.FStar_Parser_AST.level
               in
            desugar_term_aq env a2
        | FStar_Parser_AST.Match (e,branches) ->
            let desugar_branch uu____10579 =
              match uu____10579 with
              | (pat,wopt,b) ->
                  let uu____10601 = desugar_match_pat env pat  in
                  (match uu____10601 with
                   | (env1,pat1) ->
                       let wopt1 =
                         match wopt with
                         | FStar_Pervasives_Native.None  ->
                             FStar_Pervasives_Native.None
                         | FStar_Pervasives_Native.Some e1 ->
                             let uu____10626 = desugar_term env1 e1  in
                             FStar_Pervasives_Native.Some uu____10626
                          in
                       let uu____10627 = desugar_term_aq env1 b  in
                       (match uu____10627 with
                        | (b1,aq) ->
                            let uu____10640 =
                              desugar_disjunctive_pattern pat1 wopt1 b1  in
                            (uu____10640, aq)))
               in
            let uu____10645 = desugar_term_aq env e  in
            (match uu____10645 with
             | (e1,aq) ->
                 let uu____10656 =
                   let uu____10665 =
                     let uu____10676 = FStar_List.map desugar_branch branches
                        in
                     FStar_All.pipe_right uu____10676 FStar_List.unzip  in
                   FStar_All.pipe_right uu____10665
                     (fun uu____10740  ->
                        match uu____10740 with
                        | (x,y) -> ((FStar_List.flatten x), y))
                    in
                 (match uu____10656 with
                  | (brs,aqs) ->
                      let uu____10791 =
                        FStar_All.pipe_left mk1
                          (FStar_Syntax_Syntax.Tm_match (e1, brs))
                         in
                      (uu____10791, (join_aqs (aq :: aqs)))))
        | FStar_Parser_AST.Ascribed (e,t,tac_opt) ->
            let annot =
              let uu____10824 = is_comp_type env t  in
              if uu____10824
              then
                let uu____10831 = desugar_comp t.FStar_Parser_AST.range env t
                   in
                FStar_Util.Inr uu____10831
              else
                (let uu____10837 = desugar_term env t  in
                 FStar_Util.Inl uu____10837)
               in
            let tac_opt1 = FStar_Util.map_opt tac_opt (desugar_term env)  in
            let uu____10843 = desugar_term_aq env e  in
            (match uu____10843 with
             | (e1,aq) ->
                 let uu____10854 =
                   FStar_All.pipe_left mk1
                     (FStar_Syntax_Syntax.Tm_ascribed
                        (e1, (annot, tac_opt1), FStar_Pervasives_Native.None))
                    in
                 (uu____10854, aq))
        | FStar_Parser_AST.Record (uu____10883,[]) ->
            FStar_Errors.raise_error
              (FStar_Errors.Fatal_UnexpectedEmptyRecord,
                "Unexpected empty record") top.FStar_Parser_AST.range
        | FStar_Parser_AST.Record (eopt,fields) ->
            let record = check_fields env fields top.FStar_Parser_AST.range
               in
            let user_ns =
              let uu____10924 = FStar_List.hd fields  in
              match uu____10924 with | (f,uu____10936) -> f.FStar_Ident.ns
               in
            let get_field xopt f =
              let found =
                FStar_All.pipe_right fields
                  (FStar_Util.find_opt
                     (fun uu____10982  ->
                        match uu____10982 with
                        | (g,uu____10988) ->
                            f.FStar_Ident.idText =
                              (g.FStar_Ident.ident).FStar_Ident.idText))
                 in
              let fn = FStar_Ident.lid_of_ids (FStar_List.append user_ns [f])
                 in
              match found with
              | FStar_Pervasives_Native.Some (uu____10994,e) -> (fn, e)
              | FStar_Pervasives_Native.None  ->
                  (match xopt with
                   | FStar_Pervasives_Native.None  ->
                       let uu____11008 =
                         let uu____11013 =
                           FStar_Util.format2
                             "Field %s of record type %s is missing"
                             f.FStar_Ident.idText
                             (record.FStar_Syntax_DsEnv.typename).FStar_Ident.str
                            in
                         (FStar_Errors.Fatal_MissingFieldInRecord,
                           uu____11013)
                          in
                       FStar_Errors.raise_error uu____11008
                         top.FStar_Parser_AST.range
                   | FStar_Pervasives_Native.Some x ->
                       (fn,
                         (FStar_Parser_AST.mk_term
                            (FStar_Parser_AST.Project (x, fn))
                            x.FStar_Parser_AST.range x.FStar_Parser_AST.level)))
               in
            let user_constrname =
              FStar_Ident.lid_of_ids
                (FStar_List.append user_ns
                   [record.FStar_Syntax_DsEnv.constrname])
               in
            let recterm =
              match eopt with
              | FStar_Pervasives_Native.None  ->
                  let uu____11021 =
                    let uu____11032 =
                      FStar_All.pipe_right record.FStar_Syntax_DsEnv.fields
                        (FStar_List.map
                           (fun uu____11063  ->
                              match uu____11063 with
                              | (f,uu____11073) ->
                                  let uu____11074 =
                                    let uu____11075 =
                                      get_field FStar_Pervasives_Native.None
                                        f
                                       in
                                    FStar_All.pipe_left
                                      FStar_Pervasives_Native.snd uu____11075
                                     in
                                  (uu____11074, FStar_Parser_AST.Nothing)))
                       in
                    (user_constrname, uu____11032)  in
                  FStar_Parser_AST.Construct uu____11021
              | FStar_Pervasives_Native.Some e ->
                  let x = FStar_Ident.gen e.FStar_Parser_AST.range  in
                  let xterm =
                    let uu____11093 =
                      let uu____11094 = FStar_Ident.lid_of_ids [x]  in
                      FStar_Parser_AST.Var uu____11094  in
                    FStar_Parser_AST.mk_term uu____11093
                      x.FStar_Ident.idRange FStar_Parser_AST.Expr
                     in
                  let record1 =
                    let uu____11096 =
                      let uu____11109 =
                        FStar_All.pipe_right record.FStar_Syntax_DsEnv.fields
                          (FStar_List.map
                             (fun uu____11139  ->
                                match uu____11139 with
                                | (f,uu____11149) ->
                                    get_field
                                      (FStar_Pervasives_Native.Some xterm) f))
                         in
                      (FStar_Pervasives_Native.None, uu____11109)  in
                    FStar_Parser_AST.Record uu____11096  in
                  FStar_Parser_AST.Let
                    (FStar_Parser_AST.NoLetQualifier,
                      [(FStar_Pervasives_Native.None,
                         ((FStar_Parser_AST.mk_pattern
                             (FStar_Parser_AST.PatVar
                                (x, FStar_Pervasives_Native.None))
                             x.FStar_Ident.idRange), e))],
                      (FStar_Parser_AST.mk_term record1
                         top.FStar_Parser_AST.range
                         top.FStar_Parser_AST.level))
               in
            let recterm1 =
              FStar_Parser_AST.mk_term recterm top.FStar_Parser_AST.range
                top.FStar_Parser_AST.level
               in
            let uu____11209 = desugar_term_aq env recterm1  in
            (match uu____11209 with
             | (e,s) ->
                 (match e.FStar_Syntax_Syntax.n with
                  | FStar_Syntax_Syntax.Tm_app
                      ({
                         FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_fvar
                           fv;
                         FStar_Syntax_Syntax.pos = uu____11225;
                         FStar_Syntax_Syntax.vars = uu____11226;_},args)
                      ->
                      let uu____11248 =
                        let uu____11251 =
                          let uu____11252 =
                            let uu____11267 =
                              let uu____11268 =
                                FStar_Ident.set_lid_range
                                  (fv.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v
                                  e.FStar_Syntax_Syntax.pos
                                 in
                              let uu____11269 =
                                let uu____11272 =
                                  let uu____11273 =
                                    let uu____11280 =
                                      FStar_All.pipe_right
                                        record.FStar_Syntax_DsEnv.fields
                                        (FStar_List.map
                                           FStar_Pervasives_Native.fst)
                                       in
                                    ((record.FStar_Syntax_DsEnv.typename),
                                      uu____11280)
                                     in
                                  FStar_Syntax_Syntax.Record_ctor uu____11273
                                   in
                                FStar_Pervasives_Native.Some uu____11272  in
                              FStar_Syntax_Syntax.fvar uu____11268
                                FStar_Syntax_Syntax.Delta_constant
                                uu____11269
                               in
                            (uu____11267, args)  in
                          FStar_Syntax_Syntax.Tm_app uu____11252  in
                        FStar_All.pipe_left mk1 uu____11251  in
                      (uu____11248, s)
                  | uu____11309 -> (e, s)))
        | FStar_Parser_AST.Project (e,f) ->
            (FStar_Syntax_DsEnv.fail_if_qualified_by_curmodule env f;
             (let uu____11313 =
                FStar_Syntax_DsEnv.fail_or env
                  (FStar_Syntax_DsEnv.try_lookup_dc_by_field_name env) f
                 in
              match uu____11313 with
              | (constrname,is_rec) ->
                  let uu____11328 = desugar_term_aq env e  in
                  (match uu____11328 with
                   | (e1,s) ->
                       let projname =
                         FStar_Syntax_Util.mk_field_projector_name_from_ident
                           constrname f.FStar_Ident.ident
                          in
                       let qual =
                         if is_rec
                         then
                           FStar_Pervasives_Native.Some
                             (FStar_Syntax_Syntax.Record_projector
                                (constrname, (f.FStar_Ident.ident)))
                         else FStar_Pervasives_Native.None  in
                       let uu____11346 =
                         let uu____11349 =
                           let uu____11350 =
                             let uu____11365 =
                               let uu____11366 =
                                 let uu____11367 = FStar_Ident.range_of_lid f
                                    in
                                 FStar_Ident.set_lid_range projname
                                   uu____11367
                                  in
                               FStar_Syntax_Syntax.fvar uu____11366
                                 FStar_Syntax_Syntax.Delta_equational qual
                                in
                             let uu____11368 =
                               let uu____11371 =
                                 FStar_Syntax_Syntax.as_arg e1  in
                               [uu____11371]  in
                             (uu____11365, uu____11368)  in
                           FStar_Syntax_Syntax.Tm_app uu____11350  in
                         FStar_All.pipe_left mk1 uu____11349  in
                       (uu____11346, s))))
        | FStar_Parser_AST.NamedTyp (uu____11378,e) -> desugar_term_aq env e
        | FStar_Parser_AST.Paren e -> failwith "impossible"
        | FStar_Parser_AST.VQuote e ->
            let tm = desugar_term env e  in
            let uu____11387 =
              let uu____11388 = FStar_Syntax_Subst.compress tm  in
              uu____11388.FStar_Syntax_Syntax.n  in
            (match uu____11387 with
             | FStar_Syntax_Syntax.Tm_fvar fv ->
                 let uu____11396 =
                   let uu___129_11399 =
                     let uu____11400 =
                       let uu____11401 = FStar_Syntax_Syntax.lid_of_fv fv  in
                       FStar_Ident.string_of_lid uu____11401  in
                     FStar_Syntax_Util.exp_string uu____11400  in
                   {
                     FStar_Syntax_Syntax.n =
                       (uu___129_11399.FStar_Syntax_Syntax.n);
                     FStar_Syntax_Syntax.pos = (e.FStar_Parser_AST.range);
                     FStar_Syntax_Syntax.vars =
                       (uu___129_11399.FStar_Syntax_Syntax.vars)
                   }  in
                 (uu____11396, noaqs)
             | uu____11414 ->
                 let uu____11415 =
                   let uu____11420 =
                     let uu____11421 = FStar_Syntax_Print.term_to_string tm
                        in
                     Prims.strcat "VQuote, expected an fvar, got: "
                       uu____11421
                      in
                   (FStar_Errors.Fatal_UnexpectedTermVQuote, uu____11420)  in
                 FStar_Errors.raise_error uu____11415
                   top.FStar_Parser_AST.range)
        | FStar_Parser_AST.Quote (e,FStar_Parser_AST.Static ) ->
            let uu____11427 = desugar_term_aq env e  in
            (match uu____11427 with
             | (tm,vts) ->
                 let qi =
                   {
                     FStar_Syntax_Syntax.qkind =
                       FStar_Syntax_Syntax.Quote_static;
                     FStar_Syntax_Syntax.antiquotes = vts
                   }  in
                 let uu____11439 =
                   FStar_All.pipe_left mk1
                     (FStar_Syntax_Syntax.Tm_quoted (tm, qi))
                    in
                 (uu____11439, noaqs))
        | FStar_Parser_AST.Antiquote (b,e) ->
            let bv =
              FStar_Syntax_Syntax.new_bv
                (FStar_Pervasives_Native.Some (e.FStar_Parser_AST.range))
                FStar_Syntax_Syntax.tun
               in
            let uu____11459 = FStar_Syntax_Syntax.bv_to_name bv  in
            let uu____11460 =
              let uu____11469 =
                let uu____11476 = desugar_term env e  in (bv, b, uu____11476)
                 in
              [uu____11469]  in
            (uu____11459, uu____11460)
        | FStar_Parser_AST.Quote (e,FStar_Parser_AST.Dynamic ) ->
            let qi =
              {
                FStar_Syntax_Syntax.qkind = FStar_Syntax_Syntax.Quote_dynamic;
                FStar_Syntax_Syntax.antiquotes = []
              }  in
            let uu____11507 =
              let uu____11510 =
                let uu____11511 =
                  let uu____11518 = desugar_term env e  in (uu____11518, qi)
                   in
                FStar_Syntax_Syntax.Tm_quoted uu____11511  in
              FStar_All.pipe_left mk1 uu____11510  in
            (uu____11507, noaqs)
        | uu____11533 when
            top.FStar_Parser_AST.level = FStar_Parser_AST.Formula ->
            let uu____11534 = desugar_formula env top  in
            (uu____11534, noaqs)
        | uu____11545 ->
            let uu____11546 =
              let uu____11551 =
                let uu____11552 = FStar_Parser_AST.term_to_string top  in
                Prims.strcat "Unexpected term: " uu____11552  in
              (FStar_Errors.Fatal_UnexpectedTerm, uu____11551)  in
            FStar_Errors.raise_error uu____11546 top.FStar_Parser_AST.range

and (not_ascribed : FStar_Parser_AST.term -> Prims.bool) =
  fun t  ->
    match t.FStar_Parser_AST.tm with
    | FStar_Parser_AST.Ascribed uu____11558 -> false
    | uu____11567 -> true

and (is_synth_by_tactic :
  FStar_Syntax_DsEnv.env -> FStar_Parser_AST.term -> Prims.bool) =
  fun e  ->
    fun t  ->
      match t.FStar_Parser_AST.tm with
      | FStar_Parser_AST.App (l,r,FStar_Parser_AST.Hash ) ->
          is_synth_by_tactic e l
      | FStar_Parser_AST.Var lid ->
          let uu____11573 =
            FStar_Syntax_DsEnv.resolve_to_fully_qualified_name e lid  in
          (match uu____11573 with
           | FStar_Pervasives_Native.Some lid1 ->
               FStar_Ident.lid_equals lid1 FStar_Parser_Const.synth_lid
           | FStar_Pervasives_Native.None  -> false)
      | uu____11577 -> false

and (desugar_args :
  FStar_Syntax_DsEnv.env ->
    (FStar_Parser_AST.term,FStar_Parser_AST.imp)
      FStar_Pervasives_Native.tuple2 Prims.list ->
      (FStar_Syntax_Syntax.term,FStar_Syntax_Syntax.arg_qualifier
                                  FStar_Pervasives_Native.option)
        FStar_Pervasives_Native.tuple2 Prims.list)
  =
  fun env  ->
    fun args  ->
      FStar_All.pipe_right args
        (FStar_List.map
           (fun uu____11614  ->
              match uu____11614 with
              | (a,imp) ->
                  let uu____11627 = desugar_term env a  in
                  arg_withimp_e imp uu____11627))

and (desugar_comp :
  FStar_Range.range ->
    FStar_Syntax_DsEnv.env ->
      FStar_Parser_AST.term ->
        FStar_Syntax_Syntax.comp' FStar_Syntax_Syntax.syntax)
  =
  fun r  ->
    fun env  ->
      fun t  ->
        let fail1 err = FStar_Errors.raise_error err r  in
        let is_requires uu____11659 =
          match uu____11659 with
          | (t1,uu____11665) ->
              let uu____11666 =
                let uu____11667 = unparen t1  in
                uu____11667.FStar_Parser_AST.tm  in
              (match uu____11666 with
               | FStar_Parser_AST.Requires uu____11668 -> true
               | uu____11675 -> false)
           in
        let is_ensures uu____11685 =
          match uu____11685 with
          | (t1,uu____11691) ->
              let uu____11692 =
                let uu____11693 = unparen t1  in
                uu____11693.FStar_Parser_AST.tm  in
              (match uu____11692 with
               | FStar_Parser_AST.Ensures uu____11694 -> true
               | uu____11701 -> false)
           in
        let is_app head1 uu____11716 =
          match uu____11716 with
          | (t1,uu____11722) ->
              let uu____11723 =
                let uu____11724 = unparen t1  in
                uu____11724.FStar_Parser_AST.tm  in
              (match uu____11723 with
               | FStar_Parser_AST.App
                   ({ FStar_Parser_AST.tm = FStar_Parser_AST.Var d;
                      FStar_Parser_AST.range = uu____11726;
                      FStar_Parser_AST.level = uu____11727;_},uu____11728,uu____11729)
                   -> (d.FStar_Ident.ident).FStar_Ident.idText = head1
               | uu____11730 -> false)
           in
        let is_smt_pat uu____11740 =
          match uu____11740 with
          | (t1,uu____11746) ->
              let uu____11747 =
                let uu____11748 = unparen t1  in
                uu____11748.FStar_Parser_AST.tm  in
              (match uu____11747 with
               | FStar_Parser_AST.Construct
                   (cons1,({
                             FStar_Parser_AST.tm = FStar_Parser_AST.Construct
                               (smtpat,uu____11751);
                             FStar_Parser_AST.range = uu____11752;
                             FStar_Parser_AST.level = uu____11753;_},uu____11754)::uu____11755::[])
                   ->
                   (FStar_Ident.lid_equals cons1 FStar_Parser_Const.cons_lid)
                     &&
                     (FStar_Util.for_some
                        (fun s  -> smtpat.FStar_Ident.str = s)
                        ["SMTPat"; "SMTPatT"; "SMTPatOr"])
               | FStar_Parser_AST.Construct
                   (cons1,({
                             FStar_Parser_AST.tm = FStar_Parser_AST.Var
                               smtpat;
                             FStar_Parser_AST.range = uu____11794;
                             FStar_Parser_AST.level = uu____11795;_},uu____11796)::uu____11797::[])
                   ->
                   (FStar_Ident.lid_equals cons1 FStar_Parser_Const.cons_lid)
                     &&
                     (FStar_Util.for_some
                        (fun s  -> smtpat.FStar_Ident.str = s)
                        ["smt_pat"; "smt_pat_or"])
               | uu____11822 -> false)
           in
        let is_decreases = is_app "decreases"  in
        let pre_process_comp_typ t1 =
          let uu____11854 = head_and_args t1  in
          match uu____11854 with
          | (head1,args) ->
              (match head1.FStar_Parser_AST.tm with
               | FStar_Parser_AST.Name lemma when
                   (lemma.FStar_Ident.ident).FStar_Ident.idText = "Lemma" ->
                   let unit_tm =
                     ((FStar_Parser_AST.mk_term
                         (FStar_Parser_AST.Name FStar_Parser_Const.unit_lid)
                         t1.FStar_Parser_AST.range
                         FStar_Parser_AST.Type_level),
                       FStar_Parser_AST.Nothing)
                      in
                   let nil_pat =
                     ((FStar_Parser_AST.mk_term
                         (FStar_Parser_AST.Name FStar_Parser_Const.nil_lid)
                         t1.FStar_Parser_AST.range FStar_Parser_AST.Expr),
                       FStar_Parser_AST.Nothing)
                      in
                   let req_true =
                     let req =
                       FStar_Parser_AST.Requires
                         ((FStar_Parser_AST.mk_term
                             (FStar_Parser_AST.Name
                                FStar_Parser_Const.true_lid)
                             t1.FStar_Parser_AST.range
                             FStar_Parser_AST.Formula),
                           FStar_Pervasives_Native.None)
                        in
                     ((FStar_Parser_AST.mk_term req t1.FStar_Parser_AST.range
                         FStar_Parser_AST.Type_level),
                       FStar_Parser_AST.Nothing)
                      in
                   let thunk_ens_ ens =
                     let wildpat =
                       FStar_Parser_AST.mk_pattern FStar_Parser_AST.PatWild
                         ens.FStar_Parser_AST.range
                        in
                     FStar_Parser_AST.mk_term
                       (FStar_Parser_AST.Abs ([wildpat], ens))
                       ens.FStar_Parser_AST.range FStar_Parser_AST.Expr
                      in
                   let thunk_ens uu____11952 =
                     match uu____11952 with
                     | (e,i) ->
                         let uu____11963 = thunk_ens_ e  in (uu____11963, i)
                      in
                   let fail_lemma uu____11975 =
                     let expected_one_of =
                       ["Lemma post";
                       "Lemma (ensures post)";
                       "Lemma (requires pre) (ensures post)";
                       "Lemma post [SMTPat ...]";
                       "Lemma (ensures post) [SMTPat ...]";
                       "Lemma (ensures post) (decreases d)";
                       "Lemma (ensures post) (decreases d) [SMTPat ...]";
                       "Lemma (requires pre) (ensures post) (decreases d)";
                       "Lemma (requires pre) (ensures post) [SMTPat ...]";
                       "Lemma (requires pre) (ensures post) (decreases d) [SMTPat ...]"]
                        in
                     let msg = FStar_String.concat "\n\t" expected_one_of  in
                     FStar_Errors.raise_error
                       (FStar_Errors.Fatal_InvalidLemmaArgument,
                         (Prims.strcat
                            "Invalid arguments to 'Lemma'; expected one of the following:\n\t"
                            msg)) t1.FStar_Parser_AST.range
                      in
                   let args1 =
                     match args with
                     | [] -> fail_lemma ()
                     | req::[] when is_requires req -> fail_lemma ()
                     | smtpat::[] when is_smt_pat smtpat -> fail_lemma ()
                     | dec::[] when is_decreases dec -> fail_lemma ()
                     | ens::[] ->
                         let uu____12055 =
                           let uu____12062 =
                             let uu____12069 = thunk_ens ens  in
                             [uu____12069; nil_pat]  in
                           req_true :: uu____12062  in
                         unit_tm :: uu____12055
                     | req::ens::[] when
                         (is_requires req) && (is_ensures ens) ->
                         let uu____12116 =
                           let uu____12123 =
                             let uu____12130 = thunk_ens ens  in
                             [uu____12130; nil_pat]  in
                           req :: uu____12123  in
                         unit_tm :: uu____12116
                     | ens::smtpat::[] when
                         (((let uu____12179 = is_requires ens  in
                            Prims.op_Negation uu____12179) &&
                             (let uu____12181 = is_smt_pat ens  in
                              Prims.op_Negation uu____12181))
                            &&
                            (let uu____12183 = is_decreases ens  in
                             Prims.op_Negation uu____12183))
                           && (is_smt_pat smtpat)
                         ->
                         let uu____12184 =
                           let uu____12191 =
                             let uu____12198 = thunk_ens ens  in
                             [uu____12198; smtpat]  in
                           req_true :: uu____12191  in
                         unit_tm :: uu____12184
                     | ens::dec::[] when
                         (is_ensures ens) && (is_decreases dec) ->
                         let uu____12245 =
                           let uu____12252 =
                             let uu____12259 = thunk_ens ens  in
                             [uu____12259; nil_pat; dec]  in
                           req_true :: uu____12252  in
                         unit_tm :: uu____12245
                     | ens::dec::smtpat::[] when
                         ((is_ensures ens) && (is_decreases dec)) &&
                           (is_smt_pat smtpat)
                         ->
                         let uu____12319 =
                           let uu____12326 =
                             let uu____12333 = thunk_ens ens  in
                             [uu____12333; smtpat; dec]  in
                           req_true :: uu____12326  in
                         unit_tm :: uu____12319
                     | req::ens::dec::[] when
                         ((is_requires req) && (is_ensures ens)) &&
                           (is_decreases dec)
                         ->
                         let uu____12393 =
                           let uu____12400 =
                             let uu____12407 = thunk_ens ens  in
                             [uu____12407; nil_pat; dec]  in
                           req :: uu____12400  in
                         unit_tm :: uu____12393
                     | req::ens::smtpat::[] when
                         ((is_requires req) && (is_ensures ens)) &&
                           (is_smt_pat smtpat)
                         ->
                         let uu____12467 =
                           let uu____12474 =
                             let uu____12481 = thunk_ens ens  in
                             [uu____12481; smtpat]  in
                           req :: uu____12474  in
                         unit_tm :: uu____12467
                     | req::ens::dec::smtpat::[] when
                         (((is_requires req) && (is_ensures ens)) &&
                            (is_smt_pat smtpat))
                           && (is_decreases dec)
                         ->
                         let uu____12546 =
                           let uu____12553 =
                             let uu____12560 = thunk_ens ens  in
                             [uu____12560; dec; smtpat]  in
                           req :: uu____12553  in
                         unit_tm :: uu____12546
                     | _other -> fail_lemma ()  in
                   let head_and_attributes =
                     FStar_Syntax_DsEnv.fail_or env
                       (FStar_Syntax_DsEnv.try_lookup_effect_name_and_attributes
                          env) lemma
                      in
                   (head_and_attributes, args1)
               | FStar_Parser_AST.Name l when
                   FStar_Syntax_DsEnv.is_effect_name env l ->
                   let uu____12622 =
                     FStar_Syntax_DsEnv.fail_or env
                       (FStar_Syntax_DsEnv.try_lookup_effect_name_and_attributes
                          env) l
                      in
                   (uu____12622, args)
               | FStar_Parser_AST.Name l when
                   (let uu____12650 = FStar_Syntax_DsEnv.current_module env
                       in
                    FStar_Ident.lid_equals uu____12650
                      FStar_Parser_Const.prims_lid)
                     && ((l.FStar_Ident.ident).FStar_Ident.idText = "Tot")
                   ->
                   let uu____12651 =
                     let uu____12658 =
                       FStar_Ident.set_lid_range
                         FStar_Parser_Const.effect_Tot_lid
                         head1.FStar_Parser_AST.range
                        in
                     (uu____12658, [])  in
                   (uu____12651, args)
               | FStar_Parser_AST.Name l when
                   (let uu____12676 = FStar_Syntax_DsEnv.current_module env
                       in
                    FStar_Ident.lid_equals uu____12676
                      FStar_Parser_Const.prims_lid)
                     && ((l.FStar_Ident.ident).FStar_Ident.idText = "GTot")
                   ->
                   let uu____12677 =
                     let uu____12684 =
                       FStar_Ident.set_lid_range
                         FStar_Parser_Const.effect_GTot_lid
                         head1.FStar_Parser_AST.range
                        in
                     (uu____12684, [])  in
                   (uu____12677, args)
               | FStar_Parser_AST.Name l when
                   (((l.FStar_Ident.ident).FStar_Ident.idText = "Type") ||
                      ((l.FStar_Ident.ident).FStar_Ident.idText = "Type0"))
                     || ((l.FStar_Ident.ident).FStar_Ident.idText = "Effect")
                   ->
                   let uu____12700 =
                     let uu____12707 =
                       FStar_Ident.set_lid_range
                         FStar_Parser_Const.effect_Tot_lid
                         head1.FStar_Parser_AST.range
                        in
                     (uu____12707, [])  in
                   (uu____12700, [(t1, FStar_Parser_AST.Nothing)])
               | uu____12730 ->
                   let default_effect =
                     let uu____12732 = FStar_Options.ml_ish ()  in
                     if uu____12732
                     then FStar_Parser_Const.effect_ML_lid
                     else
                       ((let uu____12735 =
                           FStar_Options.warn_default_effects ()  in
                         if uu____12735
                         then
                           FStar_Errors.log_issue
                             head1.FStar_Parser_AST.range
                             (FStar_Errors.Warning_UseDefaultEffect,
                               "Using default effect Tot")
                         else ());
                        FStar_Parser_Const.effect_Tot_lid)
                      in
                   let uu____12737 =
                     let uu____12744 =
                       FStar_Ident.set_lid_range default_effect
                         head1.FStar_Parser_AST.range
                        in
                     (uu____12744, [])  in
                   (uu____12737, [(t1, FStar_Parser_AST.Nothing)]))
           in
        let uu____12767 = pre_process_comp_typ t  in
        match uu____12767 with
        | ((eff,cattributes),args) ->
            (if (FStar_List.length args) = (Prims.parse_int "0")
             then
               (let uu____12816 =
                  let uu____12821 =
                    let uu____12822 = FStar_Syntax_Print.lid_to_string eff
                       in
                    FStar_Util.format1 "Not enough args to effect %s"
                      uu____12822
                     in
                  (FStar_Errors.Fatal_NotEnoughArgsToEffect, uu____12821)  in
                fail1 uu____12816)
             else ();
             (let is_universe uu____12833 =
                match uu____12833 with
                | (uu____12838,imp) -> imp = FStar_Parser_AST.UnivApp  in
              let uu____12840 = FStar_Util.take is_universe args  in
              match uu____12840 with
              | (universes,args1) ->
                  let universes1 =
                    FStar_List.map
                      (fun uu____12899  ->
                         match uu____12899 with
                         | (u,imp) -> desugar_universe u) universes
                     in
                  let uu____12906 =
                    let uu____12921 = FStar_List.hd args1  in
                    let uu____12930 = FStar_List.tl args1  in
                    (uu____12921, uu____12930)  in
                  (match uu____12906 with
                   | (result_arg,rest) ->
                       let result_typ =
                         desugar_typ env
                           (FStar_Pervasives_Native.fst result_arg)
                          in
                       let rest1 = desugar_args env rest  in
                       let uu____12985 =
                         let is_decrease uu____13023 =
                           match uu____13023 with
                           | (t1,uu____13033) ->
                               (match t1.FStar_Syntax_Syntax.n with
                                | FStar_Syntax_Syntax.Tm_app
                                    ({
                                       FStar_Syntax_Syntax.n =
                                         FStar_Syntax_Syntax.Tm_fvar fv;
                                       FStar_Syntax_Syntax.pos = uu____13043;
                                       FStar_Syntax_Syntax.vars = uu____13044;_},uu____13045::[])
                                    ->
                                    FStar_Syntax_Syntax.fv_eq_lid fv
                                      FStar_Parser_Const.decreases_lid
                                | uu____13076 -> false)
                            in
                         FStar_All.pipe_right rest1
                           (FStar_List.partition is_decrease)
                          in
                       (match uu____12985 with
                        | (dec,rest2) ->
                            let decreases_clause =
                              FStar_All.pipe_right dec
                                (FStar_List.map
                                   (fun uu____13190  ->
                                      match uu____13190 with
                                      | (t1,uu____13200) ->
                                          (match t1.FStar_Syntax_Syntax.n
                                           with
                                           | FStar_Syntax_Syntax.Tm_app
                                               (uu____13209,(arg,uu____13211)::[])
                                               ->
                                               FStar_Syntax_Syntax.DECREASES
                                                 arg
                                           | uu____13240 -> failwith "impos")))
                               in
                            let no_additional_args =
                              let is_empty l =
                                match l with
                                | [] -> true
                                | uu____13257 -> false  in
                              (((is_empty decreases_clause) &&
                                  (is_empty rest2))
                                 && (is_empty cattributes))
                                && (is_empty universes1)
                               in
                            let uu____13268 =
                              no_additional_args &&
                                (FStar_Ident.lid_equals eff
                                   FStar_Parser_Const.effect_Tot_lid)
                               in
                            if uu____13268
                            then FStar_Syntax_Syntax.mk_Total result_typ
                            else
                              (let uu____13272 =
                                 no_additional_args &&
                                   (FStar_Ident.lid_equals eff
                                      FStar_Parser_Const.effect_GTot_lid)
                                  in
                               if uu____13272
                               then FStar_Syntax_Syntax.mk_GTotal result_typ
                               else
                                 (let flags1 =
                                    let uu____13279 =
                                      FStar_Ident.lid_equals eff
                                        FStar_Parser_Const.effect_Lemma_lid
                                       in
                                    if uu____13279
                                    then [FStar_Syntax_Syntax.LEMMA]
                                    else
                                      (let uu____13283 =
                                         FStar_Ident.lid_equals eff
                                           FStar_Parser_Const.effect_Tot_lid
                                          in
                                       if uu____13283
                                       then [FStar_Syntax_Syntax.TOTAL]
                                       else
                                         (let uu____13287 =
                                            FStar_Ident.lid_equals eff
                                              FStar_Parser_Const.effect_ML_lid
                                             in
                                          if uu____13287
                                          then [FStar_Syntax_Syntax.MLEFFECT]
                                          else
                                            (let uu____13291 =
                                               FStar_Ident.lid_equals eff
                                                 FStar_Parser_Const.effect_GTot_lid
                                                in
                                             if uu____13291
                                             then
                                               [FStar_Syntax_Syntax.SOMETRIVIAL]
                                             else [])))
                                     in
                                  let flags2 =
                                    FStar_List.append flags1 cattributes  in
                                  let rest3 =
                                    let uu____13309 =
                                      FStar_Ident.lid_equals eff
                                        FStar_Parser_Const.effect_Lemma_lid
                                       in
                                    if uu____13309
                                    then
                                      match rest2 with
                                      | req::ens::(pat,aq)::[] ->
                                          let pat1 =
                                            match pat.FStar_Syntax_Syntax.n
                                            with
                                            | FStar_Syntax_Syntax.Tm_fvar fv
                                                when
                                                FStar_Syntax_Syntax.fv_eq_lid
                                                  fv
                                                  FStar_Parser_Const.nil_lid
                                                ->
                                                let nil =
                                                  FStar_Syntax_Syntax.mk_Tm_uinst
                                                    pat
                                                    [FStar_Syntax_Syntax.U_zero]
                                                   in
                                                let pattern =
                                                  let uu____13398 =
                                                    FStar_Ident.set_lid_range
                                                      FStar_Parser_Const.pattern_lid
                                                      pat.FStar_Syntax_Syntax.pos
                                                     in
                                                  FStar_Syntax_Syntax.fvar
                                                    uu____13398
                                                    FStar_Syntax_Syntax.Delta_constant
                                                    FStar_Pervasives_Native.None
                                                   in
                                                FStar_Syntax_Syntax.mk_Tm_app
                                                  nil
                                                  [(pattern,
                                                     (FStar_Pervasives_Native.Some
                                                        FStar_Syntax_Syntax.imp_tag))]
                                                  FStar_Pervasives_Native.None
                                                  pat.FStar_Syntax_Syntax.pos
                                            | uu____13413 -> pat  in
                                          let uu____13414 =
                                            let uu____13425 =
                                              let uu____13436 =
                                                let uu____13445 =
                                                  FStar_Syntax_Syntax.mk
                                                    (FStar_Syntax_Syntax.Tm_meta
                                                       (pat1,
                                                         (FStar_Syntax_Syntax.Meta_desugared
                                                            FStar_Syntax_Syntax.Meta_smt_pat)))
                                                    FStar_Pervasives_Native.None
                                                    pat1.FStar_Syntax_Syntax.pos
                                                   in
                                                (uu____13445, aq)  in
                                              [uu____13436]  in
                                            ens :: uu____13425  in
                                          req :: uu____13414
                                      | uu____13486 -> rest2
                                    else rest2  in
                                  FStar_Syntax_Syntax.mk_Comp
                                    {
                                      FStar_Syntax_Syntax.comp_univs =
                                        universes1;
                                      FStar_Syntax_Syntax.effect_name = eff;
                                      FStar_Syntax_Syntax.result_typ =
                                        result_typ;
                                      FStar_Syntax_Syntax.effect_args = rest3;
                                      FStar_Syntax_Syntax.flags =
                                        (FStar_List.append flags2
                                           decreases_clause)
                                    }))))))

and (desugar_formula :
  env_t -> FStar_Parser_AST.term -> FStar_Syntax_Syntax.term) =
  fun env  ->
    fun f  ->
      let connective s =
        match s with
        | "/\\" -> FStar_Pervasives_Native.Some FStar_Parser_Const.and_lid
        | "\\/" -> FStar_Pervasives_Native.Some FStar_Parser_Const.or_lid
        | "==>" -> FStar_Pervasives_Native.Some FStar_Parser_Const.imp_lid
        | "<==>" -> FStar_Pervasives_Native.Some FStar_Parser_Const.iff_lid
        | "~" -> FStar_Pervasives_Native.Some FStar_Parser_Const.not_lid
        | uu____13510 -> FStar_Pervasives_Native.None  in
      let mk1 t =
        FStar_Syntax_Syntax.mk t FStar_Pervasives_Native.None
          f.FStar_Parser_AST.range
         in
      let setpos t =
        let uu___130_13531 = t  in
        {
          FStar_Syntax_Syntax.n = (uu___130_13531.FStar_Syntax_Syntax.n);
          FStar_Syntax_Syntax.pos = (f.FStar_Parser_AST.range);
          FStar_Syntax_Syntax.vars =
            (uu___130_13531.FStar_Syntax_Syntax.vars)
        }  in
      let desugar_quant q b pats body =
        let tk =
          desugar_binder env
            (let uu___131_13573 = b  in
             {
               FStar_Parser_AST.b = (uu___131_13573.FStar_Parser_AST.b);
               FStar_Parser_AST.brange =
                 (uu___131_13573.FStar_Parser_AST.brange);
               FStar_Parser_AST.blevel = FStar_Parser_AST.Formula;
               FStar_Parser_AST.aqual =
                 (uu___131_13573.FStar_Parser_AST.aqual)
             })
           in
        let desugar_pats env1 pats1 =
          FStar_List.map
            (fun es  ->
               FStar_All.pipe_right es
                 (FStar_List.map
                    (fun e  ->
                       let uu____13636 = desugar_term env1 e  in
                       FStar_All.pipe_left
                         (arg_withimp_t FStar_Parser_AST.Nothing) uu____13636)))
            pats1
           in
        match tk with
        | (FStar_Pervasives_Native.Some a,k) ->
            let uu____13649 = FStar_Syntax_DsEnv.push_bv env a  in
            (match uu____13649 with
             | (env1,a1) ->
                 let a2 =
                   let uu___132_13659 = a1  in
                   {
                     FStar_Syntax_Syntax.ppname =
                       (uu___132_13659.FStar_Syntax_Syntax.ppname);
                     FStar_Syntax_Syntax.index =
                       (uu___132_13659.FStar_Syntax_Syntax.index);
                     FStar_Syntax_Syntax.sort = k
                   }  in
                 let pats1 = desugar_pats env1 pats  in
                 let body1 = desugar_formula env1 body  in
                 let body2 =
                   match pats1 with
                   | [] -> body1
                   | uu____13681 ->
                       mk1
                         (FStar_Syntax_Syntax.Tm_meta
                            (body1, (FStar_Syntax_Syntax.Meta_pattern pats1)))
                    in
                 let body3 =
                   let uu____13695 =
                     let uu____13698 =
                       let uu____13699 = FStar_Syntax_Syntax.mk_binder a2  in
                       [uu____13699]  in
                     no_annot_abs uu____13698 body2  in
                   FStar_All.pipe_left setpos uu____13695  in
                 let uu____13704 =
                   let uu____13705 =
                     let uu____13720 =
                       let uu____13721 =
                         FStar_Ident.set_lid_range q
                           b.FStar_Parser_AST.brange
                          in
                       FStar_Syntax_Syntax.fvar uu____13721
                         (FStar_Syntax_Syntax.Delta_defined_at_level
                            (Prims.parse_int "1"))
                         FStar_Pervasives_Native.None
                        in
                     let uu____13722 =
                       let uu____13725 = FStar_Syntax_Syntax.as_arg body3  in
                       [uu____13725]  in
                     (uu____13720, uu____13722)  in
                   FStar_Syntax_Syntax.Tm_app uu____13705  in
                 FStar_All.pipe_left mk1 uu____13704)
        | uu____13730 -> failwith "impossible"  in
      let push_quant q binders pats body =
        match binders with
        | b::b'::_rest ->
            let rest = b' :: _rest  in
            let body1 =
              let uu____13810 = q (rest, pats, body)  in
              let uu____13817 =
                FStar_Range.union_ranges b'.FStar_Parser_AST.brange
                  body.FStar_Parser_AST.range
                 in
              FStar_Parser_AST.mk_term uu____13810 uu____13817
                FStar_Parser_AST.Formula
               in
            let uu____13818 = q ([b], [], body1)  in
            FStar_Parser_AST.mk_term uu____13818 f.FStar_Parser_AST.range
              FStar_Parser_AST.Formula
        | uu____13827 -> failwith "impossible"  in
      let uu____13830 =
        let uu____13831 = unparen f  in uu____13831.FStar_Parser_AST.tm  in
      match uu____13830 with
      | FStar_Parser_AST.Labeled (f1,l,p) ->
          let f2 = desugar_formula env f1  in
          FStar_All.pipe_left mk1
            (FStar_Syntax_Syntax.Tm_meta
               (f2,
                 (FStar_Syntax_Syntax.Meta_labeled
                    (l, (f2.FStar_Syntax_Syntax.pos), p))))
      | FStar_Parser_AST.QForall ([],uu____13838,uu____13839) ->
          failwith "Impossible: Quantifier without binders"
      | FStar_Parser_AST.QExists ([],uu____13850,uu____13851) ->
          failwith "Impossible: Quantifier without binders"
      | FStar_Parser_AST.QForall (_1::_2::_3,pats,body) ->
          let binders = _1 :: _2 :: _3  in
          let uu____13882 =
            push_quant (fun x  -> FStar_Parser_AST.QForall x) binders pats
              body
             in
          desugar_formula env uu____13882
      | FStar_Parser_AST.QExists (_1::_2::_3,pats,body) ->
          let binders = _1 :: _2 :: _3  in
          let uu____13918 =
            push_quant (fun x  -> FStar_Parser_AST.QExists x) binders pats
              body
             in
          desugar_formula env uu____13918
      | FStar_Parser_AST.QForall (b::[],pats,body) ->
          desugar_quant FStar_Parser_Const.forall_lid b pats body
      | FStar_Parser_AST.QExists (b::[],pats,body) ->
          desugar_quant FStar_Parser_Const.exists_lid b pats body
      | FStar_Parser_AST.Paren f1 -> failwith "impossible"
      | uu____13961 -> desugar_term env f

and (typars_of_binders :
  FStar_Syntax_DsEnv.env ->
    FStar_Parser_AST.binder Prims.list ->
      (FStar_Syntax_DsEnv.env,(FStar_Syntax_Syntax.bv,FStar_Syntax_Syntax.arg_qualifier
                                                        FStar_Pervasives_Native.option)
                                FStar_Pervasives_Native.tuple2 Prims.list)
        FStar_Pervasives_Native.tuple2)
  =
  fun env  ->
    fun bs  ->
      let uu____13966 =
        FStar_List.fold_left
          (fun uu____14002  ->
             fun b  ->
               match uu____14002 with
               | (env1,out) ->
                   let tk =
                     desugar_binder env1
                       (let uu___133_14054 = b  in
                        {
                          FStar_Parser_AST.b =
                            (uu___133_14054.FStar_Parser_AST.b);
                          FStar_Parser_AST.brange =
                            (uu___133_14054.FStar_Parser_AST.brange);
                          FStar_Parser_AST.blevel = FStar_Parser_AST.Formula;
                          FStar_Parser_AST.aqual =
                            (uu___133_14054.FStar_Parser_AST.aqual)
                        })
                      in
                   (match tk with
                    | (FStar_Pervasives_Native.Some a,k) ->
                        let uu____14071 = FStar_Syntax_DsEnv.push_bv env1 a
                           in
                        (match uu____14071 with
                         | (env2,a1) ->
                             let a2 =
                               let uu___134_14091 = a1  in
                               {
                                 FStar_Syntax_Syntax.ppname =
                                   (uu___134_14091.FStar_Syntax_Syntax.ppname);
                                 FStar_Syntax_Syntax.index =
                                   (uu___134_14091.FStar_Syntax_Syntax.index);
                                 FStar_Syntax_Syntax.sort = k
                               }  in
                             (env2,
                               ((a2, (trans_aqual b.FStar_Parser_AST.aqual))
                               :: out)))
                    | uu____14108 ->
                        FStar_Errors.raise_error
                          (FStar_Errors.Fatal_UnexpectedBinder,
                            "Unexpected binder") b.FStar_Parser_AST.brange))
          (env, []) bs
         in
      match uu____13966 with | (env1,tpars) -> (env1, (FStar_List.rev tpars))

and (desugar_binder :
  FStar_Syntax_DsEnv.env ->
    FStar_Parser_AST.binder ->
      (FStar_Ident.ident FStar_Pervasives_Native.option,FStar_Syntax_Syntax.term)
        FStar_Pervasives_Native.tuple2)
  =
  fun env  ->
    fun b  ->
      match b.FStar_Parser_AST.b with
      | FStar_Parser_AST.TAnnotated (x,t) ->
          let uu____14195 = desugar_typ env t  in
          ((FStar_Pervasives_Native.Some x), uu____14195)
      | FStar_Parser_AST.Annotated (x,t) ->
          let uu____14200 = desugar_typ env t  in
          ((FStar_Pervasives_Native.Some x), uu____14200)
      | FStar_Parser_AST.TVariable x ->
          let uu____14204 =
            FStar_Syntax_Syntax.mk
              (FStar_Syntax_Syntax.Tm_type FStar_Syntax_Syntax.U_unknown)
              FStar_Pervasives_Native.None x.FStar_Ident.idRange
             in
          ((FStar_Pervasives_Native.Some x), uu____14204)
      | FStar_Parser_AST.NoName t ->
          let uu____14212 = desugar_typ env t  in
          (FStar_Pervasives_Native.None, uu____14212)
      | FStar_Parser_AST.Variable x ->
          ((FStar_Pervasives_Native.Some x), FStar_Syntax_Syntax.tun)

let (mk_data_discriminators :
  FStar_Syntax_Syntax.qualifier Prims.list ->
    FStar_Syntax_DsEnv.env ->
      FStar_Ident.lident Prims.list -> FStar_Syntax_Syntax.sigelt Prims.list)
  =
  fun quals  ->
    fun env  ->
      fun datas  ->
        let quals1 =
          FStar_All.pipe_right quals
            (FStar_List.filter
               (fun uu___96_14251  ->
                  match uu___96_14251 with
                  | FStar_Syntax_Syntax.Abstract  -> true
                  | FStar_Syntax_Syntax.Private  -> true
                  | uu____14252 -> false))
           in
        let quals2 q =
          let uu____14265 =
            (let uu____14268 = FStar_Syntax_DsEnv.iface env  in
             Prims.op_Negation uu____14268) ||
              (FStar_Syntax_DsEnv.admitted_iface env)
             in
          if uu____14265
          then FStar_List.append (FStar_Syntax_Syntax.Assumption :: q) quals1
          else FStar_List.append q quals1  in
        FStar_All.pipe_right datas
          (FStar_List.map
             (fun d  ->
                let disc_name = FStar_Syntax_Util.mk_discriminator d  in
                let uu____14282 = FStar_Ident.range_of_lid disc_name  in
                let uu____14283 =
                  quals2
                    [FStar_Syntax_Syntax.OnlyName;
                    FStar_Syntax_Syntax.Discriminator d]
                   in
                {
                  FStar_Syntax_Syntax.sigel =
                    (FStar_Syntax_Syntax.Sig_declare_typ
                       (disc_name, [], FStar_Syntax_Syntax.tun));
                  FStar_Syntax_Syntax.sigrng = uu____14282;
                  FStar_Syntax_Syntax.sigquals = uu____14283;
                  FStar_Syntax_Syntax.sigmeta =
                    FStar_Syntax_Syntax.default_sigmeta;
                  FStar_Syntax_Syntax.sigattrs = []
                }))
  
let (mk_indexed_projector_names :
  FStar_Syntax_Syntax.qualifier Prims.list ->
    FStar_Syntax_Syntax.fv_qual ->
      FStar_Syntax_DsEnv.env ->
        FStar_Ident.lident ->
          FStar_Syntax_Syntax.binder Prims.list ->
            FStar_Syntax_Syntax.sigelt Prims.list)
  =
  fun iquals  ->
    fun fvq  ->
      fun env  ->
        fun lid  ->
          fun fields  ->
            let p = FStar_Ident.range_of_lid lid  in
            let uu____14324 =
              FStar_All.pipe_right fields
                (FStar_List.mapi
                   (fun i  ->
                      fun uu____14354  ->
                        match uu____14354 with
                        | (x,uu____14362) ->
                            let uu____14363 =
                              FStar_Syntax_Util.mk_field_projector_name lid x
                                i
                               in
                            (match uu____14363 with
                             | (field_name,uu____14371) ->
                                 let only_decl =
                                   ((let uu____14375 =
                                       FStar_Syntax_DsEnv.current_module env
                                        in
                                     FStar_Ident.lid_equals
                                       FStar_Parser_Const.prims_lid
                                       uu____14375)
                                      ||
                                      (fvq <> FStar_Syntax_Syntax.Data_ctor))
                                     ||
                                     (let uu____14377 =
                                        let uu____14378 =
                                          FStar_Syntax_DsEnv.current_module
                                            env
                                           in
                                        uu____14378.FStar_Ident.str  in
                                      FStar_Options.dont_gen_projectors
                                        uu____14377)
                                    in
                                 let no_decl =
                                   FStar_Syntax_Syntax.is_type
                                     x.FStar_Syntax_Syntax.sort
                                    in
                                 let quals q =
                                   if only_decl
                                   then
                                     let uu____14394 =
                                       FStar_List.filter
                                         (fun uu___97_14398  ->
                                            match uu___97_14398 with
                                            | FStar_Syntax_Syntax.Abstract 
                                                -> false
                                            | uu____14399 -> true) q
                                        in
                                     FStar_Syntax_Syntax.Assumption ::
                                       uu____14394
                                   else q  in
                                 let quals1 =
                                   let iquals1 =
                                     FStar_All.pipe_right iquals
                                       (FStar_List.filter
                                          (fun uu___98_14412  ->
                                             match uu___98_14412 with
                                             | FStar_Syntax_Syntax.Abstract 
                                                 -> true
                                             | FStar_Syntax_Syntax.Private 
                                                 -> true
                                             | uu____14413 -> false))
                                      in
                                   quals (FStar_Syntax_Syntax.OnlyName ::
                                     (FStar_Syntax_Syntax.Projector
                                        (lid, (x.FStar_Syntax_Syntax.ppname)))
                                     :: iquals1)
                                    in
                                 let decl =
                                   let uu____14415 =
                                     FStar_Ident.range_of_lid field_name  in
                                   {
                                     FStar_Syntax_Syntax.sigel =
                                       (FStar_Syntax_Syntax.Sig_declare_typ
                                          (field_name, [],
                                            FStar_Syntax_Syntax.tun));
                                     FStar_Syntax_Syntax.sigrng = uu____14415;
                                     FStar_Syntax_Syntax.sigquals = quals1;
                                     FStar_Syntax_Syntax.sigmeta =
                                       FStar_Syntax_Syntax.default_sigmeta;
                                     FStar_Syntax_Syntax.sigattrs = []
                                   }  in
                                 if only_decl
                                 then [decl]
                                 else
                                   (let dd =
                                      let uu____14422 =
                                        FStar_All.pipe_right quals1
                                          (FStar_List.contains
                                             FStar_Syntax_Syntax.Abstract)
                                         in
                                      if uu____14422
                                      then
                                        FStar_Syntax_Syntax.Delta_abstract
                                          FStar_Syntax_Syntax.Delta_equational
                                      else
                                        FStar_Syntax_Syntax.Delta_equational
                                       in
                                    let lb =
                                      let uu____14427 =
                                        let uu____14432 =
                                          FStar_Syntax_Syntax.lid_as_fv
                                            field_name dd
                                            FStar_Pervasives_Native.None
                                           in
                                        FStar_Util.Inr uu____14432  in
                                      {
                                        FStar_Syntax_Syntax.lbname =
                                          uu____14427;
                                        FStar_Syntax_Syntax.lbunivs = [];
                                        FStar_Syntax_Syntax.lbtyp =
                                          FStar_Syntax_Syntax.tun;
                                        FStar_Syntax_Syntax.lbeff =
                                          FStar_Parser_Const.effect_Tot_lid;
                                        FStar_Syntax_Syntax.lbdef =
                                          FStar_Syntax_Syntax.tun;
                                        FStar_Syntax_Syntax.lbattrs = [];
                                        FStar_Syntax_Syntax.lbpos =
                                          FStar_Range.dummyRange
                                      }  in
                                    let impl =
                                      let uu____14436 =
                                        let uu____14437 =
                                          let uu____14444 =
                                            let uu____14447 =
                                              let uu____14448 =
                                                FStar_All.pipe_right
                                                  lb.FStar_Syntax_Syntax.lbname
                                                  FStar_Util.right
                                                 in
                                              FStar_All.pipe_right
                                                uu____14448
                                                (fun fv  ->
                                                   (fv.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v)
                                               in
                                            [uu____14447]  in
                                          ((false, [lb]), uu____14444)  in
                                        FStar_Syntax_Syntax.Sig_let
                                          uu____14437
                                         in
                                      {
                                        FStar_Syntax_Syntax.sigel =
                                          uu____14436;
                                        FStar_Syntax_Syntax.sigrng = p;
                                        FStar_Syntax_Syntax.sigquals = quals1;
                                        FStar_Syntax_Syntax.sigmeta =
                                          FStar_Syntax_Syntax.default_sigmeta;
                                        FStar_Syntax_Syntax.sigattrs = []
                                      }  in
                                    if no_decl then [impl] else [decl; impl]))))
               in
            FStar_All.pipe_right uu____14324 FStar_List.flatten
  
let (mk_data_projector_names :
  FStar_Syntax_Syntax.qualifier Prims.list ->
    FStar_Syntax_DsEnv.env ->
      FStar_Syntax_Syntax.sigelt -> FStar_Syntax_Syntax.sigelt Prims.list)
  =
  fun iquals  ->
    fun env  ->
      fun se  ->
        match se.FStar_Syntax_Syntax.sigel with
        | FStar_Syntax_Syntax.Sig_datacon
            (lid,uu____14498,t,uu____14500,n1,uu____14502) when
            let uu____14507 =
              FStar_Ident.lid_equals lid FStar_Parser_Const.lexcons_lid  in
            Prims.op_Negation uu____14507 ->
            let uu____14508 = FStar_Syntax_Util.arrow_formals t  in
            (match uu____14508 with
             | (formals,uu____14524) ->
                 (match formals with
                  | [] -> []
                  | uu____14547 ->
                      let filter_records uu___99_14561 =
                        match uu___99_14561 with
                        | FStar_Syntax_Syntax.RecordConstructor
                            (uu____14564,fns) ->
                            FStar_Pervasives_Native.Some
                              (FStar_Syntax_Syntax.Record_ctor (lid, fns))
                        | uu____14576 -> FStar_Pervasives_Native.None  in
                      let fv_qual =
                        let uu____14578 =
                          FStar_Util.find_map se.FStar_Syntax_Syntax.sigquals
                            filter_records
                           in
                        match uu____14578 with
                        | FStar_Pervasives_Native.None  ->
                            FStar_Syntax_Syntax.Data_ctor
                        | FStar_Pervasives_Native.Some q -> q  in
                      let iquals1 =
                        if
                          FStar_List.contains FStar_Syntax_Syntax.Abstract
                            iquals
                        then FStar_Syntax_Syntax.Private :: iquals
                        else iquals  in
                      let uu____14588 = FStar_Util.first_N n1 formals  in
                      (match uu____14588 with
                       | (uu____14611,rest) ->
                           mk_indexed_projector_names iquals1 fv_qual env lid
                             rest)))
        | uu____14637 -> []
  
let (mk_typ_abbrev :
  FStar_Ident.lident ->
    FStar_Syntax_Syntax.univ_name Prims.list ->
      (FStar_Syntax_Syntax.bv,FStar_Syntax_Syntax.aqual)
        FStar_Pervasives_Native.tuple2 Prims.list ->
        FStar_Syntax_Syntax.typ ->
          FStar_Syntax_Syntax.term ->
            FStar_Ident.lident Prims.list ->
              FStar_Syntax_Syntax.qualifier Prims.list ->
                FStar_Range.range -> FStar_Syntax_Syntax.sigelt)
  =
  fun lid  ->
    fun uvs  ->
      fun typars  ->
        fun k  ->
          fun t  ->
            fun lids  ->
              fun quals  ->
                fun rng  ->
                  let dd =
                    let uu____14703 =
                      FStar_All.pipe_right quals
                        (FStar_List.contains FStar_Syntax_Syntax.Abstract)
                       in
                    if uu____14703
                    then
                      let uu____14706 =
                        FStar_Syntax_Util.incr_delta_qualifier t  in
                      FStar_Syntax_Syntax.Delta_abstract uu____14706
                    else FStar_Syntax_Util.incr_delta_qualifier t  in
                  let lb =
                    let uu____14709 =
                      let uu____14714 =
                        FStar_Syntax_Syntax.lid_as_fv lid dd
                          FStar_Pervasives_Native.None
                         in
                      FStar_Util.Inr uu____14714  in
                    let uu____14715 =
                      let uu____14718 = FStar_Syntax_Syntax.mk_Total k  in
                      FStar_Syntax_Util.arrow typars uu____14718  in
                    let uu____14721 = no_annot_abs typars t  in
                    {
                      FStar_Syntax_Syntax.lbname = uu____14709;
                      FStar_Syntax_Syntax.lbunivs = uvs;
                      FStar_Syntax_Syntax.lbtyp = uu____14715;
                      FStar_Syntax_Syntax.lbeff =
                        FStar_Parser_Const.effect_Tot_lid;
                      FStar_Syntax_Syntax.lbdef = uu____14721;
                      FStar_Syntax_Syntax.lbattrs = [];
                      FStar_Syntax_Syntax.lbpos = rng
                    }  in
                  {
                    FStar_Syntax_Syntax.sigel =
                      (FStar_Syntax_Syntax.Sig_let ((false, [lb]), lids));
                    FStar_Syntax_Syntax.sigrng = rng;
                    FStar_Syntax_Syntax.sigquals = quals;
                    FStar_Syntax_Syntax.sigmeta =
                      FStar_Syntax_Syntax.default_sigmeta;
                    FStar_Syntax_Syntax.sigattrs = []
                  }
  
let rec (desugar_tycon :
  FStar_Syntax_DsEnv.env ->
    FStar_Parser_AST.decl ->
      FStar_Syntax_Syntax.qualifier Prims.list ->
        FStar_Parser_AST.tycon Prims.list ->
          (env_t,FStar_Syntax_Syntax.sigelts) FStar_Pervasives_Native.tuple2)
  =
  fun env  ->
    fun d  ->
      fun quals  ->
        fun tcs  ->
          let rng = d.FStar_Parser_AST.drange  in
          let tycon_id uu___100_14778 =
            match uu___100_14778 with
            | FStar_Parser_AST.TyconAbstract (id1,uu____14780,uu____14781) ->
                id1
            | FStar_Parser_AST.TyconAbbrev
                (id1,uu____14791,uu____14792,uu____14793) -> id1
            | FStar_Parser_AST.TyconRecord
                (id1,uu____14803,uu____14804,uu____14805) -> id1
            | FStar_Parser_AST.TyconVariant
                (id1,uu____14835,uu____14836,uu____14837) -> id1
             in
          let binder_to_term b =
            match b.FStar_Parser_AST.b with
            | FStar_Parser_AST.Annotated (x,uu____14881) ->
                let uu____14882 =
                  let uu____14883 = FStar_Ident.lid_of_ids [x]  in
                  FStar_Parser_AST.Var uu____14883  in
                FStar_Parser_AST.mk_term uu____14882 x.FStar_Ident.idRange
                  FStar_Parser_AST.Expr
            | FStar_Parser_AST.Variable x ->
                let uu____14885 =
                  let uu____14886 = FStar_Ident.lid_of_ids [x]  in
                  FStar_Parser_AST.Var uu____14886  in
                FStar_Parser_AST.mk_term uu____14885 x.FStar_Ident.idRange
                  FStar_Parser_AST.Expr
            | FStar_Parser_AST.TAnnotated (a,uu____14888) ->
                FStar_Parser_AST.mk_term (FStar_Parser_AST.Tvar a)
                  a.FStar_Ident.idRange FStar_Parser_AST.Type_level
            | FStar_Parser_AST.TVariable a ->
                FStar_Parser_AST.mk_term (FStar_Parser_AST.Tvar a)
                  a.FStar_Ident.idRange FStar_Parser_AST.Type_level
            | FStar_Parser_AST.NoName t -> t  in
          let tot =
            FStar_Parser_AST.mk_term
              (FStar_Parser_AST.Name FStar_Parser_Const.effect_Tot_lid) rng
              FStar_Parser_AST.Expr
             in
          let with_constructor_effect t =
            FStar_Parser_AST.mk_term
              (FStar_Parser_AST.App (tot, t, FStar_Parser_AST.Nothing))
              t.FStar_Parser_AST.range t.FStar_Parser_AST.level
             in
          let apply_binders t binders =
            let imp_of_aqual b =
              match b.FStar_Parser_AST.aqual with
              | FStar_Pervasives_Native.Some (FStar_Parser_AST.Implicit ) ->
                  FStar_Parser_AST.Hash
              | uu____14919 -> FStar_Parser_AST.Nothing  in
            FStar_List.fold_left
              (fun out  ->
                 fun b  ->
                   let uu____14925 =
                     let uu____14926 =
                       let uu____14933 = binder_to_term b  in
                       (out, uu____14933, (imp_of_aqual b))  in
                     FStar_Parser_AST.App uu____14926  in
                   FStar_Parser_AST.mk_term uu____14925
                     out.FStar_Parser_AST.range out.FStar_Parser_AST.level) t
              binders
             in
          let tycon_record_as_variant uu___101_14945 =
            match uu___101_14945 with
            | FStar_Parser_AST.TyconRecord (id1,parms,kopt,fields) ->
                let constrName =
                  FStar_Ident.mk_ident
                    ((Prims.strcat "Mk" id1.FStar_Ident.idText),
                      (id1.FStar_Ident.idRange))
                   in
                let mfields =
                  FStar_List.map
                    (fun uu____15001  ->
                       match uu____15001 with
                       | (x,t,uu____15012) ->
                           let uu____15017 =
                             let uu____15018 =
                               let uu____15023 =
                                 FStar_Syntax_Util.mangle_field_name x  in
                               (uu____15023, t)  in
                             FStar_Parser_AST.Annotated uu____15018  in
                           FStar_Parser_AST.mk_binder uu____15017
                             x.FStar_Ident.idRange FStar_Parser_AST.Expr
                             FStar_Pervasives_Native.None) fields
                   in
                let result =
                  let uu____15025 =
                    let uu____15026 =
                      let uu____15027 = FStar_Ident.lid_of_ids [id1]  in
                      FStar_Parser_AST.Var uu____15027  in
                    FStar_Parser_AST.mk_term uu____15026
                      id1.FStar_Ident.idRange FStar_Parser_AST.Type_level
                     in
                  apply_binders uu____15025 parms  in
                let constrTyp =
                  FStar_Parser_AST.mk_term
                    (FStar_Parser_AST.Product
                       (mfields, (with_constructor_effect result)))
                    id1.FStar_Ident.idRange FStar_Parser_AST.Type_level
                   in
                let uu____15031 =
                  FStar_All.pipe_right fields
                    (FStar_List.map
                       (fun uu____15058  ->
                          match uu____15058 with
                          | (x,uu____15068,uu____15069) ->
                              FStar_Syntax_Util.unmangle_field_name x))
                   in
                ((FStar_Parser_AST.TyconVariant
                    (id1, parms, kopt,
                      [(constrName, (FStar_Pervasives_Native.Some constrTyp),
                         FStar_Pervasives_Native.None, false)])),
                  uu____15031)
            | uu____15122 -> failwith "impossible"  in
          let desugar_abstract_tc quals1 _env mutuals uu___102_15161 =
            match uu___102_15161 with
            | FStar_Parser_AST.TyconAbstract (id1,binders,kopt) ->
                let uu____15185 = typars_of_binders _env binders  in
                (match uu____15185 with
                 | (_env',typars) ->
                     let k =
                       match kopt with
                       | FStar_Pervasives_Native.None  ->
                           FStar_Syntax_Util.ktype
                       | FStar_Pervasives_Native.Some k ->
                           desugar_term _env' k
                        in
                     let tconstr =
                       let uu____15231 =
                         let uu____15232 =
                           let uu____15233 = FStar_Ident.lid_of_ids [id1]  in
                           FStar_Parser_AST.Var uu____15233  in
                         FStar_Parser_AST.mk_term uu____15232
                           id1.FStar_Ident.idRange
                           FStar_Parser_AST.Type_level
                          in
                       apply_binders uu____15231 binders  in
                     let qlid = FStar_Syntax_DsEnv.qualify _env id1  in
                     let typars1 = FStar_Syntax_Subst.close_binders typars
                        in
                     let k1 = FStar_Syntax_Subst.close typars1 k  in
                     let se =
                       {
                         FStar_Syntax_Syntax.sigel =
                           (FStar_Syntax_Syntax.Sig_inductive_typ
                              (qlid, [], typars1, k1, mutuals, []));
                         FStar_Syntax_Syntax.sigrng = rng;
                         FStar_Syntax_Syntax.sigquals = quals1;
                         FStar_Syntax_Syntax.sigmeta =
                           FStar_Syntax_Syntax.default_sigmeta;
                         FStar_Syntax_Syntax.sigattrs = []
                       }  in
                     let _env1 =
                       FStar_Syntax_DsEnv.push_top_level_rec_binding _env id1
                         FStar_Syntax_Syntax.Delta_constant
                        in
                     let _env2 =
                       FStar_Syntax_DsEnv.push_top_level_rec_binding _env'
                         id1 FStar_Syntax_Syntax.Delta_constant
                        in
                     (_env1, _env2, se, tconstr))
            | uu____15246 -> failwith "Unexpected tycon"  in
          let push_tparams env1 bs =
            let uu____15294 =
              FStar_List.fold_left
                (fun uu____15334  ->
                   fun uu____15335  ->
                     match (uu____15334, uu____15335) with
                     | ((env2,tps),(x,imp)) ->
                         let uu____15426 =
                           FStar_Syntax_DsEnv.push_bv env2
                             x.FStar_Syntax_Syntax.ppname
                            in
                         (match uu____15426 with
                          | (env3,y) -> (env3, ((y, imp) :: tps))))
                (env1, []) bs
               in
            match uu____15294 with
            | (env2,bs1) -> (env2, (FStar_List.rev bs1))  in
          match tcs with
          | (FStar_Parser_AST.TyconAbstract (id1,bs,kopt))::[] ->
              let kopt1 =
                match kopt with
                | FStar_Pervasives_Native.None  ->
                    let uu____15539 = tm_type_z id1.FStar_Ident.idRange  in
                    FStar_Pervasives_Native.Some uu____15539
                | uu____15540 -> kopt  in
              let tc = FStar_Parser_AST.TyconAbstract (id1, bs, kopt1)  in
              let uu____15548 = desugar_abstract_tc quals env [] tc  in
              (match uu____15548 with
               | (uu____15561,uu____15562,se,uu____15564) ->
                   let se1 =
                     match se.FStar_Syntax_Syntax.sigel with
                     | FStar_Syntax_Syntax.Sig_inductive_typ
                         (l,uu____15567,typars,k,[],[]) ->
                         let quals1 = se.FStar_Syntax_Syntax.sigquals  in
                         let quals2 =
                           if
                             FStar_List.contains
                               FStar_Syntax_Syntax.Assumption quals1
                           then quals1
                           else
                             ((let uu____15584 =
                                 let uu____15585 = FStar_Options.ml_ish ()
                                    in
                                 Prims.op_Negation uu____15585  in
                               if uu____15584
                               then
                                 let uu____15586 =
                                   let uu____15591 =
                                     let uu____15592 =
                                       FStar_Syntax_Print.lid_to_string l  in
                                     FStar_Util.format1
                                       "Adding an implicit 'assume new' qualifier on %s"
                                       uu____15592
                                      in
                                   (FStar_Errors.Warning_AddImplicitAssumeNewQualifier,
                                     uu____15591)
                                    in
                                 FStar_Errors.log_issue
                                   se.FStar_Syntax_Syntax.sigrng uu____15586
                               else ());
                              FStar_Syntax_Syntax.Assumption
                              ::
                              FStar_Syntax_Syntax.New
                              ::
                              quals1)
                            in
                         let t =
                           match typars with
                           | [] -> k
                           | uu____15599 ->
                               let uu____15600 =
                                 let uu____15607 =
                                   let uu____15608 =
                                     let uu____15621 =
                                       FStar_Syntax_Syntax.mk_Total k  in
                                     (typars, uu____15621)  in
                                   FStar_Syntax_Syntax.Tm_arrow uu____15608
                                    in
                                 FStar_Syntax_Syntax.mk uu____15607  in
                               uu____15600 FStar_Pervasives_Native.None
                                 se.FStar_Syntax_Syntax.sigrng
                            in
                         let uu___135_15625 = se  in
                         {
                           FStar_Syntax_Syntax.sigel =
                             (FStar_Syntax_Syntax.Sig_declare_typ (l, [], t));
                           FStar_Syntax_Syntax.sigrng =
                             (uu___135_15625.FStar_Syntax_Syntax.sigrng);
                           FStar_Syntax_Syntax.sigquals = quals2;
                           FStar_Syntax_Syntax.sigmeta =
                             (uu___135_15625.FStar_Syntax_Syntax.sigmeta);
                           FStar_Syntax_Syntax.sigattrs =
                             (uu___135_15625.FStar_Syntax_Syntax.sigattrs)
                         }
                     | uu____15628 -> failwith "Impossible"  in
                   let env1 = FStar_Syntax_DsEnv.push_sigelt env se1  in
                   let env2 =
                     let uu____15631 = FStar_Syntax_DsEnv.qualify env1 id1
                        in
                     FStar_Syntax_DsEnv.push_doc env1 uu____15631
                       d.FStar_Parser_AST.doc
                      in
                   (env2, [se1]))
          | (FStar_Parser_AST.TyconAbbrev (id1,binders,kopt,t))::[] ->
              let uu____15646 = typars_of_binders env binders  in
              (match uu____15646 with
               | (env',typars) ->
                   let k =
                     match kopt with
                     | FStar_Pervasives_Native.None  ->
                         let uu____15682 =
                           FStar_Util.for_some
                             (fun uu___103_15684  ->
                                match uu___103_15684 with
                                | FStar_Syntax_Syntax.Effect  -> true
                                | uu____15685 -> false) quals
                            in
                         if uu____15682
                         then FStar_Syntax_Syntax.teff
                         else FStar_Syntax_Util.ktype
                     | FStar_Pervasives_Native.Some k -> desugar_term env' k
                      in
                   let t0 = t  in
                   let quals1 =
                     let uu____15692 =
                       FStar_All.pipe_right quals
                         (FStar_Util.for_some
                            (fun uu___104_15696  ->
                               match uu___104_15696 with
                               | FStar_Syntax_Syntax.Logic  -> true
                               | uu____15697 -> false))
                        in
                     if uu____15692
                     then quals
                     else
                       if
                         t0.FStar_Parser_AST.level = FStar_Parser_AST.Formula
                       then FStar_Syntax_Syntax.Logic :: quals
                       else quals
                      in
                   let qlid = FStar_Syntax_DsEnv.qualify env id1  in
                   let se =
                     let uu____15706 =
                       FStar_All.pipe_right quals1
                         (FStar_List.contains FStar_Syntax_Syntax.Effect)
                        in
                     if uu____15706
                     then
                       let uu____15709 =
                         let uu____15716 =
                           let uu____15717 = unparen t  in
                           uu____15717.FStar_Parser_AST.tm  in
                         match uu____15716 with
                         | FStar_Parser_AST.Construct (head1,args) ->
                             let uu____15738 =
                               match FStar_List.rev args with
                               | (last_arg,uu____15768)::args_rev ->
                                   let uu____15780 =
                                     let uu____15781 = unparen last_arg  in
                                     uu____15781.FStar_Parser_AST.tm  in
                                   (match uu____15780 with
                                    | FStar_Parser_AST.Attributes ts ->
                                        (ts, (FStar_List.rev args_rev))
                                    | uu____15809 -> ([], args))
                               | uu____15818 -> ([], args)  in
                             (match uu____15738 with
                              | (cattributes,args1) ->
                                  let uu____15857 =
                                    desugar_attributes env cattributes  in
                                  ((FStar_Parser_AST.mk_term
                                      (FStar_Parser_AST.Construct
                                         (head1, args1))
                                      t.FStar_Parser_AST.range
                                      t.FStar_Parser_AST.level), uu____15857))
                         | uu____15868 -> (t, [])  in
                       match uu____15709 with
                       | (t1,cattributes) ->
                           let c =
                             desugar_comp t1.FStar_Parser_AST.range env' t1
                              in
                           let typars1 =
                             FStar_Syntax_Subst.close_binders typars  in
                           let c1 = FStar_Syntax_Subst.close_comp typars1 c
                              in
                           let quals2 =
                             FStar_All.pipe_right quals1
                               (FStar_List.filter
                                  (fun uu___105_15890  ->
                                     match uu___105_15890 with
                                     | FStar_Syntax_Syntax.Effect  -> false
                                     | uu____15891 -> true))
                              in
                           {
                             FStar_Syntax_Syntax.sigel =
                               (FStar_Syntax_Syntax.Sig_effect_abbrev
                                  (qlid, [], typars1, c1,
                                    (FStar_List.append cattributes
                                       (FStar_Syntax_Util.comp_flags c1))));
                             FStar_Syntax_Syntax.sigrng = rng;
                             FStar_Syntax_Syntax.sigquals = quals2;
                             FStar_Syntax_Syntax.sigmeta =
                               FStar_Syntax_Syntax.default_sigmeta;
                             FStar_Syntax_Syntax.sigattrs = []
                           }
                     else
                       (let t1 = desugar_typ env' t  in
                        mk_typ_abbrev qlid [] typars k t1 [qlid] quals1 rng)
                      in
                   let env1 = FStar_Syntax_DsEnv.push_sigelt env se  in
                   let env2 =
                     FStar_Syntax_DsEnv.push_doc env1 qlid
                       d.FStar_Parser_AST.doc
                      in
                   (env2, [se]))
          | (FStar_Parser_AST.TyconRecord uu____15902)::[] ->
              let trec = FStar_List.hd tcs  in
              let uu____15926 = tycon_record_as_variant trec  in
              (match uu____15926 with
               | (t,fs) ->
                   let uu____15943 =
                     let uu____15946 =
                       let uu____15947 =
                         let uu____15956 =
                           let uu____15959 =
                             FStar_Syntax_DsEnv.current_module env  in
                           FStar_Ident.ids_of_lid uu____15959  in
                         (uu____15956, fs)  in
                       FStar_Syntax_Syntax.RecordType uu____15947  in
                     uu____15946 :: quals  in
                   desugar_tycon env d uu____15943 [t])
          | uu____15964::uu____15965 ->
              let env0 = env  in
              let mutuals =
                FStar_List.map
                  (fun x  ->
                     FStar_All.pipe_left (FStar_Syntax_DsEnv.qualify env)
                       (tycon_id x)) tcs
                 in
              let rec collect_tcs quals1 et tc =
                let uu____16132 = et  in
                match uu____16132 with
                | (env1,tcs1) ->
                    (match tc with
                     | FStar_Parser_AST.TyconRecord uu____16357 ->
                         let trec = tc  in
                         let uu____16381 = tycon_record_as_variant trec  in
                         (match uu____16381 with
                          | (t,fs) ->
                              let uu____16440 =
                                let uu____16443 =
                                  let uu____16444 =
                                    let uu____16453 =
                                      let uu____16456 =
                                        FStar_Syntax_DsEnv.current_module
                                          env1
                                         in
                                      FStar_Ident.ids_of_lid uu____16456  in
                                    (uu____16453, fs)  in
                                  FStar_Syntax_Syntax.RecordType uu____16444
                                   in
                                uu____16443 :: quals1  in
                              collect_tcs uu____16440 (env1, tcs1) t)
                     | FStar_Parser_AST.TyconVariant
                         (id1,binders,kopt,constructors) ->
                         let uu____16543 =
                           desugar_abstract_tc quals1 env1 mutuals
                             (FStar_Parser_AST.TyconAbstract
                                (id1, binders, kopt))
                            in
                         (match uu____16543 with
                          | (env2,uu____16603,se,tconstr) ->
                              (env2,
                                ((FStar_Util.Inl
                                    (se, constructors, tconstr, quals1)) ::
                                tcs1)))
                     | FStar_Parser_AST.TyconAbbrev (id1,binders,kopt,t) ->
                         let uu____16752 =
                           desugar_abstract_tc quals1 env1 mutuals
                             (FStar_Parser_AST.TyconAbstract
                                (id1, binders, kopt))
                            in
                         (match uu____16752 with
                          | (env2,uu____16812,se,tconstr) ->
                              (env2,
                                ((FStar_Util.Inr (se, binders, t, quals1)) ::
                                tcs1)))
                     | uu____16937 ->
                         failwith "Unrecognized mutual type definition")
                 in
              let uu____16984 =
                FStar_List.fold_left (collect_tcs quals) (env, []) tcs  in
              (match uu____16984 with
               | (env1,tcs1) ->
                   let tcs2 = FStar_List.rev tcs1  in
                   let docs_tps_sigelts =
                     FStar_All.pipe_right tcs2
                       (FStar_List.collect
                          (fun uu___107_17495  ->
                             match uu___107_17495 with
                             | FStar_Util.Inr
                                 ({
                                    FStar_Syntax_Syntax.sigel =
                                      FStar_Syntax_Syntax.Sig_inductive_typ
                                      (id1,uvs,tpars,k,uu____17562,uu____17563);
                                    FStar_Syntax_Syntax.sigrng = uu____17564;
                                    FStar_Syntax_Syntax.sigquals =
                                      uu____17565;
                                    FStar_Syntax_Syntax.sigmeta = uu____17566;
                                    FStar_Syntax_Syntax.sigattrs =
                                      uu____17567;_},binders,t,quals1)
                                 ->
                                 let t1 =
                                   let uu____17628 =
                                     typars_of_binders env1 binders  in
                                   match uu____17628 with
                                   | (env2,tpars1) ->
                                       let uu____17659 =
                                         push_tparams env2 tpars1  in
                                       (match uu____17659 with
                                        | (env_tps,tpars2) ->
                                            let t1 = desugar_typ env_tps t
                                               in
                                            let tpars3 =
                                              FStar_Syntax_Subst.close_binders
                                                tpars2
                                               in
                                            FStar_Syntax_Subst.close tpars3
                                              t1)
                                    in
                                 let uu____17692 =
                                   let uu____17713 =
                                     mk_typ_abbrev id1 uvs tpars k t1 
                                       [id1] quals1 rng
                                      in
                                   ((id1, (d.FStar_Parser_AST.doc)), [],
                                     uu____17713)
                                    in
                                 [uu____17692]
                             | FStar_Util.Inl
                                 ({
                                    FStar_Syntax_Syntax.sigel =
                                      FStar_Syntax_Syntax.Sig_inductive_typ
                                      (tname,univs1,tpars,k,mutuals1,uu____17781);
                                    FStar_Syntax_Syntax.sigrng = uu____17782;
                                    FStar_Syntax_Syntax.sigquals =
                                      tname_quals;
                                    FStar_Syntax_Syntax.sigmeta = uu____17784;
                                    FStar_Syntax_Syntax.sigattrs =
                                      uu____17785;_},constrs,tconstr,quals1)
                                 ->
                                 let mk_tot t =
                                   let tot1 =
                                     FStar_Parser_AST.mk_term
                                       (FStar_Parser_AST.Name
                                          FStar_Parser_Const.effect_Tot_lid)
                                       t.FStar_Parser_AST.range
                                       t.FStar_Parser_AST.level
                                      in
                                   FStar_Parser_AST.mk_term
                                     (FStar_Parser_AST.App
                                        (tot1, t, FStar_Parser_AST.Nothing))
                                     t.FStar_Parser_AST.range
                                     t.FStar_Parser_AST.level
                                    in
                                 let tycon = (tname, tpars, k)  in
                                 let uu____17883 = push_tparams env1 tpars
                                    in
                                 (match uu____17883 with
                                  | (env_tps,tps) ->
                                      let data_tpars =
                                        FStar_List.map
                                          (fun uu____17960  ->
                                             match uu____17960 with
                                             | (x,uu____17974) ->
                                                 (x,
                                                   (FStar_Pervasives_Native.Some
                                                      (FStar_Syntax_Syntax.Implicit
                                                         true)))) tps
                                         in
                                      let tot_tconstr = mk_tot tconstr  in
                                      let uu____17982 =
                                        let uu____18011 =
                                          FStar_All.pipe_right constrs
                                            (FStar_List.map
                                               (fun uu____18125  ->
                                                  match uu____18125 with
                                                  | (id1,topt,doc1,of_notation)
                                                      ->
                                                      let t =
                                                        if of_notation
                                                        then
                                                          match topt with
                                                          | FStar_Pervasives_Native.Some
                                                              t ->
                                                              FStar_Parser_AST.mk_term
                                                                (FStar_Parser_AST.Product
                                                                   ([
                                                                    FStar_Parser_AST.mk_binder
                                                                    (FStar_Parser_AST.NoName
                                                                    t)
                                                                    t.FStar_Parser_AST.range
                                                                    t.FStar_Parser_AST.level
                                                                    FStar_Pervasives_Native.None],
                                                                    tot_tconstr))
                                                                t.FStar_Parser_AST.range
                                                                t.FStar_Parser_AST.level
                                                          | FStar_Pervasives_Native.None
                                                               -> tconstr
                                                        else
                                                          (match topt with
                                                           | FStar_Pervasives_Native.None
                                                                ->
                                                               failwith
                                                                 "Impossible"
                                                           | FStar_Pervasives_Native.Some
                                                               t -> t)
                                                         in
                                                      let t1 =
                                                        let uu____18181 =
                                                          close env_tps t  in
                                                        desugar_term env_tps
                                                          uu____18181
                                                         in
                                                      let name =
                                                        FStar_Syntax_DsEnv.qualify
                                                          env1 id1
                                                         in
                                                      let quals2 =
                                                        FStar_All.pipe_right
                                                          tname_quals
                                                          (FStar_List.collect
                                                             (fun
                                                                uu___106_18192
                                                                 ->
                                                                match uu___106_18192
                                                                with
                                                                | FStar_Syntax_Syntax.RecordType
                                                                    fns ->
                                                                    [
                                                                    FStar_Syntax_Syntax.RecordConstructor
                                                                    fns]
                                                                | uu____18204
                                                                    -> []))
                                                         in
                                                      let ntps =
                                                        FStar_List.length
                                                          data_tpars
                                                         in
                                                      let uu____18212 =
                                                        let uu____18233 =
                                                          let uu____18234 =
                                                            let uu____18235 =
                                                              let uu____18250
                                                                =
                                                                let uu____18253
                                                                  =
                                                                  let uu____18256
                                                                    =
                                                                    FStar_All.pipe_right
                                                                    t1
                                                                    FStar_Syntax_Util.name_function_binders
                                                                     in
                                                                  FStar_Syntax_Syntax.mk_Total
                                                                    uu____18256
                                                                   in
                                                                FStar_Syntax_Util.arrow
                                                                  data_tpars
                                                                  uu____18253
                                                                 in
                                                              (name, univs1,
                                                                uu____18250,
                                                                tname, ntps,
                                                                mutuals1)
                                                               in
                                                            FStar_Syntax_Syntax.Sig_datacon
                                                              uu____18235
                                                             in
                                                          {
                                                            FStar_Syntax_Syntax.sigel
                                                              = uu____18234;
                                                            FStar_Syntax_Syntax.sigrng
                                                              = rng;
                                                            FStar_Syntax_Syntax.sigquals
                                                              = quals2;
                                                            FStar_Syntax_Syntax.sigmeta
                                                              =
                                                              FStar_Syntax_Syntax.default_sigmeta;
                                                            FStar_Syntax_Syntax.sigattrs
                                                              = []
                                                          }  in
                                                        ((name, doc1), tps,
                                                          uu____18233)
                                                         in
                                                      (name, uu____18212)))
                                           in
                                        FStar_All.pipe_left FStar_List.split
                                          uu____18011
                                         in
                                      (match uu____17982 with
                                       | (constrNames,constrs1) ->
                                           ((tname, (d.FStar_Parser_AST.doc)),
                                             [],
                                             {
                                               FStar_Syntax_Syntax.sigel =
                                                 (FStar_Syntax_Syntax.Sig_inductive_typ
                                                    (tname, univs1, tpars, k,
                                                      mutuals1, constrNames));
                                               FStar_Syntax_Syntax.sigrng =
                                                 rng;
                                               FStar_Syntax_Syntax.sigquals =
                                                 tname_quals;
                                               FStar_Syntax_Syntax.sigmeta =
                                                 FStar_Syntax_Syntax.default_sigmeta;
                                               FStar_Syntax_Syntax.sigattrs =
                                                 []
                                             })
                                           :: constrs1))
                             | uu____18495 -> failwith "impossible"))
                      in
                   let name_docs =
                     FStar_All.pipe_right docs_tps_sigelts
                       (FStar_List.map
                          (fun uu____18627  ->
                             match uu____18627 with
                             | (name_doc,uu____18655,uu____18656) -> name_doc))
                      in
                   let sigelts =
                     FStar_All.pipe_right docs_tps_sigelts
                       (FStar_List.map
                          (fun uu____18736  ->
                             match uu____18736 with
                             | (uu____18757,uu____18758,se) -> se))
                      in
                   let uu____18788 =
                     let uu____18795 =
                       FStar_List.collect FStar_Syntax_Util.lids_of_sigelt
                         sigelts
                        in
                     FStar_Syntax_MutRecTy.disentangle_abbrevs_from_bundle
                       sigelts quals uu____18795 rng
                      in
                   (match uu____18788 with
                    | (bundle,abbrevs) ->
                        let env2 = FStar_Syntax_DsEnv.push_sigelt env0 bundle
                           in
                        let env3 =
                          FStar_List.fold_left FStar_Syntax_DsEnv.push_sigelt
                            env2 abbrevs
                           in
                        let data_ops =
                          FStar_All.pipe_right docs_tps_sigelts
                            (FStar_List.collect
                               (fun uu____18861  ->
                                  match uu____18861 with
                                  | (uu____18884,tps,se) ->
                                      mk_data_projector_names quals env3 se))
                           in
                        let discs =
                          FStar_All.pipe_right sigelts
                            (FStar_List.collect
                               (fun se  ->
                                  match se.FStar_Syntax_Syntax.sigel with
                                  | FStar_Syntax_Syntax.Sig_inductive_typ
                                      (tname,uu____18935,tps,k,uu____18938,constrs)
                                      when
                                      (FStar_List.length constrs) >
                                        (Prims.parse_int "1")
                                      ->
                                      let quals1 =
                                        se.FStar_Syntax_Syntax.sigquals  in
                                      let quals2 =
                                        if
                                          FStar_List.contains
                                            FStar_Syntax_Syntax.Abstract
                                            quals1
                                        then FStar_Syntax_Syntax.Private ::
                                          quals1
                                        else quals1  in
                                      mk_data_discriminators quals2 env3
                                        constrs
                                  | uu____18957 -> []))
                           in
                        let ops = FStar_List.append discs data_ops  in
                        let env4 =
                          FStar_List.fold_left FStar_Syntax_DsEnv.push_sigelt
                            env3 ops
                           in
                        let env5 =
                          FStar_List.fold_left
                            (fun acc  ->
                               fun uu____18974  ->
                                 match uu____18974 with
                                 | (lid,doc1) ->
                                     FStar_Syntax_DsEnv.push_doc env4 lid
                                       doc1) env4 name_docs
                           in
                        (env5,
                          (FStar_List.append [bundle]
                             (FStar_List.append abbrevs ops)))))
          | [] -> failwith "impossible"
  
let (desugar_binders :
  FStar_Syntax_DsEnv.env ->
    FStar_Parser_AST.binder Prims.list ->
      (FStar_Syntax_DsEnv.env,FStar_Syntax_Syntax.binder Prims.list)
        FStar_Pervasives_Native.tuple2)
  =
  fun env  ->
    fun binders  ->
      let uu____19013 =
        FStar_List.fold_left
          (fun uu____19036  ->
             fun b  ->
               match uu____19036 with
               | (env1,binders1) ->
                   let uu____19056 = desugar_binder env1 b  in
                   (match uu____19056 with
                    | (FStar_Pervasives_Native.Some a,k) ->
                        let uu____19073 =
                          as_binder env1 b.FStar_Parser_AST.aqual
                            ((FStar_Pervasives_Native.Some a), k)
                           in
                        (match uu____19073 with
                         | (binder,env2) -> (env2, (binder :: binders1)))
                    | uu____19090 ->
                        FStar_Errors.raise_error
                          (FStar_Errors.Fatal_MissingNameInBinder,
                            "Missing name in binder")
                          b.FStar_Parser_AST.brange)) (env, []) binders
         in
      match uu____19013 with
      | (env1,binders1) -> (env1, (FStar_List.rev binders1))
  
let (push_reflect_effect :
  FStar_Syntax_DsEnv.env ->
    FStar_Syntax_Syntax.qualifier Prims.list ->
      FStar_Ident.lid -> FStar_Range.range -> FStar_Syntax_DsEnv.env)
  =
  fun env  ->
    fun quals  ->
      fun effect_name  ->
        fun range  ->
          let uu____19143 =
            FStar_All.pipe_right quals
              (FStar_Util.for_some
                 (fun uu___108_19148  ->
                    match uu___108_19148 with
                    | FStar_Syntax_Syntax.Reflectable uu____19149 -> true
                    | uu____19150 -> false))
             in
          if uu____19143
          then
            let monad_env =
              FStar_Syntax_DsEnv.enter_monad_scope env
                effect_name.FStar_Ident.ident
               in
            let reflect_lid =
              let uu____19153 = FStar_Ident.id_of_text "reflect"  in
              FStar_All.pipe_right uu____19153
                (FStar_Syntax_DsEnv.qualify monad_env)
               in
            let quals1 =
              [FStar_Syntax_Syntax.Assumption;
              FStar_Syntax_Syntax.Reflectable effect_name]  in
            let refl_decl =
              {
                FStar_Syntax_Syntax.sigel =
                  (FStar_Syntax_Syntax.Sig_declare_typ
                     (reflect_lid, [], FStar_Syntax_Syntax.tun));
                FStar_Syntax_Syntax.sigrng = range;
                FStar_Syntax_Syntax.sigquals = quals1;
                FStar_Syntax_Syntax.sigmeta =
                  FStar_Syntax_Syntax.default_sigmeta;
                FStar_Syntax_Syntax.sigattrs = []
              }  in
            FStar_Syntax_DsEnv.push_sigelt env refl_decl
          else env
  
let rec (desugar_effect :
  FStar_Syntax_DsEnv.env ->
    FStar_Parser_AST.decl ->
      FStar_Parser_AST.qualifiers ->
        FStar_Ident.ident ->
          FStar_Parser_AST.binder Prims.list ->
            FStar_Parser_AST.term ->
              FStar_Parser_AST.decl Prims.list ->
                FStar_Parser_AST.term Prims.list ->
                  (FStar_Syntax_DsEnv.env,FStar_Syntax_Syntax.sigelt
                                            Prims.list)
                    FStar_Pervasives_Native.tuple2)
  =
  fun env  ->
    fun d  ->
      fun quals  ->
        fun eff_name  ->
          fun eff_binders  ->
            fun eff_typ  ->
              fun eff_decls  ->
                fun attrs  ->
                  let env0 = env  in
                  let monad_env =
                    FStar_Syntax_DsEnv.enter_monad_scope env eff_name  in
                  let uu____19297 = desugar_binders monad_env eff_binders  in
                  match uu____19297 with
                  | (env1,binders) ->
                      let eff_t = desugar_term env1 eff_typ  in
                      let for_free =
                        let uu____19318 =
                          let uu____19319 =
                            let uu____19326 =
                              FStar_Syntax_Util.arrow_formals eff_t  in
                            FStar_Pervasives_Native.fst uu____19326  in
                          FStar_List.length uu____19319  in
                        uu____19318 = (Prims.parse_int "1")  in
                      let mandatory_members =
                        let rr_members = ["repr"; "return"; "bind"]  in
                        if for_free
                        then rr_members
                        else
                          FStar_List.append rr_members
                            ["return_wp";
                            "bind_wp";
                            "if_then_else";
                            "ite_wp";
                            "stronger";
                            "close_wp";
                            "assert_p";
                            "assume_p";
                            "null_wp";
                            "trivial"]
                         in
                      let name_of_eff_decl decl =
                        match decl.FStar_Parser_AST.d with
                        | FStar_Parser_AST.Tycon
                            (uu____19370,(FStar_Parser_AST.TyconAbbrev
                                          (name,uu____19372,uu____19373,uu____19374),uu____19375)::[])
                            -> FStar_Ident.text_of_id name
                        | uu____19408 ->
                            failwith "Malformed effect member declaration."
                         in
                      let uu____19409 =
                        FStar_List.partition
                          (fun decl  ->
                             let uu____19421 = name_of_eff_decl decl  in
                             FStar_List.mem uu____19421 mandatory_members)
                          eff_decls
                         in
                      (match uu____19409 with
                       | (mandatory_members_decls,actions) ->
                           let uu____19438 =
                             FStar_All.pipe_right mandatory_members_decls
                               (FStar_List.fold_left
                                  (fun uu____19467  ->
                                     fun decl  ->
                                       match uu____19467 with
                                       | (env2,out) ->
                                           let uu____19487 =
                                             desugar_decl env2 decl  in
                                           (match uu____19487 with
                                            | (env3,ses) ->
                                                let uu____19500 =
                                                  let uu____19503 =
                                                    FStar_List.hd ses  in
                                                  uu____19503 :: out  in
                                                (env3, uu____19500)))
                                  (env1, []))
                              in
                           (match uu____19438 with
                            | (env2,decls) ->
                                let binders1 =
                                  FStar_Syntax_Subst.close_binders binders
                                   in
                                let actions_docs =
                                  FStar_All.pipe_right actions
                                    (FStar_List.map
                                       (fun d1  ->
                                          match d1.FStar_Parser_AST.d with
                                          | FStar_Parser_AST.Tycon
                                              (uu____19571,(FStar_Parser_AST.TyconAbbrev
                                                            (name,action_params,uu____19574,
                                                             {
                                                               FStar_Parser_AST.tm
                                                                 =
                                                                 FStar_Parser_AST.Construct
                                                                 (uu____19575,
                                                                  (def,uu____19577)::
                                                                  (cps_type,uu____19579)::[]);
                                                               FStar_Parser_AST.range
                                                                 =
                                                                 uu____19580;
                                                               FStar_Parser_AST.level
                                                                 =
                                                                 uu____19581;_}),doc1)::[])
                                              when Prims.op_Negation for_free
                                              ->
                                              let uu____19633 =
                                                desugar_binders env2
                                                  action_params
                                                 in
                                              (match uu____19633 with
                                               | (env3,action_params1) ->
                                                   let action_params2 =
                                                     FStar_Syntax_Subst.close_binders
                                                       action_params1
                                                      in
                                                   let uu____19653 =
                                                     let uu____19654 =
                                                       FStar_Syntax_DsEnv.qualify
                                                         env3 name
                                                        in
                                                     let uu____19655 =
                                                       let uu____19656 =
                                                         desugar_term env3
                                                           def
                                                          in
                                                       FStar_Syntax_Subst.close
                                                         (FStar_List.append
                                                            binders1
                                                            action_params2)
                                                         uu____19656
                                                        in
                                                     let uu____19661 =
                                                       let uu____19662 =
                                                         desugar_typ env3
                                                           cps_type
                                                          in
                                                       FStar_Syntax_Subst.close
                                                         (FStar_List.append
                                                            binders1
                                                            action_params2)
                                                         uu____19662
                                                        in
                                                     {
                                                       FStar_Syntax_Syntax.action_name
                                                         = uu____19654;
                                                       FStar_Syntax_Syntax.action_unqualified_name
                                                         = name;
                                                       FStar_Syntax_Syntax.action_univs
                                                         = [];
                                                       FStar_Syntax_Syntax.action_params
                                                         = action_params2;
                                                       FStar_Syntax_Syntax.action_defn
                                                         = uu____19655;
                                                       FStar_Syntax_Syntax.action_typ
                                                         = uu____19661
                                                     }  in
                                                   (uu____19653, doc1))
                                          | FStar_Parser_AST.Tycon
                                              (uu____19669,(FStar_Parser_AST.TyconAbbrev
                                                            (name,action_params,uu____19672,defn),doc1)::[])
                                              when for_free ->
                                              let uu____19707 =
                                                desugar_binders env2
                                                  action_params
                                                 in
                                              (match uu____19707 with
                                               | (env3,action_params1) ->
                                                   let action_params2 =
                                                     FStar_Syntax_Subst.close_binders
                                                       action_params1
                                                      in
                                                   let uu____19727 =
                                                     let uu____19728 =
                                                       FStar_Syntax_DsEnv.qualify
                                                         env3 name
                                                        in
                                                     let uu____19729 =
                                                       let uu____19730 =
                                                         desugar_term env3
                                                           defn
                                                          in
                                                       FStar_Syntax_Subst.close
                                                         (FStar_List.append
                                                            binders1
                                                            action_params2)
                                                         uu____19730
                                                        in
                                                     {
                                                       FStar_Syntax_Syntax.action_name
                                                         = uu____19728;
                                                       FStar_Syntax_Syntax.action_unqualified_name
                                                         = name;
                                                       FStar_Syntax_Syntax.action_univs
                                                         = [];
                                                       FStar_Syntax_Syntax.action_params
                                                         = action_params2;
                                                       FStar_Syntax_Syntax.action_defn
                                                         = uu____19729;
                                                       FStar_Syntax_Syntax.action_typ
                                                         =
                                                         FStar_Syntax_Syntax.tun
                                                     }  in
                                                   (uu____19727, doc1))
                                          | uu____19737 ->
                                              FStar_Errors.raise_error
                                                (FStar_Errors.Fatal_MalformedActionDeclaration,
                                                  "Malformed action declaration; if this is an \"effect for free\", just provide the direct-style declaration. If this is not an \"effect for free\", please provide a pair of the definition and its cps-type with arrows inserted in the right place (see examples).")
                                                d1.FStar_Parser_AST.drange))
                                   in
                                let actions1 =
                                  FStar_List.map FStar_Pervasives_Native.fst
                                    actions_docs
                                   in
                                let eff_t1 =
                                  FStar_Syntax_Subst.close binders1 eff_t  in
                                let lookup1 s =
                                  let l =
                                    let uu____19769 =
                                      FStar_Ident.mk_ident
                                        (s, (d.FStar_Parser_AST.drange))
                                       in
                                    FStar_Syntax_DsEnv.qualify env2
                                      uu____19769
                                     in
                                  let uu____19770 =
                                    let uu____19771 =
                                      FStar_Syntax_DsEnv.fail_or env2
                                        (FStar_Syntax_DsEnv.try_lookup_definition
                                           env2) l
                                       in
                                    FStar_All.pipe_left
                                      (FStar_Syntax_Subst.close binders1)
                                      uu____19771
                                     in
                                  ([], uu____19770)  in
                                let mname =
                                  FStar_Syntax_DsEnv.qualify env0 eff_name
                                   in
                                let qualifiers =
                                  FStar_List.map
                                    (trans_qual d.FStar_Parser_AST.drange
                                       (FStar_Pervasives_Native.Some mname))
                                    quals
                                   in
                                let se =
                                  if for_free
                                  then
                                    let dummy_tscheme =
                                      let uu____19788 =
                                        FStar_Syntax_Syntax.mk
                                          FStar_Syntax_Syntax.Tm_unknown
                                          FStar_Pervasives_Native.None
                                          FStar_Range.dummyRange
                                         in
                                      ([], uu____19788)  in
                                    let uu____19795 =
                                      let uu____19796 =
                                        let uu____19797 =
                                          let uu____19798 = lookup1 "repr"
                                             in
                                          FStar_Pervasives_Native.snd
                                            uu____19798
                                           in
                                        let uu____19807 = lookup1 "return"
                                           in
                                        let uu____19808 = lookup1 "bind"  in
                                        let uu____19809 =
                                          FStar_List.map (desugar_term env2)
                                            attrs
                                           in
                                        {
                                          FStar_Syntax_Syntax.cattributes =
                                            [];
                                          FStar_Syntax_Syntax.mname = mname;
                                          FStar_Syntax_Syntax.univs = [];
                                          FStar_Syntax_Syntax.binders =
                                            binders1;
                                          FStar_Syntax_Syntax.signature =
                                            eff_t1;
                                          FStar_Syntax_Syntax.ret_wp =
                                            dummy_tscheme;
                                          FStar_Syntax_Syntax.bind_wp =
                                            dummy_tscheme;
                                          FStar_Syntax_Syntax.if_then_else =
                                            dummy_tscheme;
                                          FStar_Syntax_Syntax.ite_wp =
                                            dummy_tscheme;
                                          FStar_Syntax_Syntax.stronger =
                                            dummy_tscheme;
                                          FStar_Syntax_Syntax.close_wp =
                                            dummy_tscheme;
                                          FStar_Syntax_Syntax.assert_p =
                                            dummy_tscheme;
                                          FStar_Syntax_Syntax.assume_p =
                                            dummy_tscheme;
                                          FStar_Syntax_Syntax.null_wp =
                                            dummy_tscheme;
                                          FStar_Syntax_Syntax.trivial =
                                            dummy_tscheme;
                                          FStar_Syntax_Syntax.repr =
                                            uu____19797;
                                          FStar_Syntax_Syntax.return_repr =
                                            uu____19807;
                                          FStar_Syntax_Syntax.bind_repr =
                                            uu____19808;
                                          FStar_Syntax_Syntax.actions =
                                            actions1;
                                          FStar_Syntax_Syntax.eff_attrs =
                                            uu____19809
                                        }  in
                                      FStar_Syntax_Syntax.Sig_new_effect_for_free
                                        uu____19796
                                       in
                                    {
                                      FStar_Syntax_Syntax.sigel = uu____19795;
                                      FStar_Syntax_Syntax.sigrng =
                                        (d.FStar_Parser_AST.drange);
                                      FStar_Syntax_Syntax.sigquals =
                                        qualifiers;
                                      FStar_Syntax_Syntax.sigmeta =
                                        FStar_Syntax_Syntax.default_sigmeta;
                                      FStar_Syntax_Syntax.sigattrs = []
                                    }
                                  else
                                    (let rr =
                                       FStar_Util.for_some
                                         (fun uu___109_19815  ->
                                            match uu___109_19815 with
                                            | FStar_Syntax_Syntax.Reifiable 
                                                -> true
                                            | FStar_Syntax_Syntax.Reflectable
                                                uu____19816 -> true
                                            | uu____19817 -> false)
                                         qualifiers
                                        in
                                     let un_ts =
                                       ([], FStar_Syntax_Syntax.tun)  in
                                     let uu____19827 =
                                       let uu____19828 =
                                         let uu____19829 =
                                           lookup1 "return_wp"  in
                                         let uu____19830 = lookup1 "bind_wp"
                                            in
                                         let uu____19831 =
                                           lookup1 "if_then_else"  in
                                         let uu____19832 = lookup1 "ite_wp"
                                            in
                                         let uu____19833 = lookup1 "stronger"
                                            in
                                         let uu____19834 = lookup1 "close_wp"
                                            in
                                         let uu____19835 = lookup1 "assert_p"
                                            in
                                         let uu____19836 = lookup1 "assume_p"
                                            in
                                         let uu____19837 = lookup1 "null_wp"
                                            in
                                         let uu____19838 = lookup1 "trivial"
                                            in
                                         let uu____19839 =
                                           if rr
                                           then
                                             let uu____19840 = lookup1 "repr"
                                                in
                                             FStar_All.pipe_left
                                               FStar_Pervasives_Native.snd
                                               uu____19840
                                           else FStar_Syntax_Syntax.tun  in
                                         let uu____19856 =
                                           if rr
                                           then lookup1 "return"
                                           else un_ts  in
                                         let uu____19858 =
                                           if rr
                                           then lookup1 "bind"
                                           else un_ts  in
                                         let uu____19860 =
                                           FStar_List.map (desugar_term env2)
                                             attrs
                                            in
                                         {
                                           FStar_Syntax_Syntax.cattributes =
                                             [];
                                           FStar_Syntax_Syntax.mname = mname;
                                           FStar_Syntax_Syntax.univs = [];
                                           FStar_Syntax_Syntax.binders =
                                             binders1;
                                           FStar_Syntax_Syntax.signature =
                                             eff_t1;
                                           FStar_Syntax_Syntax.ret_wp =
                                             uu____19829;
                                           FStar_Syntax_Syntax.bind_wp =
                                             uu____19830;
                                           FStar_Syntax_Syntax.if_then_else =
                                             uu____19831;
                                           FStar_Syntax_Syntax.ite_wp =
                                             uu____19832;
                                           FStar_Syntax_Syntax.stronger =
                                             uu____19833;
                                           FStar_Syntax_Syntax.close_wp =
                                             uu____19834;
                                           FStar_Syntax_Syntax.assert_p =
                                             uu____19835;
                                           FStar_Syntax_Syntax.assume_p =
                                             uu____19836;
                                           FStar_Syntax_Syntax.null_wp =
                                             uu____19837;
                                           FStar_Syntax_Syntax.trivial =
                                             uu____19838;
                                           FStar_Syntax_Syntax.repr =
                                             uu____19839;
                                           FStar_Syntax_Syntax.return_repr =
                                             uu____19856;
                                           FStar_Syntax_Syntax.bind_repr =
                                             uu____19858;
                                           FStar_Syntax_Syntax.actions =
                                             actions1;
                                           FStar_Syntax_Syntax.eff_attrs =
                                             uu____19860
                                         }  in
                                       FStar_Syntax_Syntax.Sig_new_effect
                                         uu____19828
                                        in
                                     {
                                       FStar_Syntax_Syntax.sigel =
                                         uu____19827;
                                       FStar_Syntax_Syntax.sigrng =
                                         (d.FStar_Parser_AST.drange);
                                       FStar_Syntax_Syntax.sigquals =
                                         qualifiers;
                                       FStar_Syntax_Syntax.sigmeta =
                                         FStar_Syntax_Syntax.default_sigmeta;
                                       FStar_Syntax_Syntax.sigattrs = []
                                     })
                                   in
                                let env3 =
                                  FStar_Syntax_DsEnv.push_sigelt env0 se  in
                                let env4 =
                                  FStar_Syntax_DsEnv.push_doc env3 mname
                                    d.FStar_Parser_AST.doc
                                   in
                                let env5 =
                                  FStar_All.pipe_right actions_docs
                                    (FStar_List.fold_left
                                       (fun env5  ->
                                          fun uu____19886  ->
                                            match uu____19886 with
                                            | (a,doc1) ->
                                                let env6 =
                                                  let uu____19900 =
                                                    FStar_Syntax_Util.action_as_lb
                                                      mname a
                                                      (a.FStar_Syntax_Syntax.action_defn).FStar_Syntax_Syntax.pos
                                                     in
                                                  FStar_Syntax_DsEnv.push_sigelt
                                                    env5 uu____19900
                                                   in
                                                FStar_Syntax_DsEnv.push_doc
                                                  env6
                                                  a.FStar_Syntax_Syntax.action_name
                                                  doc1) env4)
                                   in
                                let env6 =
                                  push_reflect_effect env5 qualifiers mname
                                    d.FStar_Parser_AST.drange
                                   in
                                let env7 =
                                  FStar_Syntax_DsEnv.push_doc env6 mname
                                    d.FStar_Parser_AST.doc
                                   in
                                (env7, [se])))

and (desugar_redefine_effect :
  FStar_Syntax_DsEnv.env ->
    FStar_Parser_AST.decl ->
      (FStar_Ident.lident FStar_Pervasives_Native.option ->
         FStar_Parser_AST.qualifier -> FStar_Syntax_Syntax.qualifier)
        ->
        FStar_Parser_AST.qualifier Prims.list ->
          FStar_Ident.ident ->
            FStar_Parser_AST.binder Prims.list ->
              FStar_Parser_AST.term ->
                (FStar_Syntax_DsEnv.env,FStar_Syntax_Syntax.sigelt Prims.list)
                  FStar_Pervasives_Native.tuple2)
  =
  fun env  ->
    fun d  ->
      fun trans_qual1  ->
        fun quals  ->
          fun eff_name  ->
            fun eff_binders  ->
              fun defn  ->
                let env0 = env  in
                let env1 = FStar_Syntax_DsEnv.enter_monad_scope env eff_name
                   in
                let uu____19924 = desugar_binders env1 eff_binders  in
                match uu____19924 with
                | (env2,binders) ->
                    let uu____19943 =
                      let uu____19962 = head_and_args defn  in
                      match uu____19962 with
                      | (head1,args) ->
                          let lid =
                            match head1.FStar_Parser_AST.tm with
                            | FStar_Parser_AST.Name l -> l
                            | uu____20007 ->
                                let uu____20008 =
                                  let uu____20013 =
                                    let uu____20014 =
                                      let uu____20015 =
                                        FStar_Parser_AST.term_to_string head1
                                         in
                                      Prims.strcat uu____20015 " not found"
                                       in
                                    Prims.strcat "Effect " uu____20014  in
                                  (FStar_Errors.Fatal_EffectNotFound,
                                    uu____20013)
                                   in
                                FStar_Errors.raise_error uu____20008
                                  d.FStar_Parser_AST.drange
                             in
                          let ed =
                            FStar_Syntax_DsEnv.fail_or env2
                              (FStar_Syntax_DsEnv.try_lookup_effect_defn env2)
                              lid
                             in
                          let uu____20017 =
                            match FStar_List.rev args with
                            | (last_arg,uu____20047)::args_rev ->
                                let uu____20059 =
                                  let uu____20060 = unparen last_arg  in
                                  uu____20060.FStar_Parser_AST.tm  in
                                (match uu____20059 with
                                 | FStar_Parser_AST.Attributes ts ->
                                     (ts, (FStar_List.rev args_rev))
                                 | uu____20088 -> ([], args))
                            | uu____20097 -> ([], args)  in
                          (match uu____20017 with
                           | (cattributes,args1) ->
                               let uu____20148 = desugar_args env2 args1  in
                               let uu____20157 =
                                 desugar_attributes env2 cattributes  in
                               (lid, ed, uu____20148, uu____20157))
                       in
                    (match uu____19943 with
                     | (ed_lid,ed,args,cattributes) ->
                         let binders1 =
                           FStar_Syntax_Subst.close_binders binders  in
                         (if
                            (FStar_List.length args) <>
                              (FStar_List.length
                                 ed.FStar_Syntax_Syntax.binders)
                          then
                            FStar_Errors.raise_error
                              (FStar_Errors.Fatal_ArgumentLengthMismatch,
                                "Unexpected number of arguments to effect constructor")
                              defn.FStar_Parser_AST.range
                          else ();
                          (let uu____20213 =
                             FStar_Syntax_Subst.open_term'
                               ed.FStar_Syntax_Syntax.binders
                               FStar_Syntax_Syntax.t_unit
                              in
                           match uu____20213 with
                           | (ed_binders,uu____20227,ed_binders_opening) ->
                               let sub1 uu____20240 =
                                 match uu____20240 with
                                 | (us,x) ->
                                     let x1 =
                                       let uu____20254 =
                                         FStar_Syntax_Subst.shift_subst
                                           (FStar_List.length us)
                                           ed_binders_opening
                                          in
                                       FStar_Syntax_Subst.subst uu____20254 x
                                        in
                                     let s =
                                       FStar_Syntax_Util.subst_of_list
                                         ed_binders args
                                        in
                                     let uu____20258 =
                                       let uu____20259 =
                                         FStar_Syntax_Subst.subst s x1  in
                                       (us, uu____20259)  in
                                     FStar_Syntax_Subst.close_tscheme
                                       binders1 uu____20258
                                  in
                               let mname =
                                 FStar_Syntax_DsEnv.qualify env0 eff_name  in
                               let ed1 =
                                 let uu____20264 =
                                   let uu____20265 =
                                     sub1
                                       ([],
                                         (ed.FStar_Syntax_Syntax.signature))
                                      in
                                   FStar_Pervasives_Native.snd uu____20265
                                    in
                                 let uu____20276 =
                                   sub1 ed.FStar_Syntax_Syntax.ret_wp  in
                                 let uu____20277 =
                                   sub1 ed.FStar_Syntax_Syntax.bind_wp  in
                                 let uu____20278 =
                                   sub1 ed.FStar_Syntax_Syntax.if_then_else
                                    in
                                 let uu____20279 =
                                   sub1 ed.FStar_Syntax_Syntax.ite_wp  in
                                 let uu____20280 =
                                   sub1 ed.FStar_Syntax_Syntax.stronger  in
                                 let uu____20281 =
                                   sub1 ed.FStar_Syntax_Syntax.close_wp  in
                                 let uu____20282 =
                                   sub1 ed.FStar_Syntax_Syntax.assert_p  in
                                 let uu____20283 =
                                   sub1 ed.FStar_Syntax_Syntax.assume_p  in
                                 let uu____20284 =
                                   sub1 ed.FStar_Syntax_Syntax.null_wp  in
                                 let uu____20285 =
                                   sub1 ed.FStar_Syntax_Syntax.trivial  in
                                 let uu____20286 =
                                   let uu____20287 =
                                     sub1 ([], (ed.FStar_Syntax_Syntax.repr))
                                      in
                                   FStar_Pervasives_Native.snd uu____20287
                                    in
                                 let uu____20298 =
                                   sub1 ed.FStar_Syntax_Syntax.return_repr
                                    in
                                 let uu____20299 =
                                   sub1 ed.FStar_Syntax_Syntax.bind_repr  in
                                 let uu____20300 =
                                   FStar_List.map
                                     (fun action  ->
                                        let uu____20308 =
                                          FStar_Syntax_DsEnv.qualify env2
                                            action.FStar_Syntax_Syntax.action_unqualified_name
                                           in
                                        let uu____20309 =
                                          let uu____20310 =
                                            sub1
                                              ([],
                                                (action.FStar_Syntax_Syntax.action_defn))
                                             in
                                          FStar_Pervasives_Native.snd
                                            uu____20310
                                           in
                                        let uu____20321 =
                                          let uu____20322 =
                                            sub1
                                              ([],
                                                (action.FStar_Syntax_Syntax.action_typ))
                                             in
                                          FStar_Pervasives_Native.snd
                                            uu____20322
                                           in
                                        {
                                          FStar_Syntax_Syntax.action_name =
                                            uu____20308;
                                          FStar_Syntax_Syntax.action_unqualified_name
                                            =
                                            (action.FStar_Syntax_Syntax.action_unqualified_name);
                                          FStar_Syntax_Syntax.action_univs =
                                            (action.FStar_Syntax_Syntax.action_univs);
                                          FStar_Syntax_Syntax.action_params =
                                            (action.FStar_Syntax_Syntax.action_params);
                                          FStar_Syntax_Syntax.action_defn =
                                            uu____20309;
                                          FStar_Syntax_Syntax.action_typ =
                                            uu____20321
                                        }) ed.FStar_Syntax_Syntax.actions
                                    in
                                 {
                                   FStar_Syntax_Syntax.cattributes =
                                     cattributes;
                                   FStar_Syntax_Syntax.mname = mname;
                                   FStar_Syntax_Syntax.univs =
                                     (ed.FStar_Syntax_Syntax.univs);
                                   FStar_Syntax_Syntax.binders = binders1;
                                   FStar_Syntax_Syntax.signature =
                                     uu____20264;
                                   FStar_Syntax_Syntax.ret_wp = uu____20276;
                                   FStar_Syntax_Syntax.bind_wp = uu____20277;
                                   FStar_Syntax_Syntax.if_then_else =
                                     uu____20278;
                                   FStar_Syntax_Syntax.ite_wp = uu____20279;
                                   FStar_Syntax_Syntax.stronger = uu____20280;
                                   FStar_Syntax_Syntax.close_wp = uu____20281;
                                   FStar_Syntax_Syntax.assert_p = uu____20282;
                                   FStar_Syntax_Syntax.assume_p = uu____20283;
                                   FStar_Syntax_Syntax.null_wp = uu____20284;
                                   FStar_Syntax_Syntax.trivial = uu____20285;
                                   FStar_Syntax_Syntax.repr = uu____20286;
                                   FStar_Syntax_Syntax.return_repr =
                                     uu____20298;
                                   FStar_Syntax_Syntax.bind_repr =
                                     uu____20299;
                                   FStar_Syntax_Syntax.actions = uu____20300;
                                   FStar_Syntax_Syntax.eff_attrs =
                                     (ed.FStar_Syntax_Syntax.eff_attrs)
                                 }  in
                               let se =
                                 let for_free =
                                   let uu____20335 =
                                     let uu____20336 =
                                       let uu____20343 =
                                         FStar_Syntax_Util.arrow_formals
                                           ed1.FStar_Syntax_Syntax.signature
                                          in
                                       FStar_Pervasives_Native.fst
                                         uu____20343
                                        in
                                     FStar_List.length uu____20336  in
                                   uu____20335 = (Prims.parse_int "1")  in
                                 let uu____20372 =
                                   let uu____20375 =
                                     trans_qual1
                                       (FStar_Pervasives_Native.Some mname)
                                      in
                                   FStar_List.map uu____20375 quals  in
                                 {
                                   FStar_Syntax_Syntax.sigel =
                                     (if for_free
                                      then
                                        FStar_Syntax_Syntax.Sig_new_effect_for_free
                                          ed1
                                      else
                                        FStar_Syntax_Syntax.Sig_new_effect
                                          ed1);
                                   FStar_Syntax_Syntax.sigrng =
                                     (d.FStar_Parser_AST.drange);
                                   FStar_Syntax_Syntax.sigquals = uu____20372;
                                   FStar_Syntax_Syntax.sigmeta =
                                     FStar_Syntax_Syntax.default_sigmeta;
                                   FStar_Syntax_Syntax.sigattrs = []
                                 }  in
                               let monad_env = env2  in
                               let env3 =
                                 FStar_Syntax_DsEnv.push_sigelt env0 se  in
                               let env4 =
                                 FStar_Syntax_DsEnv.push_doc env3 ed_lid
                                   d.FStar_Parser_AST.doc
                                  in
                               let env5 =
                                 FStar_All.pipe_right
                                   ed1.FStar_Syntax_Syntax.actions
                                   (FStar_List.fold_left
                                      (fun env5  ->
                                         fun a  ->
                                           let doc1 =
                                             FStar_Syntax_DsEnv.try_lookup_doc
                                               env5
                                               a.FStar_Syntax_Syntax.action_name
                                              in
                                           let env6 =
                                             let uu____20397 =
                                               FStar_Syntax_Util.action_as_lb
                                                 mname a
                                                 (a.FStar_Syntax_Syntax.action_defn).FStar_Syntax_Syntax.pos
                                                in
                                             FStar_Syntax_DsEnv.push_sigelt
                                               env5 uu____20397
                                              in
                                           FStar_Syntax_DsEnv.push_doc env6
                                             a.FStar_Syntax_Syntax.action_name
                                             doc1) env4)
                                  in
                               let env6 =
                                 let uu____20399 =
                                   FStar_All.pipe_right quals
                                     (FStar_List.contains
                                        FStar_Parser_AST.Reflectable)
                                    in
                                 if uu____20399
                                 then
                                   let reflect_lid =
                                     let uu____20403 =
                                       FStar_Ident.id_of_text "reflect"  in
                                     FStar_All.pipe_right uu____20403
                                       (FStar_Syntax_DsEnv.qualify monad_env)
                                      in
                                   let quals1 =
                                     [FStar_Syntax_Syntax.Assumption;
                                     FStar_Syntax_Syntax.Reflectable mname]
                                      in
                                   let refl_decl =
                                     {
                                       FStar_Syntax_Syntax.sigel =
                                         (FStar_Syntax_Syntax.Sig_declare_typ
                                            (reflect_lid, [],
                                              FStar_Syntax_Syntax.tun));
                                       FStar_Syntax_Syntax.sigrng =
                                         (d.FStar_Parser_AST.drange);
                                       FStar_Syntax_Syntax.sigquals = quals1;
                                       FStar_Syntax_Syntax.sigmeta =
                                         FStar_Syntax_Syntax.default_sigmeta;
                                       FStar_Syntax_Syntax.sigattrs = []
                                     }  in
                                   FStar_Syntax_DsEnv.push_sigelt env5
                                     refl_decl
                                 else env5  in
                               let env7 =
                                 FStar_Syntax_DsEnv.push_doc env6 mname
                                   d.FStar_Parser_AST.doc
                                  in
                               (env7, [se]))))

and (mk_comment_attr :
  FStar_Parser_AST.decl ->
    FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax)
  =
  fun d  ->
    let uu____20415 =
      match d.FStar_Parser_AST.doc with
      | FStar_Pervasives_Native.None  -> ("", [])
      | FStar_Pervasives_Native.Some fsdoc -> fsdoc  in
    match uu____20415 with
    | (text,kv) ->
        let summary =
          match FStar_List.assoc "summary" kv with
          | FStar_Pervasives_Native.None  -> ""
          | FStar_Pervasives_Native.Some s ->
              Prims.strcat "  " (Prims.strcat s "\n")
           in
        let pp =
          match FStar_List.assoc "type" kv with
          | FStar_Pervasives_Native.Some uu____20466 ->
              let uu____20467 =
                let uu____20468 =
                  FStar_Parser_ToDocument.signature_to_document d  in
                FStar_Pprint.pretty_string 0.95 (Prims.parse_int "80")
                  uu____20468
                 in
              Prims.strcat "\n  " uu____20467
          | uu____20469 -> ""  in
        let other =
          FStar_List.filter_map
            (fun uu____20482  ->
               match uu____20482 with
               | (k,v1) ->
                   if (k <> "summary") && (k <> "type")
                   then
                     FStar_Pervasives_Native.Some
                       (Prims.strcat k (Prims.strcat ": " v1))
                   else FStar_Pervasives_Native.None) kv
           in
        let other1 =
          if other <> []
          then Prims.strcat (FStar_String.concat "\n" other) "\n"
          else ""  in
        let str =
          Prims.strcat summary (Prims.strcat pp (Prims.strcat other1 text))
           in
        let fv =
          let uu____20500 = FStar_Ident.lid_of_str "FStar.Pervasives.Comment"
             in
          FStar_Syntax_Syntax.fvar uu____20500
            FStar_Syntax_Syntax.Delta_constant FStar_Pervasives_Native.None
           in
        let arg = FStar_Syntax_Util.exp_string str  in
        let uu____20502 =
          let uu____20511 = FStar_Syntax_Syntax.as_arg arg  in [uu____20511]
           in
        FStar_Syntax_Util.mk_app fv uu____20502

and (desugar_decl :
  env_t ->
    FStar_Parser_AST.decl ->
      (env_t,FStar_Syntax_Syntax.sigelts) FStar_Pervasives_Native.tuple2)
  =
  fun env  ->
    fun d  ->
      let uu____20518 = desugar_decl_noattrs env d  in
      match uu____20518 with
      | (env1,sigelts) ->
          let attrs = d.FStar_Parser_AST.attrs  in
          let attrs1 = FStar_List.map (desugar_term env1) attrs  in
          let attrs2 =
            let uu____20538 = mk_comment_attr d  in uu____20538 :: attrs1  in
          let uu____20543 =
            FStar_List.map
              (fun sigelt  ->
                 let uu___136_20549 = sigelt  in
                 {
                   FStar_Syntax_Syntax.sigel =
                     (uu___136_20549.FStar_Syntax_Syntax.sigel);
                   FStar_Syntax_Syntax.sigrng =
                     (uu___136_20549.FStar_Syntax_Syntax.sigrng);
                   FStar_Syntax_Syntax.sigquals =
                     (uu___136_20549.FStar_Syntax_Syntax.sigquals);
                   FStar_Syntax_Syntax.sigmeta =
                     (uu___136_20549.FStar_Syntax_Syntax.sigmeta);
                   FStar_Syntax_Syntax.sigattrs = attrs2
                 }) sigelts
             in
          (env1, uu____20543)

and (desugar_decl_noattrs :
  env_t ->
    FStar_Parser_AST.decl ->
      (env_t,FStar_Syntax_Syntax.sigelts) FStar_Pervasives_Native.tuple2)
  =
  fun env  ->
    fun d  ->
      let trans_qual1 = trans_qual d.FStar_Parser_AST.drange  in
      match d.FStar_Parser_AST.d with
      | FStar_Parser_AST.Pragma p ->
          let se =
            {
              FStar_Syntax_Syntax.sigel =
                (FStar_Syntax_Syntax.Sig_pragma (trans_pragma p));
              FStar_Syntax_Syntax.sigrng = (d.FStar_Parser_AST.drange);
              FStar_Syntax_Syntax.sigquals = [];
              FStar_Syntax_Syntax.sigmeta =
                FStar_Syntax_Syntax.default_sigmeta;
              FStar_Syntax_Syntax.sigattrs = []
            }  in
          (if p = FStar_Parser_AST.LightOff
           then FStar_Options.set_ml_ish ()
           else ();
           (env, [se]))
      | FStar_Parser_AST.Fsdoc uu____20579 -> (env, [])
      | FStar_Parser_AST.TopLevelModule id1 -> (env, [])
      | FStar_Parser_AST.Open lid ->
          let env1 = FStar_Syntax_DsEnv.push_namespace env lid  in (env1, [])
      | FStar_Parser_AST.Include lid ->
          let env1 = FStar_Syntax_DsEnv.push_include env lid  in (env1, [])
      | FStar_Parser_AST.ModuleAbbrev (x,l) ->
          let uu____20595 = FStar_Syntax_DsEnv.push_module_abbrev env x l  in
          (uu____20595, [])
      | FStar_Parser_AST.Tycon (is_effect,tcs) ->
          let quals =
            if is_effect
            then FStar_Parser_AST.Effect_qual :: (d.FStar_Parser_AST.quals)
            else d.FStar_Parser_AST.quals  in
          let tcs1 =
            FStar_List.map
              (fun uu____20634  ->
                 match uu____20634 with | (x,uu____20642) -> x) tcs
             in
          let uu____20647 =
            FStar_List.map (trans_qual1 FStar_Pervasives_Native.None) quals
             in
          desugar_tycon env d uu____20647 tcs1
      | FStar_Parser_AST.TopLevelLet (isrec,lets) ->
          let quals = d.FStar_Parser_AST.quals  in
          let expand_toplevel_pattern =
            (isrec = FStar_Parser_AST.NoLetQualifier) &&
              (match lets with
               | ({
                    FStar_Parser_AST.pat = FStar_Parser_AST.PatOp uu____20669;
                    FStar_Parser_AST.prange = uu____20670;_},uu____20671)::[]
                   -> false
               | ({
                    FStar_Parser_AST.pat = FStar_Parser_AST.PatVar
                      uu____20680;
                    FStar_Parser_AST.prange = uu____20681;_},uu____20682)::[]
                   -> false
               | ({
                    FStar_Parser_AST.pat = FStar_Parser_AST.PatAscribed
                      ({
                         FStar_Parser_AST.pat = FStar_Parser_AST.PatVar
                           uu____20697;
                         FStar_Parser_AST.prange = uu____20698;_},uu____20699);
                    FStar_Parser_AST.prange = uu____20700;_},uu____20701)::[]
                   -> false
               | (p,uu____20729)::[] ->
                   let uu____20738 = is_app_pattern p  in
                   Prims.op_Negation uu____20738
               | uu____20739 -> false)
             in
          if Prims.op_Negation expand_toplevel_pattern
          then
            let lets1 =
              FStar_List.map (fun x  -> (FStar_Pervasives_Native.None, x))
                lets
               in
            let as_inner_let =
              FStar_Parser_AST.mk_term
                (FStar_Parser_AST.Let
                   (isrec, lets1,
                     (FStar_Parser_AST.mk_term
                        (FStar_Parser_AST.Const FStar_Const.Const_unit)
                        d.FStar_Parser_AST.drange FStar_Parser_AST.Expr)))
                d.FStar_Parser_AST.drange FStar_Parser_AST.Expr
               in
            let uu____20812 = desugar_term_maybe_top true env as_inner_let
               in
            (match uu____20812 with
             | (ds_lets,aq) ->
                 (check_no_aq aq;
                  (let uu____20824 =
                     let uu____20825 =
                       FStar_All.pipe_left FStar_Syntax_Subst.compress
                         ds_lets
                        in
                     uu____20825.FStar_Syntax_Syntax.n  in
                   match uu____20824 with
                   | FStar_Syntax_Syntax.Tm_let (lbs,uu____20833) ->
                       let fvs =
                         FStar_All.pipe_right
                           (FStar_Pervasives_Native.snd lbs)
                           (FStar_List.map
                              (fun lb  ->
                                 FStar_Util.right
                                   lb.FStar_Syntax_Syntax.lbname))
                          in
                       let quals1 =
                         match quals with
                         | uu____20866::uu____20867 ->
                             FStar_List.map
                               (trans_qual1 FStar_Pervasives_Native.None)
                               quals
                         | uu____20870 ->
                             FStar_All.pipe_right
                               (FStar_Pervasives_Native.snd lbs)
                               (FStar_List.collect
                                  (fun uu___110_20885  ->
                                     match uu___110_20885 with
                                     | {
                                         FStar_Syntax_Syntax.lbname =
                                           FStar_Util.Inl uu____20888;
                                         FStar_Syntax_Syntax.lbunivs =
                                           uu____20889;
                                         FStar_Syntax_Syntax.lbtyp =
                                           uu____20890;
                                         FStar_Syntax_Syntax.lbeff =
                                           uu____20891;
                                         FStar_Syntax_Syntax.lbdef =
                                           uu____20892;
                                         FStar_Syntax_Syntax.lbattrs =
                                           uu____20893;
                                         FStar_Syntax_Syntax.lbpos =
                                           uu____20894;_}
                                         -> []
                                     | {
                                         FStar_Syntax_Syntax.lbname =
                                           FStar_Util.Inr fv;
                                         FStar_Syntax_Syntax.lbunivs =
                                           uu____20906;
                                         FStar_Syntax_Syntax.lbtyp =
                                           uu____20907;
                                         FStar_Syntax_Syntax.lbeff =
                                           uu____20908;
                                         FStar_Syntax_Syntax.lbdef =
                                           uu____20909;
                                         FStar_Syntax_Syntax.lbattrs =
                                           uu____20910;
                                         FStar_Syntax_Syntax.lbpos =
                                           uu____20911;_}
                                         ->
                                         FStar_Syntax_DsEnv.lookup_letbinding_quals
                                           env
                                           (fv.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v))
                          in
                       let quals2 =
                         let uu____20925 =
                           FStar_All.pipe_right lets1
                             (FStar_Util.for_some
                                (fun uu____20956  ->
                                   match uu____20956 with
                                   | (uu____20969,(uu____20970,t)) ->
                                       t.FStar_Parser_AST.level =
                                         FStar_Parser_AST.Formula))
                            in
                         if uu____20925
                         then FStar_Syntax_Syntax.Logic :: quals1
                         else quals1  in
                       let lbs1 =
                         let uu____20994 =
                           FStar_All.pipe_right quals2
                             (FStar_List.contains
                                FStar_Syntax_Syntax.Abstract)
                            in
                         if uu____20994
                         then
                           let uu____21003 =
                             FStar_All.pipe_right
                               (FStar_Pervasives_Native.snd lbs)
                               (FStar_List.map
                                  (fun lb  ->
                                     let fv =
                                       FStar_Util.right
                                         lb.FStar_Syntax_Syntax.lbname
                                        in
                                     let uu___137_21017 = lb  in
                                     {
                                       FStar_Syntax_Syntax.lbname =
                                         (FStar_Util.Inr
                                            (let uu___138_21019 = fv  in
                                             {
                                               FStar_Syntax_Syntax.fv_name =
                                                 (uu___138_21019.FStar_Syntax_Syntax.fv_name);
                                               FStar_Syntax_Syntax.fv_delta =
                                                 (FStar_Syntax_Syntax.Delta_abstract
                                                    (fv.FStar_Syntax_Syntax.fv_delta));
                                               FStar_Syntax_Syntax.fv_qual =
                                                 (uu___138_21019.FStar_Syntax_Syntax.fv_qual)
                                             }));
                                       FStar_Syntax_Syntax.lbunivs =
                                         (uu___137_21017.FStar_Syntax_Syntax.lbunivs);
                                       FStar_Syntax_Syntax.lbtyp =
                                         (uu___137_21017.FStar_Syntax_Syntax.lbtyp);
                                       FStar_Syntax_Syntax.lbeff =
                                         (uu___137_21017.FStar_Syntax_Syntax.lbeff);
                                       FStar_Syntax_Syntax.lbdef =
                                         (uu___137_21017.FStar_Syntax_Syntax.lbdef);
                                       FStar_Syntax_Syntax.lbattrs =
                                         (uu___137_21017.FStar_Syntax_Syntax.lbattrs);
                                       FStar_Syntax_Syntax.lbpos =
                                         (uu___137_21017.FStar_Syntax_Syntax.lbpos)
                                     }))
                              in
                           ((FStar_Pervasives_Native.fst lbs), uu____21003)
                         else lbs  in
                       let names1 =
                         FStar_All.pipe_right fvs
                           (FStar_List.map
                              (fun fv  ->
                                 (fv.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v))
                          in
                       let attrs =
                         FStar_List.map (desugar_term env)
                           d.FStar_Parser_AST.attrs
                          in
                       let s =
                         {
                           FStar_Syntax_Syntax.sigel =
                             (FStar_Syntax_Syntax.Sig_let (lbs1, names1));
                           FStar_Syntax_Syntax.sigrng =
                             (d.FStar_Parser_AST.drange);
                           FStar_Syntax_Syntax.sigquals = quals2;
                           FStar_Syntax_Syntax.sigmeta =
                             FStar_Syntax_Syntax.default_sigmeta;
                           FStar_Syntax_Syntax.sigattrs = attrs
                         }  in
                       let env1 = FStar_Syntax_DsEnv.push_sigelt env s  in
                       let env2 =
                         FStar_List.fold_left
                           (fun env2  ->
                              fun id1  ->
                                FStar_Syntax_DsEnv.push_doc env2 id1
                                  d.FStar_Parser_AST.doc) env1 names1
                          in
                       (env2, [s])
                   | uu____21054 ->
                       failwith "Desugaring a let did not produce a let")))
          else
            (let uu____21060 =
               match lets with
               | (pat,body)::[] -> (pat, body)
               | uu____21079 ->
                   failwith
                     "expand_toplevel_pattern should only allow single definition lets"
                in
             match uu____21060 with
             | (pat,body) ->
                 let fresh_toplevel_name =
                   FStar_Ident.gen FStar_Range.dummyRange  in
                 let fresh_pat =
                   let var_pat =
                     FStar_Parser_AST.mk_pattern
                       (FStar_Parser_AST.PatVar
                          (fresh_toplevel_name, FStar_Pervasives_Native.None))
                       FStar_Range.dummyRange
                      in
                   match pat.FStar_Parser_AST.pat with
                   | FStar_Parser_AST.PatAscribed (pat1,ty) ->
                       let uu___139_21115 = pat1  in
                       {
                         FStar_Parser_AST.pat =
                           (FStar_Parser_AST.PatAscribed (var_pat, ty));
                         FStar_Parser_AST.prange =
                           (uu___139_21115.FStar_Parser_AST.prange)
                       }
                   | uu____21122 -> var_pat  in
                 let main_let =
                   desugar_decl env
                     (let uu___140_21129 = d  in
                      {
                        FStar_Parser_AST.d =
                          (FStar_Parser_AST.TopLevelLet
                             (isrec, [(fresh_pat, body)]));
                        FStar_Parser_AST.drange =
                          (uu___140_21129.FStar_Parser_AST.drange);
                        FStar_Parser_AST.doc =
                          (uu___140_21129.FStar_Parser_AST.doc);
                        FStar_Parser_AST.quals = (FStar_Parser_AST.Private ::
                          (d.FStar_Parser_AST.quals));
                        FStar_Parser_AST.attrs =
                          (uu___140_21129.FStar_Parser_AST.attrs)
                      })
                    in
                 let build_projection uu____21165 id1 =
                   match uu____21165 with
                   | (env1,ses) ->
                       let main =
                         let uu____21186 =
                           let uu____21187 =
                             FStar_Ident.lid_of_ids [fresh_toplevel_name]  in
                           FStar_Parser_AST.Var uu____21187  in
                         FStar_Parser_AST.mk_term uu____21186
                           FStar_Range.dummyRange FStar_Parser_AST.Expr
                          in
                       let lid = FStar_Ident.lid_of_ids [id1]  in
                       let projectee =
                         FStar_Parser_AST.mk_term (FStar_Parser_AST.Var lid)
                           FStar_Range.dummyRange FStar_Parser_AST.Expr
                          in
                       let body1 =
                         FStar_Parser_AST.mk_term
                           (FStar_Parser_AST.Match
                              (main,
                                [(pat, FStar_Pervasives_Native.None,
                                   projectee)])) FStar_Range.dummyRange
                           FStar_Parser_AST.Expr
                          in
                       let bv_pat =
                         FStar_Parser_AST.mk_pattern
                           (FStar_Parser_AST.PatVar
                              (id1, FStar_Pervasives_Native.None))
                           FStar_Range.dummyRange
                          in
                       let id_decl =
                         FStar_Parser_AST.mk_decl
                           (FStar_Parser_AST.TopLevelLet
                              (FStar_Parser_AST.NoLetQualifier,
                                [(bv_pat, body1)])) FStar_Range.dummyRange []
                          in
                       let uu____21237 = desugar_decl env1 id_decl  in
                       (match uu____21237 with
                        | (env2,ses') -> (env2, (FStar_List.append ses ses')))
                    in
                 let bvs =
                   let uu____21255 = gather_pattern_bound_vars pat  in
                   FStar_All.pipe_right uu____21255 FStar_Util.set_elements
                    in
                 FStar_List.fold_left build_projection main_let bvs)
      | FStar_Parser_AST.Main t ->
          let e = desugar_term env t  in
          let se =
            {
              FStar_Syntax_Syntax.sigel = (FStar_Syntax_Syntax.Sig_main e);
              FStar_Syntax_Syntax.sigrng = (d.FStar_Parser_AST.drange);
              FStar_Syntax_Syntax.sigquals = [];
              FStar_Syntax_Syntax.sigmeta =
                FStar_Syntax_Syntax.default_sigmeta;
              FStar_Syntax_Syntax.sigattrs = []
            }  in
          (env, [se])
      | FStar_Parser_AST.Assume (id1,t) ->
          let f = desugar_formula env t  in
          let lid = FStar_Syntax_DsEnv.qualify env id1  in
          let env1 =
            FStar_Syntax_DsEnv.push_doc env lid d.FStar_Parser_AST.doc  in
          (env1,
            [{
               FStar_Syntax_Syntax.sigel =
                 (FStar_Syntax_Syntax.Sig_assume (lid, [], f));
               FStar_Syntax_Syntax.sigrng = (d.FStar_Parser_AST.drange);
               FStar_Syntax_Syntax.sigquals =
                 [FStar_Syntax_Syntax.Assumption];
               FStar_Syntax_Syntax.sigmeta =
                 FStar_Syntax_Syntax.default_sigmeta;
               FStar_Syntax_Syntax.sigattrs = []
             }])
      | FStar_Parser_AST.Val (id1,t) ->
          let quals = d.FStar_Parser_AST.quals  in
          let t1 =
            let uu____21286 = close_fun env t  in
            desugar_term env uu____21286  in
          let quals1 =
            let uu____21290 =
              (FStar_Syntax_DsEnv.iface env) &&
                (FStar_Syntax_DsEnv.admitted_iface env)
               in
            if uu____21290
            then FStar_Parser_AST.Assumption :: quals
            else quals  in
          let lid = FStar_Syntax_DsEnv.qualify env id1  in
          let se =
            let uu____21296 =
              FStar_List.map (trans_qual1 FStar_Pervasives_Native.None)
                quals1
               in
            {
              FStar_Syntax_Syntax.sigel =
                (FStar_Syntax_Syntax.Sig_declare_typ (lid, [], t1));
              FStar_Syntax_Syntax.sigrng = (d.FStar_Parser_AST.drange);
              FStar_Syntax_Syntax.sigquals = uu____21296;
              FStar_Syntax_Syntax.sigmeta =
                FStar_Syntax_Syntax.default_sigmeta;
              FStar_Syntax_Syntax.sigattrs = []
            }  in
          let env1 = FStar_Syntax_DsEnv.push_sigelt env se  in
          let env2 =
            FStar_Syntax_DsEnv.push_doc env1 lid d.FStar_Parser_AST.doc  in
          (env2, [se])
      | FStar_Parser_AST.Exception (id1,FStar_Pervasives_Native.None ) ->
          let uu____21308 =
            FStar_Syntax_DsEnv.fail_or env
              (FStar_Syntax_DsEnv.try_lookup_lid env)
              FStar_Parser_Const.exn_lid
             in
          (match uu____21308 with
           | (t,uu____21322) ->
               let l = FStar_Syntax_DsEnv.qualify env id1  in
               let qual = [FStar_Syntax_Syntax.ExceptionConstructor]  in
               let se =
                 {
                   FStar_Syntax_Syntax.sigel =
                     (FStar_Syntax_Syntax.Sig_datacon
                        (l, [], t, FStar_Parser_Const.exn_lid,
                          (Prims.parse_int "0"),
                          [FStar_Parser_Const.exn_lid]));
                   FStar_Syntax_Syntax.sigrng = (d.FStar_Parser_AST.drange);
                   FStar_Syntax_Syntax.sigquals = qual;
                   FStar_Syntax_Syntax.sigmeta =
                     FStar_Syntax_Syntax.default_sigmeta;
                   FStar_Syntax_Syntax.sigattrs = []
                 }  in
               let se' =
                 {
                   FStar_Syntax_Syntax.sigel =
                     (FStar_Syntax_Syntax.Sig_bundle ([se], [l]));
                   FStar_Syntax_Syntax.sigrng = (d.FStar_Parser_AST.drange);
                   FStar_Syntax_Syntax.sigquals = qual;
                   FStar_Syntax_Syntax.sigmeta =
                     FStar_Syntax_Syntax.default_sigmeta;
                   FStar_Syntax_Syntax.sigattrs = []
                 }  in
               let env1 = FStar_Syntax_DsEnv.push_sigelt env se'  in
               let env2 =
                 FStar_Syntax_DsEnv.push_doc env1 l d.FStar_Parser_AST.doc
                  in
               let data_ops = mk_data_projector_names [] env2 se  in
               let discs = mk_data_discriminators [] env2 [l]  in
               let env3 =
                 FStar_List.fold_left FStar_Syntax_DsEnv.push_sigelt env2
                   (FStar_List.append discs data_ops)
                  in
               (env3, (FStar_List.append (se' :: discs) data_ops)))
      | FStar_Parser_AST.Exception (id1,FStar_Pervasives_Native.Some term) ->
          let t = desugar_term env term  in
          let t1 =
            let uu____21356 =
              let uu____21363 = FStar_Syntax_Syntax.null_binder t  in
              [uu____21363]  in
            let uu____21364 =
              let uu____21367 =
                let uu____21368 =
                  FStar_Syntax_DsEnv.fail_or env
                    (FStar_Syntax_DsEnv.try_lookup_lid env)
                    FStar_Parser_Const.exn_lid
                   in
                FStar_Pervasives_Native.fst uu____21368  in
              FStar_All.pipe_left FStar_Syntax_Syntax.mk_Total uu____21367
               in
            FStar_Syntax_Util.arrow uu____21356 uu____21364  in
          let l = FStar_Syntax_DsEnv.qualify env id1  in
          let qual = [FStar_Syntax_Syntax.ExceptionConstructor]  in
          let se =
            {
              FStar_Syntax_Syntax.sigel =
                (FStar_Syntax_Syntax.Sig_datacon
                   (l, [], t1, FStar_Parser_Const.exn_lid,
                     (Prims.parse_int "0"), [FStar_Parser_Const.exn_lid]));
              FStar_Syntax_Syntax.sigrng = (d.FStar_Parser_AST.drange);
              FStar_Syntax_Syntax.sigquals = qual;
              FStar_Syntax_Syntax.sigmeta =
                FStar_Syntax_Syntax.default_sigmeta;
              FStar_Syntax_Syntax.sigattrs = []
            }  in
          let se' =
            {
              FStar_Syntax_Syntax.sigel =
                (FStar_Syntax_Syntax.Sig_bundle ([se], [l]));
              FStar_Syntax_Syntax.sigrng = (d.FStar_Parser_AST.drange);
              FStar_Syntax_Syntax.sigquals = qual;
              FStar_Syntax_Syntax.sigmeta =
                FStar_Syntax_Syntax.default_sigmeta;
              FStar_Syntax_Syntax.sigattrs = []
            }  in
          let env1 = FStar_Syntax_DsEnv.push_sigelt env se'  in
          let env2 =
            FStar_Syntax_DsEnv.push_doc env1 l d.FStar_Parser_AST.doc  in
          let data_ops = mk_data_projector_names [] env2 se  in
          let discs = mk_data_discriminators [] env2 [l]  in
          let env3 =
            FStar_List.fold_left FStar_Syntax_DsEnv.push_sigelt env2
              (FStar_List.append discs data_ops)
             in
          (env3, (FStar_List.append (se' :: discs) data_ops))
      | FStar_Parser_AST.NewEffect (FStar_Parser_AST.RedefineEffect
          (eff_name,eff_binders,defn)) ->
          let quals = d.FStar_Parser_AST.quals  in
          desugar_redefine_effect env d trans_qual1 quals eff_name
            eff_binders defn
      | FStar_Parser_AST.NewEffect (FStar_Parser_AST.DefineEffect
          (eff_name,eff_binders,eff_typ,eff_decls)) ->
          let quals = d.FStar_Parser_AST.quals  in
          let attrs = d.FStar_Parser_AST.attrs  in
          desugar_effect env d quals eff_name eff_binders eff_typ eff_decls
            attrs
      | FStar_Parser_AST.SubEffect l ->
          let lookup1 l1 =
            let uu____21433 =
              FStar_Syntax_DsEnv.try_lookup_effect_name env l1  in
            match uu____21433 with
            | FStar_Pervasives_Native.None  ->
                let uu____21436 =
                  let uu____21441 =
                    let uu____21442 =
                      let uu____21443 = FStar_Syntax_Print.lid_to_string l1
                         in
                      Prims.strcat uu____21443 " not found"  in
                    Prims.strcat "Effect name " uu____21442  in
                  (FStar_Errors.Fatal_EffectNotFound, uu____21441)  in
                FStar_Errors.raise_error uu____21436
                  d.FStar_Parser_AST.drange
            | FStar_Pervasives_Native.Some l2 -> l2  in
          let src = lookup1 l.FStar_Parser_AST.msource  in
          let dst = lookup1 l.FStar_Parser_AST.mdest  in
          let uu____21447 =
            match l.FStar_Parser_AST.lift_op with
            | FStar_Parser_AST.NonReifiableLift t ->
                let uu____21489 =
                  let uu____21498 =
                    let uu____21505 = desugar_term env t  in
                    ([], uu____21505)  in
                  FStar_Pervasives_Native.Some uu____21498  in
                (uu____21489, FStar_Pervasives_Native.None)
            | FStar_Parser_AST.ReifiableLift (wp,t) ->
                let uu____21538 =
                  let uu____21547 =
                    let uu____21554 = desugar_term env wp  in
                    ([], uu____21554)  in
                  FStar_Pervasives_Native.Some uu____21547  in
                let uu____21563 =
                  let uu____21572 =
                    let uu____21579 = desugar_term env t  in
                    ([], uu____21579)  in
                  FStar_Pervasives_Native.Some uu____21572  in
                (uu____21538, uu____21563)
            | FStar_Parser_AST.LiftForFree t ->
                let uu____21605 =
                  let uu____21614 =
                    let uu____21621 = desugar_term env t  in
                    ([], uu____21621)  in
                  FStar_Pervasives_Native.Some uu____21614  in
                (FStar_Pervasives_Native.None, uu____21605)
             in
          (match uu____21447 with
           | (lift_wp,lift) ->
               let se =
                 {
                   FStar_Syntax_Syntax.sigel =
                     (FStar_Syntax_Syntax.Sig_sub_effect
                        {
                          FStar_Syntax_Syntax.source = src;
                          FStar_Syntax_Syntax.target = dst;
                          FStar_Syntax_Syntax.lift_wp = lift_wp;
                          FStar_Syntax_Syntax.lift = lift
                        });
                   FStar_Syntax_Syntax.sigrng = (d.FStar_Parser_AST.drange);
                   FStar_Syntax_Syntax.sigquals = [];
                   FStar_Syntax_Syntax.sigmeta =
                     FStar_Syntax_Syntax.default_sigmeta;
                   FStar_Syntax_Syntax.sigattrs = []
                 }  in
               (env, [se]))
      | FStar_Parser_AST.Splice (ids,t) ->
          let t1 = desugar_term env t  in
          let se =
            let uu____21701 =
              let uu____21702 =
                let uu____21709 =
                  FStar_List.map (FStar_Syntax_DsEnv.qualify env) ids  in
                (uu____21709, t1)  in
              FStar_Syntax_Syntax.Sig_splice uu____21702  in
            {
              FStar_Syntax_Syntax.sigel = uu____21701;
              FStar_Syntax_Syntax.sigrng = (d.FStar_Parser_AST.drange);
              FStar_Syntax_Syntax.sigquals = [];
              FStar_Syntax_Syntax.sigmeta =
                FStar_Syntax_Syntax.default_sigmeta;
              FStar_Syntax_Syntax.sigattrs = []
            }  in
          let env1 = FStar_Syntax_DsEnv.push_sigelt env se  in (env1, [se])

let (desugar_decls :
  env_t ->
    FStar_Parser_AST.decl Prims.list ->
      (env_t,FStar_Syntax_Syntax.sigelt Prims.list)
        FStar_Pervasives_Native.tuple2)
  =
  fun env  ->
    fun decls  ->
      let uu____21737 =
        FStar_List.fold_left
          (fun uu____21757  ->
             fun d  ->
               match uu____21757 with
               | (env1,sigelts) ->
                   let uu____21777 = desugar_decl env1 d  in
                   (match uu____21777 with
                    | (env2,se) -> (env2, (FStar_List.append sigelts se))))
          (env, []) decls
         in
      match uu____21737 with
      | (env1,sigelts) ->
          let rec forward acc uu___112_21822 =
            match uu___112_21822 with
            | se1::se2::sigelts1 ->
                (match ((se1.FStar_Syntax_Syntax.sigel),
                         (se2.FStar_Syntax_Syntax.sigel))
                 with
                 | (FStar_Syntax_Syntax.Sig_declare_typ
                    uu____21836,FStar_Syntax_Syntax.Sig_let uu____21837) ->
                     let uu____21850 =
                       let uu____21853 =
                         let uu___141_21854 = se2  in
                         let uu____21855 =
                           let uu____21858 =
                             FStar_List.filter
                               (fun uu___111_21872  ->
                                  match uu___111_21872 with
                                  | {
                                      FStar_Syntax_Syntax.n =
                                        FStar_Syntax_Syntax.Tm_app
                                        ({
                                           FStar_Syntax_Syntax.n =
                                             FStar_Syntax_Syntax.Tm_fvar fv;
                                           FStar_Syntax_Syntax.pos =
                                             uu____21876;
                                           FStar_Syntax_Syntax.vars =
                                             uu____21877;_},uu____21878);
                                      FStar_Syntax_Syntax.pos = uu____21879;
                                      FStar_Syntax_Syntax.vars = uu____21880;_}
                                      when
                                      let uu____21903 =
                                        let uu____21904 =
                                          FStar_Syntax_Syntax.lid_of_fv fv
                                           in
                                        FStar_Ident.string_of_lid uu____21904
                                         in
                                      uu____21903 =
                                        "FStar.Pervasives.Comment"
                                      -> true
                                  | uu____21905 -> false)
                               se1.FStar_Syntax_Syntax.sigattrs
                              in
                           FStar_List.append uu____21858
                             se2.FStar_Syntax_Syntax.sigattrs
                            in
                         {
                           FStar_Syntax_Syntax.sigel =
                             (uu___141_21854.FStar_Syntax_Syntax.sigel);
                           FStar_Syntax_Syntax.sigrng =
                             (uu___141_21854.FStar_Syntax_Syntax.sigrng);
                           FStar_Syntax_Syntax.sigquals =
                             (uu___141_21854.FStar_Syntax_Syntax.sigquals);
                           FStar_Syntax_Syntax.sigmeta =
                             (uu___141_21854.FStar_Syntax_Syntax.sigmeta);
                           FStar_Syntax_Syntax.sigattrs = uu____21855
                         }  in
                       uu____21853 :: se1 :: acc  in
                     forward uu____21850 sigelts1
                 | uu____21910 -> forward (se1 :: acc) (se2 :: sigelts1))
            | sigelts1 -> FStar_List.rev_append acc sigelts1  in
          let uu____21918 = forward [] sigelts  in (env1, uu____21918)
  
let (open_prims_all :
  (FStar_Parser_AST.decoration Prims.list -> FStar_Parser_AST.decl)
    Prims.list)
  =
  [FStar_Parser_AST.mk_decl
     (FStar_Parser_AST.Open FStar_Parser_Const.prims_lid)
     FStar_Range.dummyRange;
  FStar_Parser_AST.mk_decl (FStar_Parser_AST.Open FStar_Parser_Const.all_lid)
    FStar_Range.dummyRange]
  
let (generalize_annotated_univs :
  FStar_Syntax_Syntax.sigelt -> FStar_Syntax_Syntax.sigelt) =
  fun s  ->
    let bs_univnames bs =
      let uu____21960 =
        let uu____21967 =
          FStar_Util.new_set FStar_Syntax_Syntax.order_univ_name  in
        FStar_List.fold_left
          (fun uvs  ->
             fun uu____21984  ->
               match uu____21984 with
               | ({ FStar_Syntax_Syntax.ppname = uu____21993;
                    FStar_Syntax_Syntax.index = uu____21994;
                    FStar_Syntax_Syntax.sort = t;_},uu____21996)
                   ->
                   let uu____21999 = FStar_Syntax_Free.univnames t  in
                   FStar_Util.set_union uvs uu____21999) uu____21967
         in
      FStar_All.pipe_right bs uu____21960  in
    let empty_set = FStar_Util.new_set FStar_Syntax_Syntax.order_univ_name
       in
    match s.FStar_Syntax_Syntax.sigel with
    | FStar_Syntax_Syntax.Sig_inductive_typ uu____22007 ->
        failwith
          "Impossible: collect_annotated_universes: bare data/type constructor"
    | FStar_Syntax_Syntax.Sig_datacon uu____22024 ->
        failwith
          "Impossible: collect_annotated_universes: bare data/type constructor"
    | FStar_Syntax_Syntax.Sig_bundle (sigs,lids) ->
        let uvs =
          let uu____22052 =
            FStar_All.pipe_right sigs
              (FStar_List.fold_left
                 (fun uvs  ->
                    fun se  ->
                      let se_univs =
                        match se.FStar_Syntax_Syntax.sigel with
                        | FStar_Syntax_Syntax.Sig_inductive_typ
                            (uu____22073,uu____22074,bs,t,uu____22077,uu____22078)
                            ->
                            let uu____22087 = bs_univnames bs  in
                            let uu____22090 = FStar_Syntax_Free.univnames t
                               in
                            FStar_Util.set_union uu____22087 uu____22090
                        | FStar_Syntax_Syntax.Sig_datacon
                            (uu____22093,uu____22094,t,uu____22096,uu____22097,uu____22098)
                            -> FStar_Syntax_Free.univnames t
                        | uu____22103 ->
                            failwith
                              "Impossible: collect_annotated_universes: Sig_bundle should not have a non data/type sigelt"
                         in
                      FStar_Util.set_union uvs se_univs) empty_set)
             in
          FStar_All.pipe_right uu____22052 FStar_Util.set_elements  in
        let usubst = FStar_Syntax_Subst.univ_var_closing uvs  in
        let uu___142_22113 = s  in
        let uu____22114 =
          let uu____22115 =
            let uu____22124 =
              FStar_All.pipe_right sigs
                (FStar_List.map
                   (fun se  ->
                      match se.FStar_Syntax_Syntax.sigel with
                      | FStar_Syntax_Syntax.Sig_inductive_typ
                          (lid,uu____22142,bs,t,lids1,lids2) ->
                          let uu___143_22155 = se  in
                          let uu____22156 =
                            let uu____22157 =
                              let uu____22174 =
                                FStar_Syntax_Subst.subst_binders usubst bs
                                 in
                              let uu____22175 =
                                let uu____22176 =
                                  FStar_Syntax_Subst.shift_subst
                                    (FStar_List.length bs) usubst
                                   in
                                FStar_Syntax_Subst.subst uu____22176 t  in
                              (lid, uvs, uu____22174, uu____22175, lids1,
                                lids2)
                               in
                            FStar_Syntax_Syntax.Sig_inductive_typ uu____22157
                             in
                          {
                            FStar_Syntax_Syntax.sigel = uu____22156;
                            FStar_Syntax_Syntax.sigrng =
                              (uu___143_22155.FStar_Syntax_Syntax.sigrng);
                            FStar_Syntax_Syntax.sigquals =
                              (uu___143_22155.FStar_Syntax_Syntax.sigquals);
                            FStar_Syntax_Syntax.sigmeta =
                              (uu___143_22155.FStar_Syntax_Syntax.sigmeta);
                            FStar_Syntax_Syntax.sigattrs =
                              (uu___143_22155.FStar_Syntax_Syntax.sigattrs)
                          }
                      | FStar_Syntax_Syntax.Sig_datacon
                          (lid,uu____22190,t,tlid,n1,lids1) ->
                          let uu___144_22199 = se  in
                          let uu____22200 =
                            let uu____22201 =
                              let uu____22216 =
                                FStar_Syntax_Subst.subst usubst t  in
                              (lid, uvs, uu____22216, tlid, n1, lids1)  in
                            FStar_Syntax_Syntax.Sig_datacon uu____22201  in
                          {
                            FStar_Syntax_Syntax.sigel = uu____22200;
                            FStar_Syntax_Syntax.sigrng =
                              (uu___144_22199.FStar_Syntax_Syntax.sigrng);
                            FStar_Syntax_Syntax.sigquals =
                              (uu___144_22199.FStar_Syntax_Syntax.sigquals);
                            FStar_Syntax_Syntax.sigmeta =
                              (uu___144_22199.FStar_Syntax_Syntax.sigmeta);
                            FStar_Syntax_Syntax.sigattrs =
                              (uu___144_22199.FStar_Syntax_Syntax.sigattrs)
                          }
                      | uu____22221 ->
                          failwith
                            "Impossible: collect_annotated_universes: Sig_bundle should not have a non data/type sigelt"))
               in
            (uu____22124, lids)  in
          FStar_Syntax_Syntax.Sig_bundle uu____22115  in
        {
          FStar_Syntax_Syntax.sigel = uu____22114;
          FStar_Syntax_Syntax.sigrng =
            (uu___142_22113.FStar_Syntax_Syntax.sigrng);
          FStar_Syntax_Syntax.sigquals =
            (uu___142_22113.FStar_Syntax_Syntax.sigquals);
          FStar_Syntax_Syntax.sigmeta =
            (uu___142_22113.FStar_Syntax_Syntax.sigmeta);
          FStar_Syntax_Syntax.sigattrs =
            (uu___142_22113.FStar_Syntax_Syntax.sigattrs)
        }
    | FStar_Syntax_Syntax.Sig_declare_typ (lid,uu____22227,t) ->
        let uvs =
          let uu____22232 = FStar_Syntax_Free.univnames t  in
          FStar_All.pipe_right uu____22232 FStar_Util.set_elements  in
        let uu___145_22239 = s  in
        let uu____22240 =
          let uu____22241 =
            let uu____22248 = FStar_Syntax_Subst.close_univ_vars uvs t  in
            (lid, uvs, uu____22248)  in
          FStar_Syntax_Syntax.Sig_declare_typ uu____22241  in
        {
          FStar_Syntax_Syntax.sigel = uu____22240;
          FStar_Syntax_Syntax.sigrng =
            (uu___145_22239.FStar_Syntax_Syntax.sigrng);
          FStar_Syntax_Syntax.sigquals =
            (uu___145_22239.FStar_Syntax_Syntax.sigquals);
          FStar_Syntax_Syntax.sigmeta =
            (uu___145_22239.FStar_Syntax_Syntax.sigmeta);
          FStar_Syntax_Syntax.sigattrs =
            (uu___145_22239.FStar_Syntax_Syntax.sigattrs)
        }
    | FStar_Syntax_Syntax.Sig_let ((b,lbs),lids) ->
        let lb_univnames lb =
          let uu____22278 =
            FStar_Syntax_Free.univnames lb.FStar_Syntax_Syntax.lbtyp  in
          let uu____22281 =
            match (lb.FStar_Syntax_Syntax.lbdef).FStar_Syntax_Syntax.n with
            | FStar_Syntax_Syntax.Tm_abs (bs,e,uu____22288) ->
                let uvs1 = bs_univnames bs  in
                let uvs2 =
                  match e.FStar_Syntax_Syntax.n with
                  | FStar_Syntax_Syntax.Tm_ascribed
                      (uu____22317,(FStar_Util.Inl t,uu____22319),uu____22320)
                      -> FStar_Syntax_Free.univnames t
                  | FStar_Syntax_Syntax.Tm_ascribed
                      (uu____22367,(FStar_Util.Inr c,uu____22369),uu____22370)
                      -> FStar_Syntax_Free.univnames_comp c
                  | uu____22417 -> empty_set  in
                FStar_Util.set_union uvs1 uvs2
            | FStar_Syntax_Syntax.Tm_ascribed
                (uu____22418,(FStar_Util.Inl t,uu____22420),uu____22421) ->
                FStar_Syntax_Free.univnames t
            | FStar_Syntax_Syntax.Tm_ascribed
                (uu____22468,(FStar_Util.Inr c,uu____22470),uu____22471) ->
                FStar_Syntax_Free.univnames_comp c
            | uu____22518 -> empty_set  in
          FStar_Util.set_union uu____22278 uu____22281  in
        let all_lb_univs =
          let uu____22522 =
            FStar_All.pipe_right lbs
              (FStar_List.fold_left
                 (fun uvs  ->
                    fun lb  ->
                      let uu____22538 = lb_univnames lb  in
                      FStar_Util.set_union uvs uu____22538) empty_set)
             in
          FStar_All.pipe_right uu____22522 FStar_Util.set_elements  in
        let usubst = FStar_Syntax_Subst.univ_var_closing all_lb_univs  in
        let uu___146_22548 = s  in
        let uu____22549 =
          let uu____22550 =
            let uu____22557 =
              let uu____22564 =
                FStar_All.pipe_right lbs
                  (FStar_List.map
                     (fun lb  ->
                        let uu___147_22576 = lb  in
                        let uu____22577 =
                          FStar_Syntax_Subst.subst usubst
                            lb.FStar_Syntax_Syntax.lbtyp
                           in
                        let uu____22580 =
                          FStar_Syntax_Subst.subst usubst
                            lb.FStar_Syntax_Syntax.lbdef
                           in
                        {
                          FStar_Syntax_Syntax.lbname =
                            (uu___147_22576.FStar_Syntax_Syntax.lbname);
                          FStar_Syntax_Syntax.lbunivs = all_lb_univs;
                          FStar_Syntax_Syntax.lbtyp = uu____22577;
                          FStar_Syntax_Syntax.lbeff =
                            (uu___147_22576.FStar_Syntax_Syntax.lbeff);
                          FStar_Syntax_Syntax.lbdef = uu____22580;
                          FStar_Syntax_Syntax.lbattrs =
                            (uu___147_22576.FStar_Syntax_Syntax.lbattrs);
                          FStar_Syntax_Syntax.lbpos =
                            (uu___147_22576.FStar_Syntax_Syntax.lbpos)
                        }))
                 in
              (b, uu____22564)  in
            (uu____22557, lids)  in
          FStar_Syntax_Syntax.Sig_let uu____22550  in
        {
          FStar_Syntax_Syntax.sigel = uu____22549;
          FStar_Syntax_Syntax.sigrng =
            (uu___146_22548.FStar_Syntax_Syntax.sigrng);
          FStar_Syntax_Syntax.sigquals =
            (uu___146_22548.FStar_Syntax_Syntax.sigquals);
          FStar_Syntax_Syntax.sigmeta =
            (uu___146_22548.FStar_Syntax_Syntax.sigmeta);
          FStar_Syntax_Syntax.sigattrs =
            (uu___146_22548.FStar_Syntax_Syntax.sigattrs)
        }
    | FStar_Syntax_Syntax.Sig_assume (lid,uu____22594,fml) ->
        let uvs =
          let uu____22599 = FStar_Syntax_Free.univnames fml  in
          FStar_All.pipe_right uu____22599 FStar_Util.set_elements  in
        let uu___148_22606 = s  in
        let uu____22607 =
          let uu____22608 =
            let uu____22615 = FStar_Syntax_Subst.close_univ_vars uvs fml  in
            (lid, uvs, uu____22615)  in
          FStar_Syntax_Syntax.Sig_assume uu____22608  in
        {
          FStar_Syntax_Syntax.sigel = uu____22607;
          FStar_Syntax_Syntax.sigrng =
            (uu___148_22606.FStar_Syntax_Syntax.sigrng);
          FStar_Syntax_Syntax.sigquals =
            (uu___148_22606.FStar_Syntax_Syntax.sigquals);
          FStar_Syntax_Syntax.sigmeta =
            (uu___148_22606.FStar_Syntax_Syntax.sigmeta);
          FStar_Syntax_Syntax.sigattrs =
            (uu___148_22606.FStar_Syntax_Syntax.sigattrs)
        }
    | FStar_Syntax_Syntax.Sig_effect_abbrev (lid,uu____22619,bs,c,flags1) ->
        let uvs =
          let uu____22630 =
            let uu____22633 = bs_univnames bs  in
            let uu____22636 = FStar_Syntax_Free.univnames_comp c  in
            FStar_Util.set_union uu____22633 uu____22636  in
          FStar_All.pipe_right uu____22630 FStar_Util.set_elements  in
        let usubst = FStar_Syntax_Subst.univ_var_closing uvs  in
        let uu___149_22646 = s  in
        let uu____22647 =
          let uu____22648 =
            let uu____22661 = FStar_Syntax_Subst.subst_binders usubst bs  in
            let uu____22662 = FStar_Syntax_Subst.subst_comp usubst c  in
            (lid, uvs, uu____22661, uu____22662, flags1)  in
          FStar_Syntax_Syntax.Sig_effect_abbrev uu____22648  in
        {
          FStar_Syntax_Syntax.sigel = uu____22647;
          FStar_Syntax_Syntax.sigrng =
            (uu___149_22646.FStar_Syntax_Syntax.sigrng);
          FStar_Syntax_Syntax.sigquals =
            (uu___149_22646.FStar_Syntax_Syntax.sigquals);
          FStar_Syntax_Syntax.sigmeta =
            (uu___149_22646.FStar_Syntax_Syntax.sigmeta);
          FStar_Syntax_Syntax.sigattrs =
            (uu___149_22646.FStar_Syntax_Syntax.sigattrs)
        }
    | uu____22667 -> s
  
let (desugar_modul_common :
  FStar_Syntax_Syntax.modul FStar_Pervasives_Native.option ->
    FStar_Syntax_DsEnv.env ->
      FStar_Parser_AST.modul ->
        (env_t,FStar_Syntax_Syntax.modul,Prims.bool)
          FStar_Pervasives_Native.tuple3)
  =
  fun curmod  ->
    fun env  ->
      fun m  ->
        let env1 =
          match (curmod, m) with
          | (FStar_Pervasives_Native.None ,uu____22702) -> env
          | (FStar_Pervasives_Native.Some
             { FStar_Syntax_Syntax.name = prev_lid;
               FStar_Syntax_Syntax.declarations = uu____22706;
               FStar_Syntax_Syntax.exports = uu____22707;
               FStar_Syntax_Syntax.is_interface = uu____22708;_},FStar_Parser_AST.Module
             (current_lid,uu____22710)) when
              (FStar_Ident.lid_equals prev_lid current_lid) &&
                (FStar_Options.interactive ())
              -> env
          | (FStar_Pervasives_Native.Some prev_mod,uu____22718) ->
              let uu____22721 =
                FStar_Syntax_DsEnv.finish_module_or_interface env prev_mod
                 in
              FStar_Pervasives_Native.fst uu____22721
           in
        let uu____22726 =
          match m with
          | FStar_Parser_AST.Interface (mname,decls,admitted) ->
              let uu____22762 =
                FStar_Syntax_DsEnv.prepare_module_or_interface true admitted
                  env1 mname FStar_Syntax_DsEnv.default_mii
                 in
              (uu____22762, mname, decls, true)
          | FStar_Parser_AST.Module (mname,decls) ->
              let uu____22779 =
                FStar_Syntax_DsEnv.prepare_module_or_interface false false
                  env1 mname FStar_Syntax_DsEnv.default_mii
                 in
              (uu____22779, mname, decls, false)
           in
        match uu____22726 with
        | ((env2,pop_when_done),mname,decls,intf) ->
            let uu____22809 = desugar_decls env2 decls  in
            (match uu____22809 with
             | (env3,sigelts) ->
                 let sigelts1 =
                   FStar_All.pipe_right sigelts
                     (FStar_List.map generalize_annotated_univs)
                    in
                 let modul =
                   {
                     FStar_Syntax_Syntax.name = mname;
                     FStar_Syntax_Syntax.declarations = sigelts1;
                     FStar_Syntax_Syntax.exports = [];
                     FStar_Syntax_Syntax.is_interface = intf
                   }  in
                 (env3, modul, pop_when_done))
  
let (as_interface : FStar_Parser_AST.modul -> FStar_Parser_AST.modul) =
  fun m  ->
    match m with
    | FStar_Parser_AST.Module (mname,decls) ->
        FStar_Parser_AST.Interface (mname, decls, true)
    | i -> i
  
let (desugar_partial_modul :
  FStar_Syntax_Syntax.modul FStar_Pervasives_Native.option ->
    env_t ->
      FStar_Parser_AST.modul ->
        (env_t,FStar_Syntax_Syntax.modul) FStar_Pervasives_Native.tuple2)
  =
  fun curmod  ->
    fun env  ->
      fun m  ->
        let m1 =
          let uu____22878 =
            (FStar_Options.interactive ()) &&
              (let uu____22880 =
                 let uu____22881 =
                   let uu____22882 = FStar_Options.file_list ()  in
                   FStar_List.hd uu____22882  in
                 FStar_Util.get_file_extension uu____22881  in
               FStar_List.mem uu____22880 ["fsti"; "fsi"])
             in
          if uu____22878 then as_interface m else m  in
        let uu____22886 = desugar_modul_common curmod env m1  in
        match uu____22886 with
        | (x,y,pop_when_done) ->
            (if pop_when_done
             then (let uu____22901 = FStar_Syntax_DsEnv.pop ()  in ())
             else ();
             (x, y))
  
let (desugar_modul :
  FStar_Syntax_DsEnv.env ->
    FStar_Parser_AST.modul ->
      (env_t,FStar_Syntax_Syntax.modul) FStar_Pervasives_Native.tuple2)
  =
  fun env  ->
    fun m  ->
      let uu____22921 =
        desugar_modul_common FStar_Pervasives_Native.None env m  in
      match uu____22921 with
      | (env1,modul,pop_when_done) ->
          let uu____22935 =
            FStar_Syntax_DsEnv.finish_module_or_interface env1 modul  in
          (match uu____22935 with
           | (env2,modul1) ->
               ((let uu____22947 =
                   FStar_Options.dump_module
                     (modul1.FStar_Syntax_Syntax.name).FStar_Ident.str
                    in
                 if uu____22947
                 then
                   let uu____22948 =
                     FStar_Syntax_Print.modul_to_string modul1  in
                   FStar_Util.print1 "Module after desugaring:\n%s\n"
                     uu____22948
                 else ());
                (let uu____22950 =
                   if pop_when_done
                   then
                     FStar_Syntax_DsEnv.export_interface
                       modul1.FStar_Syntax_Syntax.name env2
                   else env2  in
                 (uu____22950, modul1))))
  
let (ast_modul_to_modul :
  FStar_Parser_AST.modul ->
    FStar_Syntax_Syntax.modul FStar_Syntax_DsEnv.withenv)
  =
  fun modul  ->
    fun env  ->
      let uu____22968 = desugar_modul env modul  in
      match uu____22968 with | (env1,modul1) -> (modul1, env1)
  
let (decls_to_sigelts :
  FStar_Parser_AST.decl Prims.list ->
    FStar_Syntax_Syntax.sigelts FStar_Syntax_DsEnv.withenv)
  =
  fun decls  ->
    fun env  ->
      let uu____22999 = desugar_decls env decls  in
      match uu____22999 with | (env1,sigelts) -> (sigelts, env1)
  
let (partial_ast_modul_to_modul :
  FStar_Syntax_Syntax.modul FStar_Pervasives_Native.option ->
    FStar_Parser_AST.modul ->
      FStar_Syntax_Syntax.modul FStar_Syntax_DsEnv.withenv)
  =
  fun modul  ->
    fun a_modul  ->
      fun env  ->
        let uu____23043 = desugar_partial_modul modul env a_modul  in
        match uu____23043 with | (env1,modul1) -> (modul1, env1)
  
let (add_modul_to_env :
  FStar_Syntax_Syntax.modul ->
    FStar_Syntax_DsEnv.module_inclusion_info ->
      (FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term) ->
        unit FStar_Syntax_DsEnv.withenv)
  =
  fun m  ->
    fun mii  ->
      fun erase_univs  ->
        fun en  ->
          let erase_univs_ed ed =
            let erase_binders bs =
              match bs with
              | [] -> []
              | uu____23129 ->
                  let t =
                    let uu____23137 =
                      FStar_Syntax_Syntax.mk
                        (FStar_Syntax_Syntax.Tm_abs
                           (bs, FStar_Syntax_Syntax.t_unit,
                             FStar_Pervasives_Native.None))
                        FStar_Pervasives_Native.None FStar_Range.dummyRange
                       in
                    erase_univs uu____23137  in
                  let uu____23146 =
                    let uu____23147 = FStar_Syntax_Subst.compress t  in
                    uu____23147.FStar_Syntax_Syntax.n  in
                  (match uu____23146 with
                   | FStar_Syntax_Syntax.Tm_abs (bs1,uu____23157,uu____23158)
                       -> bs1
                   | uu____23179 -> failwith "Impossible")
               in
            let uu____23186 =
              let uu____23193 = erase_binders ed.FStar_Syntax_Syntax.binders
                 in
              FStar_Syntax_Subst.open_term' uu____23193
                FStar_Syntax_Syntax.t_unit
               in
            match uu____23186 with
            | (binders,uu____23195,binders_opening) ->
                let erase_term t =
                  let uu____23203 =
                    let uu____23204 =
                      FStar_Syntax_Subst.subst binders_opening t  in
                    erase_univs uu____23204  in
                  FStar_Syntax_Subst.close binders uu____23203  in
                let erase_tscheme uu____23222 =
                  match uu____23222 with
                  | (us,t) ->
                      let t1 =
                        let uu____23242 =
                          FStar_Syntax_Subst.shift_subst
                            (FStar_List.length us) binders_opening
                           in
                        FStar_Syntax_Subst.subst uu____23242 t  in
                      let uu____23245 =
                        let uu____23246 = erase_univs t1  in
                        FStar_Syntax_Subst.close binders uu____23246  in
                      ([], uu____23245)
                   in
                let erase_action action =
                  let opening =
                    FStar_Syntax_Subst.shift_subst
                      (FStar_List.length
                         action.FStar_Syntax_Syntax.action_univs)
                      binders_opening
                     in
                  let erased_action_params =
                    match action.FStar_Syntax_Syntax.action_params with
                    | [] -> []
                    | uu____23277 ->
                        let bs =
                          let uu____23285 =
                            FStar_Syntax_Subst.subst_binders opening
                              action.FStar_Syntax_Syntax.action_params
                             in
                          FStar_All.pipe_left erase_binders uu____23285  in
                        let t =
                          FStar_Syntax_Syntax.mk
                            (FStar_Syntax_Syntax.Tm_abs
                               (bs, FStar_Syntax_Syntax.t_unit,
                                 FStar_Pervasives_Native.None))
                            FStar_Pervasives_Native.None
                            FStar_Range.dummyRange
                           in
                        let uu____23315 =
                          let uu____23316 =
                            let uu____23319 =
                              FStar_Syntax_Subst.close binders t  in
                            FStar_Syntax_Subst.compress uu____23319  in
                          uu____23316.FStar_Syntax_Syntax.n  in
                        (match uu____23315 with
                         | FStar_Syntax_Syntax.Tm_abs
                             (bs1,uu____23327,uu____23328) -> bs1
                         | uu____23349 -> failwith "Impossible")
                     in
                  let erase_term1 t =
                    let uu____23362 =
                      let uu____23363 = FStar_Syntax_Subst.subst opening t
                         in
                      erase_univs uu____23363  in
                    FStar_Syntax_Subst.close binders uu____23362  in
                  let uu___150_23364 = action  in
                  let uu____23365 =
                    erase_term1 action.FStar_Syntax_Syntax.action_defn  in
                  let uu____23366 =
                    erase_term1 action.FStar_Syntax_Syntax.action_typ  in
                  {
                    FStar_Syntax_Syntax.action_name =
                      (uu___150_23364.FStar_Syntax_Syntax.action_name);
                    FStar_Syntax_Syntax.action_unqualified_name =
                      (uu___150_23364.FStar_Syntax_Syntax.action_unqualified_name);
                    FStar_Syntax_Syntax.action_univs = [];
                    FStar_Syntax_Syntax.action_params = erased_action_params;
                    FStar_Syntax_Syntax.action_defn = uu____23365;
                    FStar_Syntax_Syntax.action_typ = uu____23366
                  }  in
                let uu___151_23367 = ed  in
                let uu____23368 = FStar_Syntax_Subst.close_binders binders
                   in
                let uu____23369 = erase_term ed.FStar_Syntax_Syntax.signature
                   in
                let uu____23370 = erase_tscheme ed.FStar_Syntax_Syntax.ret_wp
                   in
                let uu____23371 =
                  erase_tscheme ed.FStar_Syntax_Syntax.bind_wp  in
                let uu____23372 =
                  erase_tscheme ed.FStar_Syntax_Syntax.if_then_else  in
                let uu____23373 = erase_tscheme ed.FStar_Syntax_Syntax.ite_wp
                   in
                let uu____23374 =
                  erase_tscheme ed.FStar_Syntax_Syntax.stronger  in
                let uu____23375 =
                  erase_tscheme ed.FStar_Syntax_Syntax.close_wp  in
                let uu____23376 =
                  erase_tscheme ed.FStar_Syntax_Syntax.assert_p  in
                let uu____23377 =
                  erase_tscheme ed.FStar_Syntax_Syntax.assume_p  in
                let uu____23378 =
                  erase_tscheme ed.FStar_Syntax_Syntax.null_wp  in
                let uu____23379 =
                  erase_tscheme ed.FStar_Syntax_Syntax.trivial  in
                let uu____23380 = erase_term ed.FStar_Syntax_Syntax.repr  in
                let uu____23381 =
                  erase_tscheme ed.FStar_Syntax_Syntax.return_repr  in
                let uu____23382 =
                  erase_tscheme ed.FStar_Syntax_Syntax.bind_repr  in
                let uu____23383 =
                  FStar_List.map erase_action ed.FStar_Syntax_Syntax.actions
                   in
                {
                  FStar_Syntax_Syntax.cattributes =
                    (uu___151_23367.FStar_Syntax_Syntax.cattributes);
                  FStar_Syntax_Syntax.mname =
                    (uu___151_23367.FStar_Syntax_Syntax.mname);
                  FStar_Syntax_Syntax.univs = [];
                  FStar_Syntax_Syntax.binders = uu____23368;
                  FStar_Syntax_Syntax.signature = uu____23369;
                  FStar_Syntax_Syntax.ret_wp = uu____23370;
                  FStar_Syntax_Syntax.bind_wp = uu____23371;
                  FStar_Syntax_Syntax.if_then_else = uu____23372;
                  FStar_Syntax_Syntax.ite_wp = uu____23373;
                  FStar_Syntax_Syntax.stronger = uu____23374;
                  FStar_Syntax_Syntax.close_wp = uu____23375;
                  FStar_Syntax_Syntax.assert_p = uu____23376;
                  FStar_Syntax_Syntax.assume_p = uu____23377;
                  FStar_Syntax_Syntax.null_wp = uu____23378;
                  FStar_Syntax_Syntax.trivial = uu____23379;
                  FStar_Syntax_Syntax.repr = uu____23380;
                  FStar_Syntax_Syntax.return_repr = uu____23381;
                  FStar_Syntax_Syntax.bind_repr = uu____23382;
                  FStar_Syntax_Syntax.actions = uu____23383;
                  FStar_Syntax_Syntax.eff_attrs =
                    (uu___151_23367.FStar_Syntax_Syntax.eff_attrs)
                }
             in
          let push_sigelt1 env se =
            match se.FStar_Syntax_Syntax.sigel with
            | FStar_Syntax_Syntax.Sig_new_effect ed ->
                let se' =
                  let uu___152_23399 = se  in
                  let uu____23400 =
                    let uu____23401 = erase_univs_ed ed  in
                    FStar_Syntax_Syntax.Sig_new_effect uu____23401  in
                  {
                    FStar_Syntax_Syntax.sigel = uu____23400;
                    FStar_Syntax_Syntax.sigrng =
                      (uu___152_23399.FStar_Syntax_Syntax.sigrng);
                    FStar_Syntax_Syntax.sigquals =
                      (uu___152_23399.FStar_Syntax_Syntax.sigquals);
                    FStar_Syntax_Syntax.sigmeta =
                      (uu___152_23399.FStar_Syntax_Syntax.sigmeta);
                    FStar_Syntax_Syntax.sigattrs =
                      (uu___152_23399.FStar_Syntax_Syntax.sigattrs)
                  }  in
                let env1 = FStar_Syntax_DsEnv.push_sigelt env se'  in
                push_reflect_effect env1 se.FStar_Syntax_Syntax.sigquals
                  ed.FStar_Syntax_Syntax.mname se.FStar_Syntax_Syntax.sigrng
            | FStar_Syntax_Syntax.Sig_new_effect_for_free ed ->
                let se' =
                  let uu___153_23405 = se  in
                  let uu____23406 =
                    let uu____23407 = erase_univs_ed ed  in
                    FStar_Syntax_Syntax.Sig_new_effect_for_free uu____23407
                     in
                  {
                    FStar_Syntax_Syntax.sigel = uu____23406;
                    FStar_Syntax_Syntax.sigrng =
                      (uu___153_23405.FStar_Syntax_Syntax.sigrng);
                    FStar_Syntax_Syntax.sigquals =
                      (uu___153_23405.FStar_Syntax_Syntax.sigquals);
                    FStar_Syntax_Syntax.sigmeta =
                      (uu___153_23405.FStar_Syntax_Syntax.sigmeta);
                    FStar_Syntax_Syntax.sigattrs =
                      (uu___153_23405.FStar_Syntax_Syntax.sigattrs)
                  }  in
                let env1 = FStar_Syntax_DsEnv.push_sigelt env se'  in
                push_reflect_effect env1 se.FStar_Syntax_Syntax.sigquals
                  ed.FStar_Syntax_Syntax.mname se.FStar_Syntax_Syntax.sigrng
            | uu____23409 -> FStar_Syntax_DsEnv.push_sigelt env se  in
          let uu____23410 =
            FStar_Syntax_DsEnv.prepare_module_or_interface false false en
              m.FStar_Syntax_Syntax.name mii
             in
          match uu____23410 with
          | (en1,pop_when_done) ->
              let en2 =
                let uu____23422 =
                  FStar_Syntax_DsEnv.set_current_module en1
                    m.FStar_Syntax_Syntax.name
                   in
                FStar_List.fold_left push_sigelt1 uu____23422
                  m.FStar_Syntax_Syntax.exports
                 in
              let env = FStar_Syntax_DsEnv.finish en2 m  in
              let uu____23424 =
                if pop_when_done
                then
                  FStar_Syntax_DsEnv.export_interface
                    m.FStar_Syntax_Syntax.name env
                else env  in
              ((), uu____23424)
  