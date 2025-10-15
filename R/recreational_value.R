# example to compute recreational value at the plot level as cvDBH * nSPP
# and 2 dummy variables just to test the workflow, both static, but one at the stand level, the other at the plant level
# All the indicators will be always computed at the plot level!

.recreational_value <- function(stand_static_input = NULL,
                                stand_dynamic_input = NULL,
                                plant_static_input = NULL,
                                plant_dynamic_input = NULL,
                                  ...){

  # The tree list (i.e., species, dbh, h, n) is always described in the plant_dynamic_input.
  # If only one tree list is specified, initialize 'date' column by a default value or NULL (user decision)
  # The plant_static_input will keep the 'id_stand' variable, even if it is initially designed to
  # specify variables / parameters of the plant_entity (i.e., species)

  # If any additional parameters, there are no checking to do
  # print(head(plant_dynamic_input))

  # First, filter the tree list for the living trees
  df <- plant_dynamic_input |>
    dplyr::filter(state == "live")

  # Second, join the plant-level static variables required to compute this indicator
  df <- df |> dplyr::left_join(select(plant_static_input, id_stand, plant_entity, beautiness), by = c("id_stand", "plant_entity"))


  # Third, compute the stand level variables from the plant-level variables
  df <- df |> group_by(id_stand, date) |>
    dplyr::summarise(mn_dbh = mean(dbh), sd_dbh = sd(dbh),
                     n_spp = length(unique(plant_entity)), mn_beautiness = mean(beautiness*n))

  # Forth, join the stand-level static variables
  df <- df |> left_join(select(stand_static_input, id_stand, area), by = c("id_stand")) |>
    mutate(recreational_value_01 = (mn_dbh / sd_dbh) * n_spp * mn_beautiness / area)

  ## Return the output data frame
  res = df |> select(id_stand, date, recreational_value)
  return(res)
}
