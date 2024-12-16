nls_out <- function(nls_obj, model = "VBGF") {
  if (model == "VBGF") {
    if (is.null(nls_obj)) {
      k <- NA
      k_se <- NA
      linf <- NA
      linf_se <- NA
    } else {
      if (class(nls_obj) != "try-error") {
        k <- summary(nls_obj)$coefficients[2, 1]
        k_se <- summary(nls_obj)$coefficients[2, 2]
        linf <- summary(nls_obj)$coefficients[1, 1]
        linf_se <- summary(nls_obj)$coefficients[1, 2]
      } else {
        k <- NA
        k_se <- NA
        linf <- NA
        linf_se <- NA
      }
    }
    return(data.frame(k, k_se, linf, linf_se))
  } else if (model == "VBGF_GQ") {
    if (is.null(nls_obj)) {
      k <- NA
      k_se <- NA
      omega <- NA
      omega_se <- NA
      age0 <- NA
      age0_se <- NA
    } else {
      if (class(nls_obj) != "try-error") {
        k <- summary(nls_obj)$coefficients[1, 1]
        k_se <- summary(nls_obj)$coefficients[1, 2]
        omega <- summary(nls_obj)$coefficients[2, 1]
        omega_se <- summary(nls_obj)$coefficients[2, 2]
        age0 <- summary(nls_obj)$coefficients[3, 1]
        age0_se <- summary(nls_obj)$coefficients[3, 2]
      } else {
        k <- NA
        k_se <- NA
        omega <- NA
        omega_se <- NA
        age0 <- NA
        age0_se <- NA
      }
    }
    return(data.frame(k, k_se, omega, omega_se, age0, age0_se))
  }
}
