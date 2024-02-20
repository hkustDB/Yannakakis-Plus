## AggReduce Phase: 

# AggReduce168
# 1. aggView
create or replace view aggView5764030046740967763 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
# 2. aggJoin
create or replace view aggJoin2455330877988281973 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView5764030046740967763 where Message_hasTag_Tag.MessageId=aggView5764030046740967763.v1;

# AggReduce169
# 1. aggView
create or replace view aggView7002948059941805028 as select v1, SUM(annot) as annot from aggJoin2455330877988281973 group by v1;
# 2. aggJoin
create or replace view aggJoin1918226998254783019 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView7002948059941805028 where Comment_replyOf_Message.ParentMessageId=aggView7002948059941805028.v1;

# AggReduce170
# 1. aggView
create or replace view aggView9028798020124550464 as select v1, SUM(annot) as annot from aggJoin1918226998254783019 group by v1;
# 2. aggJoin
create or replace view aggJoin834457705673375345 as select annot from Person_likes_Message as Person_likes_Message, aggView9028798020124550464 where Person_likes_Message.MessageId=aggView9028798020124550464.v1;
# Final result: 
select SUM(annot) as v9 from aggJoin834457705673375345;

# drop view aggView5764030046740967763, aggJoin2455330877988281973, aggView7002948059941805028, aggJoin1918226998254783019, aggView9028798020124550464, aggJoin834457705673375345;
