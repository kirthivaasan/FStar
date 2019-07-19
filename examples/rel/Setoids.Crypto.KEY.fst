module Setoids.Crypto.KEY
open FStar.Bytes
open FStar.UInt32
open FStar.Map
open Setoids
open Setoids.Crypto

module DM = FStar.DependentMap
////////////////////////////////////////////////////////////////////////////////
//KEY package
////////////////////////////////////////////////////////////////////////////////

let handle = h:(bytes&bytes){int_of_bytes (fst h) <= int_of_bytes (snd h)}

let key (n:u32) = lbytes32 n
let key_state (n:u32) = (Map.t handle (option bool) & Map.t handle (option (key n)))

let key_state_rel (n:u32) = lo (key_state n)

let key_eff (n:u32) = eff (key_state_rel n)

let key_set_t (n:u32) = (lo handle) ** (lo (key n)) ^--> eff_rel (key_state_rel n) (lo handle)
let key0_set n : key_set_t n =
    fun (h, k_in) ->
    s <-- get ;
    let (h_map,k_map) = s in
    match Map.sel h_map h,Map.sel k_map h with
    | None,None ->
      let s':key_state n = (Map.upd h_map h (Some true), Map.upd k_map h (Some k_in)) in
      put s' ;;
      return h
    | _,_ ->
      raise

let key1_set n : key_set_t n =
    fun (h, k_in) ->
    s <-- get ;
    let (h_map,k_map) = s in
    match Map.sel h_map h,Map.sel k_map h with
    | None,None ->
      k <-- sample_multiple #(key_state n) n;
      let s':key_state n = (Map.upd h_map h (Some true), Map.upd k_map h (Some k_in)) in
      put s' ;;
      return h
    | _,_ ->
      raise

let key_cset_t (n:u32) = (lo handle) ** (lo (key n)) ^--> eff_rel (key_state_rel n) (lo handle)
let key_cset n : key_cset_t n =
    fun (h, k_in) ->
    s <-- get ;
    let (h_map,k_map) = s in
    match Map.sel h_map h,Map.sel k_map h with
    | None, None ->
      let s':key_state n = (Map.upd h_map h (Some false), Map.upd k_map h (Some k_in)) in
      put s' ;;
      return h
    | _,_ ->
      raise

let key_get_t (n:u32) = (lo handle) ^--> eff_rel (key_state_rel n) (lo (key n))
let key_get n : key_get_t n =
    fun h ->
    s <-- get ;
    let (h_map,k_map) = s in
    match Map.sel h_map h,Map.sel k_map h with
    | Some hon, Some k ->
      return k
    | _,_ ->
      raise

let key_hon_t (n:u32) = (lo handle) ^--> eff_rel (key_state_rel n) (lo bool)
let key_hon n : key_hon_t n =
    fun h ->
    s <-- get ;
    let (h_map,k_map) = s in
    match Map.sel h_map h,Map.sel k_map h with
    | Some hon, Some k ->
      return hon
    | _,_ ->
      raise

type key_labels =
  | GET
  | HON
  | SET
  | CSET

let key_field_types n : key_labels -> Type =
    function  GET -> key_get_t n
            | HON -> key_hon_t n
            | SET -> key_set_t n
            | CSET -> key_cset_t n

let key_field_rels n : (k:key_labels -> erel (key_field_types n k)) =
  function
      GET -> arrow (lo handle) (eff_rel (key_state_rel n) (lo (key n)))
    | HON -> arrow (lo handle) (eff_rel (key_state_rel n) (lo bool))
    | SET -> arrow (lo handle ** lo (key n)) (eff_rel (key_state_rel n) (lo handle))
    | CSET -> arrow (lo handle ** lo (key n)) (eff_rel (key_state_rel n) (lo handle))

let key_sig (n:u32) = {
  labels = key_labels;
  ops = key_field_types n;
  rels = key_field_rels n
  }

let key0_module (n:u32) : module_t (key_sig n) =
  DM.create #_ #(key_sig n).ops
    (function GET -> key_get n
            | HON -> key_hon n
            | SET -> key0_set n
            | CSET -> key_cset n)

#set-options "--z3rlimit 350 --max_fuel 2 --max_ifuel 3"
#set-options "--query_stats"
let key1_module (n:u32) : module_t (key_sig n) =
  DM.create #_ #(key_sig n).ops
    (function GET -> key_get n
            | HON -> key_hon n
            | SET -> key1_set n
            | CSET -> key_cset n)

let key0_functor n = as_fun (key0_module n)
let key1_functor n = as_fun (key1_module n)
