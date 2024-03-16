SELECT count(*)
FROM City AS CityA, City AS CityB, City AS CityC, Person AS PersonA, Person AS PersonB, Person AS PersonC, Person_knows_Person AS pkp1, Person_knows_Person AS pkp2, Person_knows_Person AS pkp3
WHERE PersonA.isLocatedIn_CityId = CityA.CityId
	AND PersonB.isLocatedIn_CityId = CityB.CityId
	AND PersonC.isLocatedIn_CityId = CityC.CityId
	AND pkp1.Person1Id = PersonA.PersonId
	AND pkp1.Person2Id = PersonB.PersonId
	AND pkp2.Person1Id = PersonB.PersonId
	AND pkp2.Person2Id = PersonC.PersonId
	AND pkp3.Person1Id = PersonC.PersonId