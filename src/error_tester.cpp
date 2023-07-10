
#include "cos.h"

#include <math.h>
#include <mpfr.h>
#include <stdio.h>



int main()
{
  double low = 0;
  double high = M_PI/4;
  size_t steps = 16384;
  double step = (high - low) / steps;

  mpfr_t ref, temp;
  mpfr_init2(ref, 106);
  mpfr_init2(temp, 106);

  printf("Input\tAbsoluteError\n");
  for (double x = low; x <= high; x += step) {
    mpfr_set_d(ref, x, MPFR_RNDN);
    mpfr_cos(ref, ref, MPFR_RNDN);

    double y = vdt::fast_cos(x);
    mpfr_d_sub(temp, y, ref, MPFR_RNDN);
    double error = mpfr_get_d(temp, MPFR_RNDN);
    double abs_error = fabs(error);

    printf("%1.16e\t%1.4e\n", x, abs_error);
  }
}
