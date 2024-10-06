create or replace view aggView4310104493668838678 as select CommentId as v3, COUNT(*) as annot, TagId as v8 from Comment_hasTag_Tag as cht2 group by CommentId,TagId;
create or replace view aggJoin2169174392551005200 as select ParentMessageId as v1, v8, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView4310104493668838678 where Comment_replyOf_Message.CommentId=aggView4310104493668838678.v3;
create or replace view aggView5618146487974932095 as select v1, SUM(annot) as annot, v8 from aggJoin2169174392551005200 group by v1,v8;
create or replace view aggJoin591335572510593264 as select TagId as v2, v8, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView5618146487974932095 where Message_hasTag_Tag.MessageId=aggView5618146487974932095.v1 and TagId<v8;
create or replace view aggView8978286366882390444 as select TagId as v2, COUNT(*) as annot from Comment_hasTag_Tag as cht1 group by TagId;
create or replace view aggJoin8629382523139131422 as select aggJoin591335572510593264.annot * aggView8978286366882390444.annot as annot from aggJoin591335572510593264 join aggView8978286366882390444 using(v2);
select SUM(annot) as v9 from aggJoin8629382523139131422;
