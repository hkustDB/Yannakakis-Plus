create or replace view aggView8569776641576808004 as select MessageId as v1, COUNT(*) as annot, TagId as v2 from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId,TagId;
create or replace view aggJoin7983289705768942448 as select CommentId as v3, v2, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView8569776641576808004 where Comment_replyOf_Message.ParentMessageId=aggView8569776641576808004.v1;
create or replace view aggView9080738476190266680 as select v3, SUM(annot) as annot, v2 from aggJoin7983289705768942448 group by v3,v2;
create or replace view aggJoin5388496460953364311 as select TagId as v6, v2, annot from Comment_hasTag_Tag as cht, aggView9080738476190266680 where cht.CommentId=aggView9080738476190266680.v3 and v2<TagId;
select SUM(annot) as v7 from aggJoin5388496460953364311;
