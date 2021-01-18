library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity dec is
    generic(n: integer := 2);
    port(
        en: in std_logic;
        a: in std_logic_vector(n-1 downto 0);
        b: out std_logic_vector((2**n)-1 downto 0)
    );
end dec;

architecture arch of dec is
begin
    lop: for i in 0 to (2**n - 1) generate
        b(i) <= '1' when (i = to_integer(unsigned(a))) and en = '1'
        else '0';
    end generate;
end arch;