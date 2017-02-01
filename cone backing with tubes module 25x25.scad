// Copyright 2017 joehil
// This file is licensed under the terms of Creative Commons Attribution 3.0 Unported.

tubed1=20;
tubed2=11;
otubed=25;
wallh=65;
tubeh=58;
tubesx=2;
tubesy=2;


// module polyhole is Copyright 2011 Nophead (of RepRap fame)
// This file is licensed under the terms of Creative Commons Attribution 3.0 Unported.
module polyhole(h, d) {
    n = max(round(2 * d),3);
    rotate([0,0,180])
        cylinder(h = h, r = (d / 2) / cos (180 / n), $fn = n);
}

module mpp(){
difference(){
nx=tubesx*otubed/7;
ny=tubesy*otubed/7-1;
cube(size=[tubesx*otubed,tubesy*otubed,0.8]);
    for(k=[0:ny]){
        for(i=[1:nx]){
            translate([(i*7-2), 4+k*7,-2])
                polyhole(h = 5, d = 0.8);
        }
    }
}
}

module tube(d1,d2,h){
    difference(){
        cylinder(d1=d1,d2=d2,h=h);
        translate([0,0,-0.5])
        cylinder(d1=d1-2,d2=d2-2,h=h+1);
    }
}

module otube(){
    difference(){
        cylinder(d1=otubed,d2=otubed,h=wallh);
        translate([0,0,-0.5])
        cylinder(d1=otubed-2,d2=otubed-2,h=wallh+1);
    }
}

module wall(){
    difference(){
        cube(size=[tubesx*tubed1+2,tubesy*tubed1+2,wallh]);
        translate([1,1,-0.5])
        cube(size=[tubesx*tubed1,tubesy*tubed1,wallh+1]);
    }
}

union(){
//wall();
mpp();
for(k=[0:tubesy-1]){  
  for(i=[0:tubesx-1]){
    translate([otubed*i+otubed/2+1,otubed*k+otubed/2+1,0.7])  
    tube(tubed1,tubed2,tubeh);
    translate([otubed*i+otubed/2+1,otubed*k+otubed/2+1,0.7])  
    otube();
  }
}
}