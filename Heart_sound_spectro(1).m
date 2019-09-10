clc;
clear;
%%%%%%%%%%%%%%%% NORMAL DATA READ %%%%%%%%%%%%%%%%%%%%%%%%%%
[normal1,fsNormal1] = audioread('normal_heart_sound.mp3');
[normal2,fsNormal2] = audioread('normal.mp3');
[normal3,fsNormal3] = audioread('a0012.wav');
%[normal4,fsNormal4] = audioread('b0001.wav');
[normal4,fsNormal4] = audioread('c0003.wav');
%[normal6,fsNormal6] = audioread('d0013.wav');
%[normal7,fsNormal7] = audioread('e00007.wav');
[normal5,fsNormal5] = audioread('f0001.wav');
[normal6,fsNormal6] = audioread('5-Normal-sounds.mp3');
[normal7,fsNormal7] = audioread('01_apex_normal_s1_s2_supine_bell.mp3');

minSize = 61719;
%%%%%%%%%%%%%%%% UNIFYING THE SIZE TO THE SMALLEST ONE %%%%%%%%%%%%%%%%%%%%%%%%%%%
normal1 = normal1(1:minSize,1);
normal2 = normal2(1:minSize,1);
normal3 = normal3(1:minSize,1);
%normal4 = normal4(:,1);
normal4 = normal4(1:minSize,1);
%normal6 = normal6(1:16000,1);
%normal7 = normal7(1:16000,1);
normal5 = normal5(1:minSize,1);
normal6 = normal6(1:minSize,1);
normal7 = normal7(1:minSize,1);

%%%%%%%%%%%%%%%% ALIGNING DATA %%%%%%%%%%%%%%%%%%%%%%%
s1 = alignsignals(normal1,normal7);
s2 = alignsignals(normal2,normal7);
s3 = alignsignals(normal3,normal7);
%s4 = alignsignals(normal4,normal10);
s4 = alignsignals(normal4,normal7);
%s6 = alignsignals(normal6,normal10);
%s7 = alignsignals(normal7,normal10);
s5 = alignsignals(normal5,normal7);
s6 = alignsignals(normal6,normal7);
s7 = normal7;

%%%%%%%%%%%%%%%% UNIFYING THE SIZE TO THE SMALLEST ONE %%%%%%%%%%%%%%%%%%%%%%%%%%%
S_normal1 = s1(1:minSize,1);
S_normal2 = s2(1:minSize,1);
S_normal3 = s3(1:minSize,1);
%S_normal4 = s4(1:minSize,1);
S_normal4 = s4(1:minSize,1);
%S_normal6 = s6(1:16000,1);
%S_normal7 = s7(1:16000,1);
S_normal5 = s5(1:minSize,1);
S_normal6 = s6(1:minSize,1);
S_normal7 = s7(1:minSize,1);

%%%%%%%%%%%%%%%% AVERAGING %%%%%%%%%%%%%%%%%%%%%%%%%
%normal_signals = [S_normal1;S_normal2;S_normal3;S_normal4;S_normal5;S_normal6;S_normal7];
%Avg_normal = mean(normal_signals,2);
%save('Avg_normal.mat','Avg_normal')


%Avg_normal = (S_normal1 + S_normal2 + S_normal3 + S_normal4 + S_normal5 + S_normal6 + S_normal7)/7;

%sound (Avg_normal)
normal_signals ={S_normal1,S_normal2,S_normal3,S_normal4,S_normal5,S_normal6,S_normal7};
concat=cat(2,normal_signals{:});
Avg_normal=mean(concat,2);

%%%%%%%%%%%%%%%% SPECTROGRAM & PEAKS %%%%%%%%%%%%%%%%%%%%%%%% 
[normalS,normalW,normalT] = spectrogram(Avg_normal,1000,100);
 
figure;
spectrogram(Avg_normal,'yaxis');
[normal_rows, normal_columns] = size(normalS); 
for i=1:normal_columns
    [pks,idx] = findpeaks(abs(normalS(:,i)));
    [rows,columns] = size(pks);
    normal_peaks(1:rows,i) = pks;
end
%CS = circshift(normalS, [0,1]); 
%P = (normalS > CS);+

%%%%%%%%%%%%%%%% TEST DATA USING CORRELATION %%%%%%%%%%%%%%%%
[normaltest,fsNormaltest] = audioread('063-Shakira - Try Everything.mp3');
normaltest = normaltest(:,1);
normaltest = normaltest(1:minSize,1);
test_align = alignsignals(normaltest,normal1);
test_align = test_align(1:minSize,1);

[normaltestS,normaltestW,normaltestT] = spectrogram(test_align,1000,100);
[testSpectro_rows, testSpectro_columns] = size(normaltestS);
for i=1:testSpectro_columns
    [test_pks,test_idx] = findpeaks(abs(normaltestS(:,i)));
    [test_rows,test_columns] = size(test_pks);
    test_peaks(1:test_rows,i) = test_pks;
end
[test_rows_final, test_columns_final] = size(test_peaks);
%normal_cut = normaltestS(1:513,1:2642);
normal_peaks = normal_peaks(1:test_rows_final, 1:test_columns_final);
cc = corrcoef(test_peaks, normal_peaks); 
coef = abs(cc(1,2))
%x=load('Avg_normal')

%%%%%%%%%%%%%%%% Stenosis DATA READ %%%%%%%%%%%%%%%%%%%%%%%%%%
[stenosis1,fs_stenosis1] = audioread('4-Aortic-stenosis-and-regurgitation.mp3');
[stenosis2,fs_stenosis2] = audioread('16_aortic_early_dias_mur_sitting_bell.mp3');
[stenosis3,fs_stenosis3] = audioread('17_aortic_sys__dias_mur_sitting_bell.mp3');
[stenosis4,fs_stenosis4] = audioread('Aortic Stenosis - Severe 2 26.mp3');
[stenosis5,fs_stenosis5] = audioread('Aortic Stenosis -Mild 26.mp3');
[stenosis6,fs_stenosis6] = audioread('AS_late.mp3');
[stenosis7,fs_stenosis7] = audioread('as-early.mp3');
%[stenosis8,fs_stenosis8] = audioread('murmur.mp3');

%%%%%%%%%%%%%%%% UNIFYING THE SIZE TO THE SMALLEST ONE %%%%%%%%%%%%%%%%%%%%%%%%%%%
stenosis1 = stenosis1(1:minSize,1);
stenosis2 = stenosis2(1:minSize,1);
stenosis3 = stenosis3(1:minSize,1);
stenosis4 = stenosis4(1:minSize,1);
stenosis5 = stenosis5(1:minSize,1);
stenosis6 = stenosis6(1:minSize,1);
stenosis7 = stenosis7(1:minSize,1);

%%%%%%%%%%%%%%%% ALIGNING DATA %%%%%%%%%%%%%%%%%%%%%%%
s1 = alignsignals(stenosis1,stenosis7);
s2 = alignsignals(stenosis2,stenosis7);
s3 = alignsignals(stenosis3,stenosis7);
%s4 = alignsignals(stenosis4,stenosis10);
s4 = alignsignals(stenosis4,stenosis7);
%s6 = alignsignals(stenosis6,stenosis10);
%s7 = alignsignals(stenosis7,stenosis10);
s5 = alignsignals(stenosis5,stenosis7);
s6 = alignsignals(stenosis6,stenosis7);
s7 = stenosis7;

%%%%%%%%%%%%%%%% UNIFYING THE SIZE TO THE SMALLEST ONE %%%%%%%%%%%%%%%%%%%%%%%%%%%
S_stenosis1 = s1(1:minSize,1);
S_stenosis2 = s2(1:minSize,1);
S_stenosis3 = s3(1:minSize,1);
%S_stenosis4 = s4(1:minSize,1);
S_stenosis4 = s4(1:minSize,1);
%S_stenosis6 = s6(1:16000,1);
%S_stenosis7 = s7(1:16000,1);
S_stenosis5 = s5(1:minSize,1);
S_stenosis6 = s6(1:minSize,1);
S_stenosis7 = s7(1:minSize,1);

%%%%%%%%%%%%%%%% AVERAGING %%%%%%%%%%%%%%%%%%%%%%%%%
% stenosis_signals = [S_stenosis1;S_stenosis2;S_stenosis3;S_stenosis4;S_stenosis5;S_stenosis6;S_stenosis7];
% Avg_stenosis = mean(stenosis_signals,2);
% save('Avg_stenosis.mat','Avg_stenosis')
%Avg_stenosis = (S_stenosis1 + S_stenosis2 + S_stenosis3 + S_stenosis4 + S_stenosis5 + S_stenosis6 + S_stenosis7)/7;
stenosis_signals ={S_stenosis1,S_stenosis2,S_stenosis3,S_stenosis4,S_stenosis5,S_stenosis6,S_stenosis7};
concat=cat(2,stenosis_signals{:});
Avg_stenosis=mean(concat,2);
%%%%%%%%%%%%%%%% SPECTROGRAM & PEAKS %%%%%%%%%%%%%%%%%%%%%%%% 
[stenosisS,stenosisW,stenosisT] = spectrogram(Avg_stenosis,1000,100);
 
figure;
spectrogram(Avg_stenosis,'yaxis');
[stenosis_rows, stenosis_columns] = size(stenosisS); 
for i=1:stenosis_columns
    [pks,idx] = findpeaks(abs(stenosisS(:,i)));
    [rows,columns] = size(pks);
    stenosis_peaks(1:rows,i) = pks;
end
%CS = circshift(stenosisS, [0,1]); 
%P = (stenosisS > CS);+

%%%%%%%%%%%%%%%% TEST DATA USING CORRELATION %%%%%%%%%%%%%%%%
[stenosistest,fsstenosistest] = audioread('063-Shakira - Try Everything.mp3');
stenosistest = stenosistest(:,1);
stenosistest = stenosistest(1:minSize,1);
test_align = alignsignals(stenosistest,stenosis1);
test_align = test_align(1:minSize,1);

[stenosistestS,stenosistestW,stenosistestT] = spectrogram(test_align,1000,100);
[testSpectro_rows, testSpectro_columns] = size(stenosistestS);
for i=1:testSpectro_columns
    [test_pks,test_idx] = findpeaks(abs(stenosistestS(:,i)));
    [test_rows,test_columns] = size(test_pks);
    test_peaks(1:test_rows,i) = test_pks;
end
[test_rows_final, test_columns_final] = size(test_peaks);
%stenosis_cut = stenosistestS(1:513,1:2642);
stenosis_peaks = stenosis_peaks(1:test_rows_final, 1:test_columns_final);
cc = corrcoef(test_peaks, stenosis_peaks); 
coef = abs(cc(1,2))
%x=load('Avg_stenosis')

%%%%%%%%%%%%%%%% ASD DATA READ %%%%%%%%%%%%%%%%%%%%%%%%%%
[ASD1,fs_ASD1] = audioread('1-ASD.mp3');
[ASD2,fs_ASD2] = audioread('7-ASD.mp3');
[ASD3,fs_ASD3] = audioread('Atrial Septal Defect 29.mp3');
[ASD4,fs_ASD4] = audioread('Atrial septal defect.mp3');
%%%%%%%%%%%%%%%% UNIFYING THE SIZE TO THE SMALLEST ONE %%%%%%%%%%%%%%%%%%%%%%%%%%%
ASD1 = ASD1(1:minSize,1);
ASD2 = ASD2(1:minSize,1);
ASD3 = ASD3(1:minSize,1);
ASD4 = ASD4(1:minSize,1);

%%%%%%%%%%%%%%%% ALIGNING DATA %%%%%%%%%%%%%%%%%%%%%%%
A1 = alignsignals(ASD1,ASD4);
A2 = alignsignals(ASD2,ASD4);
A3 = alignsignals(ASD3,ASD4);
A4 = alignsignals(ASD4,ASD4);



%%%%%%%%%%%%%%%% UNIFYING THE SIZE TO THE SMALLEST ONE %%%%%%%%%%%%%%%%%%%%%%%%%%%
S_ASD1 = s1(1:minSize,1);
S_ASD2 = s2(1:minSize,1);
S_ASD3 = s3(1:minSize,1);
%S_ASD4 = s4(1:minSize,1);
S_ASD4 = s4(1:minSize,1);

%%%%%%%%%%%%%%%% AVERAGING %%%%%%%%%%%%%%%%%%%%%%%%%
% ASD_signals = [S_ASD1;S_ASD2;S_ASD3;S_ASD4];
% Avg_ASD = mean(ASD_signals,2);
% save('Avg_ASD.mat','Avg_ASD')
%Avg_ASD = (S_ASD1 + S_ASD2 + S_ASD3 + S_ASD4 )/4;
ASD_signals = {S_ASD1,S_ASD2,S_ASD3,S_ASD4};
concat=cat(2,ASD_signals{:});
Avg_ASD = mean(concat,2);


%%%%%%%%%%%%%%%% SPECTROGRAM & PEAKS %%%%%%%%%%%%%%%%%%%%%%%% 
[ASDS,ASDW,ASDT] = spectrogram(Avg_ASD,1000,100);
 
figure;
spectrogram(Avg_ASD,'yaxis');
[ASD_rows, ASD_columns] = size(ASDS); 
for i=1:ASD_columns
    [pks,idx] = findpeaks(abs(ASDS(:,i)));
    [rows,columns] = size(pks);
    ASD_peaks(1:rows,i) = pks;
end
%CS = circshift(ASDS, [0,1]); 
%P = (ASDS > CS);+

%%%%%%%%%%%%%%%% TEST DATA USING CORRELATION %%%%%%%%%%%%%%%%
[ASDtest,fsASDtest] = audioread('063-Shakira - Try Everything.mp3');
ASDtest = ASDtest(:,1);
ASDtest = ASDtest(1:minSize,1);
test_align = alignsignals(ASDtest,ASD1);
test_align = test_align(1:minSize,1);

[ASDtestS,ASDtestW,ASDtestT] = spectrogram(test_align,1000,100);
[testSpectro_rows, testSpectro_columns] = size(ASDtestS);
for i=1:testSpectro_columns
    [test_pks,test_idx] = findpeaks(abs(ASDtestS(:,i)));
    [test_rows,test_columns] = size(test_pks);
    test_peaks(1:test_rows,i) = test_pks;
end
[test_rows_final, test_columns_final] = size(test_peaks);
%ASD_cut = ASDtestS(1:513,1:2642);
ASD_peaks = ASD_peaks(1:test_rows_final, 1:test_columns_final);
cc = corrcoef(test_peaks, ASD_peaks); 
coef = abs(cc(1,2))
%x=load('Avg_ASD')

c = containers.Map;
c('Avg_normal') = Avg_normal;
c('Avg_stenosis') = Avg_stenosis;
c('AVg_ASD') = Avg_ASD;
c('normal_peaks') = normal_peaks;
c('stenosis_peaks') = stenosis_peaks;
c('ASD_peaks') = ASD_peaks;

save('Data.mat','c');
% %it is essential to ensure that they have identical sampling rates. 
% %The safest way to do this is to resample the signal with a lower sampling rate. 
% %The resample function applies an anti-aliasing(low-pass) FIR filter to the signal during the resampling process.
% 
% %[P1,Q1] = rat(44100/fsNormal);          % Rational fraction approximation
% %[P2,Q2] = rat(44100/fsNormaltest);          % Rational fraction approximation
% %T1 = resample(normalT,P1,Q1);        % Change sampling rate by rational factor
% %T2 = resample(normaltestT,P2,Q2);        % Change sampling rate by rational factor
% 
% %[c,lags] = xcorr(normal,normaltest);