create or replace view aggView8160978892225214163 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
create or replace view aggJoin8383718172000536832 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView8160978892225214163 where Comment_replyOf_Message.ParentMessageId=aggView8160978892225214163.v1;
create or replace view aggView7592318887646090588 as select v1, SUM(annot) as annot from aggJoin8383718172000536832 group by v1;
create or replace view aggJoin5781750871767942648 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView7592318887646090588 where Message_hasCreator_Person.MessageId=aggView7592318887646090588.v1;
create or replace view aggView7091161771731866716 as select v1, SUM(annot) as annot from aggJoin5781750871767942648 group by v1;
create or replace view aggJoin3755391024924267573 as select annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView7091161771731866716 where Message_hasTag_Tag.MessageId=aggView7091161771731866716.v1;
select SUM(annot) as v9 from aggJoin3755391024924267573;
