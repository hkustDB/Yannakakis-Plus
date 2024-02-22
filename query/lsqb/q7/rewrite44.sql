create or replace view aggView1907648348260689800 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
create or replace view aggJoin177321051210684858 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView1907648348260689800 where Person_likes_Message.MessageId=aggView1907648348260689800.v1;
create or replace view aggView1126705844182642264 as select v1, SUM(annot) as annot from aggJoin177321051210684858 group by v1;
create or replace view aggJoin2421886014136597470 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView1126705844182642264 where Message_hasCreator_Person.MessageId=aggView1126705844182642264.v1;
create or replace view aggView8045927269977298164 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
create or replace view aggJoin5595667999516114554 as select aggJoin2421886014136597470.annot * aggView8045927269977298164.annot as annot from aggJoin2421886014136597470 join aggView8045927269977298164 using(v1);
select SUM(annot) as v9 from aggJoin5595667999516114554;
