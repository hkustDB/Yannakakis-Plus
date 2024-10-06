SELECT count(*)
FROM Person_knows_Person pkp1, Person_knows_Person pkp2, Person_hasInterest_Tag
WHERE pkp1.Person2Id = pkp2.Person1Id
	AND pkp1.Person1Id < pkp2.Person2Id
	AND Person_hasInterest_Tag.PersonId = pkp2.Person2Id