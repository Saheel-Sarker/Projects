#include "lcs.h"
#include "lts.h"
#include "utility.h"

char lts[11110];

void findLts (int length, char seq[]) {
    /* Basically this function just picks a spot in the sequence to split into to part (first half, second half)
    and checks the length of the lcs of the 2 parts. The loop will decrement the spot starting from the right and keep splitting
    and checking the lcs and as a lcs lenght is found that is greater than the last, it will make the actual lcs and concatinate it
    with it's self in the lts variable as a string as if a lcs is found that exists in both parts, then the original sequence must
    have the concatination of the lcs with iself as a subsequence. This subsequence will represent the longest tandem subsequence. */
    int max = 0, someLen = 0, ltsLen = 0;
    int firstLen = 0, secondLen = 0;
    char firstHalf[11110], secondHalf[11110];
    for (int i = length; i > 0; i--) { // This picks a spot to split from in the sequence starting from the right.
        for (int j = 0; j < i; j++) { //This make the first half.
            firstHalf[j] = seq[j];
        }
        for (int k = i; k < length; k++){ // This makes the second half.
            secondHalf[k - i] = seq[k];
        }
        firstLen = i;
        secondLen = length - i;
        someLen = makeTable(firstLen, secondLen, firstHalf, secondHalf); // This will create the lcs table and return the size of the lcs and store it in "someLen".
        if (someLen >= max) { // The length of the new lcs will then be compared to the length of the longest subsequence that was found before.
            max = someLen; // If the new lcs is larger then the last, then the new will be assigned as the largest.
            ltsLen = max*2; // Since the lts is the contination of the lcs with itself, then the lts must be twice the size of the lcs.
            findLcs(firstLen, secondLen, firstHalf); // Here it actually finds what the lcs is supposed to be.
            strcpy(lts, lcs); // This simulate the concatination. first the lcs is copied to the lts array.
            strcpy(lts+max, lcs); // This copies the lcs again but starting from the end of the array by adding the size of the lcs to the pointer of the first lts array.
        }
        memset(firstHalf, 0, sizeof(firstHalf)); // All this memset stuff is to clear the values of firsthalf, second half, lcs, lcs table.
        memset(lcs, 0, sizeof(lcs));
        memset(secondHalf, 0, sizeof(secondHalf));
        memset(LcsTable,0,sizeof(LcsTable[0][0]*11110*11110));
        currentIndex = 0; // Resets the current index in global to recreate the lcs during the loop.
    }
}

void findLcts (int seq1Len, int seq2Len, char seq1[], char seq2[]) { //Find the largest tandem sequence out of all lcs's
    char tempString[11110];
    int length = makeTable(seq1Len, seq2Len, seq1, seq2);
    findLcs(seq1Len, seq2Len, seq1);
    strcpy(tempString, lcs);
    reset();
    findLts (length, tempString);
}


