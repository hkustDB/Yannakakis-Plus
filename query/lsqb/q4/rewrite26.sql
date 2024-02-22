create or replace view aggView2874313488574190112 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
create or replace view aggJoin2040347107640385296 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView2874313488574190112 where Person_likes_Message.MessageId=aggView2874313488574190112.v1;
create or replace view aggView2635330725192843527 as select v1, SUM(annot) as annot from aggJoin2040347107640385296 group by v1;
create or replace view aggJoin1741979113684220915 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView2635330725192843527 where Message_hasCreator_Person.MessageId=aggView2635330725192843527.v1;
create or replace view aggView3514748893072364633 as select v1, SUM(annot) as annot from aggJoin1741979113684220915 group by v1;
create or replace view aggJoin7232462640241310635 as select annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView3514748893072364633 where Message_hasTag_Tag.MessageId=aggView3514748893072364633.v1;
select SUM(annot) as v9 from aggJoin7232462640241310635;
