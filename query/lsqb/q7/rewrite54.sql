create or replace view aggView8527172161989418836 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
create or replace view aggJoin5721006941666790585 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView8527172161989418836 where Message_hasTag_Tag.MessageId=aggView8527172161989418836.v1;
create or replace view aggView3296394020730795551 as select v1, SUM(annot) as annot from aggJoin5721006941666790585 group by v1;
create or replace view aggJoin882462195896892946 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView3296394020730795551 where Message_hasCreator_Person.MessageId=aggView3296394020730795551.v1;
create or replace view aggView3423063552773905641 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
create or replace view aggJoin5597738386737119004 as select aggJoin882462195896892946.annot * aggView3423063552773905641.annot as annot from aggJoin882462195896892946 join aggView3423063552773905641 using(v1);
select SUM(annot) as v9 from aggJoin5597738386737119004;
