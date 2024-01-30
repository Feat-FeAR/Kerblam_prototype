# A toy ___Kerblam!___ project

This repository contains a minimal data analysis project as a personal reminder
on how to use [__Kerblam!__](https://github.com/MrHedmad/kerblam).

In this project, a single __R__ script (`getStats.R`) can be launched from two
different __Bash__ pipelines (`blue_pipe.sh` and `red_pipe.sh`) for the analysis
of the same data set (`Roughness Adhesion Replicates.txt`) made up of 42
observations of 12 variables each. The script will
1. save the correlation matrix among the 12 variables as a `TSV` file 
1. save the correlation pair-plot in `PDF` format
1. print on-screen the summary statistics resulting from a multiple linear
	regression analysis of the data.

The two pipelines only differ in the color used for the dots in the pair plot.
However, unlike the _blue_pipe_, the _red_pipe_ can be launched either locally
or dockerized. In addition, both pipelines can be run on a reduced set of data
(a subset of 4 variables) via the `--profile test` option.

## Steps taken to create this ___Kerblam!___ project

1. From my _Coding_ directory (`.`)
```sh
kerblam new Kerblam_prototype
```

1. Set the following initial options
```
Creating a new project in "Kerblam_prototype"!
Do you need Python? [yes/no]: n
Do you need R? [yes/no]: y
Do you want to use pre-commit? [yes/no]: n
Do you want to setup the remote origin of the project? [yes/no]: y
Enter your username: Feat-FeAR
What cloning method would you like? [ssh/https]: ssh
✅ "Kerblam_prototype" created!
✅ "Kerblam_prototype/data/in" created!
✅ "Kerblam_prototype/data/out" created!
✅ "Kerblam_prototype/src/pipes" created!
✅ "Kerblam_prototype/src/dockerfiles" created!
✅ "Kerblam_prototype/kerblam.toml" created!
✅ "Kerblam_prototype/.gitignore" created!
🏃 Executing 'git init'... Done!
🏃 Executing 'git remote add origin git@github.com:Feat-FeAR/Kerblam_prototype.git'... Done!
```

1. From `./Kerblam_prototype`
	- added data files to `./data/in`
	- added the source code to `./scr` (`getStats.R`)
	- added two alternative pipelines to `./scr/pipes` (as Bash scripts)
	- added a _dokerfile_ for one of the two pipelines to `./scr/dockerfiles`
	- added a section `[data.profiles.test]` to `kerblam.toml` to run the pipelines on test data
	- added this `README.md`
	- tested everything
	- run `kerblam data clean` to remove output

1. Pushed remotely on GitHub

## Disclaimer

> [!IMPORTANT]
> This is in no way meant to be a guide to using __Kerblam!__, but just a small
> and innocent template for my future projects. Please refer to the
> [official documentation](https://github.com/MrHedmad/kerblam/tree/main/docs)
> for a guide on how to use __Kerblam!__ and a full understanding of this same,
> albeit minimal, toy project.
