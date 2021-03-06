((exports) ->

	exports.authorsList =
		[
			{
				code: "bob"
				codeName: null
				displayOrder: null
				id: 1
				ignored: false
				name: "Bob Roberts"
			},
			{
				code: "john"
				codeName: null
				displayOrder: null
				id: 2
				ignored: false
				name: "John Smith"
			},
			{
				code: "jane"
				codeName: null
				displayOrder: null
				id: 3
				ignored: false
				name: "Jane Doe"

			}
		]

	exports.thingParent =
		className: "ThingParent"
		codeName: "PT00001"
		id: 1
		ignored: false
		lsKind: "thing" #should be same as the className
		lsLabels: [
			id: 1
			ignored: false
			imageFile: null
			labelText: "cMAP10"
			lsKind: "thing"
			lsTransaction: 1
			lsType: "name"
			lsTypeAndKind: "name_thing"
			modifiedDate: null
			physicallyLabled: false
			preferred: true
			recordedBy: "jane"
			recordedDate: 1375141504000
			version: 0
		]
		lsStates: [
			comments: null
			id: 11
			ignored: false
			lsKind: "thing parent"
			lsTransaction: 1
			lsType: "metadata"
			lsTypeAndKind: "metadata_thing parent"
			lsValues: [
				clobValue: null
				codeOrigin: "ACAS authors"
				codeValue: "john"
				comments: null
				dateValue: null
				fileValue: null
				id: 32312
				ignored: false
				lsTransaction:
					comments: null
					id: 127
					recordedDate: 1363388477000
					version: 0
				modifiedDate: null
				numericValue: null
				publicData: true
				recordedDate: 1363388477000
				sigFigs: null
				stringValue: null
				uncertainty: null
				urlValue: null
				lsKind: "scientist"
				valueOperator: null
				lsType: "codeValue"
				lsTypeAndKind: "codeValue_scientist"
				valueUnit: null
				version: 0
			,
				clobValue: null
				codeValue: null
				comments: null
				dateValue: 1342080000000
				fileValue: null
				id: 2
				ignored: false
				lsTransaction:
					comments: null
					id: 128
					recordedDate: 1363388477000
					version: 0
				modifiedDate: null
				numericValue: null
				publicData: true
				recordedDate: 1363388477000
				sigFigs: null
				stringValue: null
				uncertainty: null
				urlValue: null
				lsKind: "completion date"
				valueOperator: null
				lsType: "dateValue"
				lsTypeAndKind: "dateValue_completion date"
				valueUnit: null
				version: 0
			,
				clobValue: null
				codeValue: null
				comments: null
				dateValue: null
				fileValue: null
				id: 3
				ignored: false
				lsTransaction:
					comments: null
					id: 127
					recordedDate: 1363388477000
					version: 0
				modifiedDate: null
				numericValue: null
				publicData: true
				recordedDate: 1363388477000
				sigFigs: null
				stringValue: "Notebook 1"
				uncertainty: null
				urlValue: null
				lsKind: "notebook"
				valueOperator: null
				lsType: "stringValue"
				lsTypeAndKind: "stringValue_notebook"
				valueUnit: null
				version: 0
			,
				clobValue: null
				codeValue: null
				comments: null
				dateValue: null
				fileValue: "TestFile.mol"
				id: 3125
				ignored: false
				lsTransaction:
					comments: null
					id: 127
					recordedDate: 1363388477000
					version: 0
				modifiedDate: null
				numericValue: null
				publicData: true
				recordedDate: 1363388477000
				sigFigs: null
				stringValue: null
				uncertainty: null
				urlValue: null
				lsKind: "structural file"
				valueOperator: null
				lsType: "fileValue"
				lsTypeAndKind: "fileValue_structural file"
				valueUnit: null
				version: 0
			,
				clobValue: null
				codeValue: null
				comments: null
				dateValue: null
				fileValue: "Test.csv"
				id: 3125000
				ignored: false
				lsTransaction:
					comments: null
					id: 127
					recordedDate: 1363388477000
					version: 0
				modifiedDate: null
				numericValue: null
				publicData: true
				recordedDate: 1363388477000
				sigFigs: null
				stringValue: null
				uncertainty: null
				urlValue: null
				lsKind: "data"
				valueOperator: null
				lsType: "fileValue"
				lsTypeAndKind: "fileValue_data"
				valueUnit: null
				version: 0
			,
				clobValue: null
				codeValue: null
				comments: null
				dateValue: null
				fileValue: "junk.csv"
				id: 3125000
				ignored: true
				lsTransaction:
					comments: null
					id: 127
					recordedDate: 1363388477000
					version: 0
				modifiedDate: null
				numericValue: null
				publicData: true
				recordedDate: 1363388477000
				sigFigs: null
				stringValue: null
				uncertainty: null
				urlValue: null
				lsKind: "data"
				valueOperator: null
				lsType: "fileValue"
				lsTypeAndKind: "fileValue_data"
				valueUnit: null
				version: 0
			,
				clobValue: null
				codeValue: null
				comments: null
				dateValue: null
				fileValue: null
				id: 234
				ignored: false
				lsTransaction:
					comments: null
					id: 128
					recordedDate: 1363388477000
					version: 0
				modifiedDate: null
				numericValue: 231
				publicData: true
				recordedDate: 1363388477000
				sigFigs: null
				stringValue: null
				uncertainty: null
				urlValue: null
				lsKind: "batch number"
				valueOperator: null
				lsType: "numericValue"
				lsTypeAndKind: "numericValue_batch number"
				unitKind: null
				unitType: null
				valueUnit: null
				version: 0
			]
			modifiedBy: null
			modifiedDate: null
			recordedBy: "userName"
			recordedDate: 1375141460000
			version: 0
		]
		lsTransaction: 1
		lsType: "parent"
		lsTypeAndKind: "parent_thing"
		modifiedBy: null
		modifiedDate: null
		recordedBy: "jane"
		recordedDate: 1375141508000
		shortDescription: " "
		version: 0

	exports.thingBatch =
		codeName: "PT00001-1"
		id: 11
		ignored: false
		lsKind: "thing" #should be same as the className
		lsStates: [
			comments: null
			id: 11
			ignored: false
			lsKind: "thing batch"
			lsTransaction: 1
			lsType: "metadata"
			lsTypeAndKind: "metadata_thing batch"
			lsValues: [
				clobValue: null
				codeOrigin: "ACAS authors"
				codeValue: "john"
				comments: null
				dateValue: null
				fileValue: null
				id: 32312
				ignored: false
				lsTransaction:
					comments: null
					id: 127
					recordedDate: 1363388477000
					version: 0
				modifiedDate: null
				numericValue: null
				publicData: true
				recordedDate: 1363388477000
				sigFigs: null
				stringValue: null
				uncertainty: null
				urlValue: null
				lsKind: "scientist"
				valueOperator: null
				lsType: "codeValue"
				lsTypeAndKind: "codeValue_scientist"
				valueUnit: null
				version: 0
			,
				clobValue: null
				codeValue: null
				comments: null
				dateValue: 1342080000000
				fileValue: null
				id: 12
				ignored: false
				lsTransaction:
					comments: null
					id: 128
					recordedDate: 1363388477000
					version: 0
				modifiedDate: null
				numericValue: null
				publicData: true
				recordedDate: 1363388477000
				sigFigs: null
				stringValue: null
				uncertainty: null
				urlValue: null
				lsKind: "completion date"
				valueOperator: null
				lsType: "dateValue"
				lsTypeAndKind: "dateValue_completion date"
				valueUnit: null
				version: 0
			,
				clobValue: null
				codeValue: null
				comments: null
				dateValue: null
				fileValue: null
				id: 13
				ignored: false
				lsTransaction:
					comments: null
					id: 127
					recordedDate: 1363388477000
					version: 0
				modifiedDate: null
				numericValue: null
				publicData: true
				recordedDate: 1363388477000
				sigFigs: null
				stringValue: "Notebook 1"
				uncertainty: null
				urlValue: null
				lsKind: "notebook"
				valueOperator: null
				lsType: "stringValue"
				lsTypeAndKind: "stringValue_notebook"
				valueUnit: null
				version: 0
			,
				clobValue: null
				codeValue: "test"
				comments: null
				dateValue: null
				fileValue: null
				id: 1233
				ignored: false
				lsTransaction:
					comments: null
					id: 127
					recordedDate: 1363388477000
					version: 0
				modifiedDate: null
				numericValue: null
				publicData: true
				recordedDate: 1363388477000
				sigFigs: null
				stringValue: null
				uncertainty: null
				urlValue: null
				lsKind: "source"
				valueOperator: null
				lsType: "codeValue"
				lsTypeAndKind: "codeValue_source"
				valueUnit: null
				version: 0
			,
				clobValue: null
				codeValue: null
				comments: null
				dateValue: null
				fileValue: null
				id: 123357
				ignored: false
				lsTransaction:
					comments: null
					id: 127
					recordedDate: 1363388477000
					version: 0
				modifiedDate: null
				numericValue: null
				publicData: true
				recordedDate: 1363388477000
				sigFigs: null
				stringValue: "12345"
				uncertainty: null
				urlValue: null
				lsKind: "source id"
				valueOperator: null
				lsType: "stringValue"
				lsTypeAndKind: "stringValue_source id"
				valueUnit: null
				version: 0
			,
				clobValue: null
				codeValue: null
				comments: null
				dateValue: null
				fileValue: null
				id: 4
				ignored: false
				lsTransaction:
					comments: null
					id: 128
					recordedDate: 1363388477000
					version: 0
				modifiedDate: null
				numericValue: 231
				publicData: true
				recordedDate: 1363388477000
				sigFigs: null
				stringValue: null
				uncertainty: null
				urlValue: null
				lsKind: "molecular weight"
				valueOperator: null
				lsType: "numericValue"
				lsTypeAndKind: "numericValue_molecular weight"
				unitKind: "g/mol"
				unitType: "molecular weight"
				valueUnit: null
				version: 0
			,
				clobValue: null
				codeValue: null
				comments: null
				dateValue: null
				fileValue: null
				id: 409
				ignored: false
				lsTransaction:
					comments: null
					id: 128
					recordedDate: 1363388477000
					version: 0
				modifiedDate: null
				numericValue: 92
				publicData: true
				recordedDate: 1363388477000
				sigFigs: null
				stringValue: null
				uncertainty: null
				urlValue: null
				lsKind: "purity"
				valueOperator: null
				lsType: "numericValue"
				lsTypeAndKind: "numericValue_purity"
				unitKind: "% purity"
				unitType: "percentage"
				valueUnit: null
				version: 0
			,
				clobValue: null
				codeValue: null
				comments: null
				dateValue: null
				fileValue: "TestFile.mol"
				id: 3125
				ignored: false
				lsTransaction:
					comments: null
					id: 127
					recordedDate: 1363388477000
					version: 0
				modifiedDate: null
				numericValue: null
				publicData: true
				recordedDate: 1363388477000
				sigFigs: null
				stringValue: null
				uncertainty: null
				urlValue: null
				lsKind: "structural file"
				valueOperator: null
				lsType: "fileValue"
				lsTypeAndKind: "fileValue_structural file"
				valueUnit: null
				version: 0
			,
				clobValue: null
				codeValue: null
				comments: null
				dateValue: null
				fileValue: "Test.csv"
				id: 3125000
				ignored: false
				lsTransaction:
					comments: null
					id: 127
					recordedDate: 1363388477000
					version: 0
				modifiedDate: null
				numericValue: null
				publicData: true
				recordedDate: 1363388477000
				sigFigs: null
				stringValue: null
				uncertainty: null
				urlValue: null
				lsKind: "data"
				valueOperator: null
				lsType: "fileValue"
				lsTypeAndKind: "fileValue_data"
				valueUnit: null
				version: 0
			]
		,
			comments: null
			id: 111
			ignored: false
			lsKind: "inventory"
			lsTransaction: 1
			lsType: "metadata"
			lsTypeAndKind: "metadata_inventory"
			lsValues: [
				clobValue: null
				codeValue: null
				comments: null
				dateValue: null
				fileValue: null
				id: 14
				ignored: false
				lsTransaction:
					comments: null
					id: 128
					recordedDate: 1363388477000
					version: 0
				modifiedDate: null
				numericValue: 2.3
				publicData: true
				recordedDate: 1363388477000
				sigFigs: null
				stringValue: null
				uncertainty: null
				urlValue: null
				lsKind: "amount made"
				valueOperator: null
				lsType: "numericValue"
				lsTypeAndKind: "numericValue_amount made"
				unitKind: "g"
				unitType: "mass"
				valueUnit: null
				version: 0
			,
				clobValue: null
				codeValue: null
				comments: null
				dateValue: null
				fileValue: null
				id: 15
				ignored: false
				lsTransaction:
					comments: null
					id: 127
					recordedDate: 1363388477000
					version: 0
				modifiedDate: null
				numericValue: null
				publicData: true
				recordedDate: 1363388477000
				sigFigs: null
				stringValue: "Cabinet 1"
				uncertainty: null
				urlValue: null
				lsKind: "location"
				valueOperator: null
				lsType: "stringValue"
				lsTypeAndKind: "stringValue_location"
				valueUnit: null
				version: 0
			]
			modifiedBy: null
			modifiedDate: null
			recordedBy: "userName"
			recordedDate: 1375141460000
			version: 0
		]
		lsTransaction: 1
		lsType: "batch"
		lsTypeAndKind: "batch_thing"
		modifiedBy: null
		modifiedDate: null
		recordedBy: "jane"
		recordedDate: 1375141508000
		shortDescription: " "
		version: 0

	exports.batchList =
		[
			{
				codeName: "PT000001-1"
				id: 11
				ignored: false
				lsKind: "thing" #should be same as the className
				lsStates: [
					comments: null
					id: 11
					ignored: false
					lsKind: "thing batch"
					lsTransaction: 1
					lsType: "metadata"
					lsTypeAndKind: "metadata_thing batch"
					lsValues: [
						clobValue: null
						codeOrigin: "ACAS authors"
						codeValue: "john"
						comments: null
						dateValue: null
						fileValue: null
						id: 32312
						ignored: false
						lsTransaction:
							comments: null
							id: 127
							recordedDate: 1363388477000
							version: 0
						modifiedDate: null
						numericValue: null
						publicData: true
						recordedDate: 1363388477000
						sigFigs: null
						stringValue: null
						uncertainty: null
						urlValue: null
						lsKind: "scientist"
						valueOperator: null
						lsType: "codeValue"
						lsTypeAndKind: "codeValue_scientist"
						valueUnit: null
						version: 0
					,
						clobValue: null
						codeValue: null
						comments: null
						dateValue: 1342080000000
						fileValue: null
						id: 12
						ignored: false
						lsTransaction:
							comments: null
							id: 128
							recordedDate: 1363388477000
							version: 0
						modifiedDate: null
						numericValue: null
						publicData: true
						recordedDate: 1363388477000
						sigFigs: null
						stringValue: null
						uncertainty: null
						urlValue: null
						lsKind: "completion date"
						valueOperator: null
						lsType: "dateValue"
						lsTypeAndKind: "dateValue_completion date"
						valueUnit: null
						version: 0
					,
						clobValue: null
						codeValue: null
						comments: null
						dateValue: null
						fileValue: null
						id: 13
						ignored: false
						lsTransaction:
							comments: null
							id: 127
							recordedDate: 1363388477000
							version: 0
						modifiedDate: null
						numericValue: null
						publicData: true
						recordedDate: 1363388477000
						sigFigs: null
						stringValue: "Notebook 1"
						uncertainty: null
						urlValue: null
						lsKind: "notebook"
						valueOperator: null
						lsType: "stringValue"
						lsTypeAndKind: "stringValue_notebook"
						valueUnit: null
						version: 0
					,
						clobValue: null
						codeValue: "Customer"
						comments: null
						dateValue: null
						fileValue: null
						id: 1233
						ignored: false
						lsTransaction:
							comments: null
							id: 127
							recordedDate: 1363388477000
							version: 0
						modifiedDate: null
						numericValue: null
						publicData: true
						recordedDate: 1363388477000
						sigFigs: null
						stringValue: null
						uncertainty: null
						urlValue: null
						lsKind: "source"
						valueOperator: null
						lsType: "codeValue"
						lsTypeAndKind: "codeValue_source"
						valueUnit: null
						version: 0
					,
						clobValue: null
						codeValue: null
						comments: null
						dateValue: null
						fileValue: null
						id: 123357
						ignored: false
						lsTransaction:
							comments: null
							id: 127
							recordedDate: 1363388477000
							version: 0
						modifiedDate: null
						numericValue: null
						publicData: true
						recordedDate: 1363388477000
						sigFigs: null
						stringValue: "12345"
						uncertainty: null
						urlValue: null
						lsKind: "source id"
						valueOperator: null
						lsType: "stringValue"
						lsTypeAndKind: "stringValue_source id"
						valueUnit: null
						version: 0
					,
						clobValue: null
						codeValue: null
						comments: null
						dateValue: null
						fileValue: null
						id: 4
						ignored: false
						lsTransaction:
							comments: null
							id: 128
							recordedDate: 1363388477000
							version: 0
						modifiedDate: null
						numericValue: 231
						publicData: true
						recordedDate: 1363388477000
						sigFigs: null
						stringValue: null
						uncertainty: null
						urlValue: null
						lsKind: "molecular weight"
						valueOperator: null
						lsType: "numericValue"
						lsTypeAndKind: "numericValue_molecular weight"
						unitKind: "g/mol"
						unitType: "molecular weight"
						valueUnit: null
						version: 0
					,
						clobValue: null
						codeValue: null
						comments: null
						dateValue: null
						fileValue: null
						id: 409
						ignored: false
						lsTransaction:
							comments: null
							id: 128
							recordedDate: 1363388477000
							version: 0
						modifiedDate: null
						numericValue: 92
						publicData: true
						recordedDate: 1363388477000
						sigFigs: null
						stringValue: null
						uncertainty: null
						urlValue: null
						lsKind: "purity"
						valueOperator: null
						lsType: "numericValue"
						lsTypeAndKind: "numericValue_purity"
						unitKind: "% purity"
						unitType: "percentage"
						valueUnit: null
						version: 0
					]
				,
					comments: null
					id: 111
					ignored: false
					lsKind: "inventory"
					lsTransaction: 1
					lsType: "metadata"
					lsTypeAndKind: "metadata_inventory"
					lsValues: [
						clobValue: null
						codeValue: null
						comments: null
						dateValue: null
						fileValue: null
						id: 14
						ignored: false
						lsTransaction:
							comments: null
							id: 128
							recordedDate: 1363388477000
							version: 0
						modifiedDate: null
						numericValue: 2.3
						publicData: true
						recordedDate: 1363388477000
						sigFigs: null
						stringValue: null
						uncertainty: null
						urlValue: null
						lsKind: "amount made"
						valueOperator: null
						lsType: "numericValue"
						lsTypeAndKind: "numericValue_amount made"
						unitKind: "g"
						unitType: "mass"
						valueUnit: null
						version: 0
					,
						clobValue: null
						codeValue: null
						comments: null
						dateValue: null
						fileValue: null
						id: 15
						ignored: false
						lsTransaction:
							comments: null
							id: 127
							recordedDate: 1363388477000
							version: 0
						modifiedDate: null
						numericValue: null
						publicData: true
						recordedDate: 1363388477000
						sigFigs: null
						stringValue: "Cabinet 1"
						uncertainty: null
						urlValue: null
						lsKind: "location"
						valueOperator: null
						lsType: "stringValue"
						lsTypeAndKind: "stringValue_location"
						valueUnit: null
						version: 0
					]
					modifiedBy: null
					modifiedDate: null
					recordedBy: "userName"
					recordedDate: 1375141460000
					version: 0
				]
				lsTransaction: 1
				lsType: "batch"
				lsTypeAndKind: "batch_thing"
				modifiedBy: null
				modifiedDate: null
				recordedBy: "jane"
				recordedDate: 1375141508000
				shortDescription: " "
				version: 0
			},
			{
				code: "PT000001-2"
				codeName: "PT000001-2"
				id: 2
				name: "PT000001-2"
				lsKind: 'thing'
			},
			{
				code: "PT000001-3"
				codeName: "PT000001-3"
				id: 3
				name: "PT000001-3"
				lsKind: 'thing'
			}
		]

) (if (typeof process is "undefined" or not process.versions) then window.thingServiceTestJSON = window.thingServiceTestJSON or {} else exports)
