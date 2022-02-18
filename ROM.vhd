-- ROM file for the ICAI-RISC-V processor.
-- Generated from the hex file:  ROM.vhd

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ROM is
  port(
    clk: in std_logic;                         -- Synchronous ROM
    en_pc: in std_logic;                       -- Whith enable
    addr: in  std_logic_vector(31 downto 0);   -- Address bus
    data: out std_logic_vector(31 downto 0) ); -- Data out
end ROM;

architecture Behavioural of ROM is
  -- The internal address is word address, no byte address
  signal internal_addr : std_logic_vector(29 downto 0);

  -- ROM declaration
 type mem_t is array (0 to 26 ) of std_logic_vector(31 downto 0);
  signal memory : mem_t:= (
     0  => X"00d00513",
     1  => X"100007b7",
     2  => X"00078793",
     3  => X"10000837",
     4  => X"00480813",
     5  => X"00082283",
     6  => X"fe551ee3",
     7  => X"00000263",
     8  => X"04600293",
     9  => X"0057a023",
     10  => X"07500293",
     11  => X"0057a023",
     12  => X"06e00293",
     13  => X"0057a023",
     14  => X"06300293",
     15  => X"0057a023",
     16  => X"06900293",
     17  => X"0057a023",
     18  => X"06f00293",
     19  => X"0057a023",
     20  => X"06e00293",
     21  => X"0057a023",
     22  => X"06100293",
     23  => X"0057a023",
     24  => X"fc0000e3",
     others => X"00000000");
begin

  internal_addr <= addr(31 downto 2);

  mem_rom: process(clk)
  begin
    if clk'event and clk = '1' then
      if en_pc = '1' then
        data <= memory(to_integer(unsigned(internal_addr)));
      end if;
    end if;
  end process mem_rom;
end architecture Behavioural;

