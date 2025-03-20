library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity tb_sobel_edge_detection is
end tb_sobel_edge_detection;

architecture behavior of tb_sobel_edge_detection is

    -- component declaration for the unit under test (uut)
    component sobel_edge_detection
        port ( clk        : in std_logic;
               rst        : in std_logic;
               pixel_in   : in std_logic_vector(7 downto 0);
               pixel_valid : in std_logic;
               pixel_out  : out std_logic_vector(7 downto 0);
               edge_valid : out std_logic);
    end component;

    -- signal declarations for the testbench
    signal clk        : std_logic := '0';                -- clock signal
    signal rst        : std_logic := '0';                -- reset signal
    signal pixel_in   : std_logic_vector(7 downto 0);    -- input pixel data
    signal pixel_valid : std_logic := '0';               -- pixel validity signal
    signal pixel_out  : std_logic_vector(7 downto 0);    -- output pixel data
    signal edge_valid : std_logic;                        -- edge detection valid signal

    -- clock generation process
    process
    begin
        clk <= not clk after 10 ns; -- clock period of 20ns (50 mhz)
        wait for 10 ns;
    end process;

begin
    -- instantiate the unit under test (uut)
    uut: sobel_edge_detection
        port map ( clk => clk,
                   rst => rst,
                   pixel_in => pixel_in,
                   pixel_valid => pixel_valid,
                   pixel_out => pixel_out,
                   edge_valid => edge_valid );

    -- test process
    process
    begin
        -- reset the uut
        rst <= '1';
        wait for 20 ns;
        rst <= '0';
        wait for 20 ns;

        -- start feeding in pixel data
        -- test with a simple 3x3 image, where each pixel is an 8-bit value
        -- pixel values are arbitrary for the test case

        -- apply first pixel and mark it valid
        pixel_in <= "00011001"; -- 25 in decimal
        pixel_valid <= '1';
        wait for 20 ns;  -- wait for 1 clock cycle

        -- apply second pixel
        pixel_in <= "00011010"; -- 26 in decimal
        wait for 20 ns;

        -- apply third pixel
        pixel_in <= "00101011"; -- 43 in decimal
        wait for 20 ns;

        -- continue applying other pixels to fill a 3x3 window
        pixel_in <= "01111000"; -- 120 in decimal
        wait for 20 ns;

        pixel_in <= "01000011"; -- 67 in decimal
        wait for 20 ns;

        pixel_in <= "00100110"; -- 38 in decimal
        wait for 20 ns;

        pixel_in <= "00011011"; -- 27 in decimal
        wait for 20 ns;

        pixel_in <= "00110001"; -- 49 in decimal
        wait for 20 ns;

        pixel_in <= "01001000"; -- 72 in decimal
        wait for 20 ns;

        -- mark pixel_valid low after sending all pixels
        pixel_valid <= '0';
        wait for 40 ns;  -- allow some time for the edge detection to complete

        -- end of test
        wait;
    end process;

end behavior;
