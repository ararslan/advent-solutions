X←⍎¨,⎕CSV'input'
p1←+/{¯2+⌊⍵÷3}¨X
fuel←{0⌈¯2+⌊⍵÷3}
p1←+/fuel¨X
totfuel←{⍵>0:⍺+f∇f←fuel⍵⋄⍵}
p2←+/0totfuel¨X
p1
p2
