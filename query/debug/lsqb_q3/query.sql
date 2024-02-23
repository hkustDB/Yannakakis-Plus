SELECT count(*)
FROM City AS CityA, City AS CityB, City AS CityC, Person AS PersonA, Person AS PersonB, Person AS PersonC, Person_knows_Person AS pkp1, Person_knows_Person AS pkp2, Person_knows_Person AS pkp3
WHERE PersonB.isLocatedIn_CityId = CityB.CityId
	AND CityB.isPartOf_CountryId = CityA.isPartOf_CountryId
	AND CityC.isPartOf_CountryId = CityA.isPartOf_CountryId
	AND PersonA.isLocatedIn_CityId = CityA.CityId
	AND PersonC.isLocatedIn_CityId = CityC.CityId
	AND pkp1.Person1Id = PersonA.PersonId
	AND pkp1.Person2Id = PersonB.PersonId
	AND pkp2.Person1Id = PersonB.PersonId
	AND pkp2.Person2Id = PersonC.PersonId
	AND pkp3.Person1Id = PersonC.PersonId
	AND pkp3.Person2Id = PersonA.PersonId