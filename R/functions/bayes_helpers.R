get_post_draws <- function(model, params){
  
  post_draws <- model %>%
    as_draws_df() %>%
    dplyr::select(all_of(params)) %>% 
    pivot_longer(everything(), names_to = "parameter") %>% 
    # mutate(parameter = str_remove(parameter, "b_"),
    #        parameter = str_remove(parameter, "_Intercept")) %>% 
    mutate(type = "Posterior")
  
  return(post_draws)
  
}


get_prior_draws <- function(model, params){
  
  prior_draws <- model %>%
    as_draws_df() %>%
    dplyr::select(all_of(params)) %>% 
    pivot_longer(everything(), names_to = "parameter") %>% 
    mutate(parameter = str_remove(parameter, "prior_")) %>% 
    mutate(type = "Prior")
  
  return(prior_draws)
  
}

plot_prior_post <- function(dat, column) {
  
  ggplot(dist, aes(value, fill = {{ column }})) +
    geom_density(color = NA, alpha = 0.5) +
    scale_fill_brewer(palette = "Set1") +
    facet_wrap(~parameter, scales = "free") +
    theme(legend.position = c(0.35, 0.9)) +
    labs(fill = "")
  
}




