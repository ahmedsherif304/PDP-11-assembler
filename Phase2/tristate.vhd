library ieee;
use ieee.std_logic_1164.all;

entity tristate is
    generic(n: integer := 32);
    port(
        en: in std_logic;
        inp: in std_logic_vector(n-1 downto 0);
        oup: out  std_logic_vector(n-1 downto 0)
    );
end tristate;

architecture arch of tristate is
begin
    oup <= inp when en = '1'
        else (others=>'Z');
end arch;