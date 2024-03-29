#include "main.h"

int main(int numOfArgs, char *args[]) {
    char invalidFlagSentence[] = "-g: to generate an instance consisting of two over the digit alphabet\n-c: to compute an LCS for the two input \n-t: to compute an LTS for the input sequence\n-p: to compute an LPS for the input sequence\n-ct: to compute an LCTS for the two input \n-cp: to compute an LCPS for the two input \n-i inputfilename: to read in sequence(s) from file \"inputfilename\"\n-o outputfilename: to write all the results into the file \"outputfilename\"\n";
    if (numOfArgs < 2) { //Checks if the number if arguments is valid
        printf("%s", invalidFlagSentence);
        return 0;
    }
    else if (numOfArgs > 10 ) {
        printf("%s", invalidFlagSentence);
        return 0;
    }
    int options[10] = {0};
    int oIndex;
    int iIndex;
    for (int i = 1; i < numOfArgs; i++) { //Stores any of the valid options given and gives an error message if there's a invalid message
        if(strcmp(args[i],"-g")==0) options[1] = 1;
        else if(strcmp(args[i],"-c")==0) options[2] = 1;
        else if(strcmp(args[i],"-ct")==0) options[3] = 1;
        else if(strcmp(args[i],"-cp")==0) options[4] = 1;
        else if(strcmp(args[i],"-t")==0) options[5] = 1;
        else if(strcmp(args[i],"-p")==0) options[6] = 1;
        else if(strcmp(args[i],"-i") == 0 && numOfArgs >= i + 2 && strcmp(args[i+1]," ") != 0)  {
            iIndex = i + 1;
            options[7] = 1;
        }
        else if(strcmp(args[i],"-o") == 0 && numOfArgs >= i + 2 && strcmp(args[i+1]," ") != 0) {
            oIndex = i + 1;
            options[9] = 1;
        }
        else if(options[7] != 1 && options[9] != 1) {
            printf("%s", invalidFlagSentence);
            return 0;
        }
    }
    int valid = 0;
    for (int i = 1; i < 7; i++) { //Checks if any of -g, -c, -ct, -cp, -t, -p were given otherwise there should be an error
        if (options[i] == 1) valid = 1;
    }
    if (valid == 0) {
        printf("%s", invalidFlagSentence);
        return 0;
    }
    FILE *fileHandler;
    if (options[1] == 1) { //when -g is given
        for (int i = 2; i < 8; i++) { //Checks if -c, -ct, -cp, -t, -p weren't given otherewise there should be a error
            if (options[i] == 1) {
                printf("%s", invalidFlagSentence);
                return 0;
            }
        }
        //this part does all the random number handling and printing.
        char random1[11110], random2[11110];
        int ranSize1, ranSize2;
        printf("Enter the lengths of the two : ");
        scanf("%d %d", &ranSize1, &ranSize2);
        randomNumber(ranSize1, random1); //gets a random number
        for (int i = 0; i < 1000000; i++) randomNumber(ranSize2, random2); //also gets a random number but time manipulation is needed by increasing time complexity to get different randome number
        printf("%s\n%s\n", random1, random2);
        if (options[9] == 1) { //does the -o function if they put it
            fileHandler = fopen(args[oIndex],"w");
            fprintf(fileHandler,"%s\n%s\n", random1, random2);
            fclose(fileHandler);
            return 0;
        }
        return 0;
    }
    char seq1[11110], seq2[11110];
    int seq1Len, seq2Len;
    if (options[7] == 1) { //if they gave -i
        if ((fileHandler = fopen(args[iIndex],"r")) == NULL) { //checks if the input file exists and gives an error if it doesn't
            printf("%s", invalidFlagSentence);
            return 0;
        }
        //Just does all the handling to get the values from the input
        fgets(seq1, 11110, fileHandler);
        fgets(seq2, 11110, fileHandler);
        fclose(fileHandler);
        seq1[strcspn(seq1, "\n")] = 0;
        seq2[strcspn(seq2, "\n")] = 0;
        seq1Len = strlen(seq1);
        seq2Len = strlen(seq2);
        if (validate(seq1, seq1Len) == 0 && validate(seq2, seq2Len) == 0) { //checks if the contents of input files is valid and gives an error if it's not
            printf("%s", invalidFlagSentence);
            return 0;
        }
    }
    else {
        input(&seq1Len, &seq2Len, seq1, seq2); //If -i isn't given, then we just get the input from the user
    }
    if (options[9] == 1) { //prints on to a output file if -o is given
        fileHandler = fopen(args[oIndex],"w");
    }
    for (int i = 2; i < 7; i++) {
        if (options[i] == 1) {
            //Just handles all the creating the sequences and printing them on to stdout or the outputfile.
            if (i == 2) { //when -c is given
                makeTable(seq1Len, seq2Len, seq1, seq2);
                findLcs(seq1Len, seq2Len, seq1);
                printf("an LCS (length = %ld) for the two sequences is:\n%s\n", strlen(lcs), lcs);
                if (options[9] == 1) {
                    fprintf(fileHandler,"an LCS (length = %ld) for the two sequences is:\n%s\n", strlen(lcs), lcs);
                }
            }
            else if (i == 3) { //when -ct is given
                findLcts(seq1Len, seq2Len, seq1, seq2);
                printf("an LCTS (length = %ld) for the two sequences is:\n%s\n", strlen(lts), lts);
                if (options[9] == 1) {
                     fprintf(fileHandler,"an LCTS (length = %ld) for the two sequences is:\n%s\n", strlen(lts), lts);
                }
            }
            else if (i == 4) { //when -cp is given
                findLcps(seq1Len, seq2Len, seq1, seq2);
                printf("an LCPS (length = %ld) for the two sequences is:\n%s\n", strlen(lcs), lcs);
                if (options[9] == 1) {
                    fprintf(fileHandler,"an LCPS (length = %ld) for the two sequences is:\n%s\n", strlen(lcs), lcs);
                }
            }
            else if (i == 5) { //when -t is given
                findLts(seq1Len, seq1);
                printf("an LTS (length = %ld) for the sequence is:\n%s\n", strlen(lts), lts);
                if (options[9] == 1) {
                    fprintf(fileHandler,"an LTS (length = %ld) for the sequence is:\n%s\n", strlen(lts), lts);
                }
            }
            else if (i == 6) { //when -p is given
                findLps(seq2Len, seq2);
                printf("an LPS (length = %ld) for the sequence is:\n%s\n", strlen(lcs), lcs);
                if (options[9] == 1) {
                    fprintf(fileHandler,"an LPS (length = %ld) for the sequence is:\n%s\n", strlen(lcs), lcs);
                }
            }
            reset();
        }
    }
    if (options[9] == 1) fclose(fileHandler);
}
