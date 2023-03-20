
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

entity radio_tx is
	 port(
	 CLK200M : in STD_LOGIC;
	 RSTn : in STD_LOGIC;
	 RX : in STD_LOGIC;
	 Radio_P : out STD_LOGIC;
	 Radio_N : out STD_LOGIC
	 );
end radio_tx;

--}} End of automatically maintained section

architecture radio_tx of radio_tx is
constant Fd : integer := 200;
constant F1 : integer := 26;
constant F2 : integer := 28;
constant N  : integer := 8;
constant max_val1 : std_logic_vector(N-1 downto 0) := conv_std_logic_vector(F1*256/Fd, N);
constant max_val2 : std_logic_vector(N-1 downto 0) := conv_std_logic_vector(F2*256/Fd, N);
signal   sum : std_logic_vector(N-1 downto 0);
begin

	main: process(CLK200M, RSTn)
	begin
		if RSTn='0' then
			sum <= (others => '0');
		elsif rising_edge(CLK200M) then
			if RX='1' then
				sum <= sum + max_val1;
			else
				sum <= sum + max_val2;
			end if;
			
			Radio_P <= sum(N-1);
			Radio_N <= not sum(N-1);
				
		end if;
	end process;

end radio_tx;
