create or replace view aggView5263784123119047734 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
create or replace view aggJoin5001928378110668526 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView5263784123119047734 where Message_hasCreator_Person.MessageId=aggView5263784123119047734.v1;
create or replace view aggView7288588395022247275 as select v1, SUM(annot) as annot from aggJoin5001928378110668526 group by v1;
create or replace view aggJoin105784768073774382 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView7288588395022247275 where Comment_replyOf_Message.ParentMessageId=aggView7288588395022247275.v1;
create or replace view aggView1271738804227137262 as select v1, SUM(annot) as annot from aggJoin105784768073774382 group by v1;
create or replace view aggJoin7960408773802557452 as select annot from Person_likes_Message as Person_likes_Message, aggView1271738804227137262 where Person_likes_Message.MessageId=aggView1271738804227137262.v1;
select SUM(annot) as v9 from aggJoin7960408773802557452;
