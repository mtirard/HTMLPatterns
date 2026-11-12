(* XMLDocument (ADR 0018, 0023): the document above the top elements of
   every input. The document of an XMLObject is the XMLObject, of a list the
   list, and of a bare XMLElement a virtual parent whose only child is the
   input. XMLDocument[c...] as a pattern root is tested in TreeContext.wlt;
   these are the symbol, the element tests and XMLDeleteCases. Fixtures are
   local to this file. *)

$doc = ImportString["<html><body><p id=\"a\">a</p><div><p id=\"b\">b</p></div></body></html>", {"HTML", "XMLObject"}];
$bare = XMLElement["body", {}, {XMLElement["p", {"id" -> "x"}, {}],
  XMLElement["div", {}, {XMLElement["p", {"id" -> "y"}, {}]}]}];

(* === The symbol === *)

TestCreate[
  XMLDocument[],
  XMLDocument[],
  TestID -> "document-inert"
];

(* === Refusals === *)

(* A Roles rule is applied to elements, and the document is not one. *)
TestCreate[
  HTMLInnerText[$doc, "Roles" -> {XMLDocument[] -> "Skip"}],
  $Failed,
  {HTMLInnerText::badpat},
  TestID -> "document-refused-one-element"
];

(* === The tests agree with XMLCases (#74) === *)

(* An input of each kind has a document, so XMLFreeQ and XMLMatchQ find an
   XMLDocument pattern exactly where XMLCases does. *)
TestCreate[
  With[{inputs = {$doc, $bare, {" ", $bare}, {$bare, XMLElement["p", {}, {}]}, {}, {"text"}},
      patterns = {XMLDocument[], XMLDocument[{XMLPattern["body"]}], XMLDocument[{XMLPattern["html"]}],
        XMLDocument[{___, XMLPattern["p"]}], XMLDocument[Child[XMLPattern["body"]]],
        XMLDocument[Descendant[XMLPattern["p", "id" -> "y"]]]}},
    Union @ Flatten @ Outer[
      {XMLFreeQ[#1, #2] === (XMLCases[#1, #2 :> 1] === {}), XMLMatchQ[#1, #2] === (XMLCases[#1, #2 :> 1] =!= {})} &,
      inputs, patterns, 1]],
  {True},
  TestID -> "document-tests-agree-with-xmlcases"
];

(* === XMLDeleteCases === *)

(* A document keeps its root element (#35). *)
TestCreate[
  XMLDeleteCases[$doc, XMLPattern["html"]],
  $doc,
  {XMLDeleteCases::root},
  TestID -> "document-delete-keeps-root"
];

TestCreate[
  XMLDeleteCases[$bare, XMLPattern["body"]],
  $bare,
  TestID -> "document-delete-never-the-bare-input"
];
