#!/bin/bash

sed -i "s/demo-project-demogcp/$1/" variables.tf
sed -i "s/demo_project_demogcp/$2/" variables.tf
