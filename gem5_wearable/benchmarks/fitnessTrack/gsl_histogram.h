/* histogram/gsl_histogram.h
 * 
 * Copyright (C) 1996, 1997, 1998, 1999, 2000, 2007 Brian Gough
 * 
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 3 of the License, or (at
 * your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
 */

#ifndef __GSL_HISTOGRAM_H__
#define __GSL_HISTOGRAM_H__

#include <stdlib.h>
#include <stdio.h>

#undef __BEGIN_DECLS
#undef __END_DECLS
#ifdef __cplusplus
# define __BEGIN_DECLS extern "C" {
# define __END_DECLS }
#else
# define __BEGIN_DECLS /* empty */
# define __END_DECLS /* empty */
#endif

__BEGIN_DECLS

typedef struct {
  size_t n ;
  double * range ;
  double * bin ;
} gsl_histogram ;

typedef struct {
  size_t n ;
  double * range ;
  double * sum ;
} gsl_histogram_pdf ;

gsl_histogram * gsl_histogram_alloc (size_t n);

void gsl_histogram_free (gsl_histogram * h);
int gsl_histogram_increment (gsl_histogram * h, double x);
int gsl_histogram_set_ranges_uniform (gsl_histogram * h, double xmin, double xmax);
int gsl_histogram_accumulate (gsl_histogram * h, double x, double weight);


int gsl_histogram_fprintf (FILE * stream, const gsl_histogram * h, 
                           const char * range_format, const char * bin_format);


__END_DECLS

#endif /* __GSL_HISTOGRAM_H__ */
