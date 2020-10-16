turtles-own [wealth]
patches-own [manna]
globals [mean-wealth]


to setup
  clear-all
  if init-manna = "Single Hill" ;; a non-homogeneous distribution of manna
  [init-single-hill]
  if init-manna = "Poisson" ;; a homogeneous distribution of manna
  [init-poisson]

  ; initializing diff clusters

  if num-clusters = 1 [
    crt num-turtles [setxy (-2.5 + (random 10) * 0.5) (-2.5 + (random 10) * 0.5) ]
    ask turtles [set color green]
  ]

  if num-clusters = 2 [
    ; blue cluster
    crt num-turtles / 2 [
      setxy
      (4 - (blue-distance-to-manna) / 100 + (random (11 - blue-cluster-density)) - (11 - blue-cluster-density) * 0.5)
      (4 - (blue-distance-to-manna) / 100 + (random (11 - blue-cluster-density)) - (11 - blue-cluster-density) * 0.5)
      set color 85
    ]

    ; pink cluster
    crt num-turtles / 2 [
      setxy
      (4 - (pink-distance-to-manna) / 100 + (random (11 - pink-cluster-density)) - (11 - pink-cluster-density) * 0.5)
      (4 - (pink-distance-to-manna) / 100 + (random (11 - pink-cluster-density)) - (11 - pink-cluster-density) * 0.5)
      set color 125
    ]
  ]

  reset-ticks
end

to go
  if all? patches [manna = 0] [stop] ; Stop if no more manna left.

  ask turtles [
    move-to one-of ([neighbors] of self) with-max [manna] ; Ask the turtles to move, to forage.
    set wealth wealth + manna
    set manna 0

    ; part 4
    if wealth-factors-on [
      set wealth (wealth + (wealth * interest-rate) - (cost-of-living / 10000)) ;
    ]

  ]

  ; plots
  plot-cumulative-dist cumulative_of_list reverse [ wealth ] of turtles

  tick
end

to init-single-hill
  let source1 patch 10 10
  ask source1 [set manna init-manna-amount ]
  repeat 100 [diffuse manna manna-diffusion-rate]
  ask patches [set pcolor manna + 40]
end

to init-poisson
  ask patches [set manna random-poisson 5]
  ask patches [set pcolor manna + 40]
end



; 1a
to-report madm [ lst ]
  let x_bar (mean lst) 
  let meanList [] 
  foreach lst [ x -> set meanList lput (abs(x_bar - x)) meanList ]
  report (sum meanList) / (length meanList)
end

; 1b
to-report max_of [ a ]
  report max a
end

to-report min_of [ a ]
  report min a
end

to-report median_of [ a ]
  report median a
end

; 1c
to-report cumulative_of_list [a]
  let cumlist []
  let cumsum 0
  foreach a [elem ->
    set cumsum (cumsum + elem)
    set cumlist (lput cumsum cumlist)]
  report cumlist
end

; 1d
to-report top-50-pct-wealth
  report (sum [ wealth ] of max-n-of (count turtles * 0.50) turtles [ wealth ]) / (sum [ wealth ] of turtles)
end

; 2b
to-report reverse_list [ a ]
  set a reverse a
  report a
end

; 2d
to plot-cumulative-dist [a]
  set-current-plot "Reverse Cumulative Wealth"
  clear-plot
  set-plot-y-range 0 120
  set-plot-x-range 0 120
  set-current-plot-pen "cum-wealth"
  plot-pen-down
  foreach a [i -> plot i]
end





; general experiment results
to-report blue-wealth-mean
  report mean [ wealth ] of turtles with [ color = 85 ]
end

to-report pink-wealth-mean
  report mean [ wealth ] of turtles with [ color = 125 ]
end

to-report blue-wealth-std
  report standard-deviation [ wealth ] of turtles with [ color = 85 ]
end

to-report pink-wealth-std
  report standard-deviation [ wealth ] of turtles with [ color = 125 ]
end

to-report blue-pct-wealth
  if (sum [ wealth] of turtles) = 0 [ report 0 ]
  if (sum [ wealth ] of turtles with [ color = 85 ]) < 0 [ report 0 ] ; negative wealth
  if (sum [ wealth ] of turtles with [ color = 125 ]) < 0 [ report 100 ] ; other turtle has negative wealth
  report (sum [ wealth ] of turtles with [ color = 85 ]) / (sum [ wealth] of turtles) * 100
end

to-report pink-pct-wealth
  if (sum [ wealth] of turtles) = 0 [ report 0 ]
  if (sum [ wealth ] of turtles with [ color = 125 ]) < 0 [ report 0 ] ; negative wealth
  if (sum [ wealth ] of turtles with [ color = 85 ]) < 0 [ report 100 ] ; other turtle has negative wealth
  report (sum [ wealth ] of turtles with [ color = 125 ]) / (sum [ wealth] of turtles) * 100
end

to-report blue-to-pink-wealth-ratio
  if (mean [ wealth ] of turtles with [ color = 125 ]) = 0 [ report 0 ]
  report (mean [ wealth ] of turtles with [ color = 85 ]) / (mean [ wealth ] of turtles with [ color = 125 ])
end





; general data analysis
to-report top-10-pct-wealth
  if (sum [ wealth ] of turtles) = 0 [ report 0 ]
  if top-10-pct-wealth-actual = 0 [ report 0 ]
  if abs (top-10-pct-wealth-actual / (sum [ wealth ] of turtles)) * 100 > 100 [ report 100 ]
  report abs (top-10-pct-wealth-actual / (sum [ wealth ] of turtles)) * 100
end

to-report bottom-50-pct-wealth
  if (sum [ wealth ] of turtles) = 0 [ report 0 ]
  if bottom-50-pct-wealth-actual = 0 [ report 0 ]
  if abs (bottom-50-pct-wealth-actual / (sum [ wealth ] of turtles)) * 100 > 100 [ report 100 ]
  report (bottom-50-pct-wealth-actual / (sum [ wealth ] of turtles)) * 100
end

to-report top-10-pct-wealth-actual
  report abs (sum [ wealth ] of max-n-of (count turtles * 0.10) turtles [ wealth ])
end

to-report bottom-50-pct-wealth-actual
  if (sum [ wealth ] of turtles) = 0 [ report 1 ]
  report abs (sum [ wealth ] of min-n-of (count turtles * 0.50) turtles [ wealth ])
end
@#$#@#$#@
GRAPHICS-WINDOW
361
45
849
534
-1
-1
14.55
1
10
1
1
1
0
1
1
1
-16
16
-16
16
1
1
1
ticks
30.0

BUTTON
49
483
176
516
NIL
setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
181
483
308
516
NIL
go\n
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

MONITOR
1416
46
1516
91
mean wealth
mean [wealth] of turtles
3
1
11

MONITOR
371
476
453
521
manna mean
mean [manna] of patches
6
1
11

CHOOSER
18
116
176
161
init-manna
init-manna
"Single Hill" "Poisson"
0

MONITOR
1524
46
1619
91
std wealth
standard-deviation [wealth] of turtles
3
1
11

MONITOR
1416
96
1619
141
wealth coefficient of variation
standard-deviation [wealth] of turtles /\nmean [wealth] of turtles
3
1
11

PLOT
1627
221
1895
398
Wealth Distribution
wealth of turtles
num of turtles
0.0
50.0
0.0
10.0
true
false
"" ""
PENS
"default" 5.0 1 -14439633 true "" "histogram [ wealth ] of turtles"

PLOT
1415
370
1615
520
Reverse Cumulative Wealth
NIL
NIL
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"cum-wealth" 5.0 0 -14439633 true "" ""

SLIDER
181
136
346
169
num-turtles
num-turtles
0
100
100.0
1
1
NIL
HORIZONTAL

SLIDER
182
96
350
129
init-manna-amount
init-manna-amount
50
200
200.0
5
1
NIL
HORIZONTAL

SLIDER
180
177
350
210
manna-diffusion-rate
manna-diffusion-rate
0.01
0.05
0.024
0.001
1
NIL
HORIZONTAL

SLIDER
181
249
339
282
interest-rate
interest-rate
0
0.1
0.0
0.001
1
NIL
HORIZONTAL

MONITOR
1416
266
1618
311
% wealth of top 10%
top-10-pct-wealth
10
1
11

MONITOR
1416
316
1618
361
% wealth of bottom 50%
bottom-50-pct-wealth
10
1
11

PLOT
1627
46
1896
214
top 10% vs bottom 50% wealth ratio
NIL
NIL
0.0
10.0
0.0
1.0
true
false
"" ""
PENS
"top-10" 1.0 0 -13840069 true "" "plot top-10-pct-wealth"
"bottom-50" 1.0 0 -2674135 true "" "plot bottom-50-pct-wealth"

MONITOR
1416
165
1617
210
total wealth of top 10%
top-10-pct-wealth-actual
10
1
11

MONITOR
1416
216
1617
261
total wealth of bottom 50%
bottom-50-pct-wealth-actual
10
1
11

CHOOSER
17
165
176
210
num-clusters
num-clusters
1 2
1

MONITOR
881
67
1007
112
blue mean wealth
blue-wealth-mean
10
1
11

MONITOR
1023
67
1149
112
pink mean wealth
pink-wealth-mean
10
1
11

SLIDER
17
357
341
390
blue-distance-to-manna
blue-distance-to-manna
300
500
323.9
0.1
1
NIL
HORIZONTAL

SLIDER
17
395
342
428
pink-distance-to-manna
pink-distance-to-manna
300
500
484.5
0.1
1
NIL
HORIZONTAL

SLIDER
20
286
178
319
cost-of-living
cost-of-living
0
100
0.0
1
1
NIL
HORIZONTAL

TEXTBOX
880
10
1171
54
Combined Results
18
0.0
0

TEXTBOX
1418
10
1791
54
General Statistical Analysis Results
18
0.0
1

TEXTBOX
21
17
171
39
Setup Variables
18
0.0
1

TEXTBOX
19
42
201
84
Play around with the variables to see how they affect the results!
11
0.0
1

TEXTBOX
382
10
832
70
OIDD 325 Case 1: Master Experiment
24
0.0
1

MONITOR
880
120
1007
165
blue wealth std
blue-wealth-std
10
1
11

MONITOR
1023
120
1148
165
pink wealth std
pink-wealth-std
10
1
11

TEXTBOX
880
46
996
80
blue cluster
14
85.0
1

TEXTBOX
1023
45
1141
63
pink cluster
14
125.0
1

MONITOR
880
253
1008
298
blue % of total wealth
blue-pct-wealth
10
1
11

MONITOR
1022
253
1147
298
pink % of total wealth
pink-pct-wealth
10
1
11

PLOT
1160
121
1374
279
Blue to Pink Wealth Ratio
NIL
NIL
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 0 -8630108 true "" "plot blue-to-pink-wealth-ratio"

MONITOR
1160
67
1373
112
blue to pink wealth ratio
blue-to-pink-wealth-ratio
17
1
11

PLOT
879
312
1151
525
Blue to Pink % of Total Wealth
NIL
NIL
0.0
10.0
0.0
100.0
true
false
"" ""
PENS
"blue" 1.0 0 -11221820 true "" "plot blue-pct-wealth"
"pink" 1.0 0 -5825686 true "" "plot pink-pct-wealth"

TEXTBOX
21
86
171
104
General Setup
14
0.0
1

TEXTBOX
22
227
172
245
Wealth Factors
14
0.0
1

TEXTBOX
20
332
244
366
Individual Cluster Factors
14
0.0
1

SLIDER
180
433
342
466
pink-cluster-density
pink-cluster-density
1
10
3.0
1
1
NIL
HORIZONTAL

SLIDER
17
433
175
466
blue-cluster-density
blue-cluster-density
1
10
9.0
1
1
NIL
HORIZONTAL

MONITOR
881
173
1147
218
mean (b-p) wealth difference
blue-wealth-mean - pink-wealth-mean
17
1
11

PLOT
1160
292
1374
525
mean (b-p) wealth difference
NIL
NIL
0.0
10.0
-5.0
5.0
true
false
"" ""
PENS
"b-p difference" 1.0 0 -8630108 true "" "plot (blue-wealth-mean - pink-wealth-mean)"

MONITOR
458
476
547
521
manna left
sum [manna] of patches
8
1
11

SLIDER
20
249
177
282
rich-init-wealth
rich-init-wealth
0
100
0.0
1
1
NIL
HORIZONTAL

SWITCH
181
286
338
319
wealth-factors-on
wealth-factors-on
1
1
-1000

@#$#@#$#@
## WHAT IS IT?

(a general understanding of what the model is trying to show or explain)

## HOW IT WORKS

(what rules the agents use to create the overall behavior of the model)

## HOW TO USE IT

(how to use the model, including a description of each of the items in the Interface tab)

## THINGS TO NOTICE

(suggested things for the user to notice while running the model)

## THINGS TO TRY

(suggested things for the user to try to do (move sliders, switches, etc.) with the model)

## EXTENDING THE MODEL

(suggested things to add or change in the Code tab to make the model more complicated, detailed, accurate, etc.)

## NETLOGO FEATURES

(interesting or unusual features of NetLogo that the model uses, particularly in the Code tab; or where workarounds were needed for missing features)

## RELATED MODELS

(models in the NetLogo Models Library and elsewhere which are of related interest)

## CREDITS AND REFERENCES

(a reference to the model's URL on the web if it has one, as well as any other necessary credits, citations, and links)
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.1.1
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
0
@#$#@#$#@
