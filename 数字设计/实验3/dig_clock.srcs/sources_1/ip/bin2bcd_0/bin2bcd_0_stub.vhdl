-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
-- Date        : Wed May 18 10:43:18 2022
-- Host        : Uylno running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               d:/vivado/dig_clock/dig_clock.srcs/sources_1/ip/bin2bcd_0/bin2bcd_0_stub.vhdl
-- Design      : bin2bcd_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a35tftg256-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bin2bcd_0 is
  Port ( 
    bin : in STD_LOGIC_VECTOR ( 7 downto 0 );
    bcd : out STD_LOGIC_VECTOR ( 7 downto 0 )
  );

end bin2bcd_0;

architecture stub of bin2bcd_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "bin[7:0],bcd[7:0]";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "bin2bcd,Vivado 2018.3";
begin
end;
