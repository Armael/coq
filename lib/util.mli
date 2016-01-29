(************************************************************************)
(*  v      *   The Coq Proof Assistant  /  The Coq Development Team     *)
(* <O___,, *   INRIA - CNRS - LIX - LRI - PPS - Copyright 1999-2016     *)
(*   \VV/  **************************************************************)
(*    //   *      This file is distributed under the terms of the       *)
(*         *       GNU Lesser General Public License Version 2.1        *)
(************************************************************************)

(** This module contains numerous utility functions on strings, lists,
   arrays, etc. *)

(** Mapping under pairs *)

val on_fst : ('a -> 'b) -> 'a * 'c -> 'b * 'c
val on_snd : ('a -> 'b) -> 'c * 'a -> 'c * 'b
val map_pair : ('a -> 'b) -> 'a * 'a -> 'b * 'b

(** Mapping under triple *)

val on_pi1 : ('a -> 'b) -> 'a * 'c * 'd -> 'b * 'c * 'd
val on_pi2 : ('a -> 'b) -> 'c * 'a * 'd -> 'c * 'b * 'd
val on_pi3 : ('a -> 'b) -> 'c * 'd * 'a -> 'c * 'd * 'b

(** {6 Projections from triplets } *)

val pi1 : 'a * 'b * 'c -> 'a
val pi2 : 'a * 'b * 'c -> 'b
val pi3 : 'a * 'b * 'c -> 'c

(** {6 Chars. } *)

val is_letter : char -> bool
val is_digit : char -> bool
val is_ident_tail : char -> bool
val is_blank : char -> bool

(** {6 Empty type} *)

module Empty :
sig
  type t
  val abort : t -> 'a
end

(** {6 Strings. } *)

module String : CString.ExtS

(** Substitute %s in the first chain by the second chain *)
val subst_command_placeholder : string -> string -> string

(** {6 Lists. } *)

module List : CList.ExtS

val (@) : 'a list -> 'a list -> 'a list

(** {6 Arrays. } *)

module Array : CArray.ExtS

(** {6 Sets. } *)

module Set : module type of CSet

(** {6 Maps. } *)

module Map : module type of CMap

(** {6 Stacks.} *)

module Stack : module type of CStack

(** {6 Streams. } *)

val stream_nth : int -> 'a Stream.t -> 'a
val stream_njunk : int -> 'a Stream.t -> unit

(** {6 Matrices. } *)

val matrix_transpose : 'a list list -> 'a list list

(** {6 Functions. } *)

val identity : 'a -> 'a
val compose : ('a -> 'b) -> ('c -> 'a) -> 'c -> 'b
val (%) : ('a -> 'b) -> ('c -> 'a) -> 'c -> 'b
val const : 'a -> 'b -> 'a
val iterate : ('a -> 'a) -> int -> 'a -> 'a
val repeat : int -> ('a -> unit) -> 'a -> unit
val app_opt : ('a -> 'a) option -> 'a -> 'a

(** {6 Delayed computations. } *)

type 'a delayed = unit -> 'a

val delayed_force : 'a delayed -> 'a

(** {6 Enriched exceptions} *)

type iexn = Exninfo.iexn

val iraise : iexn -> 'a

(** {6 Misc. } *)

type ('a, 'b) union = ('a, 'b) CSig.union = Inl of 'a | Inr of 'b
(** Union type *)

val map_union : ('a -> 'c) -> ('b -> 'd) -> ('a, 'b) union -> ('c, 'd) union

type 'a until = 'a CSig.until = Stop of 'a | Cont of 'a
(** Used for browsable-until structures. *)

type ('a, 'b) eq = ('a, 'b) CSig.eq = Refl : ('a, 'a) eq

val open_utf8_file_in : string -> in_channel
(** Open an utf-8 encoded file and skip the byte-order mark if any. *)
