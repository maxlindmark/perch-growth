VBGF_MOIIJ <- function(age, age_0, omega, k, Linf) {
  Linf * (1 - exp(-k * (age - age_0)))
}
