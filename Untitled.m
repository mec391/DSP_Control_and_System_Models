
aa=[1, 1]; %denom
bb=[1 ]; %num (3-2z^-1 -1z^-2)
[h,w] = freqz(bb,aa,'whole',2001);

plot(w/pi,20*log10(abs(h)))
ax = gca;
ax.YLim = [-100 20];
ax.XTick = 0:.5:2;
xlabel('Normalized Frequency (\times\pi rad/sample)')
ylabel('Magnitude (dB)')