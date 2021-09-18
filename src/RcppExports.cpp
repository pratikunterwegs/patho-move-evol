// Generated by using Rcpp::compileAttributes() -> do not edit by hand
// Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#include <Rcpp.h>

using namespace Rcpp;

// get_test_landscape
Rcpp::DataFrame get_test_landscape(const int nItems, const float landsize, const int nClusters, const float clusterSpread);
RcppExport SEXP _snevo_get_test_landscape(SEXP nItemsSEXP, SEXP landsizeSEXP, SEXP nClustersSEXP, SEXP clusterSpreadSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< const int >::type nItems(nItemsSEXP);
    Rcpp::traits::input_parameter< const float >::type landsize(landsizeSEXP);
    Rcpp::traits::input_parameter< const int >::type nClusters(nClustersSEXP);
    Rcpp::traits::input_parameter< const float >::type clusterSpread(clusterSpreadSEXP);
    rcpp_result_gen = Rcpp::wrap(get_test_landscape(nItems, landsize, nClusters, clusterSpread));
    return rcpp_result_gen;
END_RCPP
}
// run_pathomove
Rcpp::List run_pathomove(const int scenario, const int popsize, const int nItems, const float landsize, const int nClusters, const float clusterSpread, const int tmax, const int genmax, const float range_food, const float range_agents, const int handling_time, const int regen_time, float pTransmit, const int nInfected, const float costInfect);
RcppExport SEXP _snevo_run_pathomove(SEXP scenarioSEXP, SEXP popsizeSEXP, SEXP nItemsSEXP, SEXP landsizeSEXP, SEXP nClustersSEXP, SEXP clusterSpreadSEXP, SEXP tmaxSEXP, SEXP genmaxSEXP, SEXP range_foodSEXP, SEXP range_agentsSEXP, SEXP handling_timeSEXP, SEXP regen_timeSEXP, SEXP pTransmitSEXP, SEXP nInfectedSEXP, SEXP costInfectSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< const int >::type scenario(scenarioSEXP);
    Rcpp::traits::input_parameter< const int >::type popsize(popsizeSEXP);
    Rcpp::traits::input_parameter< const int >::type nItems(nItemsSEXP);
    Rcpp::traits::input_parameter< const float >::type landsize(landsizeSEXP);
    Rcpp::traits::input_parameter< const int >::type nClusters(nClustersSEXP);
    Rcpp::traits::input_parameter< const float >::type clusterSpread(clusterSpreadSEXP);
    Rcpp::traits::input_parameter< const int >::type tmax(tmaxSEXP);
    Rcpp::traits::input_parameter< const int >::type genmax(genmaxSEXP);
    Rcpp::traits::input_parameter< const float >::type range_food(range_foodSEXP);
    Rcpp::traits::input_parameter< const float >::type range_agents(range_agentsSEXP);
    Rcpp::traits::input_parameter< const int >::type handling_time(handling_timeSEXP);
    Rcpp::traits::input_parameter< const int >::type regen_time(regen_timeSEXP);
    Rcpp::traits::input_parameter< float >::type pTransmit(pTransmitSEXP);
    Rcpp::traits::input_parameter< const int >::type nInfected(nInfectedSEXP);
    Rcpp::traits::input_parameter< const float >::type costInfect(costInfectSEXP);
    rcpp_result_gen = Rcpp::wrap(run_pathomove(scenario, popsize, nItems, landsize, nClusters, clusterSpread, tmax, genmax, range_food, range_agents, handling_time, regen_time, pTransmit, nInfected, costInfect));
    return rcpp_result_gen;
END_RCPP
}

RcppExport SEXP run_testthat_tests(SEXP);

static const R_CallMethodDef CallEntries[] = {
    {"_snevo_get_test_landscape", (DL_FUNC) &_snevo_get_test_landscape, 4},
    {"_snevo_run_pathomove", (DL_FUNC) &_snevo_run_pathomove, 15},
    {"run_testthat_tests", (DL_FUNC) &run_testthat_tests, 1},
    {NULL, NULL, 0}
};

RcppExport void R_init_snevo(DllInfo *dll) {
    R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
}
