SELECT *
FROM Person_knows_Person pkp1, Person_knows_Person pkp2, Person_hasInterest_Tag, Person_knows_Person pkp3
WHERE pkp1.Person2Id = pkp2.Person1Id
	AND pkp1.Person1Id < pkp2.Person2Id
	AND pkp2.Person2Id = Person_hasInterest_Tag.PersonId
	AND pkp3.Person1Id = pkp1.Person1Id
  AND pkp3.Person2Id = pkp2.Person2Id