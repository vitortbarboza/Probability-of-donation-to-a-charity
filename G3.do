do "C:\Users\Augusto\Desktop\T3.do"
do "C:\Users\Augusto\AppData\Local\Temp\STD00000000.tmp"
quietly reg respond resplast weekslast propresp mailsyear, vce (rob)
margins, dydx (resplast weekslast propresp mailsyear)
estimates store _est_APE_OLS
estimates table _est__est_APE_OLS _est_APE_LOGIT _est_APE_PROBIT
estimates table _est__est_APE_OLS _est_APE_LOGIT _est_APE_PROBIT, star (0.1 0.05 0.01)
scatter y_hat_probit ind_probit
graph export Plogit.png, replace
scalar pseudoR2probit = e(r2_p)
quietly correlate y_hat_probit respond
scalar R2probit = r (rho)^2
scalar R2probit = r(rho)^2
scalar list R2probit pseudoR2probit
quietly reg respond resplast weekslast propresp mailsyear, vce (rob)
margins, dydx (resplast weekslast propresp mailsyear) post
quietly reg respond i.resplast weekslast propresp mailsyear, vce (rob)
margins, dydx (resplast weekslast propresp mailsyear) post
quietly probit respond i.resplast weekslast propresp mailsyear, vce (rob)
margins, dydx (i.resplast weekslast propresp mailsyear) post
estimates table _est_APE_PROBIT
estimates table APE_PROBIT
quietly reg respond i.resplast weekslast propresp mailsyear, vce (rob)
margins, dydx (i.resplast weekslast propresp mailsyear) atmeans post
estimates store OLSPEA
quietly probit respond i.resplast weekslast propresp mailsyear, vce (rob)
margins, dydx (i.resplast weekslast propresp mailsyear) atmeans post
estimates store PROBITPEA
quietly logit respond i.resplast weekslast propresp mailsyear, vce (rob)
margins, dydx (i.resplast weekslast propresp mailsyear) atmeans post
estimates store LOGITPEA
estimates table PROBITPEA LOGITPEA OLSPEA, star(0.1 0.05 0.01)
ivregress 2sls respond (resplast=generous) weekslast propresp mailsyear, vce (rob)
estimates store IVOLS
ivprobit respond (resplast=generous) weekslast propresp mailsyear
ivlogit respond (resplast=generous) weekslast propresp mailsyear, vce (rob)

** Logit

quietly logit respond resplast weekslast propresp mailsyear
estimates store beta_logit


**Avaliação da qualidade do ajustamento
*Probabilidade estimada
predict y_hat_logit, p
sum y_hat_logit

*index estimado

predict ind_logit, xb

*R2
scalar pseudo_R2_logit = e(r2_p)
quietly correlate y_hat_logit respond
scalar R2_logit=r(rho)^2
scalar list R2_logit pseudo_R2_logit

*Capacidade preditiva
estat classification
scalar perc_correct_logit = r(P_corr)


*Probit

probit respond resplast weekslast propresp mailsyear
estimates store beta_probit

*Avaliação da qualudade do ajustamento

sum y_hat_probit y_hat_logit

*R2
scalar pseudo_R2_probit = e(r2_p)
quietly correlate y_hat_probit respond
scalar R2_probit=r(rho)^2
scalar list R2_probit pseudo_R2_probit R2_logit pseudo_R2_logit

*Capacidade preditiva
estat classification
scalar perc_correct_probit = r(P_corr)

scalar list perc_correct_logit perc_correct_probit

*Comparação dos coeficientes estimados
estimates table beta_OLS beta_logit beta_probit, star(0.1 0.05 0.01)



estimates store APE_OLS
sum _est_APE_OLS
do "C:\Users\vitor\AppData\Local\Temp\STD00000000.tmp"
estimates store APE_OLS

quietly logit respond resplast weekslast propresp mailsyear
margins, dydx(*) post

quietly logit respond i.resplast weekslast propresp mailsyear
logit respond i.resplast weekslast propresp mailsyear
margins, dydx(*) post
estimates store APE_logit
quietly logit respond i.resplast weekslast propresp mailsyear
quietly probit respond i.resplast weekslast propresp mailsyear
margins, dydx(*) post
estimates store APE_probit
estimates table bela_OLS APE_OLS APE_logit APE_probit, star(.1, 0.05, 0.01)
reg respond resplast weekslast propresp mailsyear, vce (rob)
estimates store beta_ols
estimates table APE_OLS APE_logit APE_probit
save "C:\Users\vitor\Documents\Mestrado Econometria\2º Semestre\Microeconometria I\Trabalho 3\Micro.dta", replace



