module roundedRect(size, radius){
	// size - [x,y,z]
    // radius - radius of corners
    
    x = size[0];
	y = size[1];
	z = size[2];

	linear_extrude(height=z)
	hull()
	{
		// place 4 circles in the corners, with the given radius
		translate([(-x/2)+radius, (-y/2)+radius, 0])
            circle(r=radius);
	
		translate([(x/2)-radius, (-y/2)+radius, 0])
            circle(r=radius);
	
		translate([(-x/2)+radius, (y/2)-radius, 0])
            circle(r=radius);
	
		translate([(x/2)-radius, (y/2)-radius, 0])
            circle(r=radius);
	}
}

module pogo(heigth, diameter){
        cylinder(h=heigth,r=diameter/2);
    }
    
module dowels(heigth, diameter, columns, spacing, dowel_y_spacing, pertrusion){
        translate([-spacing, spacing/2, -pertrusion])
            cylinder(h=heigth,r=diameter/2);
        translate([columns*spacing, dowel_y_spacing + spacing/2, -pertrusion])
            cylinder(h=heigth,r=diameter/2);
        translate([columns*spacing, -dowel_y_spacing + spacing/2, -pertrusion])
            cylinder(h=heigth,r=diameter/2);
    }
    
module pogo_array(columns, spacing, pogo_height, pogo_diameter, pertusion) {
        for(x=[0:1:columns-1]) {
                for(y=[0:1:1]) {
                        translate([x*spacing,y*spacing,-pertusion]) pogo(pogo_height, pogo_diameter);
                    }
            }
    } 

module body(columns, body_height, plug_height, spacing, dowel_heigth, dowel_diameter, dowel_y_spacing, dowel_pertrusion, pogo_height, pogo_diameter, pogo_pertusion, tolerance){
        difference()
        {
            translate([(columns-1)*spacing/2, spacing/2, 0])
            {
                roundedRect([(columns+1)*spacing + 2, spacing + 2, body_height], 0.5);
            
                translate([(-((columns+1)*spacing + 2)/2)+0.5, 0, body_height])
                {
                    linear_extrude(plug_height - 1)    
                        square([1,2], center=true);
                    translate([.5, 0, plug_height - 1])
                    difference()
                    {
                        cube(2, center=true);
                        rotate([0, 45, 0])
                        linear_extrude(3) 
                        square(3, center=true);
                    }
                }
                    
                translate([(((columns+1)*spacing + 2)/2)-0.5, 0, body_height])
                {
                    linear_extrude(plug_height - 1)    
                        square([1,2], center=true);
                    translate([-.5, 0, plug_height - 1])
                    difference()
                    {
                        cube(2, center=true);
                        rotate([0, -45, 0])
                        linear_extrude(3) 
                        square(3, center=true);
                    }
                }
            }
            
            pogo_array(columns, spacing, pogo_height, pogo_diameter + tolerance, pogo_pertusion);
            dowels(dowel_heigth, dowel_diameter + tolerance, columns, spacing, dowel_y_spacing, dowel_pertrusion);
            pcb(columns, pogo_diameter, 11, spacing, tolerance);
        }
    }
    
module body_cover(columns, body_height, plug_height, spacing, tolerance){
        difference()
        {
            translate([(columns-1)*spacing/2, spacing/2, 0])
                roundedRect([(columns+1)*spacing + 2, spacing + 2, body_height], 0.5);
            
            translate([(columns-1)*spacing/2, spacing/2, 0])
            {
                
                translate([(-((columns+1)*spacing + 2)/2)+0.4999, 0, -0.0001])
                {
                    linear_extrude(plug_height - 1)    
                        square([1,2 + tolerance], center=true);
                    translate([.5, 0, plug_height - 1])
                    difference()
                    {
                        cube(2 + tolerance, center=true);
                        rotate([0, 45, 0])
                        linear_extrude(3) 
                        square(3, center=true);
                    }
                }
                    
                translate([(((columns+1)*spacing + 2)/2)-0.4999, 0, -0.0001])
                {
                    linear_extrude(plug_height - 1)    
                        square([1,2 + tolerance], center=true);
                    translate([-.5, 0, plug_height - 1])
                    difference()
                    {
                        cube(2 + tolerance, center=true);
                        rotate([0, -45, 0])
                        linear_extrude(3) 
                        square(3, center=true);
                    }
                }
            }
        
            translate([(columns-1)*spacing/2, spacing/2, -0.0001])
            {
                roundedRect([(columns-1)*spacing + 1, 2.6, body_height-1], 0.5);
                roundedRect([(columns-1)*spacing + 1, 2, body_height+0.001], 0.5);
            }
        }
    }
    
module pcb(c, d, height, spacing, tolerance){
    translate([-d/2 -0.1 - (tolerance/2), d/2 - (tolerance/2), height-1])
        cube([(c-1)*spacing + d + 0.2 + tolerance, 0.6 + tolerance, 10]);
}
