#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define DEBUG 0

typedef struct pixel_struct
{
    unsigned char red;
    unsigned char green;
    unsigned char blue;
} pixel;

int main(int argc, char **argv)
{
    int width = 1280;
    int height = 720;
    int seconds;
    pixel* image;

    // Parse the arguments for the runtime
    if(!argv[1]){
        // Default to 5 seconds
        printf("No time was specified. Defaulting to 5s!\n");
        seconds = 5;
    }
    else{
        // This unfortunate structure avoids a segfault
        if(sscanf(argv[1], "%d", &seconds) != 1){
            // Default to 5 seconds if no argument specified
            #if DEBUG==1
            printf("No time was specified. Defaulting to 5s!\n");
            #endif
            seconds = 5;
        }
        printf("Running for %ds!\n", seconds);
    }

    FILE* fout = tmpfile();
    if(fout == NULL){
        printf("File creation error!\n");
        return -1;
    }
    #if DEBUG==1
    printf("File creation successful!\n");
    #endif

    // Allocate a frame buffer
    image = malloc(width*height*sizeof(pixel));
    if(image==NULL){
        #if DEBUG==1
        printf("Memory allocation failed!\n");
        #endif
        return -1;
    }   

    int frame_count = 0;
    int trigger = 40; // Every 40 ms

    while(1){
        // Start timing
        int msec = 0;
        clock_t start = clock();

        // Fill frame with random data
        for(int i=0; i<width; i++){
            for(int j=0; j<height; j++){
                image[i+j*width].red = (unsigned char)rand();
                image[i+j*width].green = (unsigned char)rand();
                image[i+j*width].blue = (unsigned char)rand();
            }
        }

        // Write the frame data to storage
        if(fwrite((const void*)image, 3, width*height, fout) != width*height){
            #if DEBUG==1
            printf("File write operation failed!\n");
            #endif
            fclose(fout);
            return -1;
        }        

        frame_count++;
        // Check if we've processed 2 seconds yet @25 FPS
        #if DEBUG==1
        printf("Frames processed = %d\n",frame_count);
        #endif
        if(frame_count >= 25*seconds)
            break;

        // Read the clock and wait if necessary
        while(msec < trigger){
            clock_t difference = clock() - start;
            msec = difference * 1000 / CLOCKS_PER_SEC;
        }
    }
    
    fclose(fout);
    return 0;
}
