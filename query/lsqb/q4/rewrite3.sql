create or replace view aggView7080078098330718248 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
create or replace view aggJoin375560770370321887 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView7080078098330718248 where Message_hasTag_Tag.MessageId=aggView7080078098330718248.v1;
create or replace view aggView30311638674090097 as select v1, SUM(annot) as annot from aggJoin375560770370321887 group by v1;
create or replace view aggJoin4767979906879019284 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView30311638674090097 where Person_likes_Message.MessageId=aggView30311638674090097.v1;
create or replace view aggView4010417732133003500 as select v1, SUM(annot) as annot from aggJoin4767979906879019284 group by v1;
create or replace view aggJoin6308923445573011401 as select annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView4010417732133003500 where Message_hasCreator_Person.MessageId=aggView4010417732133003500.v1;
select SUM(annot) as v9 from aggJoin6308923445573011401;
