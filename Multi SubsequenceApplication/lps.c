#include "lps.h"
#include "lcs.h"
#include "utility.h"

void findLps (int length, char seq[]) {
    char backwards[11110];
    for (int i = length; i >= 0; i--) { // Get a version of the sequence that's backwards and stores it in a array.
        backwards[length - i] = seq[i - 1];
    }
    int lpsLen = makeTable(length, length, backwards, seq); // Makes the table like for all my lcs'.
    findLcs(length, length, backwards); // Create the actualy lcs.
}


void findLcps(int seq1Len, int seq2Len, char seq1[], char seq2[]) { //Find the largest palindrome out of all lcs's
    char tempString[11110];
    int length = makeTable(seq1Len, seq2Len, seq1, seq2);
    findLcs(seq1Len, seq2Len, seq1);
    strcpy(tempString, lcs);
    reset();
    findLps (length, tempString);
}