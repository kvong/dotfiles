#!/bin/bash

numConnectedSSH=$(ss | grep -i ssh | wc -l)

echo $numConnectedSSH connected
