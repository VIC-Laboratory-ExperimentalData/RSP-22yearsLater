* origina 1998 data; Contact Denis Cousineau.
data list list file='C:\Users\DenisCousineau\Documents\1_Publications\Mes Articles\_2_EnRevision\10_RSP\SPSS search analyses\search.out'
  /subject session scrap1 scrap2 block trial msize dsize type 
   isi order response rtac rtse rt.


CD "C:\Users\DenisCousineau\Desktop\RSP-2021".
SET format F8.0.

* all the NA are coverted to system missing.
DATA LIST file ="RSP22.tsv"  skip = 1 free
   /line * SessionDate (A10)	SessionTime	(TIME10.0) 
   Subject * 	Session	* RandomSeed	(F12.0) Procedure.Trial	(A10)
   Condition	* ISI	* Order	* DSize	* Response	* Cycle	* Sample	* DSet	(A4)
   ShowRSSPStimuli.ACC	* ShowRSSPStimuli.RT	*
   ShowSimStimuli.ACC	* ShowSimStimuli.RT	*
   ShowRSFPStimuli.ACC	* ShowRSFPStimuli.RT	* 
   StimSet (A15).
EXECUTE.

COMPUTE ACC = Mean(ShowRSSPStimuli.ACC, ShowRSFPStimuli.ACC, ShowSimStimuli.ACC).
COMPUTE error = 1 - ACC.
COMPUTE RT = Mean(ShowRSSPStimuli.RT, ShowRSFPStimuli.RT, ShowSimStimuli.RT).
EXECUTE.

DELETE VARIABLES ShowRSSPStimuli.ACC, ShowRSFPStimuli.ACC, ShowSimStimuli.ACC.
DELETE VARIABLES ShowRSSPStimuli.RT, ShowRSFPStimuli.RT, ShowSimStimuli.RT.

FORMATS Subject Session Dsize ISI Order Response (F3).

* DSize must be set to SCALE.
VARIABLE LEVEL Dsize (SCALE).

VARIABLE LABELS dsize 'Display size'
  /type     'Type of presentation'
  /isi      'Frame interval (ms)'
  /order    'Order of presentation'
  /response 'Response type'.

VALUE LABELS ACC 1 "Correct" 0 "Error".
VALUE LABELS type 10 "Simultaneous"
	      11 "SIM with 8 features"
	      12 "SIM without circles"
	      13 "SIM with cirlces shown with the first stimulus"
                  20 "SOP"
                  22 "SOP without circles"
                  23 "SOP with circles shown with the first stimulus"
                  30 "SFP"
	      31 "SFP with 8 features"
	      33 "SFP w/ reversed order for distractors"
	      34 "SFP never complete objects"
	      4   "SIM w/ twice as many circles"
	      5   "SIM w/ four times as many circles".
VALUE LABELS order 0 "simultaneous"
                   1 "Diag. first"
                   2 "Diag. last".
VALUE LABELS response 1 "Target present"
                   2 "Target absent".


******************************** learning curve **********************.

TEMPORARY.
SELECT IF (ACC = 1) and (Subject = 1).
GRAPH
  /LINE(MULTIPLE)=MEAN(RT) BY Session BY Response
  /INTERVAL CI(95).

***************************** end of training *************************.
TEMPORARY.
SELECT IF (session > 84) and (session <90) and (Condition = 10) and (ACC = 1).
GRAPH
  /LINE(MULTIPLE)=MEAN(RT) BY DSize BY Response
  /INTERVAL CI(95)
  /TITLE "Sessions 85 to 89 (Simultaneous)"
  /SUBTITLE "(end of retraining; correct only)".

TEMPORARY.
SELECT IF (session > 84) and (session <90) and (Condition = 10) .
GRAPH
  /LINE(MULTIPLE)=MEAN(error) BY DSize BY Response
  /INTERVAL CI(95)
  /TITLE "Sessions 85 to 89 (Simultaneous)"
  /SUBTITLE "(end of retraining; correct only)".

TEMPORARY.
SELECT IF (session > 84) and (session <90) and (Condition = 10) and (ACC = 1) and (Response =1).
REGRESSION variables = RT Dsize
  /dependent = RT  
  /method = enter.
TEMPORARY.
SELECT IF (session > 84) and (session <90) and (Condition = 10) and (ACC = 1) and (Response =2).
REGRESSION variables = RT Dsize
  /dependent = RT  
  /method = enter.


TEMPORARY.
SELECT IF (session > 84) and (session <90) and (Condition = 10) and (ACC = 1) and (Response =1).
GRAPH /histogram = RT
  /panel rowvar = Dsize.



***************************** end of RE-training *************************.

TEMPORARY.
SELECT IF (session > 99) and (session <105) and (Condition = 10) and (ACC = 1).
GRAPH
  /LINE(MULTIPLE)=MEAN(RT) BY DSize BY Response
  /INTERVAL CI(95)
  /TITLE "Sessions 100 to 104 (Simultaneous)"
  /SUBTITLE "(end of new training; correct only)".

TEMPORARY.
SELECT IF (session > 99) and (session < 105) and (Condition = 10) and (ACC = 1).
REGRESSION variables = RT Dsize
  /dependent = RT  
  /method = enter.










