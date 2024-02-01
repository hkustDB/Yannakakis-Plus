SELECT count(*)
FROM Message_hasTag_Tag, Comment_replyOf_Message, Comment_hasTag_Tag AS cht
WHERE Message_hasTag_Tag.MessageId = Comment_replyOf_Message.ParentMessageId
	AND Comment_replyOf_Message.CommentId = cht.CommentId
	AND Message_hasTag_Tag.TagId < cht.TagId