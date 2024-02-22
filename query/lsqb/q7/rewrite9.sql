create or replace view aggView9195445106194986991 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
create or replace view aggJoin7535677119366391921 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView9195445106194986991 where Comment_replyOf_Message.ParentMessageId=aggView9195445106194986991.v1;
create or replace view aggView7847763166230912664 as select v1, SUM(annot) as annot from aggJoin7535677119366391921 group by v1;
create or replace view aggJoin5025406947504724799 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView7847763166230912664 where Message_hasTag_Tag.MessageId=aggView7847763166230912664.v1;
create or replace view aggView5776012198095619226 as select v1, SUM(annot) as annot from aggJoin5025406947504724799 group by v1;
create or replace view aggJoin6925566846793888524 as select annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView5776012198095619226 where Message_hasCreator_Person.MessageId=aggView5776012198095619226.v1;
select SUM(annot) as v9 from aggJoin6925566846793888524;
