create or replace view aggView8968039300738337056 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
create or replace view aggJoin650158228168736585 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView8968039300738337056 where Person_likes_Message.MessageId=aggView8968039300738337056.v1;
create or replace view aggView2004711942632086322 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
create or replace view aggJoin2169888171285710507 as select v1, aggJoin650158228168736585.annot * aggView2004711942632086322.annot as annot from aggJoin650158228168736585 join aggView2004711942632086322 using(v1);
create or replace view aggView1304962327723950001 as select v1, SUM(annot) as annot from aggJoin2169888171285710507 group by v1;
create or replace view aggJoin8118737972192979002 as select annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView1304962327723950001 where Comment_replyOf_Message.ParentMessageId=aggView1304962327723950001.v1;
select SUM(annot) as v9 from aggJoin8118737972192979002;
