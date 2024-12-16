VBGF_GQ <- function(age, age_0, omega, k) {
  (omega / k) * (1 - exp(-k * (age - age_0)))
}
