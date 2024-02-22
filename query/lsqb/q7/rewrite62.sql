create or replace view aggView6261798374493203039 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
create or replace view aggJoin7125086632451602995 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView6261798374493203039 where Comment_replyOf_Message.ParentMessageId=aggView6261798374493203039.v1;
create or replace view aggView959519951969195919 as select v1, SUM(annot) as annot from aggJoin7125086632451602995 group by v1;
create or replace view aggJoin1599300087921423320 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView959519951969195919 where Message_hasCreator_Person.MessageId=aggView959519951969195919.v1;
create or replace view aggView3644079020220734263 as select v1, SUM(annot) as annot from aggJoin1599300087921423320 group by v1;
create or replace view aggJoin8986358738414171360 as select annot from Person_likes_Message as Person_likes_Message, aggView3644079020220734263 where Person_likes_Message.MessageId=aggView3644079020220734263.v1;
select SUM(annot) as v9 from aggJoin8986358738414171360;
