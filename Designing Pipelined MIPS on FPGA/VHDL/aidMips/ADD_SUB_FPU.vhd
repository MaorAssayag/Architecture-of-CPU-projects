-- ====================================================================
--
--	File Name:		ADD_SUB_FPU.vhd
--	Description:	ADD\SUB FPU command (ADD OPP=1010 , SUB OPP = 1011), currently support N bit's IEEE Standard 754 Floating Point Numbers
--  Floating Point Components       Sign   	Exponent  	Fraction
--               Single Precision 	1 [31] 	8 [30–23] 	23 [22–00]
--               OPP=1 -> SUB, OPP=0 -> ADD

--
--
--	Date:			16/05/2018
--	Designers:		Maor Assayag, Refael Shetrit
--
-- ====================================================================

-- libraries decleration
library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

 -- entity Definition
entity ADD_SUB_FPU is
    generic(N: integer := 32); --defualt value for N is 32
    Port(
      OPP : in std_logic;
      A :     in signed((N-1) downto 0);
      B :     in signed((N-1) downto 0);
      SUM :   out signed((N-1) downto 0));
end ADD_SUB_FPU;

 -- Architecture Definition
architecture gate_level of ADD_SUB_FPU is

-- Components
component ADD_SUB
    generic(N: positive := 8); --defualt value for N is 8
    port(
       addORsub :  in std_logic;
       A :     in signed ((N-1) downto 0);
       B :     in signed ((N-1) downto 0);
       SUM :   out signed ((N-1) downto 0);
       Cout  :  out std_logic);
end component;

component LeadingZeros_counter
    generic(N: positive := 8); --defualt value for N is 8
    port (
       X :  in  signed (N-1 downto 0);
       Y  : out signed (5 downto 0));
end component;

component Swap
    generic(N: positive := 8); --defualt value for N is 8
    port (
       SEL: in  std_logic;
       Y1 : in  signed (N-1 downto 0);
       Y2 : in  signed (N-1 downto 0);
       Out1  : out signed (N-1 downto 0);
       Out2 :  out signed (N-1 downto 0));
end component;

component MUX_Nbits
    generic(N: positive := 8); --defualt value for N is 8
    port (
           SEL: in  std_logic;
           Y1 : in  signed (N-1 downto 0);
           Y2 : in  signed (N-1 downto 0);
           Y  : out signed (N-1 downto 0));
end component;

component MAX_MIN
    generic (N: INTEGER := 8); --defualt value for N is 8
    port(
        maxORmin : in  std_logic;
        A, B :     in  signed(N-1 downto 0);
        result :   out signed(N-1 downto 0));
end component;

component shift_unit
    generic(N: integer := 8); --defualt value for N is 8
    port(
      dir :    in std_logic;
      A :      in signed(N-1 downto 0);
      B :      in signed(5 downto 0);
      result : out signed(N-1 downto 0));
end component;

--floating point components extraction signals
signal signA: std_logic;
signal signB: std_logic;
signal expA: signed(7 downto 0);
signal expB: signed(7 downto 0);
signal fractionA: signed(24 downto 0); -- original value Normlize with 1 at MSB
signal fractionB: signed(24 downto 0); -- original value Normlize with 1 at MSB
signal fraction1: signed(24 downto 0);
signal fraction2: signed(24 downto 0); -- after alligenment


--temp connection signals
signal fraction2_tmp: signed(24 downto 0); -- Second number fraction before alignment
signal expDiff: signed(7 downto 0); -- exponentA - exponentB
signal expTemp: signed(7 downto 0);
signal expTemp2: signed(7 downto 0);
signal expTemp3: signed(7 downto 0);
signal tempFraction_result : signed(24 downto 0);
signal tempFraction_result2 : signed(24 downto 0);
signal addFractionLSB : signed(24 downto 0) := (others => '0');
signal fraction_final : signed(24 downto 0);
signal Norm : signed(5 downto 0) := (others => '0');
signal tmpCarry1 : std_logic;
signal tmpCarry2 : std_logic;
signal tmpCarry3 : std_logic;
signal tmpCarry4 : std_logic;
signal tmpCarry5 : std_logic;
signal tmpCarry6 : std_logic;
signal zeroesCount : signed (5 downto 0);
signal SUBorADD: std_logic;
begin
----------------------------------------
    -- Floating point components extraction
    signA <= A(31);
    signB <= B(31);
    expA <=  A(30 downto 23);
    expB <=  B(30 downto 23);
    fractionA <= '0' & '1' & A(22 downto 0);
    fractionB <= '0' &'1' & B(22 downto 0);
    SUBorADD <= OPP xor A(31) xor B(31);

    -- Find the difference between the Exponent of A and B : expA - expB, default N=8 bits
    stage_0 : ADD_SUB
              port map ('1', expA, expB, expDiff, tmpCarry1);

    -- Find the max exponent, for the exponent component of the result
    stage_1 : MUX_Nbits generic map(8)
              port map (expDiff(7), expA, expB, expTemp);

    -- Exponent alligenment preparation : Prepare the fraction of the Number with the min exponent to be shifted
    -- if expDiff(7)=0 -> exponentA-exponentB > 0, shift right fraction B.
    stage_2 : Swap generic map (25)
              port map (expDiff(7), fractionA, fractionB, fraction1, fraction2_tmp);

    -- fraction alligenment : shift right the fraction of the Number with the min exp
    stage_3 : shift_unit generic map(25)
              port map ('1', fraction2_tmp, expDiff(5 downto 0), fraction2);

    -- Add/Sub the fractions, save the carry and the temp result for the next step
    stage_4 : ADD_SUB generic map(25)
              port map (SUBorADD, fraction1, fraction2, tempFraction_result, tmpCarry2);

    -- Normlize the fraction result
    stage_5 : LeadingZeros_counter generic map (25)
              port map(tempFraction_result,zeroesCount);
    stage_6 : shift_unit generic map(25)
              port map ('0', tempFraction_result, zeroesCount, tempFraction_result2);

    -- Correction to the fraction result, gain more accuracy (usualy more 0.00002 accuracy)
    addFractionLSB(0) <=  tempFraction_result2(0);
    stage_6_1 :  ADD_SUB generic map(25)
                 port map ('0', tempFraction_result2, addFractionLSB, fraction_final, tmpCarry6);

    SUM(22 downto 0) <= fraction_final(23 downto 1);

    -- Normlize the exponent acoording to the fraction normlzie <= exp = exp + (1-zeroesCount)
    stage_7 : ADD_SUB generic map(6)
              port map ('1', zeroesCount, "000001", Norm, tmpCarry3);

    stage_8 : ADD_SUB generic map (8)
              port map ('1', expTemp, "00" & Norm, expTemp2, tmpCarry4);-- if zeroesCount !=0

    stage_9 : ADD_SUB generic map (8)
              port map ('0', expTemp, "00000001", expTemp3, tmpCarry5);--if zeroesCount = 0

    -- if tempFraction_result2(24)=1 then zeroesCount=0 => exp = exp+1
    stage_10 : MUX_Nbits generic map(8)
              port map (tempFraction_result2(24), expTemp2, expTemp3, SUM(30 downto 23));

    --  Obtaining the sign
    SUM(31) <= ((tempFraction_result2(24) OR expDiff(7)) and (((not OPP) and signB) OR ((not signB) and OPP)))
                OR ((not expDiff(7)) and (not tempFraction_result2(24)) and signA);
----------------------------------------
end gate_level;

--EndOfFile
