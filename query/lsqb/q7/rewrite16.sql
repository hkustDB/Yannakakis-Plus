create or replace view aggView1442167632870862011 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
create or replace view aggJoin1760447494541725063 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView1442167632870862011 where Comment_replyOf_Message.ParentMessageId=aggView1442167632870862011.v1;
create or replace view aggView4335132225434561358 as select v1, SUM(annot) as annot from aggJoin1760447494541725063 group by v1;
create or replace view aggJoin26549662284221609 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView4335132225434561358 where Person_likes_Message.MessageId=aggView4335132225434561358.v1;
create or replace view aggView4216920704201336824 as select v1, SUM(annot) as annot from aggJoin26549662284221609 group by v1;
create or replace view aggJoin254581886834872246 as select annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView4216920704201336824 where Message_hasCreator_Person.MessageId=aggView4216920704201336824.v1;
select SUM(annot) as v9 from aggJoin254581886834872246;
