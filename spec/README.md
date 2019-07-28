# Simple Crontab Calculator

A command line program to calculate the time of the next occurance of a crontab

# To use

You require a Ruby runtime to run the script. Mac OS has ruby installed by default. Linux users will have to install ruby for continuing.

## Make script executable

OSX 
```bash
$ chmod +x ./cron_predictor.rb
```

## Run program

The program takes two arguments. The first is a time in format HH:MM and the second argument is the path to file which holds your crontabs.
```bash
./cron_predictor.rb 10:20 <path/to/your/input/file>
```
ex. `./cron_predictor.rb 10:20 ./example_config`

# Design decisions

Some assumptions are made for simplicity.

## Assumptions
- The crontab syntax is limited to Minutes and Hours

# TODO

- improve exception handling
