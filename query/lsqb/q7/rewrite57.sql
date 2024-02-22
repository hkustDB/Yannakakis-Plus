create or replace view aggView8088804206713439813 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
create or replace view aggJoin7425418347474756097 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView8088804206713439813 where Person_likes_Message.MessageId=aggView8088804206713439813.v1;
create or replace view aggView2887521885769784438 as select v1, SUM(annot) as annot from aggJoin7425418347474756097 group by v1;
create or replace view aggJoin36328840056775128 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView2887521885769784438 where Comment_replyOf_Message.ParentMessageId=aggView2887521885769784438.v1;
create or replace view aggView3771229643025699741 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
create or replace view aggJoin1435967260370581745 as select aggJoin36328840056775128.annot * aggView3771229643025699741.annot as annot from aggJoin36328840056775128 join aggView3771229643025699741 using(v1);
select SUM(annot) as v9 from aggJoin1435967260370581745;
