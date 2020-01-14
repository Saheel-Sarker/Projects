#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <time.h>
#include "lcs.h"
#include "lts.h"

int validate (char sequence[], int length);
void input(int *seq1Len, int *seq2Len, char seq1[], char seq2[]);
void reset();
void randomNumber(int size, char randomString[]);
