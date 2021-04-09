use <freeconnect.scad>

$fn=50;

tolerance = 0.2;

spacing = 1.27;
body_size = 11;
pogo_length = 16;
pogo_diameter = 0.68;
pogo_pertrude = 4;
dowel_length = 16;
dowel_vspacing = 1.015;
dowel_diameter = 0.8;
dowel_pertrude = 6;

if(all){
    body_bot(columns, body_size, body_size - 0.5, spacing, pogo_length, dowel_diameter, dowel_vspacing, dowel_pertrude, pogo_length, pogo_diameter, pogo_pertrude, 0);
    translate([0, 0 , body_size])  body_top(columns, body_size, body_size - 0.5, spacing, pogo_length, dowel_diameter, dowel_vspacing, dowel_pertrude, pogo_length, pogo_diameter, pogo_pertrude, 0);
    pogo_array(columns, spacing, pogo_length, pogo_diameter, 4);
    dowels(pogo_length, dowel_diameter, columns, spacing, dowel_vspacing, dowel_pertrude);
    translate([0, 0 , body_size - 1]) pcb(columns, body_size, spacing, 0);
    translate([0, 0 , 16]) cable(columns, spacing, 20);
}
else if(top){
    body_top(columns, body_size, body_size - 0.5, spacing, dowel_length, dowel_diameter, dowel_vspacing, dowel_pertrude, pogo_length, pogo_diameter, pogo_pertrude, tolerance);
}
else if(bot){
    body_bot(columns, body_size, body_size - 0.5, spacing, dowel_length, dowel_diameter, dowel_vspacing, dowel_pertrude, pogo_length, pogo_diameter, pogo_pertrude, tolerance);
}
else if(pcb){
    pcb_outline(columns, body_size, spacing);
}
else if(stackup){
    translate([0, 0 , 13]) body_bot(columns, body_size, body_size - 0.5, spacing, dowel_length, dowel_diameter, dowel_vspacing, dowel_pertrude, pogo_length, pogo_diameter, pogo_pertrude, 0);
    translate([0, 0 , 13 + 12 + 13])  body_top(columns, body_size, body_size - 0.5, spacing, pogo_length, dowel_diameter, dowel_vspacing, dowel_pertrude, pogo_length, pogo_diameter, pogo_pertrude, 0);
    pogo_array(columns, spacing, pogo_length, pogo_diameter, 4);
    dowels(pogo_length, dowel_diameter, columns, spacing, dowel_vspacing, dowel_pertrude);
    translate([0, 0 , 13 + 12]) pcb(columns, body_size, spacing, 0);
    translate([0, 0 , 13 + 12 + 13 + 12]) cable(columns, spacing, 20);
}