// OM: "structureInfo".oColTables
// https://doc.4d.com/4Dv18R5/4D/18-R5/System-Tables.300-5178468.en.html

Case of 
	: (Form event code:C388=On Selection Change:K2:29)
		ARRAY TEXT:C222($aColNames; 0)
		ARRAY TEXT:C222($aHeaderNames; 0)
		ARRAY POINTER:C280($aColVars; 0)
		ARRAY POINTER:C280($aHeaderVars; 0)
		ARRAY BOOLEAN:C223($aColsVisible; 0)
		ARRAY POINTER:C280($aStyles; 0)
		
		LISTBOX GET ARRAYS:C832(aLbTables; $aColNames; $aHeaderNames; $aColVars; $aHeaderVars; $aColsVisible; $aStyles)
		
		C_LONGINT:C283($i)
		C_TEXT:C284($tabName)
		C_OBJECT:C1216($objMarkedTabNames)
		
		If (Count in array:C907(aLbTables; True:C214)>0)  // if minimum one row is selected
			$objMarkedTabNames:=New object:C1471
			// aLbTables{$i}  // True if row is selected
			
			//%R-
			
			For ($i; 1; Size of array:C274(aLbTables))
				$objMarkedTabNames[$aColVars{1}->{$i}]:=Not:C34(aLbTables{$i})  // 1=_USER_TABLES/TABLE_NAME
			End for 
			
			LISTBOX GET ARRAYS:C832(aLbFields; $aColNames; $aHeaderNames; $aColVars; $aHeaderVars; $aColsVisible; $aStyles)
			For ($i; 1; Size of array:C274(aLbFieldsRowCtrl))
				aLbFieldsRowCtrl{$i}:=$objMarkedTabNames[$aColVars{1}->{$i}]  // 1=_USER_COLUMNS/TABLE_NAME
			End for 
			
			LISTBOX GET ARRAYS:C832(aLbIdx; $aColNames; $aHeaderNames; $aColVars; $aHeaderVars; $aColsVisible; $aStyles)
			For ($i; 1; Size of array:C274(aLbIdxRowCtrl))
				aLbIdxRowCtrl{$i}:=$objMarkedTabNames[$aColVars{5}->{$i}]  // 5=_USER_INDEXES/TABLE_NAME
			End for 
			
			LISTBOX GET ARRAYS:C832(aIdxFields; $aColNames; $aHeaderNames; $aColVars; $aHeaderVars; $aColsVisible; $aStyles)
			For ($i; 1; Size of array:C274(aIdxFieldsRowCtrl))
				aIdxFieldsRowCtrl{$i}:=$objMarkedTabNames[$aColVars{3}->{$i}]  // 3=_USER_IND_COLUMNS/TABLE_NAME
			End for 
			
			LISTBOX GET ARRAYS:C832(aLbCons; $aColNames; $aHeaderNames; $aColVars; $aHeaderVars; $aColsVisible; $aStyles)
			For ($i; 1; Size of array:C274(aLbConsRowCtrl))
				If ($aColVars{7}->{$i}="")
					aLbConsRowCtrl{$i}:=$objMarkedTabNames[$aColVars{4}->{$i}]  // 4=_USER_CONSTRAINTS/TABLE_NAME
				Else 
					aLbConsRowCtrl{$i}:=($objMarkedTabNames[$aColVars{4}->{$i}] & $objMarkedTabNames[$aColVars{7}->{$i}])  // 4=_USER_CONSTRAINTS/TABLE_NAME | 7=_USER_CONSTRAINTS/RELATED_TABLE_NAME
				End if 
			End for 
			
			LISTBOX GET ARRAYS:C832(aLbConsFields; $aColNames; $aHeaderNames; $aColVars; $aHeaderVars; $aColsVisible; $aStyles)
			For ($i; 1; Size of array:C274(aLbConsFieldsRowCtrl))
				aLbConsFieldsRowCtrl{$i}:=$objMarkedTabNames[$aColVars{3}->{$i}]  // 3=_USER_CONS_COLUMNS/TABLE_NAME
			End for 
			
			//%R+
			
		Else   // if no rows selected, show infos for all tables
			ARRAY BOOLEAN:C223(aLbFieldsRowCtrl; 0)
			ARRAY BOOLEAN:C223(aLbFieldsRowCtrl; Size of array:C274(aLbFields))
			
			ARRAY BOOLEAN:C223(aLbIdxRowCtrl; 0)
			ARRAY BOOLEAN:C223(aLbIdxRowCtrl; Size of array:C274(aLbIdx))
			
			ARRAY BOOLEAN:C223(aIdxFieldsRowCtrl; 0)
			ARRAY BOOLEAN:C223(aIdxFieldsRowCtrl; Size of array:C274(aIdxFields))
			
			ARRAY BOOLEAN:C223(aLbConsRowCtrl; 0)
			ARRAY BOOLEAN:C223(aLbConsRowCtrl; Size of array:C274(aLbCons))
			
			ARRAY BOOLEAN:C223(aLbConsFieldsRowCtrl; 0)
			ARRAY BOOLEAN:C223(aLbConsFieldsRowCtrl; Size of array:C274(aLbConsFields))
			
		End if 
		
End case 
