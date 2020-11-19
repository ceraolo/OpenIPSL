within OpenIPSL.Electrical.Controls.PSSE.ES;
model ESDC2A "DC2A Excitation System [IEEE2005]"
  extends Icons.VerifiedModel;
  extends OpenIPSL.Electrical.Controls.PSSE.ES.BaseClasses.BaseExciter;
  import OpenIPSL.NonElectrical.Functions.SE;
  import
    OpenIPSL.Electrical.Controls.PSSE.ES.BaseClasses.calculate_dc_exciter_params;
  parameter Types.Time T_R=0 "Regulator input filter time constant";
  parameter Types.PerUnit K_A=400 "Regulator output gain";
  parameter Types.Time T_A=0.02 "Regulator time constant";
  parameter Types.Time T_B=0 "Regulator denominator (lag) time constant";
  parameter Types.Time T_C=0 "Regulator numerator (lead) time constant";
  parameter Types.PerUnit V_RMAX=9 "Maximum controller output";
  parameter Types.PerUnit V_RMIN=-5.43 "Minimum controller output";
  parameter Types.PerUnit K_E=1 "Exciter field proportional constant";
  parameter Types.Time T_E=0.8 "Exciter field time constant";
  parameter Types.PerUnit K_F=0.03 "Rate feedback gain";
  parameter Types.Time T_F1=1 "Rate feedback time constant";
  parameter Types.PerUnit E_1=5.25 "Exciter output voltage for saturation factor S_E(E_1)";
  parameter Types.PerUnit E_2=7 "Exciter output voltage for saturation factor S_E(E_2)";
  parameter Types.PerUnit S_EE_1=0.03 "Exciter saturation factor at exciter output voltage E_1";
  parameter Types.PerUnit S_EE_2=0.1 "Exciter saturation factor at exciter output voltage E_2";
  Modelica.Blocks.Continuous.Derivative imDerivativeLag(
    k=K_F,
    T=T_F1,
    y_start=0,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    x_start=Efd0)
    annotation (Placement(transformation(extent={{0,-60},{-20,-40}})));
  NonElectrical.Logical.HV_GATE hV_GATE
    annotation (Placement(transformation(extent={{40,-6},{62,6}})));
  NonElectrical.Continuous.LeadLag imLeadLag(
    K=1,
    T1=T_C,
    T2=T_B,
    y_start=V_R0/K_A)
    annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  Modelica.Blocks.Math.Add3 add3_1(k3=-1)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  BaseClasses.RotatingExciterLimited rotatingExciterLimited(
    T_E=T_E,
    E_1=E_1,
    E_2=E_2,
    S_EE_1=S_EE_1,
    S_EE_2=S_EE_2,
    Efd0=Efd0,
    K_E=K_E0)
    annotation (Placement(transformation(extent={{120,-10},{140,10}})));
  NonElectrical.Continuous.SimpleLag TransducerDelay(
    K=1,
    T=T_R,
    y_start=ECOMP0)
    annotation (Placement(transformation(extent={{-170,-10},{-150,10}})));
  Modelica.Blocks.Math.Add DiffV1
    annotation (Placement(transformation(extent={{-90,30},{-70,50}})));
  NonElectrical.Continuous.SimpleLagLimVar simpleLagLimVar(
    K=K_A,
    T=T_A,
    y_start=V_R0)
    annotation (Placement(transformation(extent={{80,-10},{100,10}})));
  Modelica.Blocks.Interfaces.RealInput VT annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={102,-120}), iconTransformation(
        extent={{-10,-10},{10,10}},
        origin={-110,-80})));
  Modelica.Blocks.Math.Gain gain(k=V_RMIN0) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={82,-70})));
  Modelica.Blocks.Math.Gain gain1(k=V_RMAX0) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={110,-70})));
protected
  parameter Real V_R0(fixed=false);
  parameter Real V_RMAX0(fixed=false);
  parameter Real K_E0(fixed=false);
  parameter Real V_RMIN0(fixed=false);
  parameter Real SE_Efd0(fixed=false);
initial equation
  SE_Efd0 = OpenIPSL.NonElectrical.Functions.SE(
    Efd0,
    S_EE_1,
    S_EE_2,
    E_1,
    E_2);
  (V_RMAX0,V_RMIN0,K_E0) = calculate_dc_exciter_params(
    V_RMAX,
    V_RMIN,
    K_E,
    E_2,
    S_EE_2,
    Efd0,
    SE_Efd0);
  V_R0 = Efd0*(K_E0 + SE_Efd0);
  V_REF = V_R0/K_A + ECOMP0;
equation
  connect(add3_1.y, imLeadLag.u)
    annotation (Line(points={{-39,0},{-36,0},{-22,0}}, color={0,0,127}));
  connect(ECOMP, TransducerDelay.u)
    annotation (Line(points={{-200,0},{-172,0},{-172,0}}, color={0,0,127}));
  connect(TransducerDelay.y, DiffV.u2) annotation (Line(points={{-149,0},{-132,
          0},{-132,-6},{-122,-6}}, color={0,0,127}));
  connect(rotatingExciterLimited.EFD, EFD)
    annotation (Line(points={{141.25,0},{210,0},{210,0}}, color={0,0,127}));
  connect(imLeadLag.y, hV_GATE.n1) annotation (Line(points={{1,0},{32,0},{32,3},
          {38.625,3}}, color={0,0,127}));
  connect(VUEL, hV_GATE.n2) annotation (Line(points={{-130,-200},{-128,-200},{-128,
          -80},{32,-80},{32,-3},{38.625,-3}}, color={0,0,127}));
  connect(imDerivativeLag.u, EFD) annotation (Line(points={{2,-50},{160,-50},{
          160,0},{210,0}}, color={0,0,127}));
  connect(imDerivativeLag.y, add3_1.u3) annotation (Line(points={{-21,-50},{-46,
          -50},{-72,-50},{-72,-8},{-62,-8}}, color={0,0,127}));
  connect(DiffV.y, add3_1.u2)
    annotation (Line(points={{-99,0},{-62,0},{-62,0}}, color={0,0,127}));
  connect(VOTHSG, DiffV1.u1) annotation (Line(points={{-200,90},{-150,90},{-96,
          90},{-96,46},{-92,46}}, color={0,0,127}));
  connect(VOEL, DiffV1.u2) annotation (Line(points={{-70,-200},{-70,-200},{-70,
          -60},{-96,-60},{-96,34},{-92,34}}, color={0,0,127}));
  connect(DiffV1.y, add3_1.u1) annotation (Line(points={{-69,40},{-66,40},{-66,
          8},{-62,8}}, color={0,0,127}));
  connect(simpleLagLimVar.u, hV_GATE.p)
    annotation (Line(points={{78,0},{60.625,0}}, color={0,0,127}));
  connect(simpleLagLimVar.y, rotatingExciterLimited.I_C)
    annotation (Line(points={{101,0},{118.75,0}}, color={0,0,127}));
  connect(VT, gain.u) annotation (Line(points={{102,-120},{102,-92},{82,-92},{
          82,-82}}, color={0,0,127}));
  connect(gain.y, simpleLagLimVar.outMin)
    annotation (Line(points={{82,-59},{82,-36},{82,-14}}, color={0,0,127}));
  connect(gain1.y, simpleLagLimVar.outMax) annotation (Line(points={{110,-59},{
          110,-59},{110,20},{98,20},{98,14}}, color={0,0,127}));
  connect(gain1.u, gain.u) annotation (Line(points={{110,-82},{110,-92},{82,-92},
          {82,-82}}, color={0,0,127}));
  annotation (
    Diagram(coordinateSystem(
        extent={{-200,-200},{200,160}},
        grid={2,2})),
    Icon(coordinateSystem(
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Text(
          extent={{-100,160},{100,100}},
          lineColor={28,108,200},
          textString="ESDC2A"),Text(
          extent={{-90,-70},{-60,-90}},
          lineColor={28,108,200},
          textString="VT")}),
    Documentation(info="<html>
<table cellspacing=\"1\" cellpadding=\"1\" border=\"1\">
<tr>
<td><p>Reference</p></td>
<td>ESDC2A, PSS/E Manual</td>
</tr>
<tr>
<td><p>Last update</p></td>
<td>Major change - 2016-01-19</td>
</tr>
<tr>
<td><p>Author</p></td>
<td><p>Tin Rabuzin, SmarTS Lab, KTH Royal Institute of Technology</p></td>
</tr>
<tr>
<td><p>Contact</p></td>
<td><p><a href=\"mailto:luigiv@kth.se\">luigiv@kth.se</a></p></td>
</tr>
</table>
</html>"));
end ESDC2A;
