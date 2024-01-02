-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
-- Date        : Wed May 18 10:43:18 2022
-- Host        : Uylno running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim
--               d:/vivado/dig_clock/dig_clock.srcs/sources_1/ip/bin2bcd_0/bin2bcd_0_sim_netlist.vhdl
-- Design      : bin2bcd_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7a35tftg256-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity bin2bcd_0 is
  port (
    bin : in STD_LOGIC_VECTOR ( 7 downto 0 );
    bcd : out STD_LOGIC_VECTOR ( 7 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of bin2bcd_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of bin2bcd_0 : entity is "bin2bcd_0,bin2bcd,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of bin2bcd_0 : entity is "yes";
  attribute IP_DEFINITION_SOURCE : string;
  attribute IP_DEFINITION_SOURCE of bin2bcd_0 : entity is "package_project";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of bin2bcd_0 : entity is "bin2bcd,Vivado 2018.3";
end bin2bcd_0;

architecture STRUCTURE of bin2bcd_0 is
  signal \^bcd\ : STD_LOGIC_VECTOR ( 7 downto 1 );
  signal \bcd[4]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \bcd[4]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \bcd[4]_INST_0_i_3_n_0\ : STD_LOGIC;
  signal \^bin\ : STD_LOGIC_VECTOR ( 7 downto 0 );
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \bcd[4]_INST_0_i_1\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \bcd[4]_INST_0_i_3\ : label is "soft_lutpair0";
begin
  \^bin\(7 downto 0) <= bin(7 downto 0);
  bcd(7 downto 1) <= \^bcd\(7 downto 1);
  bcd(0) <= \^bin\(0);
\bcd[1]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"481137EC"
    )
        port map (
      I0 => \bcd[4]_INST_0_i_3_n_0\,
      I1 => \bcd[4]_INST_0_i_2_n_0\,
      I2 => \^bin\(2),
      I3 => \bcd[4]_INST_0_i_1_n_0\,
      I4 => \^bin\(1),
      O => \^bcd\(1)
    );
\bcd[2]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"3C623C46"
    )
        port map (
      I0 => \bcd[4]_INST_0_i_1_n_0\,
      I1 => \^bin\(2),
      I2 => \bcd[4]_INST_0_i_2_n_0\,
      I3 => \^bin\(1),
      I4 => \bcd[4]_INST_0_i_3_n_0\,
      O => \^bcd\(2)
    );
\bcd[3]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"10D34A08"
    )
        port map (
      I0 => \bcd[4]_INST_0_i_1_n_0\,
      I1 => \^bin\(2),
      I2 => \bcd[4]_INST_0_i_2_n_0\,
      I3 => \^bin\(1),
      I4 => \bcd[4]_INST_0_i_3_n_0\,
      O => \^bcd\(3)
    );
\bcd[4]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"95565A5A"
    )
        port map (
      I0 => \bcd[4]_INST_0_i_1_n_0\,
      I1 => \^bin\(2),
      I2 => \bcd[4]_INST_0_i_2_n_0\,
      I3 => \^bin\(1),
      I4 => \bcd[4]_INST_0_i_3_n_0\,
      O => \^bcd\(4)
    );
\bcd[4]_INST_0_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"26926426"
    )
        port map (
      I0 => \^bin\(4),
      I1 => \^bin\(6),
      I2 => \^bin\(7),
      I3 => \^bin\(5),
      I4 => \^bin\(3),
      O => \bcd[4]_INST_0_i_1_n_0\
    );
\bcd[4]_INST_0_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"3C799E3C38611C38"
    )
        port map (
      I0 => \^bin\(3),
      I1 => \^bin\(4),
      I2 => \^bin\(6),
      I3 => \^bin\(7),
      I4 => \^bin\(5),
      I5 => \^bin\(2),
      O => \bcd[4]_INST_0_i_2_n_0\
    );
\bcd[4]_INST_0_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"99294694"
    )
        port map (
      I0 => \^bin\(5),
      I1 => \^bin\(7),
      I2 => \^bin\(6),
      I3 => \^bin\(4),
      I4 => \^bin\(3),
      O => \bcd[4]_INST_0_i_3_n_0\
    );
\bcd[5]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"2C0BC3D00042C3FC"
    )
        port map (
      I0 => \^bin\(2),
      I1 => \^bin\(5),
      I2 => \^bin\(7),
      I3 => \^bin\(6),
      I4 => \^bin\(4),
      I5 => \^bin\(3),
      O => \^bcd\(5)
    );
\bcd[6]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"C03C03ECC07C03C0"
    )
        port map (
      I0 => \^bin\(2),
      I1 => \^bin\(5),
      I2 => \^bin\(7),
      I3 => \^bin\(6),
      I4 => \^bin\(4),
      I5 => \^bin\(3),
      O => \^bcd\(6)
    );
\bcd[7]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"03C0000003803400"
    )
        port map (
      I0 => \^bin\(2),
      I1 => \^bin\(5),
      I2 => \^bin\(7),
      I3 => \^bin\(6),
      I4 => \^bin\(4),
      I5 => \^bin\(3),
      O => \^bcd\(7)
    );
end STRUCTURE;
