function  w_s = soft(sigma,thld)
          w_s = sign(sigma).*max(0,abs(sigma)-thld); 
end