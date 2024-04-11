fit_nls <- function(length,age,min_nage=3,model="VBGF") { 
  if(length(age)>=min_nage) {
    switch(model,
           Gompertz=try(nls(length~Gompertz(age,Linf,k,lag),start=c(Linf=400,k=0.25,lag=1)),silent=T),
           VBGF=try(nls(length~VBGF(age,Linf,k),start=c(Linf=400,k=0.25)),silent=T),
           VBGF_GQ=try(nls(length~VBGF_GQ(age, age_0, omega, k),start=c(k=0.25,omega=100,age_0=-1)),silent=T),
           stop("Error: '",model,"' model is not available")
           )
  }
}
