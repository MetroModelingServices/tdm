### Description of inro.emme package for R ###
#  
#Documentation for inro.emme R library v 1.0.1
#18-12-2013
#INRO Consultants www.inrosoftware.com
#
#Compatible with Emme versions 4.0.1 to 4.1.x
#R Project version 3.0.2+
#Rcpp version 0.10.5
#
#Installation instructions:
#1. Install the Emme R package.
#    Packages -> Install package(s) from local zip files...
#    Choose the inro.emme zip file.
#
#2. Install the Rcpp package.
#    Packages -> Install package(s)...
#    Choose "Rcpp" from the list.
#    Or, load Rcpp package 0.10.5 from a local zip file.
#    Packages -> Install package(s) from local zip files...
#    
#3. Test the Emme R package.
#    At the R Console type "library(inro.emme)"
#    
#
#Emmebank
#    Constructor:
#        Emmebank(path, no_lock_file)
#            Open the Emme database ("emmebank" file) located at path, and 
#            return an Emmebank object.
#            path: The path to the emmebank file as a string. Use forward 
#            slashes or escape backslashes.
#            no_lock_file: whether to enforce the lock file or not. FALSE 
#            enforces the lock file, TRUE ignores it so please exercise 
#            caution.
#
#    Methods: 
#        matrix(name)
#            Lookup and return an EmmeMatrix object specified by name.
#            name: a valid matrix identifier or name. Takes one of three 
#            forms: the standard Emme matrix ID "mf1"; matrix name "auds"; 
#            or the matrix name proceeded by the prefix "mfauds".
#            
#        create_matrix(id, default_value)
#            Create and return a new matrix with the given id. 
#            The matrix cells will be initialized to default_value.
#            
#        available_matrix_identifier(type)
#            Return an available matrix identifier of the specified type.
#            Type must be one of "FULL", "ORIGN", "DESTINATION" or "SCALAR".
#            
#        delete_matrix(id)
#            Delete the matrix specified by id.
#            If there is an EmmeMatrix object for this matrix ID it will
#            now be invalid.
#            
#        scenario_numbers()
#            Return a list of the numbers (IDs) for the defined scenarios.
#            
#        dispose()
#            Closes the emmebank and removes the lock file ("emlocki"). The 
#            Emmebank object and any related EmmeMatrix objects are invalid 
#            after this call.
#
#EmmeMatrix
#            
#    Fields: 
#        id 
#            The standard matrix id, the type prefix followed by the matrix 
#            number. Read-only.
#            
#        prefix 
#            The two letter indicator of the type of matrix. Possible values 
#            are 'ms' for scalar, 'mo' for origin, 'md' for destination and 
#            'mf' for full. Read-only.
#            
#        type 
#            The type of the matrix. One of "SCALAR", "ORIGIN", "DESTINATION" 
#            or "FULL". Read-only.
#
#    Methods: 
#        get_data(scenario_id)  
#            Return the matrix data, using the zone system from the scenario 
#            specified by scenario_id. Note: for scalar matrix the scenario_id
#            still needs to be specified but is not actually used.
#               
#        set_data(data, scenario_id) 
#            Set the matrix data on disk to data, using the zone system from 
#            the scenario specified by scenario_id. The size of the data must 
#            correspond to the type of matrix and the number of zones in the 
#            specified zone system.
#            
#        init(value)
#            Set all cells in the matrix to value.
#
#        get_name()  
#        set_name(name)  
#            name: up to six characters.
#        get_description()
#        set_description(description)  
#            description: up to 40 characters.
#               
#Example usage:
#> library(inro.emme)
#Loading required package: Rcpp
#> emmebank <- new(Emmebank, "<path_to_emmebank>", FALSE)
#> matrix_ms1 <- emmebank$matrix("ms1")
#> auto_demand <- emmebank$matrix("mfauds")
#> auto_demand$id
# [1] "mf1"
#> auto_demand$get_name()
# [1] "auds"
#> auto_demand$set_name("PMdem")
#> auto_demand$set_description("PM Auto demand (transposed)")
#> auto_demand_data <- auto_demand$get_data(3001)
#> dim(auto_demand_data)
# [1] 154 154
#> auto_demand$set_data(t(auto_demand_data), 3001)
#>
#> new_matrix_id <- emmebank$available_matrix_identifier("FULL")
#> results_matrix <- emmebank$create_matrix(new_matrix_id, -1)
#> results_matrix$set_name("result")
#> results_matrix$set_description("Result of impedance calculation")
#> emmebank$delete_matrix(results_matrix$id)
#>
#> emmebank$dispose()
