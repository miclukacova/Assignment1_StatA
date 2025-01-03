// /////////////////
// Statistics A 2024/25
// January 2025
// Assignment 2
// Helle Sorensen
// /////////////////

data {
  int<lower=0> noObs;  // number of obs 
  int<lower=0> p;      // number of predictors
  int<lower=0> noSubj; // number of subjects 
  vector<lower=0>[noObs] y; // response, i.e. untransformed average bloodvolume
  matrix[noObs, p] X; // Model matrix for fixed effects
  matrix[noObs, noSubj] Z; // Model matrix for random effects
}

parameters {
  vector[p] beta;
  real<lower=0> shapeF;
  real<lower=0> shapeG;
  vector<lower=0>[noSubj] F;          
}

transformed parameters {
  vector[noSubj] U;
  U = log10(F);
}

model {
  beta ~ normal(0,10);
  shapeF ~ gamma(1,1);
  shapeG ~ gamma(1,1);
  F ~ gamma(shapeF, shapeF); 
  y ~ gamma(shapeG, shapeG/pow(10,X*beta+Z*U));
}











