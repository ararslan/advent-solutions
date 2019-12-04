fun readfile (name) =
let
  val file = TextIO.openIn name
  val contents = TextIO.inputAll file
  val _ = TextIO.closeIn file
  val lines = String.tokens (fn c => c = #"\n") contents
in
  map (fn line => valOf (Int.fromString line)) lines
end

fun fuel (mass) =
let
  val max = fn (a, b) => if (a > b) then a else b
in
  max (0, (mass div 3) - 2)
end

fun totalfuel (total, mass) =
  if (mass > 0) then totalfuel (total + (fuel mass), fuel mass)
  else total

val masses = readfile "input"
val fuels = (map fuel masses)
val totals = (map (fn mass => totalfuel (0, mass)) masses)
val sum = fn lst => foldl op+ 0 lst
val _ = print ((Int.toString (sum fuels)) ^ "\n")
val _ = print ((Int.toString (sum totals)) ^ "\n")
