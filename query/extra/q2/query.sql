SELECT *
FROM `Comment`, Comment_hasTag_Tag, Tag
WHERE Comment_hasTag_Tag.CommentId = `Comment`.CommentId
	AND Tag.TagId = Comment_hasTag_Tag.TagId AND `Comment`.replyOf_CommentId < Tag.hasType_TagClassId