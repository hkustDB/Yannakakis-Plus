create or replace view aggView7424401281374549626 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
create or replace view aggJoin1227208611147014714 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView7424401281374549626 where Message_hasCreator_Person.MessageId=aggView7424401281374549626.v1;
create or replace view aggView1814747742953879893 as select v1, SUM(annot) as annot from aggJoin1227208611147014714 group by v1;
create or replace view aggJoin6651682964405126162 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView1814747742953879893 where Comment_replyOf_Message.ParentMessageId=aggView1814747742953879893.v1;
create or replace view aggView8456414080661271296 as select v1, SUM(annot) as annot from aggJoin6651682964405126162 group by v1;
create or replace view aggJoin8542766888128540564 as select annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView8456414080661271296 where Message_hasTag_Tag.MessageId=aggView8456414080661271296.v1;
select SUM(annot) as v9 from aggJoin8542766888128540564;
