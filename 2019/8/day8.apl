⍝ Read and preprocess input to a 3D array
X←⍕1↑⎕NGET'input'
X←100 6 25⍴⍎¨X[⍸X∊'012']

⍝ Part 1
z←+/[2]+/[3]X=0
s←(z⍳⌊/z)⌷[1]X
p1←×/{+/,s=⍵}¨⍳2
p1
