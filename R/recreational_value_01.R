# example to compute recreational value at the plot level as cvDBH * nSPP
# All the indicators will always be computed at the plot level! 

recreational_value_01 <- function(stand_static_input,
                                  stand_dynamic_input = NULL,
                                  plant_static_input = NULL,
                                  plant_dynamic_input = NULL){
  
  # The tree list (i.e., species, dbh, h, n) is always described in the plant_dynamic_input. 
  # If only one tree list is specified, initialize 'date' column by a default value or NULL (user decision)
  # The plant_static_input will keep the 'id_stand' variable, even if it is initially designed to
  # specify variables / parameters of the plant_entity (i.e., species) 
  
  # If any additional parameters, there are no checking to do
  
  # First, filter the tree list for the living trees
  df <- plant_dynamic_input |> filter(state == "live")  
  
  
  
}