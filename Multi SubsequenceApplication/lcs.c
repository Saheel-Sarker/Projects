int LcsTable[11110][11110];
int currentIndex;
char lcs[11110];

int makeTable (int seq1Len, int seq2Len, char seq1[], char seq2[]) {
    for(int i = 1; i <= seq1Len; i++) { // For each number up to the length of the 1st sequence.
        for(int j = 1; j <= seq2Len; j++) { // for each number up to the length of the 2nd sequence.
            if(seq1[i - 1] == seq2[j - 1]) { // Index the first and 2nd sequence by the current number - 1 and check if the characters are the same.
                LcsTable[i][j] = LcsTable[i - 1][j - 1] + 1; // Make the current cell equal to the value of the closest top left cell + 1.
            }
            else { // Else make the current cell the largest of closest top or left cell of the current cell. Default we pick the left cell if they're equal.
                LcsTable[i][j] = LcsTable[i][j - 1] >= LcsTable[i - 1][j] ? LcsTable[i][j - 1] : LcsTable[i - 1][j];
            }
        }
    }
    return LcsTable[seq1Len][seq2Len];
}

void findLcs(int seq1Len, int seq2Len, char seq[]) { // This recursion starts from the bottom right of the lcsTable and works it's way towards the top left.
    if(seq1Len == 0 || seq2Len == 0) { // If it's already passed the beggining of a sequence.
        return; // Break the recursion to go back down to collect possible characters of the lcs.
    }
    if(LcsTable[seq1Len][seq2Len - 1] < LcsTable[seq1Len][seq2Len] && LcsTable[seq1Len - 1][seq2Len] < LcsTable[seq1Len][seq2Len]) { // If the closest top cell and left cell have a smaller value than the current cell.
        findLcs(seq1Len - 1, seq2Len - 1, seq); // Go through recursion that makes the current cell the close top left cell of the current cell.
        lcs[currentIndex] = seq[seq1Len - 1]; // Add the character to the lcs since a character for the lcs is found.
        currentIndex++; // Sets up the next index of the lcs to put the next possible characters of the lcs into.
    }
    else if(LcsTable[seq1Len][seq2Len - 1] == LcsTable[seq1Len][seq2Len]) { // The next priority is if the value of closest left cell is equal to the current cell.
        findLcs(seq1Len, seq2Len - 1, seq); // make the current cell the closest left cell.
    }
    else {
        findLcs(seq1Len - 1, seq2Len, seq); // If the current cell be the closest top left cell or left cell, then it must be the top cell.
    }
}
