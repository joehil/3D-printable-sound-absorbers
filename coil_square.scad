// Copyright 2017 joehil
// This file is licensed under the terms of Creative Commons Attribution 3.0 Unported.

holed=4;
otubed=20;
wallh=4;
tubesx=3;
tubesy=3;

// module polyhole is Copyright 2011 Nophead (of RepRap fame)
// This file is licensed under the terms of Creative Commons Attribution 3.0 Unported.
module polyhole(h, d) {
    n = max(round(2 * d),3);
    rotate([0,0,180])
        cylinder(h = h, r = (d / 2) / cos (180 / n), $fn = n);
}

module coil(){
    difference(){
        cube(size=[otubed,otubed,wallh+0.8]);
        translate([otubed/2,otubed/2,-1])
        polyhole(h = 7, d = holed);
        translate([otubed/2-holed/2,otubed/2-2.5,0.8])
        cube(size=[otubed/2-0.8+2,5,7]);
        translate([0.8,0.8,0.8])
        cube(size=[otubed-1.6,5,7]);
        translate([0.8,0.8,0.8])
        cube(size=[5,otubed-1.6,7]);
        translate([0.8,otubed-5-0.8,0.8])
        cube(size=[otubed-1.6,5,7]);
        translate([otubed-5-0.8,0.8,0.8])
        cube(size=[5,otubed/2,7]);
        
    }
}

union(){
for(k=[0:tubesy-1]){  
  for(i=[0:tubesx-1]){
    translate([otubed*i-i*0.8,otubed*k-k*0.8,0])  
    coil();
  } 
}
}