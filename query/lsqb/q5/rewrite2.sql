create or replace view aggView1470918973239501128 as select CommentId as v3, COUNT(*) as annot, TagId as v6 from Comment_hasTag_Tag as cht group by CommentId,TagId;
create or replace view aggJoin1565351427686450551 as select ParentMessageId as v1, v6, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView1470918973239501128 where Comment_replyOf_Message.CommentId=aggView1470918973239501128.v3;
create or replace view aggView166100757200212221 as select v1, SUM(annot) as annot, v6 from aggJoin1565351427686450551 group by v1,v6;
create or replace view aggJoin4933764048185338537 as select annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView166100757200212221 where Message_hasTag_Tag.MessageId=aggView166100757200212221.v1 and TagId<v6;
select SUM(annot) as v7 from aggJoin4933764048185338537;
