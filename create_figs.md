1. Connect to wherever you will create the plots with X11 forwarding (eg: `ssh -X morricone`).
2. Test that X11 forwarding is working by running `xmessage test`. You should get a popup on your desktop with the word "test".
3. Check if orca is installed by running `orca --help`. If this runs without errors you are good to go. If the command is not found or returns an erorr [instructions are here](https://github.com/plotly/orca).
4. Update the `plots.R` script with `out.dir` (a directory with `output_matrices.RData` and `tmp.RData`) and, if necessary, `proj.dir.new` (the location of a real-time-mcmc repo) and `plot.dir` (a directory to put the output plots).
5. Make sure your working directory is this repo `cd <path>/public-RTM-reports`.
6. Run `Rscript plots.R`.