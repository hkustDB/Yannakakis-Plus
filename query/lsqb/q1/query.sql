SELECT *
FROM Country, City, Person, Forum_hasMember_Person, Forum, Post, `Comment`, Comment_hasTag_Tag, Tag, TagClass
WHERE City.isPartOf_CountryId = Country.CountryId 
	AND Person.isLocatedIn_CityId = City.CityId
	AND Forum_hasMember_Person.PersonId = Person.PersonId
	AND Forum.ForumId = Forum_hasMember_Person.ForumId
	AND Post.Forum_containerOfId = Forum.ForumId
	AND `Comment`.replyOf_PostId = Post.PostId
	AND Comment_hasTag_Tag.CommentId = `Comment`.CommentId
	AND Tag.TagId = Comment_hasTag_Tag.TagId
	AND Tag.hasType_TagClassId = TagClass.TagClassId