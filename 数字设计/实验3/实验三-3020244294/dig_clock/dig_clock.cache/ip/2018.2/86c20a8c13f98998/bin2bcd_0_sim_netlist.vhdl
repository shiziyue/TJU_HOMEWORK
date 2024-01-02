-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.2 (win64) Build 2258646 Thu Jun 14 20:03:12 MDT 2018
-- Date        : Sat May 21 20:56:04 2022
-- Host        : DESKTOP-J9TUK8S running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
--               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ bin2bcd_0_sim_netlist.vhdl
-- Design      : bin2bcd_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7a35tftg256-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
  port (
    bin : in STD_LOGIC_VECTOR ( 7 downto 0 );
    bcd : out STD_LOGIC_VECTOR ( 7 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "bin2bcd_0,bin2bcd,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "yes";
  attribute IP_DEFINITION_SOURCE : string;
  attribute IP_DEFINITION_SOURCE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "package_project";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "bin2bcd,Vivado 2018.2";
end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix;

architecture STRUCTURE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
  signal \^bcd\ : STD_LOGIC_VECTOR ( 7 downto 1 );
  signal \bcd[4]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \bcd[4]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \bcd[4]_INST_0_i_3_n_0\ : STD_LOGIC;
  signal \^bin\ : STD_LOGIC_VECTOR ( 7 downto 0 );
begin
  \^bin\(7 downto 0) <= bin(7 downto 0);
  bcd(7 downto 1) <= \^bcd\(7 downto 1);
  bcd(0) <= \^bin\(0);
\bcd[1]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"11EA"
    )
        port map (
      I0 => \bcd[4]_INST_0_i_3_n_0\,
      I1 => \bcd[4]_INST_0_i_2_n_0\,
      I2 => \bcd[4]_INST_0_i_1_n_0\,
      I3 => \^bin\(1),
      O => \^bcd\(1)
    );
\bcd[2]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"998C"
    )
        port map (
      I0 => \^bin\(1),
      I1 => \bcd[4]_INST_0_i_1_n_0\,
      I2 => \bcd[4]_INST_0_i_2_n_0\,
      I3 => \bcd[4]_INST_0_i_3_n_0\,
      O => \^bcd\(2)
    );
\bcd[3]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"1E10"
    )
        port map (
      I0 => \^bin\(1),
      I1 => \bcd[4]_INST_0_i_1_n_0\,
      I2 => \bcd[4]_INST_0_i_2_n_0\,
      I3 => \bcd[4]_INST_0_i_3_n_0\,
      O => \^bcd\(3)
    );
\bcd[4]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"1FE0"
    )
        port map (
      I0 => \^bin\(1),
      I1 => \bcd[4]_INST_0_i_1_n_0\,
      I2 => \bcd[4]_INST_0_i_2_n_0\,
      I3 => \bcd[4]_INST_0_i_3_n_0\,
      O => \^bcd\(4)
    );
\bcd[4]_INST_0_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8A65A651518A18A6"
    )
        port map (
      I0 => \^bin\(6),
      I1 => \^bin\(5),
      I2 => \^bin\(7),
      I3 => \^bin\(4),
      I4 => \^bin\(3),
      I5 => \^bin\(2),
      O => \bcd[4]_INST_0_i_1_n_0\
    );
\bcd[4]_INST_0_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"C61831C68C31638C"
    )
        port map (
      I0 => \^bin\(2),
      I1 => \^bin\(3),
      I2 => \^bin\(4),
      I3 => \^bin\(7),
      I4 => \^bin\(5),
      I5 => \^bin\(6),
      O => \bcd[4]_INST_0_i_2_n_0\
    );
\bcd[4]_INST_0_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0821420810428410"
    )
        port map (
      I0 => \^bin\(2),
      I1 => \^bin\(3),
      I2 => \^bin\(4),
      I3 => \^bin\(7),
      I4 => \^bin\(5),
      I5 => \^bin\(6),
      O => \bcd[4]_INST_0_i_3_n_0\
    );
\bcd[5]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"2DC201D609D240D6"
    )
        port map (
      I0 => \^bin\(6),
      I1 => \^bin\(5),
      I2 => \^bin\(7),
      I3 => \^bin\(4),
      I4 => \^bin\(3),
      I5 => \^bin\(2),
      O => \^bcd\(5)
    );
\bcd[6]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F000000F1FFCF800"
    )
        port map (
      I0 => \^bin\(2),
      I1 => \^bin\(3),
      I2 => \^bin\(4),
      I3 => \^bin\(7),
      I4 => \^bin\(5),
      I5 => \^bin\(6),
      O => \^bcd\(6)
    );
\bcd[7]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000103F0E0000000"
    )
        port map (
      I0 => \^bin\(2),
      I1 => \^bin\(3),
      I2 => \^bin\(4),
      I3 => \^bin\(7),
      I4 => \^bin\(5),
      I5 => \^bin\(6),
      O => \^bcd\(7)
    );
end STRUCTURE;
