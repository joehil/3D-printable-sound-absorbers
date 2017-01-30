// Copyright 2011 Nophead (of RepRap fame)
// This file is licensed under the terms of Creative Commons Attribution 3.0 Unported.

tubed1=22;
tubed2=11;
wallh=65;
tubeh=58;
tubesx=5;
tubesy=5;



// Using this holes should come out approximately right when printed
module polyhole(h, d) {
    n = max(round(2 * d),3);
    rotate([0,0,180])
        cylinder(h = h, r = (d / 2) / cos (180 / n), $fn = n);
}

module mpp(){
difference(){
nx=tubesx*tubed1/7;
ny=tubesy*tubed1/7-1;
cube(size=[tubesx*tubed1+3,tubesy*tubed1+3,0.8]);
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

module wall(){
    difference(){
        cube(size=[tubesx*tubed1+2,tubesy*tubed1+2,wallh]);
        translate([1,1,-0.5])
        cube(size=[tubesx*tubed1,tubesy*tubed1,wallh+1]);
    }
}

union(){
wall();
mpp();
for(k=[0:tubesy-1]){  
  for(i=[0:tubesx-1]){
    translate([tubed1*i+tubed1/2+1,tubed1*k+tubed1/2+1,0.7])  
    tube(tubed1,tubed2,tubeh);
  }
}
}