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



module body_bot(columns, body_height, plug_height, spacing, dowel_heigth, dowel_diameter, dowel_y_spacing, dowel_pertrusion, pogo_height, pogo_diameter, pogo_pertusion, tolerance){
        difference()
        {
            translate([(columns-1)*spacing/2, spacing/2, 0])
            {
                roundedRect([(columns+1)*spacing + 2, (2*dowel_y_spacing) + dowel_diameter + 0.5, body_height], 0.5);

                translate([(-((columns+1)*spacing + 2)/2)+0.25, 0, body_height])
                {
                    linear_extrude(plug_height - 1)
                        square([0.5,2], center=true);
                    translate([.5, 0, plug_height - .75])
                    difference()
                    {
                        cube([1.5, 2, 1.5], center=true);
                        rotate([0, 45, 0])
                        linear_extrude(3)
                        square(3, center=true);
                    }
                }

                translate([(((columns+1)*spacing + 2)/2)-0.25, 0, body_height])
                {
                    linear_extrude(plug_height - 1)
                        square([0.5,2], center=true);
                    translate([-.5, 0, plug_height - 0.75])
                    difference()
                    {
                        cube([1.5, 2, 1.5], center=true);
                        rotate([0, -45, 0])
                        linear_extrude(3)
                        square(3, center=true);
                    }
                }
            }

            pogo_array(columns, spacing, pogo_height, pogo_diameter + tolerance, pogo_pertusion);
            dowels(dowel_heigth, dowel_diameter + tolerance, columns, spacing, dowel_y_spacing, dowel_pertrusion);
            translate([0, 0, body_height - 1]) pcb(columns, 10, spacing, tolerance);
        }
    }

module body_top(columns, body_height, plug_height, spacing, dowel_heigth, dowel_diameter, dowel_y_spacing, dowel_pertrusion, pogo_height, pogo_diameter, pogo_pertusion, tolerance){
        difference()
        {
            translate([(columns-1)*spacing/2, spacing/2, 0])
                roundedRect([(columns+1)*spacing + 2, (2*dowel_y_spacing) + dowel_diameter + 0.5, body_height], 0.5);

            translate([(columns-1)*spacing/2, spacing/2, 0])
            {

                translate([(-((columns+1)*spacing + 2)/2) + 0.25, 0, 0])
                {
                    linear_extrude(plug_height - 1)
                        square([0.5, 2 + tolerance], center=true);
                    translate([.5, 0, plug_height - .75])
                    difference()
                    {
                        cube([1.5 + tolerance, 2 + tolerance, 1.5 + tolerance], center=true);
                        translate([0, 0, tolerance]) rotate([0, 45, 0])
                        linear_extrude(3)
                        square(3, center=true);
                    }
                }

                translate([(((columns+1)*spacing + 2)/2)-0.25, 0, 0])
                {
                    linear_extrude(plug_height - 1)
                        square([0.5, 2 + tolerance], center=true);
                    translate([-.5, 0, plug_height - .75])
                    difference()
                    {
                        cube([1.5 + tolerance, 2 + tolerance, 1.5 + tolerance], center=true);
                        translate([0, 0, tolerance]) rotate([0, -45, 0])
                        linear_extrude(3)
                        square(3, center=true);
                    }
                }
            }

            translate([(columns-1)*spacing/2, spacing/2, 0])
                roundedRect([columns*spacing + tolerance, 2*spacing + tolerance, body_height], 0.5);

            translate([0, 0, -1]) pcb(columns, 10, spacing, tolerance);
        }
    }

module cable(columns, spacing, length){
    cube([(columns-1) * spacing, spacing, length]);
    for(x=[0:1:columns-1]) {
            for(y=[0:1:1]) {
                    translate([x*spacing,y*spacing,0]) cylinder(length, d=spacing);
                }
        }
}

module pcb(columns, height, spacing, tolerance){
    translate([((columns-1)*spacing)/2, spacing/2, height / 2])
        cube([(columns)*spacing + tolerance, 0.6 + tolerance, height], center=true);
    translate([((columns-1)*spacing)/2, spacing/2, 3 / 2])
        cube([(columns)*spacing + 2 + tolerance, 0.6 + tolerance, 3], center=true);
}

module pcb_outline(columns, height, spacing){
    translate([0, height / 2, 0])
        square([(columns)*spacing, height], center=true);
    translate([0, 3 / 2, 0])
        square([(columns)*spacing + 2, 3], center=true);
}
