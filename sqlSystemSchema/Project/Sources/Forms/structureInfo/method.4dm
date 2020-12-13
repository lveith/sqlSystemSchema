// PM: "structureInfo" (new LV 09.12.20, 11:32:02)
// https://doc.4d.com/4Dv18R5/4D/18-R5/System-Tables.300-5178468.en.html
// Last change: LV 09.12.20, 11:32:02

C_POINTER:C301($nilPtr)
C_LONGINT:C283($i)
C_LONGINT:C283($tabNr)
C_POINTER:C301($varPtr)

Case of 
	: (Form event code:C388=On Load:K2:1)
		ARRAY BOOLEAN:C223(aLbTables; 0)
		ARRAY BOOLEAN:C223(aLbFields; 0)
		ARRAY BOOLEAN:C223(aLbIdx; 0)
		ARRAY BOOLEAN:C223(aIdxFields; 0)
		ARRAY BOOLEAN:C223(aLbCons; 0)
		ARRAY BOOLEAN:C223(aLbConsFields; 0)
		ARRAY BOOLEAN:C223(aLbSchemas; 0)
		ARRAY BOOLEAN:C223(aLbViews; 0)
		ARRAY BOOLEAN:C223(aLbViewFields; 0)
		
		ARRAY BOOLEAN:C223(aLbFieldsRowCtrl; 0)
		ARRAY BOOLEAN:C223(aLbIdxRowCtrl; 0)
		ARRAY BOOLEAN:C223(aIdxFieldsRowCtrl; 0)
		ARRAY BOOLEAN:C223(aLbConsRowCtrl; 0)
		ARRAY BOOLEAN:C223(aLbConsFieldsRowCtrl; 0)
		
		ARRAY LONGINT:C221(aLbTablesColRecs; 0)
		
		Begin SQL
			SELECT * FROM _USER_TABLES INTO <<aLbTables>>;
			SELECT * FROM _USER_COLUMNS INTO <<aLbFields>>;
			SELECT * FROM _USER_INDEXES INTO <<aLbIdx>>;
			SELECT * FROM _USER_IND_COLUMNS INTO <<aIdxFields>>;
			SELECT * FROM _USER_CONSTRAINTS INTO <<aLbCons>>;
			SELECT * FROM _USER_CONS_COLUMNS INTO <<aLbConsFields>>;
			SELECT * FROM _USER_SCHEMAS INTO <<aLbSchemas>>;
			SELECT * FROM _USER_VIEWS INTO <<aLbViews>>;
			SELECT * FROM _USER_VIEW_COLUMNS INTO <<aLbViewFields>>;
		End SQL
		
		SET TIMER:C645(4)
		//String(Count in array(aLbTables; True))+" of "+String(Size of array(aLbTables))
		//String(Count in array(aLbFields; True))+" of "+String(Count in array(aLbFieldsRowCtrl; False))+" of "+String(Size of array(aLbFields))
		//String(Count in array(aLbIdx; True))+" of "+String(Count in array(aLbIdxRowCtrl; False))+" of "+String(Size of array(aLbIdx))
		//String(Count in array(aIdxFields; True))+" of "+String(Count in array(aIdxFieldsRowCtrl; False))+" of "+String(Size of array(aIdxFields))
		//String(Count in array(aLbCons; True))+" of "+String(Count in array(aLbConsRowCtrl; False))+" of "+String(Size of array(aLbCons))
		//String(Count in array(aLbConsFields; True))+" of "+String(Count in array(aLbConsFieldsRowCtrl; False))+" of "+String(Size of array(aLbConsFields))
		//String(Count in array(aLbSchemas; True))+" of "+String(Size of array(aLbSchemas))
		//String(Count in array(aLbViews; True))+" of "+String(Size of array(aLbViews))
		//String(Count in array(aLbViewFields; True))+" of "+String(Size of array(aLbViewFields))
		
		
	: (Form event code:C388=On Timer:K2:25)
		SET TIMER:C645(0)
		If (True:C214)  // do real action
			If (Is nil pointer:C315(OBJECT Get pointer:C1124(Object named:K67:5; "oLbTablesColRecs")))
				ARRAY TEXT:C222($aColNames; 0)
				ARRAY TEXT:C222($aHeaderNames; 0)
				ARRAY POINTER:C280($aColVars; 0)
				ARRAY POINTER:C280($aHeaderVars; 0)
				ARRAY BOOLEAN:C223($aColsVisible; 0)
				ARRAY POINTER:C280($aStyles; 0)
				LISTBOX GET ARRAYS:C832(aLbTables; $aColNames; $aHeaderNames; $aColVars; $aHeaderVars; $aColsVisible; $aStyles)
				If (True:C214)  // workaround wg. 4D Fehler
					// SysCatalog creates a column with unknown not useable array-type (can not used in compiled-mode)
					// Column "_USER_TABLES/TABLE_ID" has in docu not listed type=26 ?
					// Type=26 is maybe any kind of "Integer 64 bits array" (4D docu not listed any type 26)
					// As workaround, change here the type of this dynamicVarColumn from "Integer 64 bits array" to "LongInt array"
					// After change type the column can used without any error/break in compiled-component used in host-db...
					// ALERT(String(Type($aColVars{3}->))+" "+String(Bool(Value type($aColVars{3}->{1}=Is integer 64 bits))))
					ARRAY LONGINT:C221($aTmp; 0)
					COPY ARRAY:C226($aColVars{3}->; $aTmp)
					ARRAY LONGINT:C221($aColVars{3}->; Size of array:C274($aTmp))
					For ($i; 1; Size of array:C274($aTmp))
						$aColVars{3}->{$i}:=$aTmp{$i}  // 3=_USER_TABLES/TABLE_ID
					End for 
					// ALERT(String(Type($aColVars{3}->))+" "+String(Bool(Value type($aColVars{3}->{1}=Is integer 64 bits))))
				End if 
				ARRAY LONGINT:C221(aLbTablesColRecs; Size of array:C274(aLbTables))
				//%R-
				For ($i; 1; Size of array:C274(aLbTables))
					aLbTablesColRecs{$i}:=Records in table:C83(Table:C252($aColVars{3}->{$i})->)  // 3=_USER_TABLES/TABLE_ID
				End for 
				//%R+
				LISTBOX INSERT COLUMN:C829(aLbTables; LISTBOX Get number of columns:C831(aLbTables)+1; "oLbTablesColRecs"; aLbTablesColRecs; "oLbTablesHeadRecs"; $nilPtr)
				OBJECT SET TITLE:C194(*; "oLbTablesHeadRecs"; "Records in table")
			End if 
			
		Else   // do just test action
			ARRAY BOOLEAN:C223(aLbTables; 3)
			ARRAY BOOLEAN:C223(aLbFields; 4)
			ARRAY TEXT:C222($aColNames; 0)
			ARRAY TEXT:C222($aHeaderNames; 0)
			ARRAY POINTER:C280($aColVars; 0)
			ARRAY POINTER:C280($aHeaderVars; 0)
			ARRAY BOOLEAN:C223($aColsVisible; 0)
			ARRAY POINTER:C280($aStyles; 0)
			LISTBOX GET ARRAYS:C832(aLbTables; $aColNames; $aHeaderNames; $aColVars; $aHeaderVars; $aColsVisible; $aStyles)
			For ($i; 1; Size of array:C274($aColVars))
				ARRAY TEXT:C222($aColVars{$i}->; 3)
			End for 
			$aColVars{1}->{1}:="nameX"
			$aColVars{1}->{2}:="nameY"
			$aColVars{1}->{3}:="nameZ"
			LISTBOX GET ARRAYS:C832(aLbFields; $aColNames; $aHeaderNames; $aColVars; $aHeaderVars; $aColsVisible; $aStyles)
			For ($i; 1; Size of array:C274($aColVars))
				ARRAY TEXT:C222($aColVars{$i}->; 4)
			End for 
			$aColVars{1}->{1}:="nameX"
			$aColVars{1}->{2}:="nameY"
			$aColVars{1}->{3}:="nameZ"
			$aColVars{1}->{4}:="nameX"
			
		End if 
		
End case 

// - EOF -