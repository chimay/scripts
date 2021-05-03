#!/usr/bin/env zsh

# vim: fdm=indent:

setopt extended_glob

if [ $# -eq 0 ]
then
	echo Usage : $0 duration
	exit 0
fi

tempus=$1

tempus=${tempus//./:}

# Default values ?

if [[ $tempus = ?*:?*:?* ]]
then
	duration=(${(s/:/)tempus})
	hour=$duration[1]
	min=$duration[2]
	sec=$duration[3]
elif [[ $tempus = ?*:?*: ]]
then
	duration=(${(s/:/)tempus})
	hour=$duration[1]
	min=$duration[2]
elif [[ $tempus = ?*::?* ]]
then
	duration=(${(s/:/)tempus})
	hour=$duration[1]
	sec=$duration[2]
elif [[ $tempus = ?*:: ]]
then
	duration=(${(s/:/)tempus})
	hour=$duration[1]
elif [[ $tempus = :?*:?* ]]
then
	duration=(${(s/:/)tempus})
	min=$duration[1]
	sec=$duration[2]
elif [[ $tempus = :?*: ]]
then
	duration=(${(s/:/)tempus})
	min=$duration[1]
elif [[ $tempus = ::?* ]]
then
	duration=(${(s/:/)tempus})
	sec=$duration[1]
elif [[ $tempus = ?*:?* ]]
then
	duration=(${(s/:/)tempus})
	min=$duration[1]
	sec=$duration[2]
elif [[ $tempus = ?*: ]]
then
	duration=(${(s/:/)tempus})
	min=$duration[1]
elif [[ $tempus = :?* ]]
then
	duration=(${(s/:/)tempus})
	sec=$duration[1]
elif [[ $tempus = ?* ]]
then
	min=$tempus
fi

# Fractions

hour=$(echo "scale=7\n$hour" | bc)
min=$(echo "scale=7\n$min" | bc)
sec=$(echo "scale=7\n$sec" | bc)

# Décimaux

float flottant

# Décimaux heure

(( flottant = hour % 1 ))

(( hour -= flottant ))
(( min += 60 * flottant ))

# Décimaux minute

(( flottant = min % 1 ))

(( min -= flottant ))
(( sec += 60 * flottant ))

# Décimaux sec

(( flottant = sec % 1 ))

(( sec -= flottant ))

if (( flottant > 0.5 ))
then
	(( sec += 1 ))
fi

# Conversion en nombres entiers

integer hour=$hour
integer min=$min
integer sec=$sec

integer quotient modulo

# N x 60 sec -> N min

(( quotient = sec / 60 ))
(( modulo = sec % 60 ))

(( min += quotient ))
(( sec -= quotient * 60 ))

# N x 60 min -> N hour

(( quotient = min / 60 ))
(( modulo = min % 60 ))

(( hour += quotient ))
(( min = modulo ))

# print result

echo $hour:$min:$sec
