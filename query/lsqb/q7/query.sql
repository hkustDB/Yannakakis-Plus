SELECT *
FROM Message_hasTag_Tag, Message_hasCreator_Person, Comment_replyOf_Message, Person_likes_Message
WHERE Message_hasTag_Tag.MessageId = Message_hasCreator_Person.MessageId
	AND Comment_replyOf_Message.ParentMessageId = Message_hasTag_Tag.MessageId
	AND Person_likes_Message.MessageId = Message_hasTag_Tag.MessageId