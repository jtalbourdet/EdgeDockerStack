#!/bin/bash

function createDb {
    echo " *****Création base de donnée $1 *****"
    influx -execute "CREATE DATABASE $1"
}

# Créate new db when container start
#createDb db_metrics_tests