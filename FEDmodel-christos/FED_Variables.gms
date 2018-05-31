********************************************************************************
*---------------------Declare variables and equations---------------------------
********************************************************************************

*******************Dispaching existing units************************************
*------------------VKA1 Heatpump related----------------------------------------
positive variable
         H_VKA1(h)         heating power available from VKA1
         C_VKA1(h)         cooling power available from VKA1
         el_VKA1(h)        electricity needed by VKA1
;

*------------------VKA4 Heatpump related----------------------------------------
positive variable
         H_VKA4(h)         heating power available from VKA4
         C_VKA4(h)         cooling power available from VKA4
         el_VKA4(h)        electricity needed by VKA4
;

*------------------Panna1 (if re-dispach is allowed)----------------------------
positive variable
         h_Pana1(h)           heat generated by panna1
         Panna1_cap           capacity of Panna1
;
Panna1_cap.fx=cap_sup_unit('P1');
h_Pana1.up(h)$(P1P2_dispatchable(h)=1)=P1_max;
*h_Pana1.lo(h)=P1_min;

*--------------------For flue gas condencer-------------------------------------
positive variable
         h_RGK1(h)           heat generated by flue gas condencer
;
h_RGK1.up(h)$(P1P2_dispatchable(h)=1)=RGK1_max;
*h_RGK1.lo(h)=RGK1_min;

*------------------AbsC(Absorbtion Chiller) related-----------------------------
positive variable
         h_AbsC(h)           heat demand for Absorbtion Chiller
         c_AbsC(h)           cooling power available in AbsC
         AbsC_cap            capacity of AbsC
;
AbsC_cap.fx = cap_sup_unit('AbsC');

*------------------Refrigerator Machine related---------------------------------
positive variable
         el_RM(h)          electricity demand for refrigerator
         c_RM(h)           cooling power available from the refrigerator
         RM_cap            capacity of refrigerator
;
*this is the aggregated capacity of five exisiting RM Units
RM_cap.fx =cap_sup_unit('RM');

*------------------Ambient Air Cooling Machine related--------------------------
positive variable
         e_AAC(h)           electricity demand for refrigerator
         c_AAC(h)           cooling power available from the refrigerator
         AAC_cap            capacity of refrigerator
;
AAC_cap.fx = cap_sup_unit('AAC');

*----------------existing PV----------------------------------------------------
positive variable
         e_existPV(h)    electricity output of existing PV
;

******************New investments***********************************************
*------------------MC2 Refrigerator Machine related-----------------------------
positive variable
         e_RMMC(h)          electricity demand for refrigerators
         h_RMMC(h)          cooling power available from refrigerators
         c_RMMC(h)          cooling power available from refrigerators
;
binary variable
         RMMC_inv           decision variable for MC2 connection investment
;
RMMC_inv.fx $ (opt_fx_inv eq 1 and opt_fx_inv_RMMC eq 1) = 1;
*----------------Absorption Chiller Investment----------------------------------
positive variable
         h_AbsCInv(h)      heat demand by absorption chiller
         c_AbsCInv(h)      cooling generated by absorption chiller
         AbsCInv_cap       Installed capacity in kW cooling
;
*AbsCInv_cap.up=AbsCInv_MaxCap;
AbsCInv_cap.fx $ (opt_fx_inv eq 1 and opt_fx_inv_AbsCInv eq 1) = opt_fx_inv_AbsCInv_cap;
*----------------Panna 2 related -----------------------------------------------
positive variable
         fuel_P2(h)        fuel demand in P2
         h_P2(h)           generated heating in P2
;
h_P2.up(h)=P2_max;
*h_P2.lo(h)=P2_min;
binary variable
         B_P2              Decision variable for P2 investment
;
B_P2.fx $ (opt_fx_inv eq 1 and opt_fx_inv_P2 eq 1) = 1;

*----------------Refurbished turbine for Panna 2  ------------------------------
positive variable
         e_TURB(h)         electricity generated in turbine-gen
         h_TURB(h)         steam demand in turbine
         H_P2T(h)          steam generated in P2-turb combo
;
binary variable
         B_TURB            Decision variable for turbine investment
;
B_TURB.fx $ (opt_fx_inv eq 1 and opt_fx_inv_TURB eq 1) = 1;

*------------------HP related---------------------------------------------------
positive variable
         h_HP(h)           heating power available in HP
         c_HP(h)           cooling power available from HP
         e_HP(h)           electricity needed by the HP
         HP_cap            capacity of HP
;
HP_cap.fx $ (opt_fx_inv eq 1 and opt_fx_inv_HP eq 1) = opt_fx_inv_HP_cap;

*------------------TES related--------------------------------------------------
positive variable
         TES_ch(h)         input to the TES-chargin the TES
         TES_dis(h)        output from the TES-discharging the TES
         TES_en(h)         energy content of TES at any instant
         TES_cap           capacity of the TES in m3
;
*TES_cap.up=380;
binary variable
         TES_inv          Decision variable for Accumulator investment
;
TES_inv.fx $ (opt_fx_inv eq 1 and opt_fx_inv_TES eq 1) = 1;
TES_cap.fx $ (opt_fx_inv eq 1 and opt_fx_inv_TES eq 1) = opt_fx_inv_TES_cap;
*------------------BITES (Building energy storage) related----------------------
positive variable
         BTES_Sch(h,i)    charing rate of shallow section of the building
         BTES_Sdis(h,i)   dischargin rate of shallow section of the building
         BTES_Sen(h,i)    energy stored in the shallow section of the building
         BTES_Den(h,i)    energy stored in the deep section of the building
         BTES_Sloss(h,i)  heat loss from the shallow section of the building
         BTES_Dloss(h,i)  heat loss from the deep section of the building
;
BTES_Sen.up(h,i)=1000*BTES_model('BTES_Scap',i);
BTES_Den.up(h,i)=1000*BTES_model('BTES_Dcap',i);
variable
         link_BS_BD(h,i)  heat flow between the shallow and the deep section
;
binary variable
         B_BITES(i)       Decision variable weither to invest BITES control sys-
;
*Buildings with no BITES capability
B_BITES.fx(i)=0;
B_BITES.fx(BITES_Inv)=1;

*----------------Building Advanced Control (BAC) related------------------------
positive variable
         h_BAC_savings(h,i) hourly heat consumption savings per building attributable to BAC investment
;

binary variable
         B_BAC(i)   Binary investment decision variable
;
B_BAC.fx(i)=0;
B_BAC.fx(BAC_Inv)=1;

*----------------Solar PV PV relate variables-----------------------------------
positive variable
         e_PV(h)            electricity produced by PV
         PV_cap_roof(BID)   capacity of solar modules on roof
         PV_cap_facade(BID) capacity of solar modules on facade
;

*------------------Battery related----------------------------------------------
positive variables
         BES_en(h)       Energy stored in the battry at time t and building i
         BES_ch(h)       Battery charing at time t and building i
         BES_dis(h)      Battery discharging at time t and building i
         BES_cap         Capacity of the battery at building i
;
BES_cap.fx $ (opt_fx_inv eq 1 and opt_fx_inv_BES eq 1) = 0 * opt_fx_inv_BES_cap;

*------------------Refrigeration machine investment related---------------------
positive variable
         c_RMInv(h)           cooling power available from RMInv
         e_RMInv(h)           electricity needed by the RMInv
         RMInv_cap            capacity of RMInv
;
RMInv_cap.fx $ (opt_fx_inv eq 1 and opt_fx_inv_RMInv eq 1) = opt_fx_inv_RMInv_cap;
*------------------Grid El related----------------------------------------------
positive variable
         e_exp_AH(h)        Exported electricty from the AH system
         e_imp_AH(h)        Imported electricty to the AH system
         e_imp_nonAH(h)     Imported electricty to the AH system
;
e_imp_AH.up(h)=exG_max_cap;
e_exp_AH.up(h)=exG_max_cap;

*------------------Grid DH related----------------------------------------------
positive variable
         h_exp_AH(h)        Exported heat from the AH system
         h_imp_AH(h)        Imported heat to the AH system
         h_imp_nonAH(h)     Imported heat to the AH system
;
* Set maximum import and export to the grid.
h_imp_AH.up(h)=  DH_max_cap;

h_exp_AH.up(h)=DH_max_cap;
*h_DH.lo(h)=-DH_max_cap;
*h_DH.up(h)=DH_max_cap;

*------------------Grid DC related----------------------------------------------
variable
         C_DC(h)             cooling from district cooling system
;
C_DC.fx(h) = 0;

*-------------------------PE and CO2 related -----------------------------------
variable
         FED_CO2(h)     Hourly CO2 emissions in the FED system
         tot_CO2        Total CO2 emissions of the FED system
         FED_PE(h)      Hourly PE use in the FED system
         tot_PE         Total PE use in the FED system

;

*-------------------- Power tariffs --------------------------------------------
positive variables
         max_exG(m)         hourly peak demand per month
         PT_exG(m)          Monthly peak demand charge
         mean_DH(d)         daily mean demand DH
         PT_DH              peak demand charge DH
;

*--------------------Objective function-----------------------------------------
variable
         fix_cost_existing  total fixed cost for existing generation
         fix_cost_new       total fixed cost for new generation
         var_cost_existing  total variable cost for existing generation
         var_cost_new       total variable cost for new generation
         Ainv_cost          total annualized investment cost
         totCost            total cost
         invCost            total investment cost
         FED_CO2_tot        total CO2 emissions from the FED system
         peak_CO2           CO2 peak
         obj                objective function
;
*invCost.up $ (min_totCost eq 0) = inv_lim;