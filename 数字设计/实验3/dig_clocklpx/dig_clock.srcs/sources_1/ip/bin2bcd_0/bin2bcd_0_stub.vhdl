-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.2 (win64) Build 2258646 Thu Jun 14 20:03:12 MDT 2018
-- Date        : Sun May 15 12:12:52 2022
-- Host        : LAPTOP-627C3VIT running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub {d:/Huawei
--               Share/dig_clock/dig_clock.srcs/sources_1/ip/bin2bcd_0/bin2bcd_0_stub.vhdl}
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
attribute X_CORE_INFO of stub : architecture is "bin2bcd,Vivado 2018.2";
begin
end;
