global quartus

if { 0 == [llength $quartus(args)] } {
    post_message "Usage: quartus_sh -t [info script] <file name pattern>"
} else {
    set file_pattern [lindex $quartus(args) 0]
    foreach mif_name [glob $file_pattern] {
    
        # Rename to .hex
        set rootname [file rootname $mif_name]
        set hex_name ${rootname}.hex
        
        if { [catch { qexec "[file join $quartus(binpath) mif2hex] \
            $mif_name $hex_name" } res] } {
            post_message -type error $res
            break
        } else {
            post_message "Converted $mif_name to $hex_name"
        }
    }
}