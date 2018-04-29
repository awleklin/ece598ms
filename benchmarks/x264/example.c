/*****************************************************************************
 * example.c: libx264 API usage example
 *****************************************************************************
 * Copyright (C) 2014-2018 x264 project
 *
 * Authors: Anton Mitrofanov <BugMaster@narod.ru>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02111, USA.
 *
 * This program is also available under a commercial proprietary license.
 * For more information, contact us at licensing@x264.com.
 *****************************************************************************/

#ifdef _WIN32
#include <io.h>       /* _setmode() */
#include <fcntl.h>    /* _O_BINARY */
#endif

#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <x264.h>

#define FAIL_IF_ERROR( cond, ... )\
do\
{\
    if( cond )\
    {\
        fprintf( stderr, __VA_ARGS__ );\
        goto fail;\
    }\
} while( 0 )

#define DEBUG 0

int main( int argc, char **argv )
{
    int width = 1280;
    int height = 720;
    x264_param_t param;
    x264_picture_t pic;
    x264_picture_t pic_out;
    x264_t *h;
    int i_frame = 0;
    int i_frame_size;
    x264_nal_t *nal;
    int i_nal;
    int seconds;

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


#ifdef _WIN32
    _setmode( _fileno( stdin ),  _O_BINARY );
    _setmode( _fileno( stdout ), _O_BINARY );
    _setmode( _fileno( stderr ), _O_BINARY );
#endif

    //FAIL_IF_ERROR( !(argc > 1), "Example usage: example 352x288 <input.yuv >output.h264\n" );
    //FAIL_IF_ERROR( 2 != sscanf( argv[1], "%dx%d", &width, &height ), "resolution not specified or incorrect\n" );
    
    // Create a temporary file to write the output to
    FILE* fout = tmpfile();
    if(fout == NULL){
        printf("File creation error!\n");
        return -1;
    }

    #if DEBUG==1
    printf("File creation successful!\n");
    #endif

    /* Get default params for preset/tuning */
    if( x264_param_default_preset( &param, "medium", NULL ) < 0 )
        goto fail;

    /* Configure non-default params */
    param.i_bitdepth = 8;
    param.i_csp = X264_CSP_I420;
    param.i_width  = width;
    param.i_height = height;
    param.b_vfr_input = 0;
    param.b_repeat_headers = 1;
    param.b_annexb = 1;

    #if DEBUG==1
    printf("Param configuration successful!\n");
    #endif

    /* Apply profile restrictions. */
    if( x264_param_apply_profile( &param, "high" ) < 0 )
        goto fail;

    if( x264_picture_alloc( &pic, param.i_csp, param.i_width, param.i_height ) < 0 )
        goto fail;
#undef fail
#define fail fail2

    h = x264_encoder_open( &param );
    if( !h )
        goto fail;
#undef fail
#define fail fail3

    #if DEBUG==1
    printf("Picture and encoder allocation successful!\n");
    #endif

    int luma_size = width * height;
    int chroma_size = luma_size / 4;
    
    int frame_count = 0;
    int trigger = 40; // Every 40 ms
    
    // Benchmark loop to cover
    #if DEBUG==1
    printf("Beginning encoding!\n");
    #endif
    
    /* Encode frames */
    for( ;; i_frame++ )
    {
        /* Read input frame */
        /*if( fread( pic.img.plane[0], 1, luma_size, stdin ) != luma_size )
            break;
        if( fread( pic.img.plane[1], 1, chroma_size, stdin ) != chroma_size )
            break;
        if( fread( pic.img.plane[2], 1, chroma_size, stdin ) != chroma_size )
            break;*/
        
        // Start timing
        int msec = 0;
        clock_t start = clock();

        // Fill buffers with "sensor data"
        for(int j=0; j<luma_size; j++){
            pic.img.plane[0][j] = (uint8_t)rand();
        }
        for(int j=0; j<chroma_size; j++){
            pic.img.plane[1][j] = (uint8_t)rand();
            pic.img.plane[2][j] = (uint8_t)rand();
        }       

        pic.i_pts = i_frame;
        i_frame_size = x264_encoder_encode( h, &nal, &i_nal, &pic, &pic_out );
        if( i_frame_size < 0 )
            goto fail;
        else if( i_frame_size )
        {
            if( !fwrite( nal->p_payload, i_frame_size, 1, fout ) )
                goto fail;
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
    /* Flush delayed frames */
    while( x264_encoder_delayed_frames( h ) )
    {
        i_frame_size = x264_encoder_encode( h, &nal, &i_nal, NULL, &pic_out );
        if( i_frame_size < 0 )
            goto fail;
        else if( i_frame_size )
        {
            if( !fwrite( nal->p_payload, i_frame_size, 1, fout ) )
                goto fail;
        }
    }

    x264_encoder_close( h );
    x264_picture_clean( &pic );
    // Don't forget to close the temporary file!
    fclose(fout);
    return 0;

#undef fail
fail3:
    if(fout!=NULL)
        fclose(fout);
    x264_encoder_close( h );
fail2:
    if(fout!=NULL)
        fclose(fout);
    x264_picture_clean( &pic );
fail:
    if(fout!=NULL)
        fclose(fout);
    return -1;
}
