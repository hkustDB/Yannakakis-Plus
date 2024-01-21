SELECT *
FROM Person_knows_Person, `Comment`, Post
WHERE Person_knows_Person.Person1Id = `Comment`.hasCreator_PersonId
	AND Person_knows_Person.Person2Id = Post.hasCreator_PersonId
	AND `Comment`.replyOf_PostId = Post.PostId