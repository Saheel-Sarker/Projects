extern int LcsTable[11110][11110];
extern int currentIndex;
extern char lcs[11110];

int makeTable (int seq1Len, int seq2Len, char seq1[], char seq2[]);
void findLcs(int seq1Len, int seq2Len, char seq[]);
