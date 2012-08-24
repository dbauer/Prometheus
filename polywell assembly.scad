res=55;
////////////////8 INCH CONFLAT FLANGE////////////////////////////
conrad=100.8;
conheight=22.1;

module conflat(){
	difference(){

//conflat body
		union(){
cylinder(h=22.1, r=conrad, $fn=res);

//conflat ridge
			translate([0,0,22.1]){
				difference(){
cylinder(h=1, r=conrad, $fn=res);
translate([0,0,-.2]) 
cylinder(h=2, r=conrad -15.5, $fn=res);
				}
			}
		}

//center hole 
translate([0,0,-4])
cylinder(h=30, r=18.9, $fn=res);

//screw hole 1
translate([43,0,22.3-4.7-20])
cylinder(h=9.8+20, r=2.9, $fn=res);

//screw hole 2
translate([-42.4,0,22.3-4.7-20])
cylinder(h=9.8+20, r=2.9, $fn=res);

//bolt holes
for (x=[18:18:360])
rotate([0,0,x+9])
translate([conrad-6.5,0,-1])
cylinder(h=25, r=4, $fn=res);

//helium leak slots
translate([conrad-15.6,0,conheight]) 
cube([15.7,1.6,2.8]);
translate([-conrad,0.6,conheight]) 
cube([15.7,1.6,2.8]);
	}

//knife edge
translate([0,0,22.1])
rotate_extrude($fn=res)
translate([conrad-17.3,0,0]) 
polygon( points=[[0,0],[2.8,0],[0,1]]);
}
/////////////////////////////////////////////////////////////////////////////

//////////////////////////////CHAMBER///////////////////////////////////


chamlength=228.6;
chaminrad=73.4;
chamoutrad =76;


module chamber(){

////chamber outside
	difference(){
		union(){
			rotate([-90,0,0]){
//x tube
			
				
translate([0,0,-75.7])
				difference(){
cylinder(h=chamlength, r=chamoutrad, fn=100, $fn=res);
rotate([0,45,0])
translate([-53.5,-140,-55])  
cube(250);
				}
				

	//y tube
translate([-75.7,0,0])
rotate([0,270,180])
				difference(){
cylinder(h=chamlength, r=chamoutrad, fn=100, $fn=res);

//slicer cube
rotate([0,45,0])
translate([-53.5,-140,-55])
cube(250);
				}
			}
		}


////chamber inside
	//x tube
		union(){
			rotate([-90,0,0]){
translate([0,0,-75.7])
				difference(){
cylinder(h=chamlength+5, r=chaminrad, fn=100, $fn=res);

	//slicer cube
rotate([0,45,0])
translate([-53.5,-140,-55]) 
cube(250);
				}
				

	//y tube
translate([-75.7,0,0])
rotate([0,270,180])
			difference(){
cylinder(h=chamlength+5, r=chaminrad, fn=100, $fn=res);

	//slicer cube
rotate([0,45,0])
translate([-53.5,-140,-55])
cube(250);
			}			
		}
	}
}
	
////bolt rims
	
	//bolt rim x
	translate([133.3,0,0]){	
		rotate([0,90,0]){
			difference(){
conflat();
		
translate([0,0,-3]) 
cylinder(r=conrad-27, h=30, $fn=res);
			}
		}
	}
	//bolt rim 
	rotate([0,90,90]){
		translate([0,0,133.3]){	
			difference(){
conflat();

translate([0,0,-3]) 
cylinder(r=conrad-27, h=30, $fn=res);
			}
		}
	}
}





//////////////////////////////////////////////////////////////////////////////

/////////////////////////////////CORE/////////////////////////////////////

//these variables control the deminsions of the core.
//tweak them to get the right balance of toroidal raduis, cube size, ect.

	facerad=40;
	torusoutrad=8;
	torusinrad=torusoutrad-3;
	coilspace=facerad+12;
	connectorpos= sqrt(2*coilspace*coilspace)-7.5;
	coreoffset=7; //if you want the core centered in the chamber, set this to 0
	

module core(){
difference(){
////core outside
	translate([coreoffset, -coreoffset,0]){
	union(){

	//coilface1
		translate([0,coilspace,0]){
		rotate(a=[90,0,0])
		rotate_extrude($fn=res)
		translate([facerad, 0, 0])
		circle(r = torusoutrad, $fn = res);
}

	//coil face 2
		translate([0,-coilspace,0]){
		rotate(a=[90,0,0])
		rotate_extrude($fn=res)
		translate([facerad, 0, 0])
		circle(r =torusoutrad, $fn = res);
}

	//coil face 3
		translate([0,0,coilspace]){
		rotate([90,0,0]){
		rotate(a=[90,0,0])
		rotate_extrude($fn=res)
		translate([facerad, 0, 0])
		circle(r =torusoutrad, $fn = res);
}}

	//coil face 4
		translate([0,0,-coilspace]){
		rotate([90,0,0]){
		rotate(a=[90,0,0])
		rotate_extrude($fn=res)
		translate([facerad, 0, 0])
		circle(r = torusoutrad, $fn = res);
}}

	//coil face 5
		translate([coilspace,0,0]){
		rotate([0,0,90]){
		rotate(a=[90,0,0])
		rotate_extrude($fn=res)
		translate([facerad, 0, 0])
		circle(r = torusoutrad, $fn = res);
}}

	//coil face 6
		translate([-coilspace,0,0]){
		rotate([0,0,90]){
		rotate(a=[90,0,0])
		rotate_extrude($fn=res)
		translate([facerad, 0, 0])
		circle(r =torusoutrad, $fn = res);
}}


	//torus connectors about y axis
		for(y=[0:90:360])
		rotate([y+42,0,0])
		translate([-2,connectorpos,0]) cube([4,4,7]);

	//torus connectors about x axis
		for(x=[0:90:360])
		rotate([0,x+47,0])
		translate([connectorpos,-2,0]) cube([4,4,7]);

	//torus connectors about z axis
		for(z=[0:90:360])
		rotate([0,0,z+43])
		translate([connectorpos,0,-2]) cube([4,7,4]);


translate([0,-sqrt(2*(facerad*facerad))+20,sqrt(2*(facerad*facerad))-10]){
rotate([45,0,0]){

translate([3,-7,-8]){
difference(){ 
cylinder(r=3,h=20, $fn=res);
translate([-3,0,-1]) cylinder(r=1, h=30, $fn=res);
}}}
}}
}

////core inside
	translate([coreoffset, -coreoffset,0]){
	union(){

	//coilcavity1
		translate([0,coilspace,0]){
		rotate(a=[90,0,0])
		rotate_extrude($fn=res)
		translate([facerad, 0, 0])
		circle(r = torusinrad, $fn = res);
}

	//coilcavity2
		translate([0,-coilspace,0]){
		rotate(a=[90,0,0])
		rotate_extrude($fn=res)
		translate([facerad, 0, 0])
		circle(r = torusinrad, $fn = res);
}

	//coilcavity3
		translate([0,0,coilspace]){
		rotate([90,0,0]){
		rotate(a=[90,0,0])
		rotate_extrude($fn=res)
		translate([facerad, 0, 0])
		circle(r = torusinrad, $fn = res);
}}

	//coilcavity4
		translate([0,0,-coilspace]){
		rotate([90,0,0]){
		rotate(a=[90,0,0])
		rotate_extrude($fn=res)
		translate([facerad, 0, 0])
		circle(r = torusinrad, $fn = res);
}}

	//coilcavity5
		translate([coilspace,0,0]){
		rotate([0,0,90]){
		rotate(a=[90,0,0])
		rotate_extrude($fn=res)
		translate([facerad, 0, 0])
		circle(r = torusinrad, $fn = res);
}}

	//coilcavity6
		translate([-coilspace,0,0]){
		rotate([0,0,90]){
		rotate(a=[90,0,0])
		rotate_extrude($fn=res)
		translate([facerad, 0, 0])
		circle(r =torusinrad, $fn = res);
}}}}

//slicer cube
	translate([coreoffset, -coreoffset,0]){
	for(x=[0:90:360])
	rotate([x,0,0])
	for(y=[0:90:360])
	rotate([0,0,y])
	translate([-facerad-10,-facerad-22, -facerad-10]) 
	cube([2*facerad+20, torusoutrad+2,2*facerad+20]);
}

}}
////////////////////////////////////////////////////////////////////////////


///////////////////////////////COVERS///////////////////////////////////

////normal covers
	//cover outside
	//for(w=[0:100:500])
	//translate([w,0,0]){
	module cover(){

	difference(){		
		
		rotate_extrude($fn=res)
		translate([facerad, 0, 0])
		circle(r =torusoutrad, $fn = res);

	//cover inside
		
		rotate_extrude($fn=res)
		translate([facerad, 0, 0])
		circle(r =torusinrad, $fn = res);

	//slicer
		translate([0,0,torusoutrad-3])
		cube([2*facerad+20,2*facerad+20, torusoutrad+2], center=true);
}}

////support cover

module supportcover(){
	rotate([0,0,90]){
	//cover
		translate([coreoffset, -coreoffset,0])
		translate([-49.1,0,0])   				
		rotate([0,90,0])
		cover();

	//column 1
		difference(){
		translate([coreoffset, -coreoffset,0]) 
		translate([-54.6,facerad,0])
		rotate([0,270,0])
		cylinder(r=6,h=88.9, $fn=res);

		rotate([90,0,0])
		translate([-173.15,0,0])
		rotate([0,90,0])
		translate([43,0,35.5])
		cylinder(h=30,r=6.5, $fn=res);
		}

// elefant foot 1
		translate([16.25,0,0]){
			difference(){
				hull(){
		translate([coreoffset, -coreoffset,0]) 
		translate([-142.5,facerad,0])
		rotate([0,270,0])
		cylinder(r=6,h=20, $fn=res);

		rotate([90,0,0])
		translate([-173.15,0,0])
		rotate([0,90,0])
		translate([43,0,22.3-4.7])
		color("red")
		cylinder(h=1, r=15, $fn=res);

				}
		rotate([90,0,0])
		translate([-173.15,0,0])
		rotate([0,90,0])
		translate([43,0,22.3-5.7])
		cylinder(h=23,r=3.6, $fn=res);
		
		rotate([90,0,0])
		translate([-173.15,0,0])
		rotate([0,90,0])
		translate([43,0,20.5])
		cylinder(h=23,r=6.5, $fn=res);
			}
		}

	//column 2
	
		difference(){		
		translate([coreoffset, -coreoffset,0]) 
		translate([-126.3,-facerad,0])
		rotate([-180,270,0])
		cylinder(r=6,h=72.445, $fn=res);

		rotate([90,0,0])
		translate([-183,0,0])
		rotate([0,90,0])
		translate([-42.4,0,50.3-4.7])
		cylinder(h=43, r=6.4, $fn=res);
		}

//elephant foot 2

		translate([16.25,0,0]){		
			difference(){
				hull(){
		translate([coreoffset, -coreoffset,0]) 
		translate([-142,-facerad,0])
		rotate([0,270,0])
		cylinder(r=6,h=20.5, $fn=res);

		translate([coreoffset, -coreoffset,0]) 
		translate([-161.47,-facerad+4.55,-.3])
		rotate([0,270,0])
		cylinder(r=15,h=1, $fn=res);
				}
	//screw hole
		rotate([90,0,0])
		translate([-183,0,0])
		rotate([0,90,0])
		translate([-42.4,0,30.5])
		cylinder(h=17.8, r1=6.5, r2=6.4, $fn=res);

		rotate([90,0,0])
		translate([-183,0,0])
		rotate([0,90,0])
		translate([-42.4,0,22.5])
		cylinder(h=30.8, r=3.5, $fn=res);
			}
		}
	}

//accerlerator cradle
translate([0,12,0]){
	difference(){
translate([coreoffset, -coreoffset, 0])
translate([0,-85,-7.65])
cube([10,15,15]);

translate([coreoffset, -coreoffset, 0])
 rotate([90,0,0])
translate([0,0,69])
cylinder(h=17.5, r=7.9);


//zip tie hole
	
rotate([0,0,90])
translate([-83.5,-17,-20])
scale([1.5,1,1])
cylinder(h=40, r=2);	
	}

	rotate([0,0,90]){
		translate([-14,0,0]){
			difference(){
				hull(){

translate([coreoffset, -coreoffset,0]) 
translate([-60,-facerad,0])
rotate([0,270,0])
cylinder(r=6,h=42, $fn=res);

rotate([0,0,-90])
translate([15,-78,-7.65]) 
cube([1,15,15]);
				}

//zip tie hole
	
translate([-70,-17,-20])
scale([1.5,1,1])	
cylinder(h=40, r=2);
	
			}
		}
	}
}
}
//////////////////////////////////////////////////////////////////////////////


///////////////////////////E GUN ASSEMBLY/////////////////////////////


module targets(){
//guide ball
translate([coreoffset, -coreoffset, 0])
color([.1,.1,.6]) 
sphere(5);

//guide rod
translate([coreoffset, -coreoffset, 0])
rotate([90,0,0])
color([.1,.6,.1])
cylinder(h=500, r=.5, $fn=res);
}


//cathode holder
module cathodeholder(){

//bottom piece
	translate([0,12,0]){
		difference(){


translate([coreoffset, -coreoffset,0]) 
translate([-facerad/2-12,-130,-6])
cube([facerad+15,20,6]);

//wire holders
translate([coreoffset, -coreoffset, 0])
translate([5,-105,0])
rotate([90,0,0])
cylinder(h=30, r=2.5, $fn=res);

translate([coreoffset, -coreoffset, 0])
translate([-5,-105,0])
rotate([90,0,0])
cylinder(h=30, r=2.5, $fn=res);


//zip tie groves
translate([coreoffset, -coreoffset, 0])
translate([16,-105,-7])
rotate([90,0,0])
scale([1.5,1,1])
cylinder(h=30, r=2.5, $fn=res);


translate([coreoffset, -coreoffset, 0])
translate([-17,-105,-7])
rotate([90,0,0])
scale([1.5,1,1])
cylinder(h=30, r=2.5, $fn=res);


//ziptie hole
translate([coreoffset, -coreoffset, 0])
translate([-27,-119,-9])
rotate([0,0,90])
scale([1.5,1,1])
cylinder(h=30, r=2.5, $fn=res);
		
		}	
	}


//column hugger

	difference(){
translate([coreoffset, -coreoffset,0]) 
translate([-35,-facerad-58,])
rotate([90,0,0])
cylinder(r=7,h=20, $fn=res);

translate([coreoffset, -coreoffset,0]) 
translate([-40,-facerad-57,0])
rotate([90,0,0])
cylinder(r=6,h=22, $fn=res);

//ziptie hole

translate([coreoffset, -coreoffset, 0])
translate([-27,-107,-9])
rotate([0,0,90])
scale([1.5,1,1])
cylinder(h=30, r=2.5, $fn=res);
	}

//top piece
	translate([0,6,-5.5]){				
		difference(){

translate([coreoffset, -coreoffset,0])
translate([-facerad/2-8,-124,6])
cube([facerad+11,20,6]);


//wire holes
translate([coreoffset, -coreoffset, 0])
translate([5,-96,6])
rotate([90,0,0])
cylinder(h=30, r=2.5, $fn=res);


translate([coreoffset, -coreoffset, 0])
translate([-5,-96,6])
rotate([90,0,0])
cylinder(h=30, r=2.5, $fn=res);


//zip tie grooves
translate([coreoffset, -coreoffset, 0])
translate([16,-96,12])
rotate([90,0,0])
scale([1.5,1,1])
cylinder(h=30, r=2.5, $fn=res);


translate([coreoffset, -coreoffset, 0])
translate([-17,-96,12])
rotate([90,0,0])
scale([1.5,1,1])
cylinder(h=30, r=2.5, $fn=res);
				
				

//ziptie hole

translate([coreoffset, -coreoffset, 0])
translate([-27,-112,-9])
rotate([0,0,90])
scale([1.5,1,1])
cylinder(h=30, r=2.5, $fn=res);
		
		}
	} 
} 


//cathode holder
module dissassembledcathodeholder(){

//bottom piece
	translate([0,12,0]){
		difference(){


translate([coreoffset, -coreoffset,0]) 
translate([-facerad/2-12,-130,-6])
cube([facerad+15,20,6]);

//wire holders
translate([coreoffset, -coreoffset, 0])
translate([5,-105,0])
rotate([90,0,0])
cylinder(h=30, r=2.5, $fn=res);

translate([coreoffset, -coreoffset, 0])
translate([-5,-105,0])
rotate([90,0,0])
cylinder(h=30, r=2.5, $fn=res);


//zip tie groves
translate([coreoffset, -coreoffset, 0])
translate([16,-105,-7])
rotate([90,0,0])
scale([1.5,1,1])
cylinder(h=30, r=2.5, $fn=res);


translate([coreoffset, -coreoffset, 0])
translate([-17,-105,-7])
rotate([90,0,0])
scale([1.5,1,1])
cylinder(h=30, r=2.5, $fn=res);


//ziptie hole
translate([coreoffset, -coreoffset, 0])
translate([-27,-119,-9])
rotate([0,0,90])
scale([1.5,1,1])
cylinder(h=30, r=2.5, $fn=res);
		
		}	
	}


//column hugger

	difference(){
translate([coreoffset, -coreoffset,0]) 
translate([-35,-facerad-58,])
rotate([90,0,0])
cylinder(r=7,h=20, $fn=res);

translate([coreoffset, -coreoffset,0]) 
translate([-40,-facerad-57,0])
rotate([90,0,0])
cylinder(r=6,h=22, $fn=res);

//ziptie hole

translate([coreoffset, -coreoffset, 0])
translate([-27,-107,-9])
rotate([0,0,90])
scale([1.5,1,1])
cylinder(h=30, r=2.5, $fn=res);
	}

//top piece
	translate([0,50,-12.5]){				
		difference(){

translate([coreoffset, -coreoffset,0])
translate([-facerad/2-8,-124,6])
cube([facerad+11,20,6]);


//wire holes
translate([coreoffset, -coreoffset, 0])
translate([5,-96,6])
rotate([90,0,0])
cylinder(h=30, r=2.5, $fn=res);


translate([coreoffset, -coreoffset, 0])
translate([-5,-96,6])
rotate([90,0,0])
cylinder(h=30, r=2.5, $fn=res);


//zip tie grooves
translate([coreoffset, -coreoffset, 0])
translate([16,-96,12])
rotate([90,0,0])
scale([1.5,1,1])
cylinder(h=30, r=2.5, $fn=res);


translate([coreoffset, -coreoffset, 0])
translate([-17,-96,12])
rotate([90,0,0])
scale([1.5,1,1])
cylinder(h=30, r=2.5, $fn=res);
				
				

//ziptie hole

translate([coreoffset, -coreoffset, 0])
translate([-27,-112,-9])
rotate([0,0,90])
scale([1.5,1,1])
cylinder(h=30, r=2.5, $fn=res);
		
		}
	} 
} 


////////////////////////////////////////////////////////////////////////////

//to see the parts, uncomment these
//rotate([270,0,0])translate([0,0,-500])conflat();
//core();
//rotate([0,0,-90])chamber();
//translate([0,-17,0])supportcover();
//targets();
//translate([0,-8,0])cathodeholder();



