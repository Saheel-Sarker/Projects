#include "utility.h"

int validate (char sequence[], int length) {
    char test[] = "0123456789"; // Each element for the sequence is check if it's in this string.
    int validElement, i, j; // ValidElement is false (0) initially but if the element that's indexed is in the test case, validElement will become true (1).
    for (i = 0; i < length; i++) {
        validElement = 0;
        for (j = 0; j < 10; j++) {
            if (sequence[i] == test[j]) { // Element is in the test.
                validElement = 1;
            }
        }
        if (validElement == 0) { // If a element isn't in the test then validElement will remain false (0) and be caught here to return false (0) to the main function.
            return 0;
        }
    }
    return 1; // If the loop is able to iterate with no trouble then the sequence must be valid and so it will return true (1).
}

void input(int *seq1Len, int *seq2Len, char seq1[], char seq2[]) {
    while (1) {
        printf("To compute an LCS,\nenter the first sequence: ");
        fgets(seq1, 11110, stdin); // Needed to use fgets to read empty input.
        seq1[strcspn(seq1, "\n")] = 0; // Strips the new line character.
        *seq1Len = strlen(seq1);
        if (validate(seq1, *seq1Len) == 1) { // When validate() returns 1 it means that it's true aka it's a good sequence.
            printf("enter the second sequence: ");
            fgets(seq2, 11110, stdin);
            seq2[strcspn(seq2, "\n")] = 0;
            *seq2Len = strlen(seq2);
            if (validate(seq2, *seq2Len) == 1) {
                break;
            }
        }
        printf("\nError, non-digit character detected!\n\n");
    }
}

void reset() { // Resets all the global values to be reused in other functions
    memset(lcs, 0, sizeof(lcs));
    memset(LcsTable,0,sizeof(LcsTable[0][0]*11110*11110));
    memset(lts, 0, sizeof(lts));
    currentIndex = 0; // Resets the current index in global to recreate the lcs during the loop.
}


void randomNumber(int size, char randomString[]) { //Gets a random number given a certain size.
  srand((unsigned)time(NULL));
  char randomDigit[2];
  int index = 0;
  for(int i = 0; i < size; i++) {
      snprintf(randomDigit, 2,"%d", rand());
      strcpy(randomString+index, randomDigit);
      index++;
  }
}
