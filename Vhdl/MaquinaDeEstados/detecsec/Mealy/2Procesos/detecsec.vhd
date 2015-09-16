library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity detecsec is
    Port ( RST,CLK,Xin : in std_logic;
           Zout        : out std_logic
         );
end detecsec;

architecture Behavioral of detecsec is

type estado is (s0,s1,s2,s3);
signal pr,sg : estado;

begin
-- parte secuencial

process (rst,clk)
begin
	if rst='1' then pr<=s0;
	  elsif clk'event and clk='1' then
        pr<=sg;
	end if;
end process;

-- fin parte secuencial

--parte combinacional

process (pr,Xin)
begin
case pr is
		when s0  =>
     	IF Xin = '0' THEN
		    sg <= s0;
            Zout <= '0';
		    ELSE
		    sg <= s1;
            Zout <= '0';		    
		END IF;
        when s1  =>
     	IF Xin = '0' THEN
		    sg <= s0;
            Zout <= '0';
		    ELSE
		    sg <= s2;
            Zout <= '0';		    
		END IF;
        when s2  =>
     	IF Xin = '0' THEN
		    sg <= s3;
            Zout <= '0';
		    ELSE
		    sg <= s2;
            Zout <= '0';		    
		END IF;
        when s3  =>
     	IF Xin = '0' THEN
		    sg <= s0;
            Zout <= '0';
		    ELSE
		    sg <= s1;
            Zout <= '1';		    
		END IF;
end case;
end process;
end Behavioral;

