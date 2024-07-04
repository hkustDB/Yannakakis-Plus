create or replace view aggView8490452443775666821 as select CommentId as v3, COUNT(*) as annot, TagId as v6 from Comment_hasTag_Tag as cht group by CommentId,TagId;
create or replace view aggJoin8408218018919933344 as select ParentMessageId as v1, v6, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView8490452443775666821 where Comment_replyOf_Message.CommentId=aggView8490452443775666821.v3;
create or replace view aggView5042690179764851006 as select v1, SUM(annot) as annot, v6 from aggJoin8408218018919933344 group by v1,v6;
create or replace view aggJoin5626356670199849901 as select TagId as v2, v6, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView5042690179764851006 where Message_hasTag_Tag.MessageId=aggView5042690179764851006.v1 and TagId<v6;
select SUM(annot) as v7 from aggJoin5626356670199849901;
