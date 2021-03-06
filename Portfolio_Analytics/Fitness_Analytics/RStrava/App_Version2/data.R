library(rStrava)


path = "R:/5_IT/5_Secrets/"
load(paste0(path, "Strava_stoken.Rdata"))

# get activities, get activities by location, plot
if (!exists("input$run")) {
    input = NULL
    input$run = 1
}
    

my_acts <- get_activity_list(stoken)

#runNo=1

run=compile_activity(my_acts[runNo])

run_distance=run$distance



# plots for most recent activity
test = get_spdsplits(my_acts,
stoken, acts = runNo, units = 'imperial')
