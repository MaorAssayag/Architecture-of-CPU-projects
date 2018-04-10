flag_handle : process
      variable FLAGS : std_logic_vector(5 downto 0) := "000000";
      begin
      if (addORsub = '1') then
        FLAG <= FLAGS; -- will assign at the end of process
        FLAGS(0) := '1'; -- is A=B ?
        wait on tempSUM;
        eachBit: for i in 0 to (N-1) loop
          FLAGS(0) := (FLAGS(0) AND (NOT tempSUM(i)));
        end loop;
        FLAGS(1) := NOT FLAGS(0); -- A!=B
        FLAGS(2) := NOT tempSUM(N-1);--A >= B if tempSUM(N-1)=0 then
        FLAGS(3) := FLAGS(2) AND FLAGS(1); -- A>B if A>=B & A!=B
        FLAGS(4) := NOT FLAGS(3);-- A<=B if !(A>B)
        FLAGS(5) := FLAGS(4) AND FLAGS(1); -- A<B if (A<=B & A!=B)
      end if;
  end process flag_handle;
