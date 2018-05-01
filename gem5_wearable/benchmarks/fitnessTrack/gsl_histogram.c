#include <stdio.h>
#include "gsl_histogram.h"
#define LINEAR_OPT 1

int
gsl_histogram_fprintf (FILE * stream, const gsl_histogram * h,
                       const char *range_format, const char *bin_format)
{
  size_t i;
  const size_t n = h->n;

  for (i = 0; i < n; i++)
    {
      fprintf (stream, range_format, h->range[i]);

      putc (' ', stream);

      fprintf (stream, range_format, h->range[i + 1]);


      putc (' ', stream);


      fprintf (stream, bin_format, h->bin[i]);


      putc ('\n', stream);

    }

  return 0;
}


gsl_histogram *
gsl_histogram_alloc (size_t n)
{
  gsl_histogram *h;


  h = (gsl_histogram *) malloc (sizeof (gsl_histogram));

  h->range = (double *) malloc ((n + 1) * sizeof (double));

  if (h->range == 0)
    {
      free (h);         /* exception in constructor, avoid memory leak */

    }

  h->bin = (double *) malloc (n * sizeof (double));

  if (h->bin == 0)
    {
      free (h->range);
      free (h);         /* exception in constructor, avoid memory leak */

    }

  h->n = n;

  return h;
}

void
gsl_histogram_free (gsl_histogram * h)
{
  if(h == NULL) return;
  free (h->range);
  free (h->bin);
  free (h);
}


static void
make_uniform (double range[], size_t n, double xmin, double xmax)
{
  size_t i;

  for (i = 0; i <= n; i++)
    {
      double f1 = ((double) (n-i) / (double) n);
      double f2 = ((double) i / (double) n);
      range[i] = f1 * xmin +  f2 * xmax;
    }
}

int 
gsl_histogram_set_ranges_uniform (gsl_histogram * h, double xmin, double xmax)
{
  size_t i;
  const size_t n = h->n;


  /* initialize ranges */

  make_uniform (h->range, n, xmin, xmax);

  /* clear contents */

  for (i = 0; i < n; i++)
    {
      h->bin[i] = 0;
    }

  return 0;
}

int
gsl_histogram_increment (gsl_histogram * h, double x)
{
  int status = gsl_histogram_accumulate (h, x, 1.0);
  return status;
}

static int find (const size_t n, const double range[], 
                 const double x, size_t * i);

static int
find (const size_t n, const double range[], const double x, size_t * i)
{
  size_t i_linear, lower, upper, mid;

  if (x < range[0])
    {
      return -1;
    }

  if (x >= range[n])
    {
      return +1;
    }

  /* optimize for linear case */

#ifdef LINEAR_OPT
  {
    double u =  (x - range[0]) / (range[n] - range[0]);
    i_linear = (size_t) (u * n);
  }

  if (x >= range[i_linear] && x < range[i_linear + 1])
    {
      *i = i_linear;
      return 0;
    }
#endif

  /* perform binary search */

  upper = n ;
  lower = 0 ;

  while (upper - lower > 1)
    {
      mid = (upper + lower) / 2 ;
      
      if (x >= range[mid])
        {
          lower = mid ;
        }
      else
        {
          upper = mid ;
        }
    }

  *i = lower ;

  /* sanity check the result */

  return 0;
}

int
gsl_histogram_accumulate (gsl_histogram * h, double x, double weight)
{

  size_t index = 0;

  find (h->n, h->range, x, &index);


  h->bin[index] += weight;

  return 0;
}
