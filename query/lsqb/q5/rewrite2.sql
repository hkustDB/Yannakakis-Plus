create or replace view aggJoin1565351427686450551 as select ParentMessageId as v1, TagId as v6 from Comment_replyOf_Message as Comment_replyOf_Message, Comment_hasTag_Tag where Comment_replyOf_Message.CommentId=Comment_hasTag_Tag.CommentId;
create or replace view aggView166100757200212221 as select v1, COUNT(*) as annot, v6 from aggJoin1565351427686450551 group by v1,v6;
select sum(annot) from Message_hasTag_Tag as Message_hasTag_Tag, aggView166100757200212221 where Message_hasTag_Tag.MessageId=aggView166100757200212221.v1 and TagId<v6;
