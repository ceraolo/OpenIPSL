within iPSL.Examples.DevelopmentExamples.Electrical.Controls.PSAT.TG;
model TGTypeV_test
  import PowerSystems = iPSL;

  PowerSystems.Electrical.Machines.PSAT.ThirdOrder.Order3 GenOrder3(
    P_0=0.16041,
    Q_0=0.12012,
    V_b=400,
    V_0=1,
    angle_0=0,
    Sn=20,
    Vn=400,
    ra=0.001,
    xd1=0.302,
    M=10,
    D=0,
    xd=1.9,
    Td10=8,
    xq=1.7) annotation (Placement(visible=true,
        transformation(
        origin={-27.3443,-7.3756},
        extent={{-16.6557,-16.6244},{16.6557,16.6244}},
        rotation=0)));
  PowerSystems.Electrical.Loads.PSAT.LOADPQ pwLoadPQ1(P_0 = 0.08, Q_0 = 0.06,
    V_0=1,
    angle_0=0)                                                          annotation(Placement(visible = true, transformation(origin = {61.147, 4.3286}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = 0)));
  PowerSystems.Electrical.Branches.PwLine pwLine1(
    B=0.001/2,
    G=0,
    R=0.01,
    X=0.1) annotation (Placement(visible=true, transformation(
        origin={15.8634,-9.6714},
        extent={{-10.0,-10.0},{10.0,10.0}},
        rotation=0)));
  PowerSystems.Electrical.Branches.PwLine pwLine2(
    B=0.001/2,
    G=0,
    R=0.01,
    X=0.1) annotation (Placement(visible=true, transformation(
        origin={15.8634,4.3286},
        extent={{-10.0,-10.0},{10.0,10.0}},
        rotation=0)));
  PowerSystems.Electrical.Branches.PwLine pwLine3(
    B=0.001/2,
    G=0,
    R=0.01,
    X=0.1) annotation (Placement(visible=true, transformation(
        origin={39.5,-10},
        extent={{-10.0,-10.0},{10.0,10.0}},
        rotation=0)));
  PowerSystems.Electrical.Branches.PwLine pwLine4(
    B=0.001/2,
    G=0,
    R=0.01,
    X=0.1) annotation (Placement(visible=true, transformation(
        origin={38.863,5.3286},
        extent={{-10.0,-10.0},{10.0,10.0}},
        rotation=0)));
  PowerSystems.Electrical.Loads.PSAT.LOADPQ pwLoadPQ2(P_0 = 0.08, Q_0 = 0.06,
    V_0=1,
    angle_0=0)                                                          annotation(Placement(visible = true, transformation(origin = {61.5, -10}, extent = {{-10.0, -10.0}, {10.0, 10.0}}, rotation = 0)));
  PowerSystems.Electrical.Controls.PSAT.TG.TGTypeV tGModel5_1(Ki = 0.5, Kp = 3.0, Tg = 0.2, Tp = 0.05, sigma = 0.04, vmin = -0.1, vmax = 0.1, gmax = 1, gmin = 0, Tw = 1, Pref = 0.160552) annotation(Placement(transformation(extent = {{-78, -22}, {-56, -6}})));
  Modelica.Blocks.Sources.Sine sine(amplitude = 0.001, freqHz = 0.2, offset = 1, startTime = 5) annotation(Placement(transformation(extent = {{-6, 6}, {6, -6}}, rotation = 180, origin = {46, -40})));
  Modelica.Blocks.Sources.Sine sine1(amplitude = -0.001, freqHz = 0.2, startTime = 10, offset = 0) annotation(Placement(transformation(extent = {{6, -6}, {-6, 6}}, rotation = 0, origin = {14, -30})));
  Modelica.Blocks.Math.Add add annotation(Placement(transformation(extent = {{-8, -8}, {8, 8}}, rotation = 180, origin = {-28, -36})));
  inner PowerSystems.Electrical.SystemBase SysData
    annotation (Placement(transformation(extent={{0,60},{44,80}})));
equation
  connect(pwLine4.n, pwLoadPQ1.p) annotation(Line(visible = true, origin = {65.076, 7.3286}, points={{-19.213,
          -2},{-19.213,8},{-3.929,8}}));
  connect(pwLine3.n, pwLoadPQ2.p) annotation(Line(visible = true, origin = {87, -15.5}, points={{-40.5,
          5.5},{-25.5,5.5},{-25.5,16.5}}));
  connect(pwLine2.n, pwLine4.p) annotation(Line(visible = true, origin = {27.1134, 6.8286}, points = {{-4.25, -2.5}, {4.75, -2.5}, {4.75, -1.5}, {4.7496, -1.5}}));
  connect(pwLine1.n, pwLine3.p) annotation(Line(visible = true, origin = {27.0909, -4.8357}, points = {{-4.2275, -4.8357}, {5.4091, -4.8357}, {5.4091, -5.1643}}));
  connect(pwLine1.n, pwLine2.n) annotation(Line(visible = true, origin = {22.8634, -5.6714}, points = {{0, -4}, {0, -4}, {0, 10}}));
  connect(GenOrder3.p, pwLine2.p) annotation(Line(visible = true, origin = {1.2254, 1.7135}, points={{
          -10.2484,-9.00658},{1.638,-9.00658},{1.638,2.6151},{7.638,2.6151}}));
  connect(pwLine2.p, pwLine1.p) annotation(Line(visible = true, origin = {8.8634, -5.6714}, points = {{0, 10}, {0, -4}, {0, -4}}));
  connect(GenOrder3.vf0, GenOrder3.vf) annotation(Line(points={{-40.6689,
          10.9112},{-2,10.9112},{-2,16},{-54,16},{-54,0.936599},{-44,
          0.936599}},                                                                                                   color = {0, 0, 127}, smooth = Smooth.None));
  connect(tGModel5_1.Pm, GenOrder3.pm) annotation(Line(points={{-54.57,-14.08},{
          -48,-14.08},{-48,-15.6878},{-44,-15.6878}},                                                                                     color = {0, 0, 127}, smooth = Smooth.None));
  connect(GenOrder3.w, tGModel5_1.w) annotation(Line(points={{-9.02303,7.58636},
          {0,7.58636},{0,-26},{-86,-26},{-86,-14},{-80,-14},{-80,-14.88},{-79.87,
          -14.88}},                                                                                                    color = {0, 0, 127}, smooth = Smooth.None));
  connect(GenOrder3.pm0, tGModel5_1.w1) annotation(Line(points={{-40.6689,
          -25.6624},{0,-25.6624},{0,18},{-88,18},{-88,-9.52},{-79.98,-9.52}},                                                                            color = {0, 0, 127}, smooth = Smooth.None));
  connect(sine.y, add.u1) annotation(Line(points = {{39.4, -40}, {-16, -40}, {-16, -40}, {-18, -40}, {-18, -40}, {-18.4, -40.8}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(sine1.y, add.u2) annotation(Line(points = {{7.4, -30}, {-18, -30}, {-18, -31.2}, {-18.4, -31.2}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(add.y, tGModel5_1.wref) annotation(Line(points = {{-36.8, -36}, {-88, -36}, {-88, -19.2}, {-79.87, -19.2}}, color = {0, 0, 127}, smooth = Smooth.None));
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}})),
      Documentation(info="<html>
<p><span style=\"font-family: MS Shell Dlg 2;\">&LT;iPSL: iTesla Power System Library&GT;</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">Copyright 2015 RTE (France), AIA (Spain), KTH (Sweden) and DTU (Denmark)</span></p>
<ul>
<li><span style=\"font-family: MS Shell Dlg 2;\">RTE: http://www.rte-france.com/ </span></li>
<li><span style=\"font-family: MS Shell Dlg 2;\">AIA: http://www.aia.es/en/energy/</span></li>
<li><span style=\"font-family: MS Shell Dlg 2;\">KTH: https://www.kth.se/en</span></li>
<li><span style=\"font-family: MS Shell Dlg 2;\">DTU:http://www.dtu.dk/english</span></li>
</ul>
<p><span style=\"font-family: MS Shell Dlg 2;\">The authors can be contacted by email: info at itesla-ipsl dot org</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">This package is part of the iTesla Power System Library (&QUOT;iPSL&QUOT;) .</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">The iPSL is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">The iPSL is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">You should have received a copy of the GNU Lesser General Public License along with the iPSL. If not, see &LT;http://www.gnu.org/licenses/&GT;.</span></p>
</html>"));
end TGTypeV_test;
