# Generate xyz files from quantics output based on a unique grid that every state's wavepacket touches

## Aim

To extract grid points from a 2D normal mode coordinate space from the quantics output file (after running a MCTDH, vMCG, etc. quantum dynamics simulation). Then to select the unique grid that has non-negligible probability at any time-step ( p(t) > 10^-3 for all t ) for all states. From this unique grid, convert to xyz coordinates for each grid-point and write to xyz files. Then the xyz files can be used for quantum chemistry calculations such as calculations of ultrafast spectra over the time-evolving nuclear wavepacket.

## Requirements

quantics quantum dynamics code (showsys, vcpnts), octave (or matlab), a bash terminal

## Look at the state populations

Run the populations script to extract the populations from the 'output' file:

```
./populations.sh
```

to generate state1.pop, state2.pop, ...

The populations can be plotted with 

```
gnuplot populations.gp
```

which generates populations.eps


## Convert the output to coordinates

The first step is to generate gnuplot .pl files for each state. The showsys tool from quantics is used to generate these files:

```
showsys
20  (choose normal modes)
x 0 0 0 0 0 0 y  (this selects the normal modes to plot on the x and y axis, 0 means do not plot)
60 (choose state)
1  (state number: 1,2,...)
1  (compute densities, takes some time)
4  (write to file)
state1.pl  (file named appropriately)
0  (exit)
```

Here create directories for each state for convenience, and copy the corresponding .pl file into each directory,

```
mkdir state1 state2 ...
cp state1.pl state1/
cp state2.pl state2/
...
```

Then enter each directory and split the .pl file into time-steps,

```
./stepsplit.sh state1.pl
```

to generate step-1.dat, step-2.dat, ... , for each time-step.

Next, only select grid points with >10^-3 probability,

```
./onlynonzero.sh
```

creating step-1.nonzero, step-2.nonzero, ...

Do this for each state in each state directory.

Each time-step often repeats grid points, so use this octave (or matlab) script to print only the unique grid points touched by the wavepacket over all the time-steps:

```
octave select_grid.m
```

to generate out.dat for each state, containing all unique grid points with >10^-3 probability. Do this for each state.

It ends up that different grid points get selected for each state (out.dat is different for each state). We want an overall grid, to generate xyz files and compute the XANES spectra from. This involves selecting all the grid points touched by any state wavepacket. 

So back in the main directory,

```
octave final_grid.m
```

which creates grid.dat.

Now that we have the final grid points in normal mode coordinates (for the 2 modes selected in showsys), we need to generate xyz files for each grid point. The vcpnts tool can do this, if we create vcpnts input files for each grid point.

This is done in the vcpnts2xyz directory, and now that grid.dat is in the main directory we can run the generate_vcpnts_inps.sh,

```
cd vcpnts2xyz
./generate_vcpnts_inps.sh
```

which generates 1_vcpnts.inp, 2_vcpnts.inp, ..., for each grid point.

The next step is to run each input with vcpnts, i.e. loop over all vcpnts input files and run. This requires the frequency .log file from Gaussian S0_freq.log which is in the vcpnts2xyz directory. Run the script,

```
./create_xyzs.sh
```

to make the corresponding xyz files for each grid point. Finally, we can generate orca files based on XANES TDDFT template files,

```
./generate_orca.sh
```

This creates the orca directory, and subdirectories 1_GS, 1_CT, 2_GS, 2_CT, ... for the ground state XANES (GS), and lowest energy triplet XANES (CT) for each grid point, and copies the necessary xyz file into its appropriate orca directory.

At last, run all the orca calculations...

Then combine all spectra with weights from the quantum dynamics simulation.

# Combine spectra over each nuclear wavepacket at every time-step

- To be written soon......


