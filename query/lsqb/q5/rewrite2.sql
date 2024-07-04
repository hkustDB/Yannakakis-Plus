create or replace view aggView8251221306594839328 as select CommentId as v3, COUNT(*) as annot, TagId as v6 from Comment_hasTag_Tag as cht group by CommentId,TagId;
create or replace view aggJoin2752615185619279158 as select ParentMessageId as v1, v6, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView8251221306594839328 where Comment_replyOf_Message.CommentId=aggView8251221306594839328.v3;
create or replace view aggView7030790823876649699 as select v1, SUM(annot) as annot, v6 from aggJoin2752615185619279158 group by v1,v6;
create or replace view aggJoin5025770053506841352 as select TagId as v2, v6, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView7030790823876649699 where Message_hasTag_Tag.MessageId=aggView7030790823876649699.v1 and TagId<v6;
select SUM(annot) as v7 from aggJoin5025770053506841352;
