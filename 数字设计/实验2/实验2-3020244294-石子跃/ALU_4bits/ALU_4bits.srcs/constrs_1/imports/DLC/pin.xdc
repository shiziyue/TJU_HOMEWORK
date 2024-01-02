#Constraints of system clock
set_property -dict { PACKAGE_PIN F5  IOSTANDARD LVCMOS33 } [get_ports { sys_clk }];

#Constraints of system reset
set_property -dict { PACKAGE_PIN K5  IOSTANDARD LVCMOS33 } [get_ports { sys_rst_n }];

#Constraints of input ports A
set_property -dict { PACKAGE_PIN B9   IOSTANDARD LVCMOS33 } [get_ports { A[0] }];
set_property -dict { PACKAGE_PIN D11  IOSTANDARD LVCMOS33 } [get_ports { A[1] }];
set_property -dict { PACKAGE_PIN B11  IOSTANDARD LVCMOS33 } [get_ports { A[2] }];
set_property -dict { PACKAGE_PIN B12  IOSTANDARD LVCMOS33 } [get_ports { A[3] }];

#Constraints of input ports B
set_property -dict { PACKAGE_PIN K16  IOSTANDARD LVCMOS33 } [get_ports { B[0] }];
set_property -dict { PACKAGE_PIN P6   IOSTANDARD LVCMOS33 } [get_ports { B[1] }];
set_property -dict { PACKAGE_PIN D10  IOSTANDARD LVCMOS33 } [get_ports { B[2] }];
set_property -dict { PACKAGE_PIN C8   IOSTANDARD LVCMOS33 } [get_ports { B[3] }];

#Constraints of input ports aluop
set_property -dict { PACKAGE_PIN A10  IOSTANDARD LVCMOS33 } [get_ports { aluop[0] }];
set_property -dict { PACKAGE_PIN B10  IOSTANDARD LVCMOS33 } [get_ports { aluop[1] }];
set_property -dict { PACKAGE_PIN J13  IOSTANDARD LVCMOS33 } [get_ports { aluop[2] }];
set_property -dict { PACKAGE_PIN K15  IOSTANDARD LVCMOS33 } [get_ports { aluop[3] }];

#Constraints of output ports {ov, zero}
set_property -dict { PACKAGE_PIN L14   IOSTANDARD LVCMOS33 } [get_ports { zero }];
set_property -dict { PACKAGE_PIN M14   IOSTANDARD LVCMOS33 } [get_ports { ov   }];

#Constraints of output ports an
set_property -dict { PACKAGE_PIN D9   IOSTANDARD LVCMOS33 } [get_ports { an[0] }];
set_property -dict { PACKAGE_PIN E12  IOSTANDARD LVCMOS33 } [get_ports { an[1] }];
set_property -dict { PACKAGE_PIN E13  IOSTANDARD LVCMOS33 } [get_ports { an[2] }];
set_property -dict { PACKAGE_PIN E11  IOSTANDARD LVCMOS33 } [get_ports { an[3] }];

#Constraints of output ports a_to_g
set_property -dict { PACKAGE_PIN C4  IOSTANDARD LVCMOS33 } [get_ports { a_to_g[7] }];
set_property -dict { PACKAGE_PIN D5  IOSTANDARD LVCMOS33 } [get_ports { a_to_g[6] }];
set_property -dict { PACKAGE_PIN D6  IOSTANDARD LVCMOS33 } [get_ports { a_to_g[5] }];
set_property -dict { PACKAGE_PIN C6  IOSTANDARD LVCMOS33 } [get_ports { a_to_g[4] }];
set_property -dict { PACKAGE_PIN T9  IOSTANDARD LVCMOS33 } [get_ports { a_to_g[3] }];
set_property -dict { PACKAGE_PIN L12 IOSTANDARD LVCMOS33 } [get_ports { a_to_g[2] }];
set_property -dict { PACKAGE_PIN L13 IOSTANDARD LVCMOS33 } [get_ports { a_to_g[1] }];
set_property -dict { PACKAGE_PIN K13 IOSTANDARD LVCMOS33 } [get_ports { a_to_g[0] }];

set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]