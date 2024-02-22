create or replace view aggView4416358217733702639 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
create or replace view aggJoin5215340904204248432 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView4416358217733702639 where Comment_replyOf_Message.ParentMessageId=aggView4416358217733702639.v1;
create or replace view aggView6435399693674107168 as select v1, SUM(annot) as annot from aggJoin5215340904204248432 group by v1;
create or replace view aggJoin4208074832272230811 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView6435399693674107168 where Message_hasTag_Tag.MessageId=aggView6435399693674107168.v1;
create or replace view aggView8896863848672438927 as select v1, SUM(annot) as annot from aggJoin4208074832272230811 group by v1;
create or replace view aggJoin1254787927780715738 as select annot from Person_likes_Message as Person_likes_Message, aggView8896863848672438927 where Person_likes_Message.MessageId=aggView8896863848672438927.v1;
select SUM(annot) as v9 from aggJoin1254787927780715738;
