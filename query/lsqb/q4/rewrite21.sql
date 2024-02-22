create or replace view aggView3406383156851552746 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
create or replace view aggJoin2200397482612536335 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView3406383156851552746 where Message_hasTag_Tag.MessageId=aggView3406383156851552746.v1;
create or replace view aggView656349866505927463 as select v1, SUM(annot) as annot from aggJoin2200397482612536335 group by v1;
create or replace view aggJoin3881944618469661775 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView656349866505927463 where Comment_replyOf_Message.ParentMessageId=aggView656349866505927463.v1;
create or replace view aggView7908828268071902821 as select v1, SUM(annot) as annot from aggJoin3881944618469661775 group by v1;
create or replace view aggJoin3431964040071266823 as select annot from Person_likes_Message as Person_likes_Message, aggView7908828268071902821 where Person_likes_Message.MessageId=aggView7908828268071902821.v1;
select SUM(annot) as v9 from aggJoin3431964040071266823;
