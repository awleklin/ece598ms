#include "stdio.h"
#include "unistd.h"
#include "time.h"
#include "gsl/histogram/gsl_histogram.h"
#define minBPM 0
#define maxBPM 220
#define binsBPM 220
#define maxBeatOffset 100
#define sampleFreq 100
#define intervalBPM 60
#define runTime 120
#define trigger 1000

int main()
{
    volatile int x,second;
    float bpm[runTime-intervalBPM] = {0};
    int beats[runTime*sampleFreq];
    FILE* fout = tmpfile();
   
    // Loop through seconds for given run time
    for(second=0;second<runTime;second++){
    
        // Start timing
        int msec = 0;
        clock_t start = clock();
        
        gsl_histogram * h = gsl_histogram_alloc (binsBPM);
        gsl_histogram_set_ranges_uniform (h, minBPM, maxBPM);
        // Randomly generates a 1 at ~60 1's/minute
        for(x=0;x<sampleFreq;x++){
            if((rand()%sampleFreq)>(sampleFreq-2))
                beats[second*sampleFreq+x] = 1;
            else
                beats[second*sampleFreq+x] = 0;
        }
        
        // Begin calculating BPM
        if(second>=intervalBPM){
            for(x=0;x<(intervalBPM*sampleFreq);x++){
                bpm[second-intervalBPM] +=  (float)beats[second*sampleFreq-x];
            }
            bpm[second-intervalBPM] *= (60/(float)intervalBPM);
            // Populates the histogram structure
            for(x=0;x<(second-intervalBPM);x++){
                gsl_histogram_increment (h, bpm[x]);
            }    
        }
        
        if(second==(runTime-1)){
            // Prints the histogram
            gsl_histogram_fprintf (fout, h, "%g", "%g");
        }
        gsl_histogram_free (h);
        
        // Read the clock and wait if necessary
        while(msec < trigger){
            clock_t difference = clock() - start;
            msec = difference * 1000 / CLOCKS_PER_SEC;
       }
    }
    fclose(fout);
    return 0;
}
