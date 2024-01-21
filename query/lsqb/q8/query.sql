SELECT *
FROM Message_hasTag_Tag, Comment_replyOf_Message, Comment_hasTag_Tag AS cht1, Comment_hasTag_Tag AS cht2
WHERE Message_hasTag_Tag.MessageId = Comment_replyOf_Message.ParentMessageId
	AND Comment_replyOf_Message.CommentId = cht1.CommentId
	AND Message_hasTag_Tag.TagId = cht2.TagId
    AND Comment_replyOf_Message.CommentId = cht2.CommentId
    AND Message_hasTag_Tag.TagId < cht1.TagId