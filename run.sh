#!/bin/sh

for student in students/* ; do
 for turnin in ${student}/* ; do
  racket -t coq.rkt -- ${turnin} ${student}/${turnin}/*
 done | racket -t sum.rkt
done
