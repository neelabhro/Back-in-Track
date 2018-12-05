c=Buffer.read(s,"C:/Users/anant/Downloads/Coldplay_-_Viva_La_Vida-dvgZkm1xWPE.wav");
b=Buffer.read(s,"C:/Users/anant/Downloads/Coldplay_-_A_Sky_Full_of_Stars_Lyrics-LR73DrKX_bs.wav");
a=Buffer.alloc(s, s.sampleRate * b.duration, 1);
(
a= SynthDef(\help_autotrack,{arg vol=1.0, beepvol=1.0, lock=0;
var trackb,trackh,trackq,tempo;
var trackb1,trackh1,trackq1,tempo1;
var source, beep,source1;
var inputfft, outputfft;

source= PlayBuf.ar(1,c.bufnum,1.0,1,0,1);

inputfft = FFT(LocalBuf(1024), source);

#trackb,trackh,trackq,tempo=BeatTrack.kr(inputfft, lock);

source1= PlayBuf.ar(1,b.bufnum,1.0,1,0,1);

outputfft = FFT(LocalBuf(1024), source1);

#trackb1,trackh1,trackq1,tempo1 = BeatTrack.kr(outputfft, lock);

source1 = PlayBuf.ar(1, b.bufnum, tempo/tempo1,1, 0,0,1);

beep = SinOsc.ar(1000,0.0,Decay.kr(trackb,0.1));

RecordBuf.ar(source1, a.bufnum);

	// Out.ar(0,Pan2.ar((vol*source1)+(beepvol*beep)+(vol*source/5),0.0));

Out.ar(0,Pan2.ar((vol*source1)),0.0);

}).play;
)

s.prepareForRecord; // you have to call this first

s.record;

s.pauseRecording; // pausable

s.record // start again

s.stopRecording;