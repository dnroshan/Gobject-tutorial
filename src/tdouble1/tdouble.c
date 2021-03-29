#include "tdouble.h"

struct _TDouble {
  GObject parent;
  double value;
};

G_DEFINE_TYPE (TDouble, t_double, G_TYPE_OBJECT)

static void
t_double_class_init (TDoubleClass *class) {
}

static void
t_double_init (TDouble *d) {
}

gboolean
t_double_get_value (TDouble *d, double *value) {
  g_return_val_if_fail (T_IS_DOUBLE (d), FALSE);

  *value = d->value;
  return TRUE;
}

void
t_double_set_value (TDouble *d, double value) {
  g_return_if_fail (T_IS_DOUBLE (d));

  d->value = value;
}

TDouble *
t_double_new (double value) {
  TDouble *d;

  d = g_object_new (T_TYPE_DOUBLE, NULL);
  d->value = value;
  return d;
}

