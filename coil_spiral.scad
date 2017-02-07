// Copyright 2017 joehil
// This file is licensed under the terms of Creative Commons Attribution 3.0 Unported.

tubesx=1;
tubesy=1;

holed=4;
otubed=20;
wallh=1;

// module polyhole is Copyright 2011 Nophead (of RepRap fame)
// This file is licensed under the terms of Creative Commons Attribution 3.0 Unported.
module polyhole(h, d) {
    n = max(round(2 * d),3);
    rotate([0,0,180])
        cylinder(h = h, r = (d / 2) / cos (180 / n), $fn = n);
}

module spiral(baseRadius=3,frequency=1) {
	diff=(baseRadius*2+0.5);
    factor=diff/120;
    union(){
		for(i=[0:120*frequency]){
			hull(){
				rotate ([0,0,i*3]) translate ([i*factor,0,0]) sphere(r=baseRadius, center=true);
				rotate ([0,0,(i*3+1)]) translate ([(i+1)*factor,0,0]) sphere(r=baseRadius,center=true);
			}
		}
	}
}

module spiral_narrowing(baseRadius=3,frequency=1) {
	diff=(baseRadius*2+0.5);
    factor=diff/120;
    union(){
		for(i=[0:120*frequency]){
			hull(){
                if(i<240){
                    rotate ([0,0,i*3]) translate ([i*factor,0,0]) sphere(r=baseRadius, center=true);
                    rotate ([0,0,(i*3+1)]) translate ([(i+1)*factor,0,0]) sphere(r=baseRadius,center=true);
                }
                else{
                    rotate ([0,0,i*3]) translate ([i*factor,0,0]) sphere(r=baseRadius-baseRadius*(i-240)/150, center=true);
                    rotate ([0,0,(i*3+1)]) translate ([(i+1)*factor,0,0]) sphere(r=baseRadius-baseRadius*(i-240)/150,center=true);
                }
			}
		}
	}
}

module coil(){
    difference(){
        cube(size=[otubed,otubed,wallh+0.8]);
        translate([otubed/2,otubed/2,-1])
        polyhole(h = 3.5, d = holed);
        translate([otubed/2+0.7,otubed/2,2.3])
//        spiral(baseRadius=1.5,frequency=2.68);
        spiral_narrowing(baseRadius=1.5,frequency=2.8);
    }
}

//coil();

union(){
for(k=[0:tubesy-1]){  
  for(i=[0:tubesx-1]){
    translate([otubed*i-i,otubed*k-k,0])  
    coil();
  } 
}
}