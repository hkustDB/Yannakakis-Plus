create or replace view aggView3709687845555122460 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
create or replace view aggJoin7271205251385281280 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView3709687845555122460 where Person_likes_Message.MessageId=aggView3709687845555122460.v1;
create or replace view aggView955632274642813413 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
create or replace view aggJoin3199775146973359490 as select v1, aggJoin7271205251385281280.annot * aggView955632274642813413.annot as annot from aggJoin7271205251385281280 join aggView955632274642813413 using(v1);
create or replace view aggView8331562089769245759 as select v1, SUM(annot) as annot from aggJoin3199775146973359490 group by v1;
create or replace view aggJoin7204800714504869592 as select annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView8331562089769245759 where Message_hasTag_Tag.MessageId=aggView8331562089769245759.v1;
select SUM(annot) as v9 from aggJoin7204800714504869592;
