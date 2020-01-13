#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <conio.h>

#define N 10000

int validate (char sequence[], int length); // Validates the users inputs.
void findLcs(int seq1Len, int seq2Len, char seq1[]); // Finds the Longest Common sequence
void captialize (char sequence[]);

// All these variables have to be global in order to use recursion effectively to get the Longest common sequence in the findLcs function.
int currentIndex; // This basically indexes Lcs to put in characters of the lcs one after another.
int LcsTable[N][N]; // This is a 2d array that's completed using the reference algorithm to find the lcs. Initialized this 2d array to zero.
char lcs[N]; // This is a string that we put each character of the longest common sequence into and then get the size of and print.

int main() {
    char seq1[N], seq2[N]; // seq1 and se2 are the 1st and 2nd sequence that's to be inputed into.
    int seq1Len, seq2Len, lcsLen, i, j; // seq1Len and seq2Len are the lengths of the 1st and 2nd sequence while lcsLen is the length of the lcs. i and j are counters for the for loop.
    while (1) {
        printf("To find the longest shared DNA or RNA sequence,\nenter the first genetic sequence: ");
        fgets(seq1, N, stdin); // Needed to use fgets to read empty input.
        seq1[strcspn(seq1, "\n")] = 0; // Strips the new line character.
        captialize(seq1);
        seq1Len = strlen(seq1);
        if (validate(seq1, seq1Len) == 1) { // When validate() returns 1 it means that it's true aka it's a good sequence.
            printf("enter the second genetic sequence: ");
            fgets(seq2, N, stdin);
            seq2[strcspn(seq2, "\n")] = 0;
            captialize(seq2);
            seq2Len = strlen(seq2);
            if (validate(seq2, seq2Len) == 1) {
                break;
            }
        }
        printf("\nError, invalid character detected. Please enter a proper sequence\n\n");
    }
    printf("\nThe two entered genetic sequences (with lengths %d and %d respectively) are:\n%s\n%s\n\n", seq1Len, seq2Len, seq1, seq2);
    for(i = 1; i <= seq1Len; i++) { // for each number up to the length of the 1st sequence.
        for(j = 1; j <= seq2Len; j++) { // for each number up to the length of the 2nd sequence.
            if(seq1[i - 1] == seq2[j - 1]) { // Index the first and 2nd sequence by the current number - 1 and check if the characters are the same.
                LcsTable[i][j] = LcsTable[i - 1][j - 1] + 1; // Make the current cell equal to the value of the closest top left cell + 1.
            }
            else { // Else make the current cell the largest of closest top or left cell of the current cell. Default we pick the left cell if they're equal.
                LcsTable[i][j] = LcsTable[i][j - 1] >= LcsTable[i - 1][j] ? LcsTable[i][j - 1] : LcsTable[i - 1][j];
            }
        }
    }
    findLcs(seq1Len, seq2Len, seq1);
    lcsLen = strlen(lcs);
    printf("The longest shared genetic sequence (with length %d) is:\n%s\n", lcsLen, lcs);
    printf("Press any key to close.\n");
    getch();
    return 0;
}

int validate (char sequence[], int length) {
    char test[] = "ACTGU"; // Each element for the sequence is check if it's in this string.
    int validElement, i, j; // validElement is false (0) initially but if the element that's indexed is in the test case, validElement will become true (1).
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

void captialize (char sequence[]) {
    char *ptr = sequence;
    while (*ptr != '\0') {
        *ptr = toupper(*ptr);
        ptr++;
    }
}

void findLcs(int seq1Len, int seq2Len, char seq1[]) { // This recursion starts from the bottom right of the lcsTable and works it's way towards the top left.
    if(seq1Len == 0 || seq2Len == 0) { // If it's already passed the beggining of a sequence
        return; // Break the recursion to go back down to collect possible characters of the lcs.
    }
    if(LcsTable[seq1Len][seq2Len - 1] < LcsTable[seq1Len][seq2Len] && LcsTable[seq1Len - 1][seq2Len] < LcsTable[seq1Len][seq2Len]) { // If the closest top cell and left cell have a smaller value than the current cell.
        findLcs(seq1Len - 1, seq2Len - 1, seq1); // Go through recursion that makes the current cell the close top left cell of the current cell.
        lcs[currentIndex] = seq1[seq1Len - 1]; // Add the character to the lcs since a character for the lcs is found.
        currentIndex++; // Sets up the next index of the lcs to put the next possible characters of the lcs into.
    }
    else if(LcsTable[seq1Len][seq2Len - 1] == LcsTable[seq1Len][seq2Len]) { // The next priority is if the value of closest left cell is equal to the current cell.
        findLcs(seq1Len, seq2Len - 1, seq1); // make the current cell the closest left cell.
    }
    else {
        findLcs(seq1Len - 1, seq2Len, seq1); // If the current cell be the closest top left cell or left cell, then it must be the top cell.
    }
}
