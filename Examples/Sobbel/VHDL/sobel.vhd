library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity sobel_edge_detection is
    port ( 
    clk         : in std_logic;                      -- clock signal
    rst         : in std_logic;                      -- reset signal
    pixel_in    : in std_logic_vector(7 downto 0);   -- 8-bit grayscale input pixel
    pixel_valid : in std_logic;                      -- pixel validity signal
    pixel_out   : out std_logic_vector(7 downto 0);  -- 8-bit output pixel (edge detected)
    edge_valid  : out std_logic);                    -- edge detection valid signal
end sobel_edge_detection;

architecture behavioral of sobel_edge_detection is

    -- sobel kernels for horizontal and vertical edge detection
    type kernel is array(0 to 8) of integer;
    
    constant sobel_x : kernel := (-1, 0, 1, -2, 0, 2, -1, 0, 1);  -- horizontal kernel
    constant sobel_y : kernel := (1, 2, 1, 0, 0, 0, -1, -2, -1);  -- vertical kernel

    -- signal declarations
    signal pixel_data : array(0 to 8) of std_logic_vector(7 downto 0); -- buffer for 3x3 pixels
    signal gx, gy     : integer := 0; -- gradients in x and y direction
    signal edge_magnitude : integer := 0; -- final edge magnitude

begin

    -- process that applies sobel filter on the image
    process(clk, rst)
    begin
        if rst = '1' then
            -- reset state
            pixel_data <= (others => (others => '0'));
            gx <= 0;
            gy <= 0;
            edge_magnitude <= 0;
            pixel_out <= (others => '0');
            edge_valid <= '0';
        elsif rising_edge(clk) then
            if pixel_valid = '1' then
                -- shift the pixel buffer to make room for the new pixel
                for i in 1 to 7 loop
                    pixel_data(i) <= pixel_data(i - 1);
                end loop;
                pixel_data(0) <= pixel_in;
                
                -- apply the sobel operator (horizontal and vertical)
                gx := 0;
                gy := 0;
                
                -- apply the sobel filters (kernels)
                for i in 0 to 8 loop
                    gx := gx + to_integer(signed(pixel_data(i))) * sobel_x(i);
                    gy := gy + to_integer(signed(pixel_data(i))) * sobel_y(i);
                end loop;
                
                -- compute the edge magnitude (euclidean norm)
                edge_magnitude := integer'sqrt(gx * gx + gy * gy);
                
                -- saturate the result to 8 bits
                if edge_magnitude > 255 then
                    pixel_out <= "11111111"; -- saturate to 255 if the result is above 255
                else
                    pixel_out <= std_logic_vector(to_unsigned(edge_magnitude, 8));
                end if;
                
                -- indicate that the edge detection is valid
                edge_valid <= '1';
            else
                edge_valid <= '0';
            end if;
        end if;
    end process;

end behavioral;
