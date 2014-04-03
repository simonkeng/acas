((exports) ->

	exports.curveCuratorThumbs =
		sortOptions: [

			code: "compoundCode"
			name: "Compound Name"
		,
			code: "EC50"
			name: "EC50"
		,
			code: "SST"
			name: "SST"
		,
			code: "SSE"
			name: "SSE"
		,
			code: "rsquare"
			name: "R^2"
		]
		curves: [
			curveid: "90807_AG-00000026"
			algorithmApproved: true
			userApproved: true
			category: "Active"
			curveAttributes:
				EC50: .05
				SST: 9
				SSE: .8
				rsquare: .95
				compoundCode: "CMPD-0000008"
		,
			curveid: "126925_AG-00000237"
			algorithmApproved: true
			userApproved: false
			category: "Active"
			curveAttributes:
				EC50: .06
				SST: 10
				SSE: .9
				rsquare: .96
				compoundCode: "CMPD-0000002"
		,
			curveid: "126869_AG-00000231"
			algorithmApproved: true
			userApproved: true
			category: "Active"
			curveAttributes:
				EC50: .07
				SST: 11
				SSE: .1
				rsquare: .97
				compoundCode: "CMPD-0000003"
		,
			curveid: "126907_AG-00000232"
			algorithmApproved: false
			#userApproved: if not user approved yet, don't send this variable
			category: "Inactive"
			curveAttributes:
				EC50: .08
				SST: 12
				SSE: .11
				rsquare: .98
				compoundCode: "CMPD-0000004"
		,
			curveid: "126907_AG-00000233"
			algorithmApproved: true
			category: "Inactive"
			curveAttributes:
				EC50: .05
				SST: 9
				SSE: .8
				rsquare: .95
				compoundCode: "CMPD-0000005"
		,
			curveid: "126907_AG-00000234"
			algorithmApproved: true
			category: "Inactive"
			curveAttributes:
				EC50: .03
				SST: 9
				SSE: .8
				rsquare: .95
				compoundCode: "CMPD-0000006"
		,
			curveid: "126907_AG-00000235"
			compoundCode: "CMPD-0000007"
			algorithmApproved: true
			category: "Sigmoid"
			curveAttributes:
				EC50: .02
				SST: 9
				SSE: .8
				rsquare: .95
				compoundCode: "CMPD-0000007"
		,
			curveid: "126907_AG-00000236"
			algorithmApproved: true
			category: "Sigmoid"
			curveAttributes:
				EC50: .01
				SST: 9
				SSE: .8
				rsquare: .95
				compoundCode: "CMPD-0000001"
		,
			curveid: "126907_AG-00000239"
			algorithmApproved: true
			userApproved: null
			category: "Sigmoid"
			curveAttributes:
				EC50: .005
				SST: 9
				SSE: .8
				rsquare: .95
				compoundCode: "CMPD-0000009"
		]


	exports.curveStubs = [
		curveid: "90807_AG-00000026"
		status: "pass"
		category: "active"
	,
		curveid: "126925_AG-00000233"
		status: "pass"
		category: "active"
	,
		curveid: "126869_AG-00000231"
		status: "fail"
		category: "active"
	,
		curveid: "126907_AG-00000232"
		status: "pass"
		category: "inactive"
	]

#	exports.curveDetail  =
#		fiteParameters: "copy form experiment test jsons"
#		div1
#		div2
#	  div3
#		div4
#	  plotParams
#	  sessionID
#		curveid: "126907_AG-00000239"
#		algorithmApproved: true
#		userApproved: null
#		category: "Sigmoid"
#		curveAttributes:
#			EC50: .005
#			SST: 9
#			SSE: .8
#			rsquare: .95
#			compoundCode: "CMPD-0000009"

	exports.curveDetail =
		blah =
			reportedValues: "<TABLE >\n<TR> <TH> name </TH> <TH> value </TH>  </TR>\n  <TR> <TD> min </TD> <TD align=\"right\"> -40.34 </TD> </TR>\n  <TR> <TD> max </TD> <TD align=\"right\"> 88.85 </TD> </TR>\n  <TR> <TD> slope </TD> <TD align=\"right\"> 0.83 </TD> </TR>\n  <TR> <TD> ec50 </TD> <TD align=\"right\"> 0.33 </TD> </TR>\n   </TABLE>\n"
			fitSummary: "Model fitted: Log-logistic (ED50 as parameter) (4 parms)Parameter estimates:                   Estimate Std. Error   t-value p-valueslope:(Intercept)  -0.82592    0.22130  -3.73203  0.0007min:(Intercept)   -40.34298   19.85547  -2.03183  0.0496max:(Intercept)    95.79625    7.02167  13.64293  0.0000ec50:(Intercept)    0.33409    0.12607   2.65002  0.0119Residual standard error: 10.83299 (36 degrees of freedom)"
			parameterStdErrors: "<TABLE >\n<TR> <TH> name </TH> <TH> pValue </TH> <TH> stdErr </TH> <TH> tValue </TH>  </TR>\n  <TR> <TD> ec50 </TD> <TD align=\"right\"> 0.01 </TD> <TD align=\"right\"> 0.13 </TD> <TD align=\"right\"> 2.65 </TD> </TR>\n  <TR> <TD> max </TD> <TD align=\"right\"> 0.00 </TD> <TD align=\"right\"> 7.02 </TD> <TD align=\"right\"> 13.64 </TD> </TR>\n  <TR> <TD> min </TD> <TD align=\"right\"> 0.05 </TD> <TD align=\"right\"> 19.86 </TD> <TD align=\"right\"> -2.03 </TD> </TR>\n  <TR> <TD> slope </TD> <TD align=\"right\"> 0.00 </TD> <TD align=\"right\"> 0.22 </TD> <TD align=\"right\"> -3.73 </TD> </TR>\n   </TABLE>\n"
			curveErrors: "<TABLE >\n<TR> <TH> name </TH> <TH> V1 </TH>  </TR>\n  <TR> <TD> SSE </TD> <TD align=\"right\"> 4224.73 </TD> </TR>\n  <TR> <TD> SST </TD> <TD align=\"right\"> 65852.81 </TD> </TR>\n  <TR> <TD> rSquared </TD> <TD align=\"right\"> 0.94 </TD> </TR>\n   </TABLE>\n"
			category: "Failed maxUncertaintyRule"
			algorithmApproved: true
			curveAttributes:
				EC50: 0.334089617553989
				Operator: null
				SST: 65852.8104
				SSE: 4224.73357696757
				rSquared: 0.935845812026762
				compoundCode: "CMPD-0000007-01"
			sessionID: "/var/folders/5b/s62pqy655kx6929zhxrml5c80000gn/T//rSe-27a632eeddad"
			plotData:
				plotWindow: [
					-3.91202300542815
					99.1928
					3.40119738166216
					-46.9528
				]
				points: [
					{
						response_sv_id: 14383
						dose: 0.31
						doseUnits: "uM"
						response: 8.79
						responseUnits: "efficacy"
						flag: "NA"
					}
					{
						response_sv_id: 14384
						dose: 0.31
						doseUnits: "uM"
						response: 24.24
						responseUnits: "efficacy"
						flag: "NA"
					}
					{
						response_sv_id: 14387
						dose: 0.31
						doseUnits: "uM"
						response: 46.43
						responseUnits: "efficacy"
						flag: "NA"
					}
					{
						response_sv_id: 14390
						dose: 0.31
						doseUnits: "uM"
						response: 24.97
						responseUnits: "efficacy"
						flag: "NA"
					}
					{
						response_sv_id: 14395
						dose: 1.25
						doseUnits: "uM"
						response: 60.53
						responseUnits: "efficacy"
						flag: "NA"
					}
					{
						response_sv_id: 14398
						dose: 1.25
						doseUnits: "uM"
						response: 67.27
						responseUnits: "efficacy"
						flag: "NA"
					}
					{
						response_sv_id: 14401
						dose: 1.25
						doseUnits: "uM"
						response: 59.57
						responseUnits: "efficacy"
						flag: "NA"
					}
					{
						response_sv_id: 14406
						dose: 1.25
						doseUnits: "uM"
						response: 63.11
						responseUnits: "efficacy"
						flag: "NA"
					}
					{
						response_sv_id: 14411
						dose: 10
						doseUnits: "uM"
						response: 88.22
						responseUnits: "efficacy"
						flag: "NA"
					}
					{
						response_sv_id: 14412
						dose: 10
						doseUnits: "uM"
						response: 85.81
						responseUnits: "efficacy"
						flag: "NA"
					}
					{
						response_sv_id: 14417
						dose: 10
						doseUnits: "uM"
						response: 93.78
						responseUnits: "efficacy"
						flag: "NA"
					}
					{
						response_sv_id: 14420
						dose: 10
						doseUnits: "uM"
						response: 87.6
						responseUnits: "efficacy"
						flag: "NA"
					}
					{
						response_sv_id: 14423
						dose: 0.04
						doseUnits: "uM"
						response: -0.14
						responseUnits: "efficacy"
						flag: "NA"
					}
					{
						response_sv_id: 14428
						dose: 0.04
						doseUnits: "uM"
						response: -18.23
						responseUnits: "efficacy"
						flag: "NA"
					}
					{
						response_sv_id: 14431
						dose: 0.04
						doseUnits: "uM"
						response: -41.54
						responseUnits: "efficacy"
						flag: "NA"
					}
					{
						response_sv_id: 14432
						dose: 0.04
						doseUnits: "uM"
						response: -37.16
						responseUnits: "efficacy"
						flag: "NA"
					}
					{
						response_sv_id: 14439
						dose: 2.5
						doseUnits: "uM"
						response: 74.91
						responseUnits: "efficacy"
						flag: "NA"
					}
					{
						response_sv_id: 14440
						dose: 2.5
						doseUnits: "uM"
						response: 82.21
						responseUnits: "efficacy"
						flag: "NA"
					}
					{
						response_sv_id: 14445
						dose: 2.5
						doseUnits: "uM"
						response: 69.91
						responseUnits: "efficacy"
						flag: "NA"
					}
					{
						response_sv_id: 14446
						dose: 2.5
						doseUnits: "uM"
						response: 71.88
						responseUnits: "efficacy"
						flag: "NA"
					}
					{
						response_sv_id: 14451
						dose: 0.08
						doseUnits: "uM"
						response: 4.3
						responseUnits: "efficacy"
						flag: "NA"
					}
					{
						response_sv_id: 14456
						dose: 0.08
						doseUnits: "uM"
						response: -10.87
						responseUnits: "efficacy"
						flag: "NA"
					}
					{
						response_sv_id: 14459
						dose: 0.08
						doseUnits: "uM"
						response: 23.68
						responseUnits: "efficacy"
						flag: "NA"
					}
					{
						response_sv_id: 14462
						dose: 0.08
						doseUnits: "uM"
						response: -22.66
						responseUnits: "efficacy"
						flag: "NA"
					}
					{
						response_sv_id: 14465
						dose: 20
						doseUnits: "uM"
						response: 89.01
						responseUnits: "efficacy"
						flag: "NA"
					}
					{
						response_sv_id: 14470
						dose: 20
						doseUnits: "uM"
						response: 85.97
						responseUnits: "efficacy"
						flag: "NA"
					}
					{
						response_sv_id: 14473
						dose: 20
						doseUnits: "uM"
						response: 90.3
						responseUnits: "efficacy"
						flag: "NA"
					}
					{
						response_sv_id: 14474
						dose: 20
						doseUnits: "uM"
						response: 85.75
						responseUnits: "efficacy"
						flag: "NA"
					}
					{
						response_sv_id: 14481
						dose: 0.16
						doseUnits: "uM"
						response: -8.56
						responseUnits: "efficacy"
						flag: "NA"
					}
					{
						response_sv_id: 14484
						dose: 0.16
						doseUnits: "uM"
						response: 4.81
						responseUnits: "efficacy"
						flag: "NA"
					}
					{
						response_sv_id: 14485
						dose: 0.16
						doseUnits: "uM"
						response: 13.68
						responseUnits: "efficacy"
						flag: "NA"
					}
					{
						response_sv_id: 14488
						dose: 0.16
						doseUnits: "uM"
						response: 12.67
						responseUnits: "efficacy"
						flag: "NA"
					}
					{
						response_sv_id: 14495
						dose: 0.63
						doseUnits: "uM"
						response: 44.35
						responseUnits: "efficacy"
						flag: "NA"
					}
					{
						response_sv_id: 14496
						dose: 0.63
						doseUnits: "uM"
						response: 38
						responseUnits: "efficacy"
						flag: "NA"
					}
					{
						response_sv_id: 14499
						dose: 0.63
						doseUnits: "uM"
						response: 50.19
						responseUnits: "efficacy"
						flag: "NA"
					}
					{
						response_sv_id: 14502
						dose: 0.63
						doseUnits: "uM"
						response: 31.82
						responseUnits: "efficacy"
						flag: "NA"
					}
					{
						response_sv_id: 14509
						dose: 5
						doseUnits: "uM"
						response: 87.38
						responseUnits: "efficacy"
						flag: "NA"
					}
					{
						response_sv_id: 14512
						dose: 5
						doseUnits: "uM"
						response: 81.93
						responseUnits: "efficacy"
						flag: "NA"
					}
					{
						response_sv_id: 14513
						dose: 5
						doseUnits: "uM"
						response: 93.45
						responseUnits: "efficacy"
						flag: "NA"
					}
					{
						response_sv_id: 14516
						dose: 5
						doseUnits: "uM"
						response: 82.44
						responseUnits: "efficacy"
						flag: "NA"
					}
				]
				curve: [
					{
						dose: 0.04
						response: -20.2400032371294
					}
					{
						dose: 1.54957983193277
						response: 65.8821382871788
					}
					{
						dose: 16.6453781512605
						response: 90.6062811114323
					}
					{
						dose: 16.8131092436975
						response: 90.6474626024016
					}
					{
						dose: 16.9808403361345
						response: 90.6879259223143
					}
					{
						dose: 17.1485714285714
						response: 90.7276903126428
					}
					{
						dose: 17.3163025210084
						response: 90.7667743224322
					}
					{
						dose: 17.4840336134454
						response: 90.8051958394737
					}
					{
						dose: 17.6517647058824
						response: 90.8429721197973
					}
					{
						dose: 17.8194957983193
						response: 90.8801198155897
					}
					{
						dose: 17.9872268907563
						response: 90.9166550016353
					}
					{
						dose: 18.1549579831933
						response: 90.9525932003706
					}
					{
						dose: 1.71731092436975
						response: 67.8162528515293
					}
					{
						dose: 18.3226890756303
						response: 90.9879494056368
					}
					{
						dose: 18.4904201680672
						response: 91.0227381052093
					}
					{
						dose: 18.6581512605042
						response: 91.0569733021768
					}
					{
						dose: 18.8258823529412
						response: 91.0906685352392
					}
					{
						dose: 18.9936134453781
						response: 91.1238368979866
					}
					{
						dose: 19.1613445378151
						response: 91.1564910572202
					}
					{
						dose: 19.3290756302521
						response: 91.1886432703689
					}
					{
						dose: 19.4968067226891
						response: 91.2203054020557
					}
					{
						dose: 19.664537815126
						response: 91.2514889398592
					}
					{
						dose: 19.832268907563
						response: 91.282205009319
					}
					{
						dose: 1.88504201680672
						response: 69.4884721787188
					}
					{
						dose: 20
						response: 91.312464388224
					}
					{
						dose: 2.0527731092437
						response: 70.9505165785417
					}
					{
						dose: 2.22050420168067
						response: 72.2410752569606
					}
					{
						dose: 2.38823529411765
						response: 73.3897150816077
					}
					{
						dose: 2.55596638655462
						response: 74.4194506281529
					}
					{
						dose: 2.7236974789916
						response: 75.3484847428508
					}
					{
						dose: 2.89142857142857
						response: 76.1914178612337
					}
					{
						dose: 3.05915966386555
						response: 76.9601071992789
					}
					{
						dose: 0.207731092436975
						response: 14.538607325235
					}
					{
						dose: 3.22689075630252
						response: 77.6642893230965
					}
					{
						dose: 3.3946218487395
						response: 78.3120392230297
					}
					{
						dose: 3.56235294117647
						response: 78.910114168498
					}
					{
						dose: 3.73008403361345
						response: 79.464214916676
					}
					{
						dose: 3.89781512605042
						response: 79.9791866868323
					}
					{
						dose: 4.06554621848739
						response: 80.4591755954619
					}
					{
						dose: 4.23327731092437
						response: 80.9077517212213
					}
					{
						dose: 4.40100840336134
						response: 81.3280068648568
					}
					{
						dose: 4.56873949579832
						response: 81.722632906544
					}
					{
						dose: 4.73647058823529
						response: 82.0939851337908
					}
					{
						dose: 0.37546218487395
						response: 31.0058914867057
					}
					{
						dose: 4.90420168067227
						response: 82.4441338170299
					}
					{
						dose: 5.07193277310924
						response: 82.7749065146723
					}
					{
						dose: 5.23966386554622
						response: 83.0879230055142
					}
					{
						dose: 5.40739495798319
						response: 83.3846243131443
					}
					{
						dose: 5.57512605042017
						response: 83.6662969622874
					}
					{
						dose: 5.74285714285714
						response: 83.9340933613743
					}
					{
						dose: 5.91058823529412
						response: 84.1890490181648
					}
					{
						dose: 6.07831932773109
						response: 84.4320971510078
					}
					{
						dose: 6.24605042016807
						response: 84.6640811464753
					}
					{
						dose: 6.41378151260504
						response: 84.885765226751
					}
					{
						dose: 0.543193277310924
						response: 41.2090655681439
					}
					{
						dose: 6.58151260504202
						response: 85.0978436214529
					}
					{
						dose: 6.74924369747899
						response: 85.3009484841895
					}
					{
						dose: 6.91697478991597
						response: 85.4956567508388
					}
					{
						dose: 7.08470588235294
						response: 85.6824961018464
					}
					{
						dose: 7.25243697478992
						response: 85.8619501628917
					}
					{
						dose: 7.42016806722689
						response: 86.0344630556419
					}
					{
						dose: 7.58789915966387
						response: 86.2004433918945
					}
					{
						dose: 7.75563025210084
						response: 86.3602677893525
					}
					{
						dose: 7.92336134453782
						response: 86.5142839749023
					}
					{
						dose: 8.09109243697479
						response: 86.6628135310604
					}
					{
						dose: 0.710924369747899
						response: 48.2916915546468
					}
					{
						dose: 8.25882352941176
						response: 86.8061543327977
					}
					{
						dose: 8.42655462184874
						response: 86.9445827149186
					}
					{
						dose: 8.59428571428571
						response: 87.0783554042977
					}
					{
						dose: 8.76201680672269
						response: 87.2077112463588
					}
					{
						dose: 8.92974789915966
						response: 87.3328727510378
					}
					{
						dose: 9.09747899159664
						response: 87.4540474799843
					}
					{
						dose: 9.26521008403361
						response: 87.5714292937963
					}
					{
						dose: 9.43294117647059
						response: 87.6851994755732
					}
					{
						dose: 9.60067226890756
						response: 87.7955277449354
					}
					{
						dose: 9.76840336134454
						response: 87.9025731748301
					}
					{
						dose: 0.878655462184874
						response: 53.5502596968108
					}
					{
						dose: 9.93613445378151
						response: 88.0064850218793
					}
					{
						dose: 10.1038655462185
						response: 88.1074034796817
					}
					{
						dose: 10.2715966386555
						response: 88.2054603633227
					}
					{
						dose: 10.4393277310924
						response: 88.3007797323492
					}
					{
						dose: 10.6070588235294
						response: 88.3934784585971
					}
					{
						dose: 10.7747899159664
						response: 88.4836667445132
					}
					{
						dose: 10.9425210084034
						response: 88.5714485969603
					}
					{
						dose: 11.1102521008403
						response: 88.6569222609231
					}
					{
						dose: 11.2779831932773
						response: 88.7401806170399
					}
					{
						dose: 11.4457142857143
						response: 88.821311546448
					}
					{
						dose: 1.04638655462185
						response: 57.635521034946
					}
					{
						dose: 11.6134453781513
						response: 88.9003982660525
					}
					{
						dose: 11.7811764705882
						response: 88.9775196369903
					}
					{
						dose: 11.9489075630252
						response: 89.0527504487701
					}
					{
						dose: 12.1166386554622
						response: 89.126161681308
					}
					{
						dose: 12.2843697478992
						response: 89.1978207468476
					}
					{
						dose: 12.4521008403361
						response: 89.2677917135538
					}
					{
						dose: 12.6198319327731
						response: 89.3361355123864
					}
					{
						dose: 12.7875630252101
						response: 89.4029101287017
					}
					{
						dose: 12.9552941176471
						response: 89.4681707798879
					}
					{
						dose: 13.123025210084
						response: 89.5319700802129
					}
					{
						dose: 1.21411764705882
						response: 60.9153153140226
					}
					{
						dose: 13.290756302521
						response: 89.5943581939522
					}
					{
						dose: 13.458487394958
						response: 89.6553829777602
					}
					{
						dose: 13.626218487395
						response: 89.7150901131627
					}
					{
						dose: 13.7939495798319
						response: 89.7735232299634
					}
					{
						dose: 13.9616806722689
						response: 89.8307240212876
					}
					{
						dose: 14.1294117647059
						response: 89.886732350919
					}
					{
						dose: 14.2971428571429
						response: 89.9415863535293
					}
					{
						dose: 14.4648739495798
						response: 89.9953225283458
					}
					{
						dose: 14.6326050420168
						response: 90.047975826755
					}
					{
						dose: 14.8003361344538
						response: 90.0995797342972
					}
					{
						dose: 1.3818487394958
						response: 63.615222545641
					}
					{
						dose: 14.9680672268908
						response: 90.15016634747
					}
					{
						dose: 15.1357983193277
						response: 90.1997664457207
					}
					{
						dose: 15.3035294117647
						response: 90.248409558977
					}
					{
						dose: 15.4712605042017
						response: 90.2961240310383
					}
					{
						dose: 15.6389915966387
						response: 90.3429370791208
					}
					{
						dose: 15.8067226890756
						response: 90.3888748498274
					}
					{
						dose: 15.9744537815126
						response: 90.4339624717921
					}
					{
						dose: 16.1421848739496
						response: 90.4782241052275
					}
					{
						dose: 16.3099159663866
						response: 90.5216829885879
					}
					{
						dose: 16.4776470588235
						response: 90.5643614825412
					}
				]

) (if (typeof process is "undefined" or not process.versions) then window.curveCuratorTestJSON = window.curveCuratorTestJSON or {} else exports)


#remember to keep requested and actual/overriden by algorithm#