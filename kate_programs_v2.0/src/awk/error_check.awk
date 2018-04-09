/Error/ {print $0}
/error/ {print $0}
$NF=="Completed\"" {print $0}
