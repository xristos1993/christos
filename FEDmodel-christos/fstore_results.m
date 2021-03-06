function [ data ] = fstore_results(h_sim,B_ID,BTES_properties)
%Function that prepares simulation results for storage

%Simulation results
gdxData='GtoM';

%Simulation options
data.min_totCost=gdx2mat(gdxData,'min_totCost');
data.min_totPE=gdx2mat(gdxData,'min_totPE');
data.min_totCO2=gdx2mat(gdxData,'min_totCO2');

%Extract electricity, heat and cooling demand in the FED system
data.el_demand=gdx2mat(gdxData,'el_demand',{h_sim.uels,B_ID.uels});
data.el_demand_nonAH=gdx2mat(gdxData,'el_demand_nonAH',{h_sim.uels,B_ID.uels});

data.h_demand=gdx2mat(gdxData,'h_demand',{h_sim.uels,B_ID.uels});
data.h_demand_nonAH=gdx2mat(gdxData,'h_demand_nonAH',{h_sim.uels,B_ID.uels});

data.c_demand=gdx2mat(gdxData,'c_demand',{h_sim.uels,B_ID.uels});
data.c_demand_AH=gdx2mat(gdxData,'c_demand_AH',{h_sim.uels,B_ID.uels});

%Electricity import and export
data.e_imp_AH=gdx2mat(gdxData,'e_imp_AH',h_sim.uels);
data.e_exp_AH=gdx2mat(gdxData,'e_exp_AH',h_sim.uels);
data.e_imp_nonAH=gdx2mat(gdxData,'e_imp_nonAH',h_sim.uels);
data.AH_el_imp_tot=gdx2mat(gdxData,'AH_el_imp_tot');
data.AH_el_exp_tot=gdx2mat(gdxData,'AH_el_exp_tot');

%heat import and export
data.h_imp_AH=gdx2mat(gdxData,'h_imp_AH',h_sim.uels);
data.h_exp_AH=gdx2mat(gdxData,'h_exp_AH',h_sim.uels);
data.h_imp_nonAH=gdx2mat(gdxData,'h_imp_nonAH',h_sim.uels);
data.AH_h_imp_tot=gdx2mat(gdxData,'AH_h_imp_tot');
data.AH_h_exp_tot=gdx2mat(gdxData,'AH_h_exp_tot');

%prices
data.el_sell_price=gdx2mat(gdxData,'el_sell_price',h_sim.uels);
data.el_price=gdx2mat(gdxData,'el_price',h_sim.uels);
data.h_price=gdx2mat(gdxData,'h_price',h_sim.uels);

%Outdoor temprature
data.tout=gdx2mat(gdxData,'tout',h_sim.uels);

%FED CO2 and PE
data.FED_PE=gdx2mat(gdxData,'FED_PE',h_sim.uels);
data.FED_CO2=gdx2mat(gdxData,'FED_CO2',h_sim.uels);
data.CO2F_PV=gdx2mat(gdxData,'CO2F_PV');
data.PEF_PV=gdx2mat(gdxData,'PEF_PV');
data.CO2F_P1=gdx2mat(gdxData,'CO2F_P1');
data.PEF_P1=gdx2mat(gdxData,'PEF_P1');
data.CO2F_P2=gdx2mat(gdxData,'CO2F_P2');
data.PEF_P2=gdx2mat(gdxData,'PEF_P2');
data.CO2F_exG=gdx2mat(gdxData,'CO2F_exG',h_sim.uels);
data.PEF_exG=gdx2mat(gdxData,'PEF_exG',h_sim.uels);
data.CO2F_DH=gdx2mat(gdxData,'CO2F_DH',h_sim.uels);
data.PEF_DH=gdx2mat(gdxData,'PEF_DH',h_sim.uels);

%Local production
data.h_Pana1=gdx2mat(gdxData,'h_Pana1',h_sim.uels);
data.h_RGK1=gdx2mat(gdxData,'h_RGK1',h_sim.uels);
data.qB1=gdx2mat(gdxData,'qB1',h_sim.uels);
data.qF1=gdx2mat(gdxData,'qF1',h_sim.uels);
data.fuel_P1=gdx2mat(gdxData,'fuel_P1',h_sim.uels);
data.P1_eff=gdx2mat(gdxData,'P1_eff');
data.H_VKA1=gdx2mat(gdxData,'H_VKA1',h_sim.uels);
data.C_VKA1=gdx2mat(gdxData,'C_VKA1',h_sim.uels);
data.el_VKA1=gdx2mat(gdxData,'el_VKA1',h_sim.uels);
data.H_VKA4=gdx2mat(gdxData,'H_VKA4',h_sim.uels);
data.C_VKA4=gdx2mat(gdxData,'C_VKA4',h_sim.uels);
data.el_VKA4=gdx2mat(gdxData,'el_VKA4',h_sim.uels);
data.h_AbsC=gdx2mat(gdxData,'h_AbsC',h_sim.uels);
data.c_AbsC=gdx2mat(gdxData,'c_AbsC',h_sim.uels);
data.h_AbsCInv=gdx2mat(gdxData,'h_AbsCInv',h_sim.uels);
data.c_AbsCInv=gdx2mat(gdxData,'c_AbsCInv',h_sim.uels);
data.AbsCInv_cap=gdx2mat(gdxData,'AbsCInv_cap');
data.invCost_AbsCInv=gdx2mat(gdxData,'invCost_AbsCInv');
data.el_RM=gdx2mat(gdxData,'el_RM',h_sim.uels);
data.c_RM=gdx2mat(gdxData,'c_RM',h_sim.uels);
data.e_RMMC=gdx2mat(gdxData,'e_RMMC',h_sim.uels);
data.h_RMMC=gdx2mat(gdxData,'h_RMMC',h_sim.uels);
data.c_RMMC=gdx2mat(gdxData,'c_RMMC',h_sim.uels);
data.RMMC_inv=gdx2mat(gdxData,'RMMC_inv');
data.invCost_RMMC=gdx2mat(gdxData,'invCost_RMMC');
data.e_AAC=gdx2mat(gdxData,'e_AAC',h_sim.uels);
data.c_AAC=gdx2mat(gdxData,'c_AAC',h_sim.uels);
data.h_HP=gdx2mat(gdxData,'h_HP',h_sim.uels);
data.e_HP=gdx2mat(gdxData,'e_HP',h_sim.uels);
data.c_HP=gdx2mat(gdxData,'c_HP',h_sim.uels);
data.HP_cap=gdx2mat(gdxData,'HP_cap');
data.invCost_HP=gdx2mat(gdxData,'invCost_HP');

%storage
data.TES_ch=gdx2mat(gdxData,'TES_ch',h_sim.uels);
data.TES_dis=gdx2mat(gdxData,'TES_dis',h_sim.uels);
data.TES_en=gdx2mat(gdxData,'TES_en',h_sim.uels);
data.TES_cap=gdx2mat(gdxData,'TES_cap');
data.TES_inv=gdx2mat(gdxData,'TES_inv');
data.invCost_TES=gdx2mat(gdxData,'invCost_TES');
data.TES_dis_eff=gdx2mat(gdxData,'TES_dis_eff');
data.TES_chr_eff=gdx2mat(gdxData,'TES_chr_eff');
data.BTES_Sch=gdx2mat(gdxData,'BTES_Sch',{h_sim.uels,BTES_properties.uels});
data.BTES_Sdis=gdx2mat(gdxData,'BTES_Sdis',{h_sim.uels,BTES_properties.uels});
data.BTES_Sen=gdx2mat(gdxData,'BTES_Sen',{h_sim.uels,BTES_properties.uels});
data.BTES_Den=gdx2mat(gdxData,'BTES_Den',{h_sim.uels,BTES_properties.uels});
data.BTES_Sloss=gdx2mat(gdxData,'BTES_Sloss',{h_sim.uels,BTES_properties.uels});
data.BTES_Dloss=gdx2mat(gdxData,'BTES_Dloss',{h_sim.uels,BTES_properties.uels});
data.link_BS_BD=gdx2mat(gdxData,'link_BS_BD',{h_sim.uels,BTES_properties.uels});
data.BTES_dis_eff=gdx2mat(gdxData,'BTES_dis_eff');
data.B_BITES=gdx2mat(gdxData,'B_BITES',BTES_properties.uels);
data.invCost_BITES=gdx2mat(gdxData,'invCost_BITES');
data.invCost_BITES=gdx2mat(gdxData,'invCost_BITES');
%BTES model
data.BTES_model=gdx2mat(gdxData,'BTES_model',{BTES_properties.uels,B_ID.uels});

%BAC
data.h_BAC_savings=gdx2mat(gdxData,'h_BAC_savings',{h_sim.uels,BTES_properties.uels});
data.B_BAC=gdx2mat(gdxData,'B_BAC',BTES_properties.uels);
data.invCost_BAC=gdx2mat(gdxData,'invCost_BAC');
data.BAC_savings_period=gdx2mat(gdxData,'BAC_savings_period',h_sim.uels);

%Boiler 2
data.B_P2=gdx2mat(gdxData,'B_P2');
data.invCost_P2=gdx2mat(gdxData,'invCost_P2');
data.fuel_P2=gdx2mat(gdxData,'fuel_P2',h_sim.uels);
data.h_P2=gdx2mat(gdxData,'h_P2',h_sim.uels);
data.H_P2T=gdx2mat(gdxData,'H_P2T',h_sim.uels);
data.B_TURB=gdx2mat(gdxData,'B_TURB');
data.invCost_TURB=gdx2mat(gdxData,'invCost_TURB');
data.e_TURB=gdx2mat(gdxData,'e_TURB',h_sim.uels);
data.h_TURB=gdx2mat(gdxData,'h_TURB',h_sim.uels);
data.P2_eff=gdx2mat(gdxData,'P2_eff');
data.TURB_eff=gdx2mat(gdxData,'TURB_eff');
end

