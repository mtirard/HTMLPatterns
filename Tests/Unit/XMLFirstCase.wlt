(* XMLFirstCase: first-match semantics across patterns, rules and defaults.
   Fixtures $tree, $treeProducts, $realTree come from
   Tests/Support/Fixtures.wl. *)

(* Base: returns first match *)
TestCreate[
  HTMLTextContent @ XMLFirstCase[$tree, XMLPattern["p"]],
  "Hello",
  TestID -> "firstcase-base"
];

(* Base with rule *)
TestCreate[
  XMLFirstCase[$tree, x:XMLPattern["p"] :> HTMLTextContent[x]],
  "Hello",
  TestID -> "firstcase-base-rule"
];

(* No match \[LongDash] default Missing["NotFound"] *)
TestCreate[
  XMLFirstCase[$tree, XMLPattern["table"]],
  Missing["NotFound"],
  TestID -> "firstcase-no-match-default"
];

(* No match \[LongDash] explicit default *)
TestCreate[
  XMLFirstCase[$tree, XMLPattern["table"], "fallback"],
  "fallback",
  TestID -> "firstcase-no-match-explicit"
];

(* Real-world: OG title via rule + base *)
TestCreate[
  XMLFirstCase[$realTree,
    XMLPattern["meta", {"property" -> "og:title", "content" -> c_}] :> c
  ],
  "Wolfram Language: Programming Language + Built-In Knowledge",
  TestID -> "firstcase-real-og-title"
];

(* A rule pattern -> rhs, its rhs evaluated when the query is given *)
TestCreate[
  XMLFirstCase[$tree, XMLPattern["p"] -> 1],
  1,
  TestID -> "firstcase-rule"
];

TestCreate[
  XMLFirstCase[$tree, XMLPattern["table"] -> 1, "fallback"],
  "fallback",
  TestID -> "firstcase-rule-default"
];

TestCreate[
  XMLFirstCase[$tree, XMLPattern["p"] -> 1, "fallback"],
  1,
  TestID -> "firstcase-rule-default-unused"
];

TestCreate[
  Block[{x = 5},
    {XMLFirstCase[$realTree, XMLPattern["meta", "property" -> x_] -> x],
     FirstCase[{"property" -> "og:title"}, ("property" -> x_) -> x]}],
  {5, 5},
  TestID -> "firstcase-rule-global-value-as-firstcase"
];

(* The result is the value itself, not a Sequence of it: Rule and Set hold
   a Sequence (SequenceHold), so a wrapper would show there. *)
TestCreate[
  "k" -> XMLFirstCase[XMLElement["div", {}, {XMLElement["b", {}, {"x"}]}],
    b : XMLPattern["b"] :> HTMLTextContent[b]],
  "k" -> "x",
  TestID -> "firstcase-rule-no-sequence-wrapper"
];

(* A right-hand side that evaluates to a Sequence gives that Sequence, as in
   FirstCase. *)
TestCreate[
  With[{t = XMLElement["div", {}, {XMLElement["b", {}, {"x"}]}]},
    {"k" -> XMLFirstCase[t, XMLPattern["b"] :> Sequence[]],
     "k" -> XMLFirstCase[t, XMLPattern["b"] :> Sequence[1, 2]]}],
  {"k" -> FirstCase[{1}, 1 :> Sequence[]], "k" -> FirstCase[{1}, 1 :> Sequence[1, 2]]},
  TestID -> "firstcase-sequence-rhs-as-firstcase"
];

TestCreate[
  "k" -> XMLFirstCase[XMLElement["div", {}, {XMLElement["b", {}, {"x"}]}], XMLPattern["b"]],
  "k" -> XMLElement["b", {}, {"x"}],
  TestID -> "firstcase-pattern-no-sequence-wrapper"
];
